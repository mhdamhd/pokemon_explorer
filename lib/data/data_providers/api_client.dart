import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:pokemon_explorer/data/utils/api_deserializer.dart';
import 'package:pokemon_explorer/data/utils/errors.dart';
import 'package:pokemon_explorer/generated/l10n.dart';
import 'package:pokemon_explorer/res/app_res.dart';
import 'package:http/retry.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  late final http.Client httpClient;
  late final SharedPreferences prefs;

  String? _token;
  String? _langaugeCode;

  final String baseURL;

  ApiClient({
    required this.baseURL,
    required String languageCode,
    http.Client? client,
  }) {
    httpClient = RetryClient(
      client ?? http.Client(),
      when: (response) =>
          response.request!.method.toLowerCase() == HttpRequestType.get.name &&
          HttpTransientErrorCodes.values
              .any((errorCode) => errorCode.statusCode == response.statusCode),
      whenError: (error, stackTrace) => error is http.ClientException,
    );
    _langaugeCode = languageCode;
  }

// setters
  void setLanguageCode(String code) {
    _langaugeCode = code;
  }

  void setCredentials(String? token, int? userId) {
    _token = token;

    _saveToken();
  }

// getters
  void get languageCode => _langaugeCode;

  String? get token => _token;

  Map<String, String> head({String? contentType, String? auth, String? token}) {
    return {
      "Authorization": auth ?? "Bearer ${token ?? _token}",
      "Content-Type": contentType ?? "application/json",
      "language": _langaugeCode!,
      "app": "android",
      "version": "1.2.0",
    };
  }

  Future<R?> invokeApi<R>(
    String path, {
    HttpRequestType requestType = HttpRequestType.get,
    Map<String, String>? headers,
    Object? body,
    List<File?> files = const [],
  }) async {
    final Uri url = Uri.parse('$baseURL$path');

    late final http.Response response;
    Map<String, String> requestHeaders = headers ?? head();
    try {
      if (requestType == HttpRequestType.get) {
        response = await httpClient.get(url, headers: requestHeaders);
        ///
        print('sdffffffffffffffffffffffffffffffffffff');
        print(response.toString());
        ///
      } else if (requestType == HttpRequestType.post) {
        if (files.isEmpty) {
          response =
              await httpClient.post(url, headers: requestHeaders, body: body);
        } else {
          Map<String, String> requestBody = {};

          (body as Map).forEach((key, value) {
            requestBody[key.toString()] = value.toString();
          });
          var request = http.MultipartRequest(
            'POST',
            url,
          );

          request.headers.addAll(requestHeaders);
          request.fields.addAll(requestBody);

          for (var file in files) {
            request.files.add(await http.MultipartFile.fromPath(
                file!.path.split(".").first, file.path,
                contentType: MediaType('file', file.path.split(".").last)));
          }

          var streamResponse = await httpClient.send(request);

          response = await http.Response.fromStream(streamResponse);
        }
      } else if (requestType == HttpRequestType.delete) {
        response = await httpClient.delete(url, headers: requestHeaders);
      }
      log('ENDPOINT $path');
      log('STATUS CODE ${response.statusCode}');
      log('RESPONSE BODY ${response.body}');
      String source = const Utf8Decoder().convert(response.bodyBytes);
      if (response.statusCode == 401) {
        throw SessionExpiredException(message: S.current.sessionExpired);
      } else if (response.statusCode >= 400) {
        String message = 'Server error';
        try {
          message = json.decode(source)["message"];
        } finally {
          throw ServerException(message: message);
        }
      }

      return ApiDeserializer<R>(rawJson: response.body).deserialize() as R;
    } catch (e, s) {
      ///
      print('errrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      print(e.toString());
      ///
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }

  Future<void> loadToken() async {
    prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(Constants.tokenKey);
  }

  Future<void> removeToken() async {
    _token = null;

    await prefs.remove(Constants.tokenKey);
  }

  void _saveToken() async {
    if (_token != null) {
      prefs.setString(Constants.tokenKey, _token!);
    }
  }

  void close() => httpClient.close();
}

enum HttpRequestType {
  get,
  post,
  delete,
}

enum HttpTransientErrorCodes {
  requestTimeout(408),
  internalServerError(500),
  badGateway(502),
  serviceUnavailable(503),
  gatewayTimeout(504);

  final int statusCode;

  const HttpTransientErrorCodes(this.statusCode);
}
