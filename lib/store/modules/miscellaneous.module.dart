// import 'dart:async';

// import 'package:dio/dio.dart';
// import 'package:precheck_hire/models/allRiderOder.dart';
// import 'package:precheck_hire/models/cancelledOrder.dart';
// import 'package:precheck_hire/models/carts.dart';
// import 'package:precheck_hire/models/category.dart';
// import 'package:precheck_hire/models/completedOrder.dart';
// import 'package:precheck_hire/models/couponNew.dart';
// import 'package:precheck_hire/models/dashModel.dart';
// import 'package:precheck_hire/models/detailsModel.dart';
// import 'package:precheck_hire/models/featuredStore.dart';
// import 'package:precheck_hire/models/getProfileModel.dart';
// import 'package:precheck_hire/models/notifyList.dart';
// import 'package:precheck_hire/models/ordersbyid.dart';
// import 'package:precheck_hire/models/pendingRider.dart';
// import 'package:precheck_hire/models/productStore.dart';
// import 'package:precheck_hire/models/query.dart';
// import 'package:precheck_hire/models/retailOrder.dart';
// import 'package:precheck_hire/models/search_model.dart';
// import 'package:precheck_hire/models/statRider.dart';

// import 'package:precheck_hire/models/orders.dart';
// import 'package:precheck_hire/models/productTransaction.dart';
// import 'package:precheck_hire/models/products.dart';
// import 'package:precheck_hire/models/transactHistory.dart';
// import 'package:precheck_hire/models/vendorProduct.dart';
// import 'package:precheck_hire/models/vendorStore.dart';

// import 'package:precheck_hire/services/eko_foods.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:precheck_hire/flutter_super_state/lib/src/store.dart';

// import 'package:precheck_hire/flutter_super_state/lib/src/store_module.dart';
// import 'package:flutter/material.dart';

// class MiscellaneousModule extends StoreModule {
//   bool _isLoading = false;
//   List<Product> _product = const [];
//   // List<SellerProduct> _sellerProduct = const [];
//   List<Category> _category = const [];
//   List<QueryData> _querydata = const [];
//   List<CancelOrders> _cancelorders = const [];
//   List<CompleteOrders> _completeorders = const [];
//   List<NotifyList> _notifylist = const [];
//   List<NotifyTransact> _notifytransact = const [];

//   List<Query> _query = const [];
//   List<Product> get product => _product;
//   List<ProductTransaction> _carts = const [];
//   List<Orders> _order = const [];
//   List<RetailOrder> _retailorder = const [];
//   List<FeaturedStore> _featuredstore = const [];
//   List<VendorStoreData> _vendorStoreData = const [];
//   List<ProductDetails> _productdetails = const [];

//   List<Dash> _dash = const [];
//   //List<Query> _query = const [];
//   List<DashRider> _dashrider = const [];
//   List<Carts> _cart = const [];
//   List<storeProducts> _storeproducts = const [];
//   List<VendorProduct> _vendorproduct = [];
//   List<Ordersbyid> _ordersbyid = [];
//   List<OrderAllRider> _orderallrider = [];
//   List<RiderOrdersbyid> _riderordersbyid = [];
//   List<UserProfile> _userprofile = const [];
//   List<Coupon> _coupon = [];

//   MiscellaneousModule(Store store) : super(store);
//   bool get isLoading => _isLoading;
//   List<UserProfile> get userprofile => _userprofile;
//   List<NotifyList> get notifylist => _notifylist;
//   List<NotifyTransact> get notifytransact => _notifytransact;
//   List<Coupon> get coupon => _coupon;
//   List<RiderOrdersbyid> get riderordersbyid => _riderordersbyid;
//   List<OrderAllRider> get orderallrider => _orderallrider;
//   List<CancelOrders> get cancelorders => _cancelorders;
//   List<Ordersbyid> get ordersbyid => _ordersbyid;
//   List<CompleteOrders> get completeorders => _completeorders;
//   List<storeProducts> get storeproduct => _storeproducts;
//   List<QueryData> get querydata => _querydata;
//   List<ProductDetails> get productdetails => _productdetails;
//   List<Category> get category => _category;
//   List<Query> get query => _query;
//   List<VendorStoreData> get vendorStoreData => _vendorStoreData;
//   List<ProductTransaction> get carts => _carts;
//   List<Orders> get order => _order;
//   List<RetailOrder> get retailorder => _retailorder;
//   List<FeaturedStore> get featuredstore => _featuredstore;

