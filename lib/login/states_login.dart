

import 'package:shopapplication/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginIntialState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{
  final ShopLoginModel loginmodel;

  ShopLoginSuccessState(this.loginmodel);
}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;

  ShopLoginErrorState(this.error);
}


