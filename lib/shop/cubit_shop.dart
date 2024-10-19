import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop/categories_screen.dart';
import 'package:shop_app/shop/favourites_screen.dart';
import 'package:shop_app/shop/products_screen.dart';
import 'package:shop_app/shop/settings_screen.dart';
import 'package:shop_app/shop/states_cubit.dart';

class ShopCubit extends Cubit <ShopStates>{

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get (context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  List<Widget>bottomScreens =[
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavBar());
  }
}