//   List<Dash> get dash => _dash;
//   List<DashRider> get dashrider => _dashrider;
//   List<Carts> get cart => _cart;

//   List<VendorProduct> get vendorproduct => _vendorproduct;

//   void _setLoading(bool loading) => setState(() => _isLoading = loading);

//   Future<void> fetchProducts({required BuildContext context}) async {
//     await ShoppersApi.wrapRequest(
//       context: context,
//       hideErrorModal: context == null,
//       preRequest: () => _setLoading(true),
//       postRequest: () => _setLoading(false),
//       request: () => ShoppersApi.getProducts(),
//       onSuccess: (Map response) {
//         final List<dynamic> productDataList = response['data'];
//         print("c");
//         print(Product.fromJSONList(productDataList));
//         print("d");
//         setState(() {
//           _product = Product.fromJSONList(productDataList);
//         });
//       },
//     );
//   }

//   Future<void> fetchAllCoupons({required BuildContext context}) async {
//     print('Starting fetchAllCoupons...');

//     await ShoppersApi.wrapRequest(
//       context: context,
//       hideErrorModal: false,
//       preRequest: () {
//         print('Pre-request: setting loading state');
//         _setLoading(true);
//       },
//       postRequest: () {
//         print('Post-request: resetting loading state');
//         _setLoading(false);
//       },
//       request: () {
//         print('Making API call to getCouponAll');
//         return ShoppersApi.getCouponAll();
//       },
//       onSuccess: (Map<dynamic, dynamic> response) {
//         print('API call successful. Full response: ${response.toString()}');

//         final castedResponse = Map<String, dynamic>.from(response);
//         print('Casted response: ${castedResponse.toString()}');

//         if (castedResponse.containsKey('data') &&
//             castedResponse['data'].containsKey('coupons')) {
//           final couponsList = castedResponse['data']['coupons'];
//           print('Coupons list: $couponsList'); // Log the coupons list

//           setState(() {
//             _coupon = Coupon.fromJSONList(couponsList);
//             print('Updated coupon data: ${_coupon.toString()}');
//           });
//         } else {
//           print('Coupons not found in response');
//         }
//       },
//       onError: (error) {
//         print('Error occurred during API call: $error');
//       },
//     );

//     print('fetchAllCoupons completed.');
//   }

//   Future<void> retailOrderItems({required BuildContext context}) async {
//     ShoppersApi.wrapRequest(
//       context: context,
//       hideErrorModal: false,
//       preRequest: () => _setLoading(true),
//       postRequest: () => _setLoading(false),
//       request: () => ShoppersApi.retailerOrder(),
//       onSuccess: (Map<dynamic, dynamic> response) {
//         setState(() {
//           // Cast the response to Map<String, dynamic>
//           final castedResponse = Map<String, dynamic>.from(response);
//           _retailorder = RetailOrder.fromJSONList(castedResponse);
//         });
//       },
//     );
//   }

//   Future<void> retailNotifyItems({required BuildContext context}) async {
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: false,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.retailerNotify(),
//         onSuccess: (Map<dynamic, dynamic> response) {
//           setState(() => _notifylist =
//               NotifyList.fromJSONList(response['data']['notifications']));
//           print('UserNOTIFY: $_notifylist');
//         });
//   }

//   Future<void> retailNotifyTransact({required BuildContext context}) async {
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: false,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.retailerAllPayHistory(),
//         onSuccess: (Map<dynamic, dynamic> response) {
//           // print('UserNOTyyyIFY: $response');
//           setState(() => _notifytransact =
//               NotifyTransact.fromJSONList(response['data']['transactions']));
//           print('UserNOT77yIFY: $_notifytransact');
//         });
//   }

