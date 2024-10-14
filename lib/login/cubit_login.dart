import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/dio/dio_helper.dart';
import 'package:shop_app/dio/end_points.dart';
import 'package:shop_app/login/states_login.dart';
import 'package:shop_app/login_model.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);


  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      if (kDebugMode) {
        print(value.data);
        ShopLoginModel.fromJson(value.data);
        emit(ShopLoginSuccessState());
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}
