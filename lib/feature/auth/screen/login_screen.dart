import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/resources/colors.dart';
import 'package:flutter_application_sidorma/core/resources/fonts.dart';
import 'package:flutter_application_sidorma/core/utils/size_config.dart';
import 'package:flutter_application_sidorma/core/utils/token_helper.dart';
import 'package:flutter_application_sidorma/core/widget/custom_form_button.dart';
import 'package:flutter_application_sidorma/core/widget/custom_input_field.dart';
import 'package:flutter_application_sidorma/feature/auth/bloc/bloc/login_bloc.dart';
import 'package:flutter_application_sidorma/feature/home/screen/home_screen.dart';
import 'package:flutter_application_sidorma/feature/profile_walisiswa/screen/profile_wali_siswa_screen.dart';
import 'package:flutter_application_sidorma/feature/wali_siswa/wali_siswa_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

import 'example_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userController =
      TextEditingController(text: 'zulis@mail.com');
  TextEditingController passwordController =
      TextEditingController(text: '1301204037');

  final _loginBloc = LoginBloc();
  final _tokenHelper = TokenHelper();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xffEEF1F3),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/icons/ic_telyu.png',
                            width: 200,
                            height: 200,
                          ),
                          // Container(
                          //   width: 100,
                          //   height: 100,
                          //   decoration: BoxDecoration(
                          //     color: ColorsGlobal.secondaryColor,
                          //     shape: BoxShape.circle,
                          //   ),
                          // ),

                          const SizedBox(
                            height: 22,
                          ),
                          CustomInputField(
                              textEditingController: userController,
                              labelText: 'NIM',
                              hintText: ('Masukkan NIM'),
                              validator: (textValue) {
                                if (textValue == null || textValue.isEmpty) {
                                  return 'NIP is required!';
                                }

                                return null;
                              }),
                          const SizedBox(
                            height: 14,
                          ),
                          CustomInputField(
                            textEditingController: passwordController,
                            labelText: ('Password'),
                            hintText: ('Masukkan Password'),
                            obscureText: true,
                            suffixIcon: true,
                            validator: (textValue) {
                              if (textValue == null || textValue.isEmpty) {
                                return 'Password is required!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          // Container(
                          //   width: size.width * 0.80,
                          //   alignment: Alignment.centerRight,
                          //   child: GestureDetector(
                          //     onTap: () => {},
                          //     child: Text(
                          //       'Forget password?',
                          //       style: FontsGlobal.mediumTextStyle12,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 40,
                          ),
                          BlocConsumer<LoginBloc, LoginState>(
                            bloc: _loginBloc,
                            listener: (context, state) {
                              if (state is LoginSuccess) {
                                _tokenHelper.saveToken(
                                    state.responseLogin.data.accessToken);
                                if (state.responseLogin.data.user.role ==
                                    'mahasiswa') {
                                  _tokenHelper.saveRole(
                                      state.responseLogin.data.user.role);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()));
                                } else {
                                  _tokenHelper.saveRole(
                                      state.responseLogin.data.user.role);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const WaliSiswaScreen(),
                                    ),
                                  );
                                }
                              }
                            },
                            builder: (context, state) {
                              return CustomFormButton(
                                innerText: ('Login'),
                                onPressed: () {
                                  _loginBloc.add(
                                    LoginButtonPressed(
                                      email: userController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