//   Future<void> allProfile({required BuildContext context}) async {
//     ShoppersApi.wrapRequest(
//       context: context,
//       hideErrorModal: false,
//       preRequest: () => _setLoading(true),
//       postRequest: () => _setLoading(false),
//       request: () => ShoppersApi.getAllProfile(),
//       onSuccess: (Map<dynamic, dynamic> response) {
//         setState(() {
//           print('Full response: ${response.toString()}');

//           // Ensure response is valid and casted correctly
//           if (response != null &&
//               response['data'] != null &&
//               response['data']['user'] != null) {
//             var userData = response['data']
//                 ['user']; // Assuming response has this structure

//             // Now you can map this to your UserProfile model
//             _userprofile = [UserProfile.fromJson(userData)];

//             print('User Profile: $_userprofile');
//           } else {
//             print('Error: Response is missing necessary data');
//           }
//         });
//       },
//       onError: (error) {
//         setState(() {
//           print('Error fetching profile: $error');
//         });
//       },
//     );
//   }

//   Future<void> riderOrderAll({required BuildContext context}) async {
//     await ShoppersApi.wrapRequest(
//       context: context,
//       hideErrorModal: false,
//       preRequest: () => _setLoading(true),
//       postRequest: () => _setLoading(false),
//       request: () => ShoppersApi.fetchAllRiderOrder(),
//       onSuccess: (Map<dynamic, dynamic> response) {
//         try {
//           print('Response: $response');

//           // Ensure response is a Map<String, dynamic>
//           final castedResponse = response is Map<String, dynamic>
//               ? response
//               : Map<String, dynamic>.from(response);

//           // Parse data safely
//           final parsedOrders = OrderAllRider.fromJSONList(castedResponse);

//           // Update state
//           setState(() {
//             _orderallrider = parsedOrders;
//           });

//           print('Parsed Orders: $_orderallrider');
//         } catch (e, stackTrace) {
//           print('Error parsing rider orders: $e');
//           print(stackTrace); // Logs full error details

//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to load rider orders')),
//           );
//         }
//       },
//     );
//   }

//   Future<void> getOrderById(int? id, {required BuildContext context}) async {
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: false,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.orderByID(id),
//         onSuccess: (Map<dynamic, dynamic> response) {
//           // Check if 'data' and 'product' fields exist and are not null
//           if (response.containsKey('data') &&
//               response['data']['order'] != null) {
//             final Map<String, dynamic> productData2 =
//                 Map<String, dynamic>.from(response['data']['order']);

//             // Set the product details using fromJSON (since it's a single product)
//             setState(() => _ordersbyid = [
//                   Ordersbyid.fromJSON(productData2)
//                 ]); // Corrected here
//             //print('NNNN ${ordersbyid[0].rider!.user!.firstName}');
//           } else {
//             // Handle the case where 'product' is null or missing
//             print('Error: Product data is null or missing.');
//           }
//         });
//   }

//   Future<void> getRiderOrderById(int? id,
//       {required BuildContext context}) async {
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: false,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.getRiderOrderbyId(id),
//         onSuccess: (Map<dynamic, dynamic> response) {
//           // Check if 'data' and 'product' fields exist and are not null
//           if (response.containsKey('data') &&
//               response['data']['order'] != null) {
//             final Map<String, dynamic> productData4 =
//                 Map<String, dynamic>.from(response['data']['order']);

//             // Set the product details using fromJSON (since it's a single product)
//             setState(() => _riderordersbyid = [
//                   RiderOrdersbyid.fromJSON(productData4)
//                 ]); // Corrected here
//             print('nEEW $_productdetails');
//           } else {
//             // Handle the case where 'product' is null or missing
//             print('Error: Product data is null or missing.');
//           }
//         });
//   }

//   Future<void> getProductDetails(int? id,
//       {required BuildContext context}) async {
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: false,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.productDetails(id),
//         onSuccess: (Map<dynamic, dynamic> response) {
//           // Check if 'data' and 'product' fields exist and are not null
//           if (response.containsKey('data') &&
//               response['data']['product'] != null) {
//             final Map<String, dynamic> productData =
//                 Map<String, dynamic>.from(response['data']['product']);

