import 'package:flutter/material.dart';
import 'package:flutter_dogapp/blocs/breed_list_bloc.dart';
import 'package:flutter_dogapp/model/breedItem.dart';
import 'package:flutter_dogapp/services/repository.dart';
import 'package:flutter_dogapp/ui/breed_detail.dart';

class BreedList extends StatefulWidget {
  @override
  _BreedListState createState() => _BreedListState();
}

class _BreedListState extends State<BreedList> {
  BreedListBloc listBloc;

  @override
  void initState() {
    super.initState();
    listBloc = BreedListBloc();
    listBloc.fetchAllMovies();
  }

  @override
  void dispose() {
    listBloc.dispose();
    super.dispose();
  }

  Widget buildList(AsyncSnapshot<List<BreedItem>> snapshot) {
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
        itemCount: snapshot.data.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              child: Column(
                children: [
                  Container(
                      child: Text(
                        snapshot.data[index].breedName.capitalize(),
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                      margin: EdgeInsets.only(bottom: 5)),
                  Image.network(
                    snapshot.data[index].breedImagePath,
                    fit: BoxFit.cover,
                    width: width / 2 - 50,
                    height: width / 2 - 50,
                  ),
                ],
              ),
              onTap: () => openDetailPage(snapshot.data[index]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of breeds'),
      ),
      body: StreamBuilder(
        stream: listBloc.allBreeds,
        builder: (context, AsyncSnapshot<List<BreedItem>> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  openDetailPage(BreedItem item) {
    Navigator.of(context).push(_goToBreedDetail(item));
  }
}

Route _goToBreedDetail(BreedItem breed) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        BreedDetail(breedItem: breed, repository: Repository()),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
