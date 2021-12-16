import 'package:flutter/material.dart';
import 'package:guidance/src/models/myContactModel.dart';

var now = DateTime.now();
String convertedDateTime =
    "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
var yesterday = DateTime.now().subtract(Duration(days: 1));
String convertedDateTime2 =
    "${yesterday.year.toString()}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}";
var messageTime1 = "2021-12-15";
var vtDate1 = DateTime.parse(messageTime1);
var messageTime2 = "2021-12-14";
var vtDate2 = DateTime.parse(messageTime2);
var messageTime3 = "2021-12-13";
var vtDate3 = DateTime.parse(messageTime3);

class ChatModel {
  final String lastMessage;
  final String lastMessageTime;
  final ContactModel contact;
  bool? isDeal;

  ChatModel(
      {required this.lastMessage,
      required this.lastMessageTime,
      required this.contact,
      this.isDeal});

  static List<ChatModel> list = [
    ChatModel(
        lastMessage: "Deal!",
        isDeal: true,
        lastMessageTime: (messageTime1 == convertedDateTime)
            ? "today"
            : (messageTime1 == convertedDateTime2)
                ? "yesterday"
                : messageTime1,
        contact: ContactModel(name: "Ahmet Demir")),
    ChatModel(
        lastMessage: "Sorry can't make it",
        isDeal: false,
        lastMessageTime: (messageTime2 == convertedDateTime)
            ? "today"
            : (messageTime2 == convertedDateTime2)
                ? "yesterday"
                : messageTime2,
        contact: ContactModel(name: "Burak Ekinci")),
    ChatModel(
        lastMessage: "Hi!",
        isDeal: null,
        lastMessageTime: (messageTime3 == convertedDateTime)
            ? "today"
            : (messageTime3 == convertedDateTime2)
                ? "yesterday"
                : messageTime3,
        contact: ContactModel(name: "Mehmet Yazıcı")),
  ];
}
