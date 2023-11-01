import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Cubit/signUpCubit.dart';
import 'package:gp/Cubit/signupStates.dart';
import 'shared/components.dart';


class AdminSignUp extends StatefulWidget {
       static final formKey = GlobalKey<FormState>();

  @override
  State<AdminSignUp> createState() => _AdminSignUpState();
}

class _AdminSignUpState extends State<AdminSignUp> {
    final emailController = TextEditingController();
final passwordController = TextEditingController();
    final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   
    // print(MediaQuery.of(context).viewInsets.bottom);
  
   bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return  BlocProvider(
      create: (context) => signupCubit(),
      child: BlocConsumer<signupCubit, signupStates>(
        listener: (context, states) {
          if (states is signupErrorState ) {
           // showToast(message: states.error.toString(), state: ToastStates.error, context: context);
          }
        }, 
        
         builder: (context, states) {
          final cubit = signupCubit.get(context);

          return adminSign(
           cubit: cubit,
      
      context: context,
      icon:  Icons.done,
      signIn: false,
      title: "Register",
      heroTag: 'signup',
      emailController: emailController,
      passwordController: passwordController,
      idController: idController,
      formKey: AdminSignUp.formKey,
      keyboardIsOpened: keyboardIsOpened,
 );
    },
  
  ),);
}
}