//             // Set the product details using fromJSON (since it's a single product)
//             setState(() => _productdetails = [
//                   ProductDetails.fromJSON(productData)
//                 ]); // Corrected here
//             print('NNNN $_productdetails');
//           } else {
//             // Handle the case where 'product' is null or missing
//             print('Error: Product data is null or missing.');
//           }
//         });
//   }

//   Future<void> fetchCartItems({required BuildContext context}) async {
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context == null,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.cartProducts(),
//         onSuccess: (Map response) {
//           setState(
//               () => _carts = ProductTransaction.fromJSONList(response['data']));
//         });
//   }

//   Future<void> fetchFeaturedStore({required BuildContext context}) async {
//     print('Fetching featured store...');

//     ShoppersApi.wrapRequest(
//       context: context,
//       hideErrorModal: false,
//       preRequest: () => _setLoading(true),
//       postRequest: () => _setLoading(false),
//       request: () => ShoppersApi.fetchFeaturedStore(),
//       onSuccess: (Map<dynamic, dynamic> response) {
//         print('Fetch successful: $response');

//         if (response['status'] == 'success' && response['data'] is Map) {
//           final data = response['data'] as Map<String, dynamic>;
//           final featuredStoresData = data['featuredStores'];

//           if (featuredStoresData is List) {
//             setState(() {
//               _featuredstore = FeaturedStore.fromJSONList(featuredStoresData);
//             });
//           } else {
//             print(
//                 'Expected a list of featured stores, but got: $featuredStoresData');
//           }
//         } else {
//           print('Invalid response format or status.');
//         }
//       },
//       onError: (error) {
//         if (error is DioException) {
//           if (error.response?.statusCode == 401) {
//             print('Unauthorized access, redirecting to login...');
//             Navigator.of(context).pushReplacementNamed('/login');
//           } else {
//             print('DioException occurred: ${error.message}');
//           }
//         } else {
//           print('Unexpected error occurred: $error');
//         }
//       },
//     );
//   }

//   Future<void> fetchCartItems2({required BuildContext context}) async {
//     ShoppersApi.wrapRequest(
//       context: context,
//       hideErrorModal: context == null,
//       preRequest: () => _setLoading(true),
//       postRequest: () => _setLoading(false),
//       request: () => ShoppersApi.cartProducts(),
//       onSuccess: (Map<dynamic, dynamic> response) {
//         try {
//           // Attempt to cast the response to Map<String, dynamic>
//           final responseData = response.cast<String, dynamic>();
//           print('Response successfully cast to Map<String, dynamic>');

//           // Extract the 'data' map and handle the cart items
//           if (responseData.containsKey('data')) {
//             final data = responseData['data'] as Map<String, dynamic>;
//             print('Data extracted from response: $data');

//             if (data.containsKey('cart')) {
//               final cartData = data['cart'] as Map<String, dynamic>;
//               print('Cart data found: $cartData');

//               if (cartData.containsKey('CartItems')) {
//                 List<dynamic> cartItemsJson =
//                     cartData['CartItems'] as List<dynamic>;
//                 print('CartItems found: $cartItemsJson');

//                 // Convert the CartItems JSON into CartItem objects
//                 setState(() {
//                   _cart = Carts.fromJSONList(cartItemsJson);
//                 });
//                 print('Cart items successfully loaded.');
//               } else {
//                 print('No "CartItems" key found in the cart data.');
//               }
//             } else {
//               print('No "cart" key found in the response data.');
//             }
//           } else {
//             print('No "data" key found in the response.');
//           }
//         } catch (e) {
//           print('An error occurred during data processing: $e');
//         }

//         print('I REACH11');
//       },
//       onError: (error) {
//         // Handle errors
//         print('An error occurred: $error');
//       },
//     );
//   }

