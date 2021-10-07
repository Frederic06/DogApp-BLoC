import 'dart:async';
import 'package:flutter_dogapp/services/repository.dart';

class LoginBloc {
  LoginBloc({this.repository});
  RepositoryType repository;
  // final _repository = Repository();
  final _statusFetcher = StreamController<String>();

  Stream<String> get apiStatus => _statusFetcher.stream;

  fetchStatus() async {
    var statusResponseString = await repository.fetchAPIStatus();
    _statusFetcher.sink.add(statusResponseString);
  }

  dispose() {
    _statusFetcher.close();
  }
}
