import 'trip.dart';

class Chat {
  final String id;
  final String tripId;
  final String userEmail;
  final String userName;
  final String message;
  final String ctime;

  Chat({
    required this.id,
    required this.tripId,
    required this.userEmail,
    required this.userName,
    required this.message,
    required this.ctime,
  });

  Chat.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        tripId = json['tripId'],
        userEmail = json['userEmail'],
        userName = json['userName'],
        message = json['message'],
        ctime = json['ctime'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'tripId': tripId,
        'userEmail': userEmail,
        'userName': userName,
        'message': message,
        'ctime': ctime,
      };
}
