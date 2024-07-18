/// ValidationUtils is used for validation
extension ValidationUtils on String {
  /// Email
  String? validEmail({bool ignoreEmpty = false}) {
    if (isEmpty && ignoreEmpty) {
      return null;
    } else if (!emailRegex.hasMatch(trim())) {
      return 'Please enter valid email address';
    } else {
      return null;
    }
  }

  /// Password
  String? validPassword({bool ignoreEmpty = false}) {
    if (isEmpty && ignoreEmpty) {
      return null;
    } else if (trim().length < 6) {
      return 'Password must be atleast 6 characters';
    } else {
      return null;
    }
  }

  /// Name
  String? validName({bool ignoreEmpty = false}) {
    if (isEmpty && ignoreEmpty) {
      return null;
    } else if (trim().length < 2) {
      return 'Name should have more than 2 characters';
    } else {
      return null;
    }
  }
}

RegExp emailRegex = RegExp(
    r'''^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))''');
