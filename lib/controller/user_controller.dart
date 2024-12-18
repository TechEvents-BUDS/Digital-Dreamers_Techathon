import 'package:bidobid/repositories/user_repository.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _userRepo = Get.put(UserRepository());

  Future<List<UserModel>> getAllUser() async {
    return await _userRepo.allUser();
  }
}
