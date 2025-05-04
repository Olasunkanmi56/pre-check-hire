// import 'package:precheck_hire/dtos/login.dto.dart';

// import 'package:precheck_hire/models/profile.dart';
// //import 'package:precheck_hire/models/profile.dart';
// import 'package:precheck_hire/models/user.model.dart';
// import 'package:precheck_hire/services/eko_foods.dart';
// import 'package:precheck_hire/utils/shared_preferences_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:precheck_hire/flutter_super_state/lib/src/store.dart';
// import 'package:precheck_hire/flutter_super_state/lib/src/store_module.dart';

// class UserModule extends StoreModule {
//   var _user = User();
//   var _profile = Profile();
//   bool _isLoading = false;

//   UserModule(Store store) : super(store);

//   User get user => _user;
//   Profile get profile => _profile;

//   bool get isLoading => _isLoading;

//   void _setLoading(bool loading) => setState(() => _isLoading = loading);

//   void _updateUser(User userData) => setState(() => _user = userData);

//   void _updateProfile(Profile profileData) =>
//       setState(() => _profile = profileData);

//   Future<Map> login(LoginDto dto, {required BuildContext context}) async {
//     Map response = <dynamic, dynamic>{};
//     print("saveUser");

//     try {
//       print("TrysaveUser");

//       await ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context.mounted,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.login(dto),
//         onSuccess: (Map apiResponse) async {
//           print("apiresonsecheck33: ");

//           response = apiResponse;
//           String token = apiResponse['token'];
//           print("apiresonsecheck: $apiResponse");

//           User user = User.fromJSON({
//             'token': token,
//             ...apiResponse['data'],
//           });
//           _updateUser(user);
//           print("Update user call");
//         },
//       );
//       await userProfile(context: context);
//     } catch (e) {
//       print("Error in wrapRequest333: $e");
//     }
//     return response;
//   }

//   Future<Map> userProfile({required BuildContext context}) async {
//     Map response = <dynamic, dynamic>{};
//     try {
//       await ShoppersApi.wrapRequest(
//           context: context,
//           hideErrorModal: context.mounted,
//           preRequest: () => _setLoading(true),
//           postRequest: () => _setLoading(false),
//           request: () => ShoppersApi.userProfile(),
//           onSuccess: (Map apiResponse) async {
//             response = apiResponse;
//             Profile profile = Profile.fromJSON(apiResponse['data']);
//             print("Profile fetched: $apiResponse");
//             _updateProfile(profile);
//           });
//     } catch (e) {
//       print("Error fetching profile: $e");
//     }
//     return response;
//   }

//   void logout() => _updateUser(User(token: ''));
// }


import 'package:flutter/material.dart';
import 'package:precheck_hire/dtos/signup_request_dto.dart';
import 'package:precheck_hire/models/user.model.dart';
import 'package:precheck_hire/services/precheck_hire.dart';


class AuthStore extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  User? user;

  Future<void> signup(SignupRequestDto signupRequestDto) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _authService.signup(signupRequestDto);

      user = User(
        id: response.data.id,
        firstName: response.data.firstName,
        lastName: response.data.lastName,
        email: response.data.email,
        phoneNumber: response.data.phoneNumber,
        address: response.data.address,
        role: response.data.role,
      );
    } catch (e) {
      print('Signup failed: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
