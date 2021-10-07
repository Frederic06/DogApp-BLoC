import 'package:flutter/material.dart';
import 'package:flutter_dogapp/model/breedItem.dart';
import 'package:flutter_dogapp/ui/breed_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'breed_test.dart';

void main() {
  testWidgets('Widget tests', (WidgetTester tester) async {
    Widget testWidgetLogin = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: BreedDetail(
          repository: MockLoginRepository(),
          breedItem: BreedItem(
              breedImagePath:
                  'test',
              breedName: "Appenzeller"),
        )));
    await tester.pumpWidget(testWidgetLogin);

    final titleFinder = find.text('Appenzeller');
    expect(titleFinder, findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    final subTitleFind = find.text('Sous-races');
    expect(subTitleFind, findsOneWidget);
  });
}
