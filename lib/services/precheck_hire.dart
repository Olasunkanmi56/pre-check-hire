// import 'dart:convert';
// import 'dart:io';

// import 'package:precheck_hire/utils/shared_preferences_storage.dart';
// import 'package:dio/dio.dart';
// //import 'package:precheck_hire/dtos/booking.dto.dart';
// //import 'package:precheck_hire/dtos/delivery.dto.dart';
// import 'package:precheck_hire/dtos/login.dto.dart';
// import 'package:precheck_hire/models/user.model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:precheck_hire/store/modules/user.module.dart';
// import 'package:precheck_hire/store/store.dart';
// import 'package:precheck_hire/utils/constants.dart';
// import 'package:precheck_hire/utils/custom_dialog.dart';
// import 'package:precheck_hire/utils/http_client.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ShoppersApi {
//   static UserModule get _userModule => store.getModule<UserModule>();
//   static User get _user => _userModule.user;
//   static final Dio _client = CustomHttpClient.shoppers().client;

//   static _extractData({required Response response}) {
//     print(response.data['data']);
//     print('coming from extract data');
//     return response.data;
//   }

//   //otp validation
//   static Future<Map> otpValidation({required Map data}) async {
//     var response = await _client.post(
//       '/users/emailTokenVerification',
//       data: data,
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //otp validation
//   static Future<Map> otpResend({required Map data}) async {
//     var response = await _client.post(
//       '/users/resendEmailVerification',
//       data: data,
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //otp validation
//   static Future<Map> rejectParcel({required Map data}) async {
//     var response = await _client.post(
//       '/admin/parcels/reject',
//       data: data,
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //otp validation
//   static Future<Map> acceptParcel({required Map data}) async {
//     // var response = await _client.post(
//     //   '/admin/parcels/accept',
//     //   data: data,
//     // );
//     String token = _user.token.toString();
//     var response = await _client.post(
//       '/admin/parcels/accept',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //otp validation
//   static Future<Map> rejParcel2({required Map data}) async {
//     // var response = await _client.post(
//     //   '/admin/parcels/accept',
//     //   data: data,
//     // );
//     String token = _user.token.toString();
//     var response = await _client.post(
//       '/admin/parcels/reject',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   // logout
//   static Future<Map> logOut() async {
//     String token = _user.token.toString();
//     var response = await _client.post(
//       '/users/logout',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //Create Coupon
//   static Future<Map> addCoupon({required data}) async {
//     String token = _user.token.toString();
//     var response = await _client.post(
//       '/retailers/coupons',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(response: response);
//   }

//   //Create review
//   static Future<Map> addOrderAll2({required data}) async {
//     String token = _user.token.toString();
//     var response = await _client.post(
//       '/reviews',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(response: response);
//   }

//   // static Future<Map> logOut() async {
//   //   return _extractData(
//   //     response: await _client.get('/users/logout'),
//   //   );
//   // }

//   //get signupotp
//   static Future<Map> signUpOTP({required Map data}) async {
//     var response = await _client.post(
//       '/users/emailVerification',
//       data: data,
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //signup
//   static Future<Map> signUp({required data}) async {
//     var response = await _client.post(
//       '/users/signup',
//       data: data,
//     );
//     return _extractData(
//       response: response,
//     );
//   }

// //forget password otp
//   static Future<Map> forgetPasswordOTP({required Map data}) async {
//     var response = await _client.post(
//       '/users/forgotPassword',
//       data: data,
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //RESET PASSWORD
//   static Future<Map> resetPassword({required Map data}) async {
//     var response = await _client.patch(
//       '/users/resetPassword',
//       data: data,
//     );
//     return _extractData(
//       response: response,
//     );
//   }

// //Login API
//   static Future<Map> login(LoginDto dto) async {
//     return _extractData(
//         response: await _client.post('/users/login', data: dto.toJSON()));
//   }

//   //get products

//   static Future<Map> getProducts() async {
//     return _extractData(
//       response: await _client.get('/products/productDetails'),
//     );
//   }

