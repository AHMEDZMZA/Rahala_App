import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/di/service_locator.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/shared/widgets/app_loading.dart';
import 'package:rahala/core/shared/widgets/app_snackbar.dart';
import 'package:rahala/core/shared/widgets/app_text_field.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/user/auth/presentation/widgets/social_auth_buttons.dart';
import '../cubit/auth_state_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthStateCubit>(
      create: (context) => getIt<AuthStateCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AuthStateCubit, AuthStateState>(
            listener: (context, state) {
              if (state is AuthStateSuccess) {
                AppSnackbar.showSuccess(
                  context: context,
                  message: 'تم تسجيل الدخول بنجاح',
                );
                if (state.user.isAdmin) {
                  context.go(RouteNames.adminDashboard);
                } else {
                  context.go(RouteNames.home);
                }
              } else if (state is AuthStateError) {
                AppSnackbar.showError(context: context, message: state.message);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  if (state is AuthStateLoading)
                    Container(
                      color: Colors.black.withAlpha(76),
                      child: const Center(child: AppLoading()),
                    ),

                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.p24,
                      vertical: AppSizes.p32,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          40.h.verticalSpace,
                          Text(
                            AppStrings.welcome,
                            style: AppTextStyles.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                          AppSizes.p8.verticalSpace,
                          Text(
                            AppStrings.loginSubtitle,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          40.h.verticalSpace,
                          AppTextField(
                            controller: _emailController,
                            hintText: AppStrings.emailHint,
                            labelText: AppStrings.emailLabel,
                            type: AppTextFieldType.email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'البريد الالكترونى مطلوب';
                              } else if (!value.contains('@')) {
                                return 'البريد الالكترونى غير صحيح';
                              }
                              return null;
                            },
                          ),
                          AppSizes.p16.verticalSpace,
                          AppTextField(
                            controller: _passwordController,
                            hintText: AppStrings.passwordHint,
                            labelText: AppStrings.passwordLabel,
                            type: AppTextFieldType.password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'كلمة المرور مطلوبة';
                              } else if (value.length < 6) {
                                return 'كلمه المرور يجب ان تكون 6 احرف على الاقل ';
                              }
                              return null;
                            },
                          ),
                          AppSizes.p8.verticalSpace,
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                AppStrings.forgotPassword,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          AppSizes.p24.verticalSpace,
                          AppButton(
                            text: AppStrings.login,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthStateCubit>().login(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );
                              }
                            },
                          ),
                          AppSizes.p32.verticalSpace,
                          const SocialAuthButtons(),
                          40.h.verticalSpace,
                          RichText(
                            text: TextSpan(
                              text: AppStrings.dontHaveAccount,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              children: [
                                TextSpan(
                                  text: AppStrings.register,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        context.go(RouteNames.register),
                                ),
                              ],
                            ),
                          ).center(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
