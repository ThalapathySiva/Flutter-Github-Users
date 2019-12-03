class UserModel {
  final String userName, html_url,image;

  UserModel({this.userName, this.html_url,this.image});

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(html_url: json["html_url"], userName: json["login"],image: json["avatar_url"]);
  }
}
