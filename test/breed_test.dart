import 'package:flutter/material.dart';
import 'package:flutter_dogapp/model/breedItem.dart';
import 'package:flutter_dogapp/services/repository.dart';
import 'package:flutter_dogapp/ui/breed_detail.dart';
import 'package:flutter_dogapp/ui/login.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test Login text value', (WidgetTester tester) async {
        Widget testWidgetLogin = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: LoginWidget(repository: MockLoginRepository()))
);
    await tester.pumpWidget(testWidgetLogin);
    await tester.pumpAndSettle();
    final titleFinder = find.text('LoginOK200');
    expect(titleFinder, findsOneWidget);
    expect(find.text('1'), findsNothing);
  });

  testWidgets('Text Breed Detail', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: BreedDetail(breedItem: BreedItem(breedImagePath: "test", breedName: "Beagle"),repository: MockLoginRepository()))
);
    await tester.pumpWidget(testWidget);
await tester.pumpAndSettle();
    final titleFinder = find.text('Beagle');
    expect(titleFinder, findsOneWidget);
    final subTypeFinder = find.text("Chèvre");
    expect(subTypeFinder, findsOneWidget);
    expect(find.text('Labrador'), findsNothing);
  });
}

class MockLoginRepository extends RepositoryType {
  @override
  Future<String> fetchAPIStatus() async {
    return "LoginOK200";
  }

  @override
  Stream<List<BreedItem>> fetchAllBreeds() {
    throw UnimplementedError();
  }

  @override
  Future<String> fetchRandomPicture(String name) async {
    return "MyBeautifulPicture";
  }

  @override
  Future<List<String>> fetchSubBreeds(String name) async {
    return ["Vache", "Chèvre", "Poule", "Ray"];
  }
}
