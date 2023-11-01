
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/day_attendance.dart';

import '../models/employee.dart';
import '../shared/components.dart';
import 'loginStates.dart';

class loginCubit extends Cubit<loginStates> {
  loginCubit() : super(LoginInitialState());
  static loginCubit get(ctx) => BlocProvider.of(ctx);
  bool loading = false;
  toggleLoading() {
    loading = true;
  }

  Emp admin;
  void signIn(
    String email,
    String pass,
    BuildContext ctx,
  ) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      loading = false;
      /* showToast(
          message: "Welcome " + value.user.email,
          state: ToastStates.right,
          context: ctx); */
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (ctx) => DayAttendance(),
        ),
      );
      emit(LoginSuccessState(admin));
      //  print(value.user.email + " " + value.user.emailVerified.toString());
    }).catchError((onError) {
      showToast(
          message: onError.toString(), state: ToastStates.error, context: ctx);
      loading = false;
      emit(LoginErrorState(onError));
    });
  }
}
