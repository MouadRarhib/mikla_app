import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mikla_project/data/repository/auth_repo.dart';
import 'package:mikla_project/models/response_model.dart';
import 'package:mikla_project/models/signup_body_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late ResponseModel responseModel;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      //when you login the token has been saved
      authRepo.saveUserToken(response.body["token"]);

      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  Future<ResponseModel> login(String email, String password) async {
    late ResponseModel responseModel;
    //just for testing
    /*print("Getting token");
    print(authRepo.getUserToken().toString());*/
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password);
    //late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("Backend token");
      authRepo.saveUserToken(response.body["token"]);
      print(response.body["token"].toString());
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  bool userLoggedIn() {
    return authRepo
        .userLoggedIn(); // we used containsKey because it return a bool
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}
