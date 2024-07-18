import 'package:assignment/src/constants/color_constants.dart';
import 'package:assignment/src/constants/routing_constants.dart';
import 'package:assignment/src/constants/string_constants.dart';
import 'package:assignment/src/service/auth_service.dart';
import 'package:assignment/src/utils/progress_loader_utils.dart';
import 'package:assignment/src/utils/toast_utils.dart';
import 'package:assignment/src/utils/validation_utils.dart';
import 'package:assignment/src/widgets/button_widgets.dart';
import 'package:assignment/src/widgets/text_field_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.lightBlue,
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top, bottom: MediaQuery.paddingOf(context).bottom, left: 12, right: 12),
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
                    btnName: StringConstants.login,
                    onTap: () async {
                      if ((formKey.currentState?.validate() ?? false)) {
                        LoaderUtils.showProgressDialog(context);
                        await authService
                            .signInWithEmail(
                          emailController.text,
                          passwordController.text,
                        )
                            .then((userCredential) {
                          if (userCredential?.user != null) {
                            ToastUtils.showSuccess(message: StringConstants.loginSuccess);
                            LoaderUtils.dismissProgressDialog(context);
                            context.goNamed(RoutingConstants.home);
                          } else {
                            LoaderUtils.dismissProgressDialog(context);
                          }
                        });
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
                      const Text(StringConstants.newHere),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            context.goNamed(RoutingConstants.register);
                          },
                          child: const Text(
                            StringConstants.signUp,
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
