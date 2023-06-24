import 'dart:ui';

import 'package:pokemon_explorer/data/data_providers/api_client.dart';
import 'package:pokemon_explorer/data/utils/errors.dart';
import 'package:pokemon_explorer/generated/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

const String baseURL = 'example.org', languageCode = 'en';
late ApiClient apiClient;

void arrangeHttpClientThrowsClientExceptionOnceThenSucceeds() {
  int count = 0;
  setHttpClient(
    MockClient(
      (request) async {
        count++;
        if (count < 2) throw ClientException('Failure');
        return Response('Success', 200, request: request);
      },
    ),
  );
}

void arrangeHttpClientReturnsTransientHttpError(
    {required HttpTransientErrorCodes errorCode}) {
  int count = 0;
  setHttpClient(
    MockClient(
      (request) async {
        count++;
        return (count < 2)
            ? Response(errorCode.name, errorCode.statusCode, request: request)
            : Response('Success', 200, request: request);
      },
    ),
  );
}

void arrangeHttpClientReturnsHttpErrorCode(int errorCode) {
  int count = 0;
  setHttpClient(
    MockClient(
      (request) async {
        count++;
        return (count < 2)
            ? Response('Failure', errorCode, request: request)
            : Response('Success', 200, request: request);
      },
    ),
  );
}

void setHttpClient(Client client) => apiClient = ApiClient(
      baseURL: baseURL,
      languageCode: languageCode,
      client: client,
    );

void main() async {
  setUp(() async {
    apiClient = ApiClient(baseURL: baseURL, languageCode: languageCode);
    return S.load(const Locale('en'));
  });

  tearDown(() {
    apiClient.close();
  });

  group('HTTP Client', () {
    test('Retries GET requests on http.ClientException', () async {
      //Arrange
      arrangeHttpClientThrowsClientExceptionOnceThenSucceeds();
      //Act
      final responseBody = await apiClient.invokeApi<String>('/examples',
          requestType: HttpRequestType.get);
      //Assert
      expect(responseBody, 'Success');
    });

    for (final transientErrorCode in HttpTransientErrorCodes.values) {
      test(
          'Retries GET requests on HTTP Error ${transientErrorCode.statusCode}',
          () async {
        //Arrange
        arrangeHttpClientReturnsTransientHttpError(
            errorCode: transientErrorCode);
        //Act
        final responseBody = await apiClient.invokeApi<String>('/examples',
            requestType: HttpRequestType.get);
        //Assert
        expect(responseBody, 'Success');
      });
    }

    for (final httpRequestType in HttpRequestType.values) {
      test('Does not retry any request on HTTP Error 401', () async {
        //Arrange
        arrangeHttpClientReturnsHttpErrorCode(401);
        //Act
        final responseFuture = apiClient.invokeApi<String>('/examples',
            requestType: httpRequestType);
        //Assert
        await expectLater(
            responseFuture, throwsA(isA<SessionExpiredException>()));
      });
    }

    for (int errorCode = 400; errorCode < 600; errorCode++) {
      if (errorCode == 401) continue;
      test('Does not retry POST requests on any HTTP Error', () async {
        //Arrange
        arrangeHttpClientReturnsHttpErrorCode(errorCode);
        //Act
        final responseFuture = apiClient.invokeApi<String>('/examples',
            requestType: HttpRequestType.post);
        //Assert

        await expectLater(responseFuture, throwsA(isA<ServerException>()));
      });
    }

    for (int errorCode = 400; errorCode < 600; errorCode++) {
      if (errorCode == 401) continue;
      test('Does not retry DELETE requests on any HTTP Error', () async {
        //Arrange
        arrangeHttpClientReturnsHttpErrorCode(errorCode);
        //Act
        final responseFuture = apiClient.invokeApi<String>('/examples',
            requestType: HttpRequestType.delete);
        //Assert

        await expectLater(responseFuture, throwsA(isA<ServerException>()));
      });
    }
  });
}
