import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../resource/app_string.dart';
import '../../../app/cubit/auth_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitState>(
      builder: (context, state) {
        String buttonTitle = AppString.homeLogin;
        Function onPressed = () => context.pushNamed('login');
        if (state is AuthInitial && state.isLoggedIn) {
          buttonTitle = AppString.dashboardProfile;
          onPressed = () => context.pushNamed('profile');
        }
        return TextButton(
          onPressed: () => onPressed(),
          child: Text(buttonTitle),
        );
      },
    );
  }
}
