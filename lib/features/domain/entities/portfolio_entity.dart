/*
class PortfolioEntity {
  final int id;
  final String name, username, email, phone, website;

  PortfolioEntity({required this.id, required this.name, required this.username, required this.email, required this.phone, required this.website, });
}
*/

class PortfolioEntity {
  List<CommentsEntity>? comments;
  int? total;
  int? skip;
  int? limit;

  PortfolioEntity({this.comments, this.total, this.skip, this.limit});
}

class CommentsEntity {
  int? id;
  String? body;
  int? postId;
  int? likes;
  UserEntity? userEntity;

  CommentsEntity({
    this.id,
    this.body,
    this.postId,
    this.likes,
    this.userEntity,
  });
}

class UserEntity {
  int? id;
  String? username;
  String? fullName;

  UserEntity({this.id, this.username, this.fullName});
}
