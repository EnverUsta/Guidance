import 'package:guidance/src/models/conversation.dart';

import 'conversation.dart';
import 'enum/deal_status.dart';

class Deal {
  final id;
  final Conversation conversation;
  final String dealDate;
  final DealStatus dealStatus;
  final String ctime;
  final String utime;

  Deal({
    required this.id,
    required this.conversation,
    required this.dealDate,
    required this.dealStatus,
    required this.ctime,
    required this.utime,
  });
}