//   //delete vendor products
//   static Future<Map> deleteVendorProducts(id) async {
//     String token = _user.token.toString();
//     var response = await _client.delete(
//       '/retailers/products/$id',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //delete vendor products
//   static Future<Map> deleteVendorCoupon(id) async {
//     String token = _user.token.toString();
//     var response = await _client.delete(
//       '/retailers/coupons/$id',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //delete orders rider
//   static Future<Map> deleteRiderOrders(id) async {
//     String token = _user.token.toString();
//     var response = await _client.delete(
//       '/rider/orders/$id',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //get user info
//   static Future<Map> getUserInfo() async {
//     String token = _user.token.toString();
//     return _extractData(
//       response: await _client.get('/users/profile',
//           options: Options(
//             headers: {
//               HttpHeaders.authorizationHeader: 'Bearer $token',
//               'content-Type': 'application/json'
//             },
//           )),
//     );
//   }

//   //get dashboard info
//   static Future<Map> getDashInfo() async {
//     String token = _user.token.toString();
//     return _extractData(
//       response: await _client.get('/retailers/dashboard',
//           options: Options(
//             headers: {
//               HttpHeaders.authorizationHeader: 'Bearer $token',
//               'content-Type': 'application/json'
//             },
//           )),
//     );
//   }

//   //get Store info
//   static Future<Map> getVendorStore() async {
//     String token = _user.token.toString();
//     return _extractData(
//       response: await _client.get('/retailers/getRetailerStore',
//           options: Options(
//             headers: {
//               HttpHeaders.authorizationHeader: 'Bearer $token',
//               'content-Type': 'application/json'
//             },
//           )),
//     );
//   }

//   //get Store info
//   static Future<Map> getUserAllProduct() async {
//     String token = _user.token.toString();
//     return _extractData(
//       response: await _client.get('/users/getAllProducts',
//           options: Options(
//             headers: {
//               HttpHeaders.authorizationHeader: 'Bearer $token',
//               'content-Type': 'application/json'
//             },
//           )),
//     );
//   }

// //get dashboard info
//   static Future<Map> getDashRider() async {
//     String token = _user.token.toString();
//     return _extractData(
//       response: await _client.get('/riders/stats',
//           options: Options(
//             headers: {
//               HttpHeaders.authorizationHeader: 'Bearer $token',
//               'content-Type': 'application/json'
//             },
//           )),
//     );
//   }

//   //get dashboard info
//   static Future<Map> getCouponAll() async {
//     String token = _user.token.toString();
//     return _extractData(
//       response: await _client.get('/retailers/coupons',
//           options: Options(
//             headers: {
//               HttpHeaders.authorizationHeader: 'Bearer $token',
//               'content-Type': 'application/json'
//             },
//           )),
//     );
//   }

//   //get vendorProduct info
//   static Future<Map> getVendorProduct() async {
//     String token = _user.token.toString();
//     return _extractData(
//       response: await _client.get('/retailers/products',
//           options: Options(
//             headers: {
//               HttpHeaders.authorizationHeader: 'Bearer $token',
//               'content-Type': 'application/json'
//             },
//           )),
//     );
//   }

//   //fetch banks
//   static Future<Map> fetchBanks() async {
//     String token = _user.token.toString();
//     return _extractData(
//       response: await _client.get(
//         '/wallets/bankNameList',
//         options: Options(
//           headers: {
//             HttpHeaders.authorizationHeader: 'Bearer $token',
//           },
//         ),
//       ),
//     );
//   }

//   //update user profile
//   static Future<Map> updateUserProfile({required data}) async {
//     String token = _user.token.toString();
//     var response = await _client.patch(
//       '/users/updateProfile',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(response: response);
//   }

//   //Create Store
//   static Future<Map> createStore({required data}) async {
//     String token = _user.token.toString();
//     var response = await _client.post(
//       '/retailers/createStore',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(response: response);
//   }

