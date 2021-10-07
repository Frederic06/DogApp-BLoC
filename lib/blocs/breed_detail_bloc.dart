import 'dart:async';
import 'package:flutter_dogapp/services/repository.dart';

class BreedDetailBloc {
  BreedDetailBloc({this.repository});
  RepositoryType repository;
  
  final _breedFetcher = StreamController<List<String>>();
  final _imageFetcher = StreamController<String>();

  Stream<List<String>> get allSubBreeds => _breedFetcher.stream;
  Stream<String> get randomImageString => _imageFetcher.stream;

  fetchAllSubBreeds(String breedName) async {
    var subBreedNames = await repository.fetchSubBreeds(breedName);
    _breedFetcher.sink.add(subBreedNames);
  }

  fetchRandomPicture(String breedName) async {
    String pictureUrlString = await repository.fetchRandomPicture(breedName);
    _imageFetcher.sink.add(pictureUrlString);
  }

  dispose() {
    _breedFetcher.close();
    _imageFetcher.close();
  }
}
