part of 'app_config_cubit.dart';

class AppConfigState extends Equatable {
  final String langaugeCode;
  final String userType;
  final String userId;
  const AppConfigState({required this.langaugeCode, required this.userType , required this.userId});

  @override
  List<Object> get props => [langaugeCode , userType , userId];
}
