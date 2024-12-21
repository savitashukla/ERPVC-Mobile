import 'package:formz/formz.dart';

// Define input validation errors
enum TextInputError { empty }

class TextInputData extends FormzInput<String, TextInputError> {

  const TextInputData.pure() : super.pure('');

  const TextInputData.dirty({String value = ''}) : super.dirty(value);

  @override
  TextInputError? validator(String value) {
    return value.isEmpty ? TextInputError.empty : null;
  }
}