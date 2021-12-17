class Chat {
  String tripId;
  String userId;
  String message;
  String ctime;
  
  Chat({
    required this.tripId,
    required this.userId,
    required this.message,
    required this.ctime,
  });

  Chat.fromJson(Map<String, dynamic> json)
      : tripId = json['tripId'],
        userId = json['userId'],
        message = json['message'],
        ctime = json['ctime'];

  Map<String, dynamic> toJson() => {
        'tripId': tripId,
        'userId': userId,
        'message': message,
        'ctime': ctime,
      };
}
