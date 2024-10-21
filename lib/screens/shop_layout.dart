import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Shared/components.dart';
import '../shop/cubit_shop.dart';
import '../shop/states_shop.dart';
import 'Search_Screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'SHOP',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      SearchScreen(),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                  )),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favourite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: ShopCubit.get(context).currentIndex,
            onTap: (value) {
              ShopCubit.get(context).changeBottom(value);
            },
          ),
          body: ShopCubit.get(context)
              .bottomScreens[ShopCubit.get(context).currentIndex],
        );
      },
    );
  }
}
