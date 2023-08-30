class UserFriendList {
  int id;
  int userId;
  int friendId;
  int requestedBy;
  String createdAt;
  bool hasNewRequest;
  bool hasNewRequestAccepted;
  bool hasRemoved;
  UserFriendList(
      {required this.id,
      required this.userId,
      required this.friendId,
      required this.requestedBy,
      required this.createdAt,
      required this.hasNewRequest,
      required this.hasNewRequestAccepted,
      required this.hasRemoved});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'friendId': friendId,
      'requestedBy': requestedBy,
      'createdAt': createdAt,
      'hasNewRequest': hasNewRequest,
      'hasNewRequestAccepted': hasNewRequestAccepted,
      'hasRemoved': hasRemoved,
    };
  }

  factory UserFriendList.fromJson(Map<String, dynamic> json) {
    return UserFriendList(
      id: json['id'],
      userId: json['userId'],
      friendId: json['friendId'],
      requestedBy: json['requestedBy'],
      createdAt: json['createdAt'],
      hasNewRequest: json['hasNewRequest'],
      hasNewRequestAccepted: json['hasNewRequestAccepted'],
      hasRemoved: json['hasRemoved'],
    );
  }
}

// List<User> userList = [];
