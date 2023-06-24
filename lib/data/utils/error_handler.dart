import 'dart:async';
import 'dart:developer';

import 'dart:io';

import 'package:pokemon_explorer/data/utils/errors.dart';
import 'package:pokemon_explorer/generated/l10n.dart';
import 'package:pokemon_explorer/logic/cubit/session_controller/session_controller_cubit.dart';
import 'package:pokemon_explorer/presentation/utils/app_toast.dart';
import 'package:pokemon_explorer/presentation/widgets/common/error_widgets.dart';
import 'package:flutter/material.dart';

import 'package:provider/src/provider.dart';

class ErrorHandler<T> {
  final dynamic exception;
  final StackTrace? stackTrace;

  ErrorHandler({required this.exception, this.stackTrace}) {
    log('exception ${this.exception}');
    log(
      'stack trace  ${this.stackTrace}',
    );
  }

  Exception rethrowError() {
    final e = this.exception;
    if (e is SocketException) {
      return NoInternetConnectionException<T>(
        message: S.current.noInternetConnection,
      );
    } else if (e is TimeoutException) {
      return NoInternetConnectionException<T>(
        message: S.current.noInternetConnection,
      );
    } else if (e is NoInternetConnectionException<T>) {
      return e;
    } else if (e is ServerException) {
      return ServerException<T>(
        message: e.message,
      );
    } else if (e is ForceUpdate) {
      //TODO: HANDLE FORCE UPDATE
    } else if (e is AppUnderMaintenance) {
      //TODO: HANDLE APP UNDER MAINTAINECE
    } else if (e is SessionExpiredException) {
      return e;
    } else if (e is ParsingException) {
      log('\n');
      log("can not parse response : ${e.message} ");
      log("stack : ${e.stack!}");
      log('\n');
      return UnknownException<T>(
        message: S.current.anErrorOccured,
      );
    }
    return UnknownException<T>(
      message: S.current.anErrorOccured,
    );
  }

  Widget buildErrorWidget(
      {required BuildContext context, required VoidCallback retyCallback}) {
    if (exception is NoInternetConnectionException) {
      return ButtonErrorWidget(
        onPressed: retyCallback,
        message: exception.message,
      );
    }
    if (exception is ServerException) {
      return ButtonErrorWidget(
        onPressed: retyCallback,
        message: exception.message,
      );
    } else if (exception is SessionExpiredException) {
      context.read<SessionControllerCubit>().signout();
      AppToast(message: exception.message).show();
      return LabelErrorWidget(message: exception.message);
    } else if (exception is UnknownException) {
      return ButtonErrorWidget(
        onPressed: retyCallback,
        message: exception.message,
      );
    }
    return ButtonErrorWidget(
      enableButton: false,
      onPressed: retyCallback,
    );
  }

  String getErrorMessage() {
    if (exception is NoInternetConnectionException) {
      return (exception as NoInternetConnectionException).message;
    }
    if (exception is ServerException) {
      return (exception as ServerException).message;
    }
    return S.current.anErrorOccured;
  }

  void handlelError(BuildContext context, {Function? sessionExpiredOverride}) {
    final e = this.exception;
    if (e is NoInternetConnectionException ||
        e is ServerException ||
        e is UnknownException) {
      // showFadeInModal(context: context, text: e.message);

      AppToast(message: e.message).show();
      return;
    } else if (e is SessionExpiredException) {
      if (sessionExpiredOverride == null) {
        context.read<SessionControllerCubit>().signout();
        AppToast(message: exception.message).show();
      } else {
        sessionExpiredOverride();
      }

      return;
    }
    AppToast(
      message: S.current.anErrorOccured,
    ).show();
  }
}