//   Future<void> fetchOrderItems({required BuildContext context}) async {
//     ShoppersApi.wrapRequest(
//       context: context,
//       hideErrorModal: context == null,
//       preRequest: () => _setLoading(true),
//       postRequest: () => _setLoading(false),
//       request: () => ShoppersApi.OrderProducts(),
//       onSuccess: (Map<dynamic, dynamic> response) {
//         print('I REACH15');

//         // Cast the response to Map<String, dynamic>
//         final responseData = response.cast<String, dynamic>();

//         // Extract the 'data' map and handle the orders
//         if (responseData.containsKey('data')) {
//           final data = responseData['data'];
//           if (data.containsKey('orders')) {
//             List<dynamic> ordersJson = data['orders'];
//             // Convert the orders JSON into Orders objects
//             setState(() => _order = Orders.fromJSONList(responseData));
//             print('Orders successfully loaded.');
//           } else {
//             print('No "orders" key found in the response data.');
//           }
//         } else {
//           print('No "data" key found in the response.');
//         }

//         print('I REACH11');
//       },
//       onError: (error) {
//         // Handle errors
//         print('An error occurred: $error');
//       },
//     );

//     print('I REACH');
//   }

//   deleteCartProduct(int id, {required BuildContext context}) {
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context == null,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.deleteCartProducts(id),
//         onSuccess: (Map response) {
//           // Ensure you're accessing data correctly
//           var id = response['id']; // Ensure 'id' is properly an int
//           // Handle the response data correctly
//           fetchCartItems2(context: context);
//         });
//   }

//   deleteVendorProduct(String id, {required BuildContext context}) {
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context == null,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.deleteVendorProducts(id),
//         onSuccess: (Map response) => fetchVendorProduct(context: context));
//   }

//   deleteVendorCoupon(String id, {required BuildContext context}) {
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context == null,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.deleteVendorCoupon(id),
//         onSuccess: (Map response) => fetchVendorProduct(context: context));
//   }

//   deleteRiderOrders(String id, {required BuildContext context}) {
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context == null,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.deleteRiderOrders(id),
//         onSuccess: (Map response) => fetchVendorProduct(context: context));
//   }

//   // void fetchCategory({required BuildContext context}) {
//   //   ShoppersApi.wrapRequest(
//   //       context: context,
//   //       hideErrorModal: context == null,
//   //       preRequest: () => _setLoading(true),
//   //       postRequest: () => _setLoading(false),
//   //       request: () => ShoppersApi.fetchCategory(),
//   //       onSuccess: (Map response) {
//   //         setState(() => _category = Category.fromJSONList(response['data']));
//   //       });
//   // }

//   void fetchDashInfo({required BuildContext context}) {
//     print('TESR L1');
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context == null,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.getDashInfo(),
//         onSuccess: (Map response) {
//           setState(() => _dash = Dash.fromJSONList(response['data']));
//           print('TESR $_dash');
//         });
//   }

//   Future<void> fetchQueryInfo(String query,
//       {required BuildContext context}) async {
//     print('TESR L1');
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context == null,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.searchMain(query),
//         onSuccess: (Map response) {
//           setState(() => _querydata =
//               QueryData.fromJSONList(response['data']['products']));
//           //print('TESR $_dash');
//         });
//   }

//   void fetchAllProductInfo({required BuildContext context}) {
//     print('TESR L1');
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context == null,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.getUserAllProduct(),
//         onSuccess: (Map response) {
//           setState(
//               () => _query = Query.fromJSONList(response['data']['products']));
//           //print('TESR $_dash');
//         });
//   }

//   Future<void> getSellerProduct(id, {required BuildContext context}) async {
//     ShoppersApi.wrapRequest(
//       context: context,
//       hideErrorModal: false,
//       preRequest: () => _setLoading(true),
//       postRequest: () => _setLoading(false),
//       request: () => ShoppersApi.getSellerProducts(id),
//       onSuccess: (Map<dynamic, dynamic> response) {
//         setState(() {
//           final retailerData =
//               response['data']?['retailer'] as Map<String, dynamic>?;

//           if (retailerData != null) {
//             // Assuming storeProducts.fromJSON handles Map<String, dynamic>

