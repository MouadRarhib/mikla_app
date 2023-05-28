import 'package:get/get.dart';
import 'package:mikla_project/data/repository/user_repo.dart';
import 'package:mikla_project/models/user_model.dart';

import '../models/response_model.dart';
import '../models/signup_body_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isLoading = false;
  late UserModel _userModel;

  bool get isLoading => _isLoading;

  UserModel get userModel => _userModel;
  // late ResponseModel responseModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    print(response.body.toString());
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response
          .body); // we convert data from json to object and we put it in the variable (_usermodel)
      _isLoading = true;
      responseModel = ResponseModel(true, "sucessfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    update();
    return responseModel;
  }
}
