import 'package:bloc_demo/model/user_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserList extends StatefulWidget {
  final List<UserModel> userlist;

  UserList({this.userlist});
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(height: 10),
      itemCount: widget.userlist.length,
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 5),
          if (widget.userlist[index].image != null)
            Image.network(
              widget.userlist[index].image,
              height: 50,
              width: 50,
            ),
          SizedBox(width: 10),
          InkWell(
              onTap: () {
                _launchURL(widget.userlist[index].html_url);
              },
              child: Text(
                "${widget.userlist[index].userName}",
                style: TextStyle(decoration: TextDecoration.underline),
              ))
        ],
      ),
    );
  }
}

_launchURL(url) async {
  print(url);
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
