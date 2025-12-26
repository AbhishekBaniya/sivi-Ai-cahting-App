/*class PortfolioModel {
  final int id;
  final String name, username, email, phone, website;
  //final String description;

  PortfolioModel({required this.id, required this.name, required this.username, required this.email, required this.phone, required this.website,});

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
      website: json["website"],
    );
  }
}*/

// To parse this JSON data, do
//
//     final portfolioModel = portfolioModelFromJson(jsonString);

import 'dart:convert';

PortfolioModel portfolioModelFromJson(String str) =>
    PortfolioModel.fromJson(json.decode(str));

String portfolioModelToJson(PortfolioModel data) => json.encode(data.toJson());

class PortfolioModel {
  final List<Comment>? comments;
  final int? total;
  final int? skip;
  final int? limit;

  PortfolioModel({this.comments, this.total, this.skip, this.limit});

  factory PortfolioModel.fromJson(Map<String, dynamic> json) => PortfolioModel(
    comments: json["comments"] == null
        ? []
        : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "comments": comments == null
        ? []
        : List<dynamic>.from(comments!.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Comment {
  final int? id;
  final String? body;
  final int? postId;
  final int? likes;
  final User? user;

  Comment({this.id, this.body, this.postId, this.likes, this.user});

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    body: json["body"],
    postId: json["postId"],
    likes: json["likes"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "body": body,
    "postId": postId,
    "likes": likes,
    "user": user?.toJson(),
  };
}

class User {
  final int? id;
  final String? username;
  final String? fullName;

  User({this.id, this.username, this.fullName});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    fullName: json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "fullName": fullName,
  };
}
