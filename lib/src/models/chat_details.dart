import 'package:guidance/src/models/conversation.dart';
import 'package:guidance/src/models/user.dart';

import 'conversation.dart';

class Chat_Details {
  final int id;
  final Conversation conversation;
  final User ownerId;
  final String message;
  final String ctime;

  Chat_Details({
    required this.id,
    required this.conversation,
    required this.ownerId,
    required this.message,
    required this.ctime,
  });
}
