import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Shared/components.dart';
import '../models/categories_model.dart';
import '../models/home_model.dart';
import '../shop/cubit_shop.dart';
import '../shop/states_shop.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!(state.model.status ?? true)) {
            {
              ShowToast(
                  text: '${state.model.message}',
                  state: ChooseToastColor.ERROR);
            }
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var list1 = cubit.homeModel;
        var list2 = cubit.categoriesModel;

        if (list1 != null && list2 != null) {
          // Check if both lists are available
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                builderWidget(list1, list2, context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: 1,
          );
        } else {
          return const Center(
              child:
                  CircularProgressIndicator()); // Or any other loading widget
        }
      },
    );
  }

  Widget builderWidget(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      // categoriesModel categoriesModel
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
              items: model.data?.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 300,
                scrollPhysics: const ScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#dba06b'),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 100.0,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel.data!.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel.data!.data.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.w800,
                      color: HexColor('#dba06b'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1 / 2,
                children: List.generate(
                  model.data!.products.length,
                  (index) =>
                      buildGridProduct(model.data!.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                fit: BoxFit.fill,
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200.0,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20.0,
                    height: 1.4,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      // Assuming you want to uncomment this later
                      onPressed: () {
                        if (model.id != null) {
                          ShopCubit.get(context).changeFavorites(
                              model.id!); // Use non-null assertion operator (!)
                        }
                        if (kDebugMode) {
                          print(model.id);
                        }
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                            (ShopCubit.get(context).favorites[model.id] ??
                                    true) // Use null-aware operator (??)
                                ? Colors.pinkAccent
                                : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.fill,
          ),
          Container(
            color: Colors.black.withOpacity(
              .5,
            ),
            width: 100.0,
            child: Text(
              '${model.name}',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
