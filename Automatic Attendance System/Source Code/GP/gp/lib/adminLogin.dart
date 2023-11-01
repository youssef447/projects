import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Cubit/loginCubit.dart';
import 'package:gp/Cubit/loginStates.dart';
import 'shared/components.dart';

class AdminLogin extends StatefulWidget {
     static final formKey = GlobalKey<FormState>();

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
    final emailController = TextEditingController();
        final idController = TextEditingController();

final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).viewInsets.bottom);

   
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return BlocProvider(
      create: (context) => loginCubit(),
      child: BlocConsumer<loginCubit, loginStates>(
        listener: (context, states) {
          
        }, 
        
         builder: (context, states) {
          final cubit = loginCubit.get(context);

          return adminSign(
            cubit: cubit,
      context: context,
      icon: Icons.arrow_forward_ios,
      signIn: true,
      title: "Login",
      heroTag: 'login',
      emailController: emailController,
      passwordController: passwordController,
            idController: idController,
      
      formKey: AdminLogin.formKey,
      keyboardIsOpened: keyboardIsOpened,
    );
    },
  
  ),);
}
}
