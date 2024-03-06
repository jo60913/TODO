part of 'auth_cubit.dart';

abstract class AuthCubitState extends Equatable {
  const AuthCubitState();
}

class AuthInitial extends AuthCubitState {
  final bool isLoggedIn;
  final String? userID;

  const AuthInitial({required this.isLoggedIn, this.userID});

  @override
  List<Object> get props => [];
}
