import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/shared/components.dart';

import '../models/employee.dart';
import 'signupStates.dart';

class signupCubit extends Cubit<signupStates> {
  signupCubit() : super(signupInitialState());

   static signupCubit get(ctx) => BlocProvider.of(ctx);
  bool loading=false;
   toggleLoading(){
     loading=true;

   }
  Emp admin;
  void signUp(
     String email,
     String pass,
     String id,
     BuildContext ctx,
  ) {
        emit(signupLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) {
                          showToast(message: "Registered Successfully", state: ToastStates.right, context: ctx);

     // Emp emp = Emp(email: email,id:id);
      //Add user LoginIn home Info to FireStore
      //addUser(emp,ctx);


      print(value.user.email + " " + value.user.emailVerified.toString());
    }).catchError((onError) {
     
      showToast(message: onError.toString(), state: ToastStates.error, context: ctx);
      //print("errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror is ${onError.toString()}");
      loading=false;
      emit(signupErrorState(onError));
      //showToast(message: onError, state: ToastStates.error, context: ctx);
      
    });
  }

  void addUser(Emp emp, BuildContext ctx,) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(emp.id)
        .set(emp.toMap())
        .then((value) {
                showToast(message: "Registered Successfully", state: ToastStates.right, context: ctx);

          loading=false;
      emit(signupSuccessState(emp));
    }).catchError((onError) {
      emit(signupErrorState(onError));
      showToast(message: onError, state: ToastStates.error, context: ctx);
    });
  }
}
