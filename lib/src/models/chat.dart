import 'user.dart';
import 'trip.dart';

class Chat {
  final String id;
  final Trip trip;
  final User owner;
  final String message;
  final String ctime;

  Chat({
    required this.id,
    required this.trip,
    required this.owner,
    required this.message,
    required this.ctime,
  });
}
