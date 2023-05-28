import 'package:get/get.dart';
import 'package:mikla_project/data/api/Api_client.dart';
import 'package:mikla_project/models/signup_body_model.dart';
import 'package:mikla_project/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences; // for saving data inside the app
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(
        AppConstants.LOGIN_URI, {"email": email, "password": password});
  }

  /* token is verification String from server
  that tells you okay you are authenticated
  */
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  //  method for checking login
  bool userLoggedIn() {
    return sharedPreferences.containsKey(
        AppConstants.TOKEN); // we used containsKey because it return a bool
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
