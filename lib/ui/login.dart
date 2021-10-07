import 'package:flutter/material.dart';
import 'package:flutter_dogapp/blocs/login_bloc.dart';
import 'package:flutter_dogapp/services/repository.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({this.repository});
  final RepositoryType repository;
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc(repository: widget.repository);
    loginBloc.fetchStatus();
  }

  @override
  void dispose() {
    loginBloc.dispose();
    super.dispose();
  }

  Widget _renewButton() {
    return InkWell(
      onTap: () {
        resetLoginStatus();
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
      title: Text('Login'),
      actions: <Widget>[_renewButton()],
    );
  }

  Widget buildStatusText(AsyncSnapshot<String> snapshot) {
    return Center(
        child: Text(
      snapshot.data,
      style: TextStyle(fontSize: 30, color: Colors.green),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _myAppBar(),
      body: StreamBuilder(
        stream: loginBloc.apiStatus,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return buildStatusText(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void resetLoginStatus() {
    loginBloc.fetchStatus();
  }
}
