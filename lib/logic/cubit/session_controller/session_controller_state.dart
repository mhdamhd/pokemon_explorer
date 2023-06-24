part of 'session_controller_cubit.dart';

@immutable
abstract class SessionControllerState extends Equatable {
  final GlobalKey? globalKey;
  const SessionControllerState({this.globalKey});

  @override
  List<Object> get props => [];
}

class SessionControllerInitial extends SessionControllerState {
  SessionControllerInitial() : super(globalKey: GlobalKey());
}

class SessionControllerLoading extends SessionControllerState {}

class SessionControllerError extends SessionControllerState {
  final Object exception;

  const SessionControllerError(this.exception);
    @override
  List<Object> get props => [exception];
}

class SessionControllerSignedout extends SessionControllerState {
  SessionControllerSignedout() : super(globalKey: GlobalKey());
}