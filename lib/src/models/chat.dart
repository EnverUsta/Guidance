class Chat {
  String? id;
  String tripId;
  String userId;
  String message;
  String ctime;
  
  Chat({
    required this.tripId,
    required this.userId,
    required this.message,
    required this.ctime,
    this.id,
  });

  Chat.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        tripId = json['tripId'],
        userId = json['userId'],
        message = json['message'],
        ctime = json['ctime'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'tripId': tripId,
        'userId': userId,
        'message': message,
        'ctime': ctime,
      };
}
