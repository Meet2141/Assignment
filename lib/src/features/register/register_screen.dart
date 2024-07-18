import 'package:assignment/src/constants/color_constants.dart';
import 'package:assignment/src/constants/routing_constants.dart';
import 'package:assignment/src/constants/string_constants.dart';
import 'package:assignment/src/service/auth_service.dart';
import 'package:assignment/src/utils/progress_loader_utils.dart';
import 'package:assignment/src/utils/toast_utils.dart';
import 'package:assignment/src/utils/validation_utils.dart';
import 'package:assignment/src/widgets/button_widgets.dart';
import 'package:assignment/src/widgets/text_field_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: ColorConstants.lightBlue,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(ctx).top,
          bottom: MediaQuery.paddingOf(ctx).bottom,
          left: 12,
          right: 12,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  StringConstants.myNews,
                  style: TextStyle(color: ColorConstants.primary, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  TextFieldWidgets(
                    controller: nameController,
                    hintText: StringConstants.name,
                    onChange: (value) {},
                    validate: (value) {
                      return value.toString().validName();
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFieldWidgets(
                    controller: emailController,
                    hintText: StringConstants.email,
                    keyboardType: TextInputType.emailAddress,
                    onChange: (value) {
                      setState(() {
                        formKey.currentState!.validate();
                      });
                    },
                    validate: (value) {
                      return value.toString().validEmail();
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFieldWidgets(
                    controller: passwordController,
                    hintText: StringConstants.password,
                    obscureText: true,
                    onChange: (value) {
                      setState(() {
                        formKey.currentState!.validate();
                      });
                    },
                    validate: (value) {
                      return value.toString().validPassword();
                    },
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  ButtonWidgets(
                    btnName: StringConstants.signUp,
                    onTap: () async {
                      if ((formKey.currentState?.validate() ?? false)) {
                        LoaderUtils.showProgressDialog(context);
                        UserCredential? userCredential = await _authService.signUpWithEmail(
                          emailController.text,
                          passwordController.text,
                        );

                        ///Enter new user details into fire store
                        if ((userCredential?.additionalUserInfo?.isNewUser ?? false)) {
                          var userRef = _authService.db.collection('users').doc(userCredential?.user?.uid);
                          var user = await userRef.get();
                          if (!user.exists) {
                            userRef.set({
                              'name': nameController.text,
                              'email': emailController.text,
                              'password': passwordController.text,
                            });
                          }
                          if (mounted) {
                            context.goNamed(RoutingConstants.home);
                          }
                        } else {
                          if (mounted) {
                            LoaderUtils.dismissProgressDialog(context);
                          }
                        }
                      } else {
                        ToastUtils.showFailed(message: StringConstants.somethingWentWrong);
                        LoaderUtils.dismissProgressDialog(context);
                      }
                    },
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(StringConstants.alreadyHaveAnAccount),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            context.goNamed(RoutingConstants.login);
                          },
                          child: const Text(
                            StringConstants.login,
                            style: TextStyle(color: ColorConstants.primary, fontWeight: FontWeight.w600),
                          ))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
