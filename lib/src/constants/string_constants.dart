
import 'package:assignment/src/app_state/app_state.dart';

///StringConstants - Strings Constants are defined here
class StringConstants {
  static const appName = 'Assignment';
  static const developerName = 'Meet Shah';
  static const by = 'by';
  static const home = 'Home';
  static const welcome = 'Welcome!';
  static const myNews = 'MyNews';
  static const name = 'Name';
  static const email = 'Email';
  static const password = 'Password';
  static const login = 'Login';
  static const signUp = 'SignUp';
  static const newHere = 'New here?';
  static const alreadyHaveAnAccount = 'Already have an account?';
  static const topHeadlines = 'Top Headlines';
  static const logoutSuccess = 'Logout Success!!';
  static const loginSuccess = 'Login Success!!';
  static const signUpSuccess = 'SignUp Successfully!!';
  static const userAlreadyExist = 'User Already Exist!!';
  static const apiKey = '{YOUR_KEY}';

  //Error
  static const requestTimedOut = 'Request timed out';
  static const serverError = 'Server error';
  static const connectTimedOut = 'Connect timed out';
  static const pleaseTryAgain = 'Please try again.';
  static const somethingWentWrong = 'Something Went Wrong';
  static const pleaseCheckInternet = 'Please Check Internet';
  static const internetConnectionLost = 'Internet connection lost. Please retry';
  static const errorMessage = 'Authentication failed, Please contact to admin for onBoarding!';
}

///Created typedef for Map<String, dynamic> (JSON File Type)
typedef JsonPayLoad = Map<String, dynamic>;

/// Global variable for AppState class
AppState appState = AppState();
