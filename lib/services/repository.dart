import 'dart:async';
import 'package:flutter_dogapp/Model/breedListResponse.dart';
import 'package:flutter_dogapp/model/breedItem.dart';
import 'package:flutter_dogapp/model/subBreedResponse.dart';
import 'package:flutter_dogapp/services/network_handler.dart';
import 'package:flutter_dogapp/services/route.dart';

class Repository extends RepositoryType {
  Repository._privateConstructor();

  static final Repository _instance = Repository._privateConstructor();

  factory Repository() {
    return _instance;
  }

  Stream<List<BreedItem>> fetchAllBreeds() async* {
    var response =
        await NetworkHandler().makeGetRequest(kGetAllBreedsURLString);

    if (response.statusCode == 200) {
      var breedList = List<BreedItem>.empty(growable: true);

      var list = breedListResponseFromJson(response.data).getBreedList();

      for (var filename in list) {
        var urlSS = getRandomBreedImage(filename);

        var newResponse = await NetworkHandler().makeGetRequest(urlSS);
        if (newResponse.statusCode == 200) {
          var imagesPath = newResponse.data["message"];

          var newBreedItem =
              BreedItem(breedName: filename, breedImagePath: imagesPath);

          breedList.add(newBreedItem);
          yield breedList;
        } else {
          print("error: ${response.statusMessage}");
          throw Exception('Erreur dans la récupération des données');
        }
      }
    } else {
      throw Exception('Erreur dans la récupération des données');
    }
  }

  Future<String> fetchRandomPicture(String name) async {
    String requestURLString = getRandomImageFromBreed(name);
    var response = await NetworkHandler().makeGetRequest(requestURLString);
    if (response.statusCode == 200) {
      return response.data["message"];
    } else {
      throw Exception('Erreur dans la récupération des données');
    }
  }

  Future<List<String>> fetchSubBreeds(String name) async {
    String requestURLString = getSubBreedList(name);
    print(requestURLString);
    var response = await NetworkHandler().makeGetRequest(requestURLString);

    if (response.statusCode == 200) {
      var subreeds = subBreedListFromJson(response.data);
      return subreeds.message;
    } else {
      return List<String>.empty(growable: true);
    }
  }

  Future<String> fetchAPIStatus() async {
    var response = await NetworkHandler().makeGetRequest(kLoginURLString);
    var responseString =
        response.statusCode.toString() + response.statusMessage;
    return responseString;
  }
}

abstract class RepositoryType {
  Future<String> fetchAPIStatus();
  Future<List<String>> fetchSubBreeds(String name);
  Stream<List<BreedItem>> fetchAllBreeds();
  Future<String> fetchRandomPicture(String name);
}
