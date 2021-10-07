import 'dart:async';
import 'package:flutter_dogapp/model/breedItem.dart';
import 'package:flutter_dogapp/services/repository.dart';

class BreedListBloc {
  final _repository = Repository();
  final _moviesFetcher = StreamController<List<BreedItem>>();

  Stream<List<BreedItem>> get allBreeds => _moviesFetcher.stream;

  fetchAllMovies() async {
    _repository.fetchAllBreeds().listen((value) {
      if (!_moviesFetcher.isClosed) {
        _moviesFetcher.sink.add(value);
      }
    });
  }

  dispose() {
    _moviesFetcher.close();
  }
}
