import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapplication/screens/register_screen.dart';
import 'package:shopapplication/screens/shop_layout.dart';
import '../dio/cache_helper.dart';
import '../login/cubit_login.dart';
import '../login/states_login.dart';
import '../models/login_model.dart';
import '../shared/components.dart';
import '../shared/constants.dart';

class LoginScreen extends StatefulWidget {
  ShopLoginModel? loginModel;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var _obscureText = true;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: HexColor('#301c06'), fontSize: 50),
                          ),
                        ),
                        Text('Login to see our hot offers!',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: HexColor('#dba06b'),
                                    )),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'Email-Address',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.email,
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ListView(
                          shrinkWrap:
                              true, // Prevent ListView from taking up full screen height
                          physics:
                              NeverScrollableScrollPhysics(), // Disable scrolling
                          children: [
                            if (state
                                is! ShopLoginLoadingState) // Condition check
                              defaultButton(
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).UserLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'login',
                                isUpperCase: true,
                                background: HexColor('#80532a'),
                              )
                            else // Fallback
                              Center(child: CircularProgressIndicator()),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: HexColor('#dba06b'),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                );
                              },
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: HexColor('#301c06'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginmodel.status!) {
              print(state.loginmodel.message);
              print(state.loginmodel.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginmodel.data!.token,
              ).then((value) {
                // Mark the then block as async
                token = state.loginmodel.data!.token!;
                // Wait for navigation to complete before exiting the listener
                navigateandfinish(
                  context,
                  ShopLayout(),
                );
              });
            } else {
              print(state.loginmodel.message);
              ShowToast(
                text: state.loginmodel.message!,
                state: ChooseToastColor.ERROR,
              );
            }
          }
        },
      ),
    );
  }
}
