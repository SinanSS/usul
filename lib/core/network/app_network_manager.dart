import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '/core/di/injection.dart';
import '/core/error/failure.dart';
import '/core/logger/app_logger.dart';
import '/models/base_model.dart';

class AppNetworkManager {
  static final AppNetworkManager _instance = AppNetworkManager._internal();
  factory AppNetworkManager() => _instance;
  AppNetworkManager._internal();

  final http.Client _client = http.Client();
  String baseUrl = 'https://api.example.com';
  String? _authToken;
  late final AppLogger _logger = getIt<AppLogger>();

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (_authToken != null) 'Authorization': 'Bearer $_authToken',
  };

  void setAuthToken(String? token) => _authToken = token;
  void setBaseUrl(String url) => baseUrl = url;

  Future<Either<Failure, BaseModel<T>>> request<T>(
    String endpoint, {
    dynamic body,
    required T Function(dynamic json) fromJson,
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final url = _buildUri(endpoint, queryParameters);
      final headers = _headers;

      _logger.d('Request: ${method.name.toUpperCase()} $url');
      if (body != null) _logger.d('Body: $body');

      final http.Response response = await _executeRequest(
        method: method,
        url: url,
        headers: headers,
        body: body,
      );

      _logger.d('Response: ${response.statusCode} - ${response.body}');

      return _handleResponse(response, fromJson);
    } on SocketException catch (e) {
      _logger.e('No internet connection', error: e);
      return Left(Failure.noInternet());
    } on HttpException catch (e) {
      _logger.e('Server error', error: e);
      return Left(Failure.serverError());
    } on FormatException catch (e) {
      _logger.e('Bad response format', error: e);
      return Left(Failure.badResponse());
    } catch (e) {
      _logger.e('Unknown error', error: e);
      return Left(Failure.unknown(e.toString()));
    }
  }

  Future<http.Response> _executeRequest({
    required HttpMethod method,
    required Uri url,
    required Map<String, String> headers,
    dynamic body,
  }) async {
    final encodedBody = body != null ? jsonEncode(body) : null;

    switch (method) {
      case HttpMethod.get:
        return await _client.get(url, headers: headers);
      case HttpMethod.post:
        return await _client.post(url, headers: headers, body: encodedBody);
      case HttpMethod.put:
        return await _client.put(url, headers: headers, body: encodedBody);
      case HttpMethod.patch:
        return await _client.patch(url, headers: headers, body: encodedBody);
      case HttpMethod.delete:
        return await _client.delete(url, headers: headers, body: encodedBody);
    }
  }

  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParameters) {
    final url = endpoint.startsWith('http') ? endpoint : '$baseUrl$endpoint';
    final uri = Uri.parse(url);

    if (queryParameters != null && queryParameters.isNotEmpty) {
      return uri.replace(queryParameters: queryParameters);
    }
    return uri;
  }

  Either<Failure, BaseModel<T>> _handleResponse<T>(
    http.Response response,
    T Function(dynamic json) fromJson,
  ) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        final jsonData = jsonDecode(response.body);
        final data = fromJson(jsonData);
        return Right(BaseModel(data: data, message: 'Success'));
      } catch (e) {
        return Left(Failure.parseError(e.toString()));
      }
    } else {
      return Left(Failure.fromStatusCode(response.statusCode, response.body));
    }
  }

  void dispose() => _client.close();
}

enum HttpMethod { get, post, put, patch, delete }