//   static Future<Map> updateStoreData({required data}) async {
//     String token = _user.token.toString();
//     var response = await _client.patch(
//       '/retailers/updateStore',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(response: response);
//   }

//   //Create Store
//   static Future<Map> createProduct({required data}) async {
//     String token = _user.token.toString();
//     var response = await _client.post(
//       '/retailers/createProduct',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(response: response);
//   }

//   //sell
//   static Future<Map> riderliveReview({required data}) async {
//     String token = _user.token.toString();
//     var response = await _client.post(
//       '/reviews',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(response: response);
//   }

//   //sell
//   static Future<Map> sellProducts({required data}) async {
//     String token = _user.token.toString();
//     var response = await _client.post(
//       '/products/uploadProduct',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(response: response);
//   }

//   static Future<Map> kwikData({required data}) async {
//     String token = _user.token.toString();
//     var response = await _client.post(
//       '/products/addItemToCart',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(response: response);
//   }

//   //add item to cart
//   static Future<Map> addItemToCart({required data}) async {
//     String token = _user.token.toString();
//     var response = await _client.post(
//       '/products/addItemToCart',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(response: response);
//   }

//   //add item to cart
//   static Future<Map> addUserItemToCart({required data}) async {
//     String token = _user.token.toString();
//     var response = await _client.post(
//       '/users/cart',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(response: response);
//   }

//   //startpayment
//   static Future<Map> payment({required data}) async {
//     String token = _user.token.toString();
//     var response = await _client.post(
//       '/paystackTransactions/paystackPaymentInitialize',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //account security reset
//   // static Future<Map> resetSecurityPassword({required Map data}) async {
//   //   var response = await _client.patch(
//   //     '/users/updatePassword',
//   //     data: data,
//   //   );
//   //   return _extractData(
//   //     response: response,
//   //   );
//   // }
//   static Future<Map> resetSecurityPassword({required Map data}) async {
//     String token = _user.token.toString();
//     var response = await _client.patch(
//       '/users/updatePassword',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(response: response);
//   }

//   // //fetch category
//   // static Future<Map> fetchCategory() async {
//   //   return _extractData(
//   //       response: await _client.get('/products/productCategory'));
//   // }

//   //fetch user category
//   static Future<Map> fetchUserCategory() async {
//     return _extractData(response: await _client.get('/products/userCategory'));
//   }

//   //fetch user category
//   // static Future<Map> fetchFeaturedStore() async {
//   //   return _extractData(
//   //       response: await _client.get('/retailers/featured-stores'));
//   // }
//   static Future<Map> fetchFeaturedStore() async {
//     String token = _user.token.toString();
//     print('token$token');
//     var response = await _client.get(
//       '/retailers/featured-stores',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   static Future<Map> fetchAllRiderOrder() async {
//     String token = _user.token.toString();
//     print('token$token');
//     var response = await _client.get(
//       '/admin/parcels/all',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   static Future<Map> fetchAllStore() async {
//     String token = _user.token.toString();
//     print('token$token');
//     var response = await _client.get(
//       '/retailers/stores/all',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     print("GGG$response");
//     return _extractData(
//       response: response,
//     );
//   }

//   //fetch shoe sizes
//   // static Future<Map> fetchFeaturedStore() async {
//   //   return _extractData(
//   //       response: await _client.get(
//   //     '/retailers/featured-stores',
//   //   ));
//   // }

//   //fetch shoe sizes
//   static Future<Map> fetchWomenSizes() async {
//     return _extractData(response: await _client.get('/products/womenSize'));
//   }

//   //fetch states
//   static Future<Map> fetchStates() async {
//     var data = json.encode({"countryName": "Nigeria"});
//     var response = await _client.post(
//       '/users/stateNamebyCountryName',
//       data: data,
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //fetch cart products
//   static Future<Map> cartProducts() async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/users/cart',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //fetch cart products
//   static Future<Map> OrderProducts() async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/users/orders/active',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }
// //sendstack new booking

