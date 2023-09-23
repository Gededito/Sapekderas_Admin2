import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sapekderas/models/enums.dart';
import 'package:sapekderas/models/user_model.dart';
import 'package:sapekderas/utils/utils.dart';

import '../../routes/routes.dart';
import '../../view_model/auth/cubit/login_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isHide = true;

  @override
  void initState() {
    super.initState();
    emailController =
        TextEditingController(text: kDebugMode ? "test@gmail.com" : "");
    passwordController =
        TextEditingController(text: kDebugMode ? "12345678" : "");
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SAPEKDERAS",
                style: FontsUtils.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 100),
              TextField(
                controller: emailController,
                // keyboardType: ,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: FontsUtils.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600),
                    suffixIcon: const Icon(
                      Icons.person,
                      size: 30,
                    )),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                obscureText: isHide,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: FontsUtils.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isHide = !isHide;
                      });
                    },
                    child: isHide
                        ? const Icon(
                            Icons.visibility_rounded,
                            // color: Colors.white,
                            size: 30,
                          )
                        : const Icon(
                            Icons.visibility_off_rounded,
                            size: 30,

                            // color: Colors.white,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 150,
                height: 40,
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.main, (context) => false);
                    } else if (state is LoginError) {
                      Fluttertoast.showToast(msg: state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsUtils.bgScaffold,

                          // backgroundColor:
                          //     const Color.fromRGBO(255, 255, 255, 1),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: Colors.black)),
                        ),
                        child: const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator()),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (emailController.text == "") {
                          Fluttertoast.showToast(
                            msg: "Email tidak boleh kosong",
                          );
                        } else if (!(RegUtils.regEmail
                            .hasMatch(emailController.text))) {
                          Fluttertoast.showToast(
                            msg: "Masukkan email yang benar",
                          );
                          return;
                        } else if (passwordController.text == "") {
                          Fluttertoast.showToast(
                            msg: "Password tidak boleh kosong",
                          );
                        } else {
                          context.read<LoginCubit>().loginEvent(UserModel(
                                email: emailController.text,
                                password: passwordController.text,
                                id: '',
                              ));
                          // context.read<LoginCubit>().addAdmin();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                        backgroundColor: ColorsUtils.bgScaffold,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.black)),
                      ),
                      child: Text(
                        'Login',
                        style: FontsUtils.poppins(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class LetterUserViewArgs {
  final UserModel? model;
  final Crud crud;

  const LetterUserViewArgs({this.model, this.crud = Crud.create});
}
