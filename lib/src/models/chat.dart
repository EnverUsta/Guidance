class Chat {
  final String id;
  final String tripId;
  final String userId;
  final String message;
  final String ctime;

  Chat({
    required this.id,
    required this.tripId,
    required this.userId,
    required this.message,
    required this.ctime,
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
