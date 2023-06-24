import 'package:pokemon_explorer/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_controller_state.dart';

class SessionControllerCubit extends Cubit<SessionControllerState> {
  final AuthRepository _authRepository;
  SessionControllerCubit(this._authRepository)
      : super(SessionControllerInitial());

  void signout() async {
    try {
      await _authRepository.signout();

      emit(SessionControllerSignedout());

      emit(SessionControllerInitial());
    } catch (e, s) {
      emit(SessionControllerError(e));
    }
  }
}
