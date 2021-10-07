import 'package:dio/dio.dart';

class NetworkHandler {
  NetworkHandler._privateConstructor();

  static final NetworkHandler _instance = NetworkHandler._privateConstructor();

  factory NetworkHandler() {
    return _instance;
  }

  Future<Response> makeGetRequest(String requestURL) async {
    Response response = await Dio().get(
      requestURL,
    );
    return response;
  }

  Future<Response> makePostRequest(String requestURL) async {
    Response response =
        await Dio().post(requestURL);
    return response;
  }
}
