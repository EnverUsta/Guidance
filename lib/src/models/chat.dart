import 'user_model.dart';
import 'trip.dart';

class Chat {
  final String id;
  final Trip trip;
  final UserModel owner;
  final String message;
  final String ctime;

  Chat({
    required this.id,
    required this.trip,
    required this.owner,
    required this.message,
    required this.ctime,
  });

  Chat.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        trip = json['trip'],
        owner = json['owner'],
        message = json['message'],
        ctime = json['ctime'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'trip': trip,
        'owner': owner,
        'message': message,
        'ctime': ctime,
      };
}
