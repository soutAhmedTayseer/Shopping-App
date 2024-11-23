import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopapplication/Shared/components.dart';
import 'package:shopapplication/Shared/constants.dart';

import '../shop/cubit_shop.dart';
import '../shop/states_shop.dart';

class ProfileScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var TextController = TextEditingController();

  var EmailController = TextEditingController();

  var PhoneController = TextEditingController();

  var ImageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          var model = ShopCubit
              .get(context)
              .userModel;
          TextController.text = model?.data?.name ?? '';
          EmailController.text = model?.data?.email ?? '';
          PhoneController.text = model?.data?.phone ?? '';
          ImageController.text = model?.data?.image ?? '';

          return ListView.separated(
            itemCount: 1,
            itemBuilder: (context, index) =>
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        if(state is ShopLoadingUpdateUserState)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: TextController,
                          type: TextInputType.text,
                          label: 'Name',
                          prefix: Icons.person,
                          validate: (Value) {
                            if (Value == null || Value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        defaultFormField(
                          controller: EmailController,
                          type: TextInputType.emailAddress,
                          label: 'Email',
                          prefix: Icons.email,
                          validate: (Value) {
                            if (Value == null || Value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        defaultFormField(
                          controller: PhoneController,
                          type: TextInputType.phone,
                          label: 'Phone Number',
                          prefix: Icons.phone,
                          validate: (Value) {
                            if (Value == null || Value.isEmpty) {
                              return 'Please enter your Phone';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        defaultFormField(
                          controller: ImageController,
                          type: TextInputType.url,
                          label: 'Image',
                          prefix: Icons.image,
                          validate: (Value) {
                            if (Value == null || Value.isEmpty) {
                              return 'Please enter your Phone';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultButton(
                          radius: 50,
                          width: 130,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).updateUserData(
                                  name: TextController.text,
                                  phone: PhoneController.text,
                                  email: EmailController.text,
                                  image: ImageController.text
                              );
                            }
                          },
                          text: 'update',
                          background: Colors.green,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: defaultButton(
                            radius: 50,
                            width: 95,
                            function: () {
                              SignOut(context);
                            },
                            text: 'Logout',
                            background: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => myDivider(),
          );
        },
        listener: (context, state) => {}

    );
  }
}