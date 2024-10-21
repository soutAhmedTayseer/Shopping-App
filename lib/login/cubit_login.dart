import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapplication/login/states_login.dart';
import 'package:shopapplication/models/login_model.dart';
import '../dio/dio_helper.dart';
import '../dio/end_points.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {

  ShopLoginCubit() : super(ShopLoginIntialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);


  void UserLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email':email,
        'password':password,
      },
    ).then((Value){
      ShopLoginModel.fromJson(Value.data);
      emit(ShopLoginSuccessState(ShopLoginModel.fromJson(Value.data)));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });
  }

}