import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiosk_app/core/constants/text_style_constants.dart';
import 'package:kiosk_app/core/utils/extensions.dart';
import 'package:kiosk_app/core/utils/navigation_utils.dart';
import 'package:kiosk_app/core/utils/size_utils.dart';
import 'package:kiosk_app/features/auth/bloc/auth_bloc.dart';
import 'package:kiosk_app/features/home/screen/home_screen.dart';
import 'package:kiosk_app/generated/assets_const.dart';
import 'package:kiosk_app/shared/widgets/custom_text_field.dart';
import 'package:kiosk_app/shared/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthBloc _authBloc = AuthBloc();
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();

  @override
  void dispose() {
    _authBloc.close();
    _txtEmail.dispose();
    _txtPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = SizeUtils.isTablet(context);
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: _authBloc,
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: isTablet ? 200 : 0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            20.height,
                            Image.asset(Assets.imgLogin),
                            100.height,
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Login",
                                style: TextStyleConstants.h2(),
                              ),
                            ),
                            10.height,
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Theme.of(context).dividerColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  CustomTextField(
                                    controller: _txtEmail,
                                    label: "Email Address",
                                    hint: "Enter email",
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) {
                                      _authBloc.add(EmailChangedEvent(email: value));
                                    },
                                  ),

                                  16.height,

                                  CustomTextField(
                                    controller: _txtPassword,
                                    label: "Password",
                                    hint: "Enter password",
                                    obscureText: !state.isPasswordVisible,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    onChanged: (value) {
                                      _authBloc.add(PasswordChangedEvent(password: value));
                                    },
                                    suffix: IconButton(
                                      onPressed: () {
                                        _authBloc.add(
                                          PasswordVisibilityEvent(
                                            isVisible: !state.isPasswordVisible,
                                          ),
                                        );
                                      },
                                      icon: state.isPasswordVisible
                                          ? const Icon(Icons.visibility_outlined)
                                          : const Icon(Icons.visibility_off_outlined),
                                    ),
                                  ),

                                  12.height,

                                  // Remember Me
                                  GestureDetector(
                                    onTap: () {
                                      _authBloc.add(
                                        RememberMeTapEvent(
                                          isRemember: !state.isRememberMe,
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          state.isRememberMe
                                              ? Assets.icCheckBoxFill
                                              : Assets.icCheckBox,
                                        ),
                                        8.width,
                                        Text(
                                          'Remember me',
                                          style: TextStyleConstants.bodyMedium(
                                            size: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            60.height,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Sign in button
                PrimaryButton(
                  label: "Log In",
                  isEnabled: state.isLoginEnabled,
                  onTap: () {
                    NavigationUtils.pushReplacement(context, const HomeScreen());
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
