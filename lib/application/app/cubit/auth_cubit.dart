import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(const AuthInitial(isLoggedIn: false));

  void authStateChange({User? user}) {
    debugPrint("authStateChange 是否登入 ${user != null} ${user?.uid}");
    final bool isLoggIn = user != null;
    emit(AuthInitial(
      userID: user?.uid,
      isLoggedIn: isLoggIn,
    ));
  }
}
