import 'dart:io';

class UserPost {
  int postId;
  int userId;
  String createdAt;
  String title;
  String description;
  File image;
  List<int> postLikedBy;

  UserPost(
      {required this.postId,
      required this.userId,
      required this.createdAt,
      required this.title,
      required this.description,
      required this.image,
      required this.postLikedBy});
  Map<String, dynamic> toJson() {
    String imagePath = image.path;
    return {
      'postId': postId,
      'userId': userId,
      'createdAt': createdAt,
      'title': title,
      'description': description,
      'image': imagePath,
      'postLikedBy': postLikedBy,
      // Map other properties accordingly...
    };
  }

  factory UserPost.fromJson(Map<String, dynamic> json) {
    File? imageFile = json['image'] != "" ? File(json['image']) : null;
    return UserPost(
      postId: json['postId'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      title: json['title'],
      description: json['description'],
      image: imageFile!,
      postLikedBy: List<int>.from(json['postLikedBy']),
    );
  }
  bool isLikedByUser(int userId) {
    return postLikedBy.contains(userId);
  }
}

// List<UserDetail> userDetailList = [];