//   //fetch seller products
//   static Future<Map> sellerProducts() async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/sellers/getAllSellerProducts',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //fetch seller products
//   static Future<Map> userMessage(String? accountId) async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/conversation/get-all-conversation-user/$accountId',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     print("GLGGG$response");
//     return _extractData(
//       response: response,
//     );
//   }

//   //fetch seller products
//   static Future<Map> orderByID(int? orderId) async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/users/orders/$orderId',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     print("GLGGG$response");
//     return _extractData(
//       response: response,
//     );
//   }

//   // //logout
//   // static Future<Map> logOut() async {
//   //   String token = _user.token.toString();
//   //   var response = await _client.get(
//   //     '/users/logout',
//   //     options: Options(
//   //       headers: {
//   //         HttpHeaders.authorizationHeader: 'Bearer $token',
//   //       },
//   //     ),
//   //   );
//   //   return _extractData(
//   //     response: response,
//   //   );
//   // }

//   // product retailer ordered
//   static Future<Map> retailerOrder() async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/retailers/orders',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   // product retailer ordered
//   static Future<Map> retailerNotify() async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/notifications/getNotifications',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   // product retailer ordered
//   static Future<Map> retailerAllPayHistory() async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/transactions/getTransactionsHistory',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   // product ordered
//   static Future<Map> productOrdered() async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/products/userProductOrders',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //userprofile
//   static Future<Map> userProfile() async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/users/profile',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //complaint api
//   static Future<Map> complaintProduct({required data}) async {
//     String token = _user.token.toString();
//     var response = await _client.patch(
//       '/products/productComplaintMessage',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(response: response);
//   }

//   //delete cart products
//   static Future<Map> deleteCartProducts(int? id) async {
//     String token = _user.token.toString();
//     var response = await _client.delete(
//       '/users/cart/$id',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //sendstacklocations
//   static Future<Map> availableLocations() async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/deliveries/getSendStackAvailableLocations',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //sendstacklocations
//   static Future<Map> kwikLocations(String? query) async {
//     print("GLGGG$query");
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/deliveries/autocomplete?query="$query"',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     print("GLGGG$response");
//     return _extractData(
//       response: response,
//     );
//   }

//   //sendstacklocations
//   static Future<Map> searchMain(String? query) async {
//     print("GL00G$query");
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/users/searchProducts/search?query="$query"',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     print("GL00G$response");
//     return _extractData(
//       response: response,
//     );
//   }

//   //sendstacklocations
//   static Future<Map> productDetails(int? id) async {
//     print("GLGGG$id");
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/users/getProductById/$id',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     print("GLGGG$response");
//     return _extractData(
//       response: response,
//     );
//   }

//   //delete cart products
//   static Future<Map> deleteSellerProducts(id) async {
//     String token = _user.token.toString();
//     var response = await _client.delete(
//       '/sellers/deleteSellerProduct/$id',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //edit seller product
//   static Future<Map> getSellerProducts(id) async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/retailers/stores/$id',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //edit seller product
//   static Future<Map> getAllProfile() async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/users/profile',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   static Future<Map> updateSellerProducts(id, data) async {
//     print(data);
//     String token = _user.token.toString();
//     var response = await _client.patch(
//       '/sellers/updateSellerProduct/$id',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   static Future<Map> patchRiderOrder(id, data) async {
//     print(data);
//     String token = _user.token.toString();
//     var response = await _client.patch(
//       '/riders/orders/$id',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   static Future<Map> getRiderOrderbyId(id) async {
//     //print(data);
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/riders/orders/$id',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   static Future<Map> completedOrder() async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/users/orders/completed',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   static Future<Map> cancelledOrder() async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/users/orders/cancelled',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   static Future<Map> cancelActiveOrder(id, data) async {
//     print(data);
//     String token = _user.token.toString();
//     var response = await _client.patch(
//       '/users/orders/$id/cancel',
//       data: data,
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //seller details
//   static Future<Map> getSellerDetails(id) async {
//     String token = _user.token.toString();
//     var response = await _client.get(
//       '/users/sellerInfo/$id',
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   //verify account number
//   static Future<Map> verifyAccountNumber(
//       String accountNumber, String bankCode) async {
//     String token = _user.token.toString();

