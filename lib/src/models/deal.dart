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

  Deal.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        trip = json['trip'],
        dealDate = json['dealDate'],
        dealStatus = json['dealStatus'],
        ctime = json['ctime'],
        utime = json['utime'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'trip': trip,
        'dealDate': dealDate,
        'dealStatus': dealStatus,
        'ctime': ctime,
        'utime': utime,
      };
}
