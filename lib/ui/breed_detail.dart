import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dogapp/blocs/breed_detail_bloc.dart';
import 'package:flutter_dogapp/model/breedItem.dart';
import 'package:flutter_dogapp/services/repository.dart';

class BreedDetail extends StatefulWidget {
  BreedDetail({this.breedItem, this.repository});
  final BreedItem breedItem;
  final RepositoryType repository;

  @override
  _BreedDetailState createState() => _BreedDetailState();
}

class _BreedDetailState extends State<BreedDetail> {
  BreedDetailBloc detailBloc;
  String imagePath;
  bool pressedRenew;

  @override
  void initState() {
    super.initState();
    pressedRenew = false;
    imagePath = widget.breedItem.breedImagePath;
    print(jsonEncode(widget.breedItem.breedImagePath).toString());
    detailBloc = BreedDetailBloc(repository: widget.repository);
    detailBloc.fetchAllSubBreeds(widget.breedItem.breedName);
  }

  @override
  void dispose() {
    detailBloc.dispose();
    super.dispose();
  }

  Widget buildList(AsyncSnapshot<List<dynamic>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.pets),
              title: Text(snapshot.data[index]),
            ),
          );
        });
  }

  Widget _renewButton() {
    return InkWell(
      onTap: () {
        resetImagePath();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.refresh,
            size: 40,
            color: Colors.white,
          )),
    );
  }

  Widget _myAppBar() {
    return AppBar(
      title: Text(widget.breedItem.breedName.capitalize()),
      actions: <Widget>[_renewButton()],
    );
  }

  Widget _subTitleWidget() {
    return Container(
        height: 30,
        child: Text("Sous-races",
            style: TextStyle(
              color: Colors.blue[600],
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            )));
  }

    Widget _lineWidget() {
    return Container(height: 2, color: Colors.grey);
  }

  @override
  Widget build(BuildContext context) {
    var pageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _myAppBar(),
      body: Container(
        height: pageHeight,
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 300,
              child: (pressedRenew)
                  ? StreamBuilder(
                      stream: detailBloc.randomImageString,
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Image.network(
                            snapshot.data,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    )
                  : (imagePath != "test" ) ? Image.network(
                      widget.breedItem.breedImagePath,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ) : Container(),
            ),
            _lineWidget(),
            _subTitleWidget(),
            Expanded(
              child: StreamBuilder(
                stream: detailBloc.allSubBreeds,
                builder: (context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasData) {
                    return buildList(snapshot);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetImagePath() {
    detailBloc.fetchRandomPicture(widget.breedItem.breedName);
    setState(() {
      pressedRenew = true;
    });
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
