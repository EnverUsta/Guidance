import 'trip.dart';
import 'enum/deal_status.dart';

class Deal {
  final String id;
  final Trip trip;
  final String dealDate;
  final DealStatus dealStatus;
  final String ctime;
  final String utime;

  Deal({
    required this.id,
    required this.trip,
    required this.dealDate,
    required this.dealStatus,
    required this.ctime,
    required this.utime,
  });
}
