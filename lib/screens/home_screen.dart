import 'package:bloc_demo/bloc/user_bloc.dart';
import 'package:bloc_demo/components/user_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _filter = new TextEditingController();
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Example');

  @override
  void initState() {
    super.initState();
    userbloc.getUser();

    _filter.addListener(() {
      if (_filter.text != "") {
        userbloc.searchUser(_filter.text);
      } else {
        userbloc.getUser();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildBar(context), body: layout());
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          autofocus: true,
          controller: _filter,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text('Github Users');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  Widget layout() {
    return userStream();
  }

  Widget userStream() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(height: 10),
          Expanded(
            child: StreamBuilder(
                stream: userbloc.userlist,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CupertinoActivityIndicator());
                  }
                  if (snapshot.hasData) {
                    return UserList(
                      userlist: snapshot.data,
                    );
                  }
                  return Container();
                }),
          ),
        ],
      ),
    );
  }
}
