part of 'setting_cubit.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingLoadingState extends SettingState {}

class SettingLoadedState extends SettingState{
  final bool fcmValue;
  const SettingLoadedState({required this.fcmValue});

  @override
  List<Object> get props => [fcmValue];
}

class SettingErrorState extends SettingState{}