//             setState(() {
//               _storeproducts = [storeProducts.fromJSON(retailerData)];
//             });

//             print('TESR44555555 $_storeproducts');
//           } else {
//             print('TESR4455555500000 $_storeproducts');
//           }
//         });
//       },
//     );
//   }

//   void getVendorStore({required BuildContext context}) {
//     print('TESR L1');
//     ShoppersApi.wrapRequest(
//       context: context,
//       hideErrorModal: false, // `context == null` check is unnecessary
//       preRequest: () => _setLoading(true),
//       postRequest: () => _setLoading(false),
//       request: () => ShoppersApi.getVendorStore(),
//       onSuccess: (Map response) {
//         setState(() {
//           _vendorStoreData = _vendorStoreData = [
//             VendorStoreData.fromJSON(response['data']['retailer'])
//           ];
//         });
//         print('TESR $_vendorStoreData');
//       },
//     );
//   }

//   void fetchDashRider({required BuildContext context}) {
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context == null,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.getDashRider(),
//         onSuccess: (Map response) {
//           setState(() => _dashrider = DashRider.fromJSONList(response['data']));
//         });
//   }

//   void fetchVendorProduct({required BuildContext context}) {
//     print('TESRNNNNAA ');
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context == null,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.getVendorProduct(),
//         onSuccess: (Map response) {
//           setState(() => _vendorproduct =
//               VendorProduct.fromJSONList(response['data']['products']));
//           print('TESR44 $_vendorproduct');
//         });
//   }

//   void fetchCompletedOrder({required BuildContext context}) {
//     print('TESRNNNNAA ');
//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context == null,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.completedOrder(),
//         onSuccess: (Map response) {
//           try {
//             // Check if response contains 'data' or access 'orders' directly
//             final Map<String, dynamic> data = response['data'] != null
//                 ? Map<String, dynamic>.from(response['data'])
//                 : Map<String, dynamic>.from(response);

//             if (data['orders'] != null) {
//               setState(() {
//                 _completeorders = CompleteOrders.fromJSONList(data);
//               });
//               print('Fetched completed orders: $_cancelorders');
//             } else {
//               print('Error: No completed the response.');
//             }
//           } catch (e) {
//             print('Error parsing completed orders: $e');
//           }
//         },
//         onError: (error) {
//           print('Error fetching completed orders: $error');
//         });
//   }

//   void fetchCancelOrders({required BuildContext context}) {
//     print('Fetching canceled orders...');

//     ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context == null,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.cancelledOrder(),
//         onSuccess: (Map response) {
//           try {
//             // Check if response contains 'data' or access 'orders' directly
//             final Map<String, dynamic> data = response['data'] != null
//                 ? Map<String, dynamic>.from(response['data'])
//                 : Map<String, dynamic>.from(response);

//             if (data['orders'] != null) {
//               setState(() {
//                 _cancelorders = CancelOrders.fromJSONList(data);
//               });
//               print('Fetched canceled orders: $_cancelorders');
//             } else {
//               print('Error: No orders found in the response.');
//             }
//           } catch (e) {
//             print('Error parsing canceled orders: $e');
//           }
//         },
//         onError: (error) {
//           print('Error fetching canceled orders: $error');
//         });
//   }

//   Future<Map> fetchSellerDetails(String id,
//       {required BuildContext context}) async {
//     Map response = <dynamic, dynamic>{};
//     await ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context.mounted,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.getSellerDetails(id),
//         onSuccess: (Map apiResponse) async {
//           response = apiResponse;
//         });
//     return response;
//   }

//   Future<Map?> verifyBankAccountNumber(String accountNumber, String bankCode,
//       {required BuildContext context}) async {
//     Map response = <dynamic, dynamic>{};

//     await ShoppersApi.wrapRequest(
//         context: context,
//         hideErrorModal: context == null,
//         preRequest: () => _setLoading(true),
//         postRequest: () => _setLoading(false),
//         request: () => ShoppersApi.verifyAccountNumber(accountNumber, bankCode),
//         onSuccess: (Map apiResponse) {
//           response = apiResponse;
//         });
//     return response;
//   }
// }
