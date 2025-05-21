// lib/services/miscellaneous_module.dart
import 'package:precheck_hire/models/candidate.model.dart';
import 'package:precheck_hire/models/category.model.dart';
import 'package:precheck_hire/models/notification.model.dart';
import 'package:precheck_hire/services/dto_client.dart';

class MiscellaneousModule {
  Future<List<String>> getNigeriaStates() async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.get('/users/getNigeriaState');

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        List states = response.data['data'];
        return states.cast<String>();
      } else {
        throw Exception("Failed to load states");
      }
    } catch (e) {
      print('Error fetching states: $e');
      rethrow;
    }
  }

  Future<List<String>> getLGAByState(String stateName) async {
    final dio = await DioClient.getInstance();
    try {
      final response = await dio.post(
        '/users/getNigeriaLGAbyStateName',
        data: {'stateName': stateName},
      );
      print('LGA API response: ${response.data}');

      if (response.statusCode == 200 &&
          response.data['status'] == 'success' &&
          response.data['data'] != null &&
          response.data['data']['lgas'] != null) {
        return List<String>.from(response.data['data']['lgas']);
      } else {
        throw Exception("Failed to load LGAs");
      }
    } catch (e) {
      print('Error fetching LGAs: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getIdentityTypes() async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.get('/users/identityTypeList');

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        List<dynamic> rawList = response.data['data'];

        return rawList.map<Map<String, dynamic>>((item) {
          return {'id': item['id'], 'name': item['name']};
        }).toList();
      } else {
        throw Exception('Failed to load identity types');
      }
    } catch (e) {
      print('Error fetching identity types: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getEmployerSubscriptionPlan() async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.get(
        '/subscriptionPlans/getAllSubscriptionPlans',
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        // Filter for only "Employer Plan"
        List subscriptionPlans = response.data['data']['subscriptionPlans'];
        var employerPlan = subscriptionPlans.firstWhere(
          (plan) =>
              plan['subscriptionType'] ==
              'user', // Assuming 'user' is for employers
          orElse: () => null, // Default value if no match is found
        );

        return employerPlan ?? {};
      } else {
        throw Exception('Failed to load subscription plans');
      }
    } catch (e) {
      print('Error fetching subscription plans: $e');
      rethrow;
    }
  }

  Future<List<UserNotification>> fetchUserNotifications() async {
    final dio = await DioClient.getInstance();

    final response = await dio.get('/notifications/getAllUserNotifications');

    final notifications =
        (response.data['data']['notifications'] as List)
            .map((json) => UserNotification.fromJson(json))
            .toList();

    return notifications;
  }

  Future<void> markNotificationAsRead(int notificationId) async {
    final dio = await DioClient.getInstance();

    await dio.patch('/notifications/mark/$notificationId/read');
  }

  Future<List<Category>> fetchDomesticCategories() async {
    final dio = await DioClient.getInstance();
    try {
      final response = await dio.get('/domesticCategories');
      // print(response);
      final List data = response.data['data']['categories'];
      return data.map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Candidate>> fetchAllCandidates({
    String? search,
    String? state,
    String? lga,
    String? jobType,
  }) async {
    final dio = await DioClient.getInstance();
    try {
      final Map<String, dynamic> queryParams = {};

      if (search != null && search.isNotEmpty) queryParams['search'] = search;
      if (state != null && state.isNotEmpty) queryParams['state'] = state;
      if (lga != null && lga.isNotEmpty) queryParams['lga'] = lga;
      if (jobType != null && jobType.isNotEmpty)
        queryParams['jobType'] = jobType;

      final response = await dio.get(
        '/candidates/getAllCandidates',
        queryParameters: queryParams,
      );

      final data = response.data;
      final List<dynamic> candidateList = data['data']['candidates'];
      return candidateList.map((json) => Candidate.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching candidates: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getCandidateDetails(int id) async {
    final dio = await DioClient.getInstance();
    final response = await dio.get('/candidates/getCandidateDetails/$id');

    if (response.statusCode == 200 && response.data['status'] == 'success') {
      // API wraps data under data.candidate
      return Map<String, dynamic>.from(response.data['data']['candidate']);
    } else {
      throw Exception(
        'Failed to load candidate (status ${response.statusCode})',
      );
    }
  }
}
