import 'package:pokemon_explorer/data/repositories/app_config_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_config_state.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  final AppConfigRepository _appConfigRepository;
  AppConfigCubit(this._appConfigRepository)
      : super(
          AppConfigState(
            langaugeCode: _appConfigRepository.locale.languageCode,
            userType: _appConfigRepository.userType,
            userId: _appConfigRepository.userId,
          ),
        );

  void setLocale(String languageCode) async {
    _appConfigRepository.setLocale(languageCode);
    emit(
      AppConfigState(
        langaugeCode: _appConfigRepository.locale.languageCode,
        userType: _appConfigRepository.userType,
        userId: _appConfigRepository.userId,
      ),
    );
  }

  void setUserData({String? userId, String? userType}) async {
    _appConfigRepository.setUserData(
      userId: userId,
      userType: userType,
    );
    emit(
      AppConfigState(
        langaugeCode: _appConfigRepository.locale.languageCode,
        userType: _appConfigRepository.userType,
        userId: _appConfigRepository.userId,
      ),
    );
  }
}
