import 'package:guidance/src/utils/helpers/validator.dart';
import 'package:flutter_test/flutter_test.dart';


void main() async{
  test('Validator.validateEmail | tests if a@a valid, false', () {
    expect(false, Validator.validateEmail("a@a"));
  });

  test('Validator.validateEmail | tests if berke@gmail.com valid, true', () {
    expect(true, Validator.validateEmail("berke@gmail.com"));
  });

  test('Validator.validateEmail | tests if @gmail.com valid, false', () {
    expect(false, Validator.validateEmail("@gmail.com"));
  });  

  test('Validator.validateEmail | tests if gmail.com valid, false', () {
    expect(false, Validator.validateEmail("gmail.com"));
  });  
}