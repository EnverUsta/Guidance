// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:guidance/src/models/user_model.dart';
import 'package:guidance/src/utils/test_mocks/mock_user_service.dart';

void main() async {
  var ts = MUserService();

  test("user_service | tests if user service be able to create user", () async {
    await ts.createUser(UserModel(
        id: "1",
        name: "Berke",
        surname: "Yavas",
        email: "by@gm",
        role: "Guide",
        country: "Finland",
        city: "Helsinki"));
    var userinfo = await ts.getUserInfo("by@gm");
    expect(userinfo.name, "Berke");
    await ts.createUser(UserModel(
        id: "2",
        name: "Merke",
        surname: "Favas",
        email: "mf@gm",
        role: "Tourist",
        country: "Minland",
        city: "Felsinki"));
  });

  test('user_service | tests if user service be able to retrieve all users', () async {
    var user = await ts.getUsers();
    expect(user.length, 2);
    expect(user.elementAt(0).name, "Berke");
    expect(user.elementAt(1).name, "Merke");
  });

  test('user_service | tests if user service be able to get guides available by city', () async {
    var user = await ts.getGuides("Helsinki");
    expect(1, user.length);
  });

  test('user_service | tests if service be able to get user info by mail address', () async {
    var user = await ts.getUserInfo("by@gm");
    expect("Berke", user.name);
  });

  // var guideservice = MGuideInfoService();
}
