import 'package:gp/models/employee.dart';

abstract class signupStates{}

class signupInitialState extends signupStates {}

class signupLoadingState extends signupStates {}

class signupSuccessState extends signupStates
{
  final Emp signupModel;

  signupSuccessState(this.signupModel);
}

class signupErrorState extends signupStates
{
  final dynamic error;

  signupErrorState(this.error);
}
//class signupLoadingState extends signupStates {}