//     var response = await _client.post(
//       '/wallets/accountNumberValidation',
//       data: {
//         'receiverBankCode': bankCode,
//         'toAccountNumber': accountNumber,
//       },
//       options: Options(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $token',
//           'content-type': 'application/json'
//         },
//       ),
//     );
//     return _extractData(
//       response: response,
//     );
//   }

//   static Future<void> wrapRequest({
//     required Function request,
//     Function? preRequest,
//     Function? postRequest,
//     Function(Map)? onSuccess,
//     Function? onError,
//     required BuildContext context,
//     String successMessage = 'Transaction successful',
//     bool showSuccessModal = false,
//     bool hideErrorModal = false,
//     bool isMultiple = false,
//     Function(List)? onMultiSuccess,
//     bool skipResponseProcessing = false,
//     Function(dynamic)? extractError,
//   }) async {
//     try {
//       if (preRequest != null) preRequest();
//       var response = await request();
//       if (!skipResponseProcessing) {
//         if (isMultiple) {
//           if (onMultiSuccess != null) onMultiSuccess(response);
//         } else {
//           var status = response['status'] ?? response['status_code'];
//           if (status == 'success') {
//             if (onSuccess != null) {
//               onSuccess(response);
//             } else if (showSuccessModal) {
//               CustomDialog.success(context: context)
//                   .showSuccessDialog(message: successMessage);
//             }
//           } else if (status == 'fail') {
//             CustomDialog.error(context: context).showErrorDialog(
//               message: response['message'] ?? DEFAULT_SERVER_ERROR,
//             );
//           } else if (!hideErrorModal) {
//             print("Arafat $response");
//             handleErrorResponse(response, context, onError, hideErrorModal);
//           }
//         }
//       }
//     } catch (e) {
//       print("Error in wrapRequest: $e");
//       if (e is DioError) {
//         if (e.response != null) {
//           var responseBody = e.response!.data;
//           if (responseBody is Map<dynamic, dynamic>) {
//             handleErrorResponse(responseBody, context, onError, hideErrorModal);
//           } else {
//             handleErrorResponse(
//               {'message': responseBody.toString()},
//               context,
//               onError,
//               hideErrorModal,
//             );
//           }
//         }
//       } else {
//         // Handle other types of exceptions here
//       }
//     } finally {
//       if (postRequest != null) postRequest();
//     }
//   }

//   static void handleErrorResponse(
//     Map<dynamic, dynamic> response,
//     BuildContext context,
//     Function? onError,
//     bool hideErrorModal,
//   ) {
//     // Your existing error handling logic goes here
//     print("Arafat $response");
//     if (!hideErrorModal) {
//       (onError ??
//           (String response) {
//             CustomDialog.error(context: context)
//                 .showErrorDialog(message: response);
//           })(
//         response ?? DEFAULT_SERVER_ERROR,
//       );
//     }
//   }
// }


import 'package:precheck_hire/dtos/login.dto.dart';
import 'package:precheck_hire/dtos/login_response_dto.dart';

import '../dtos/signup_request_dto.dart';
import '../dtos/signup_response_dto.dart';
import 'dto_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<SignupResponseDto> signup(SignupRequestDto signupRequestDto) async {
    final dio = await DioClient.getInstance();
    final response = await dio.post('/users/signup', data: signupRequestDto.toJson());

    final signupResponse = SignupResponseDto.fromJson(response.data);

    // Save token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', signupResponse.token);

    return signupResponse;
  }

  Future<LoginResponseDto> login(LoginDto loginDto) async {
    final dio = await DioClient.getInstance();
    final response = await dio.post('/users/login', data: loginDto.toJson());

    final loginResponse = LoginResponseDto.fromJson(response.data);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', loginResponse.token);

    return loginResponse;
  }
}


