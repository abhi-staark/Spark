import 'package:spark/data/network/network_api_services.dart';

class ProfileRepo {
  NetworkApiServices networkApiServices = NetworkApiServices();
  Future loadUserData() async {
    try{
      // dynamic responseData= await networkApiServices.getGetApiResponse('url');
      // return responseData;
    }catch(error){
      rethrow;
    }
  }

  Future<List> getFeaturePlans() async {
    List<Map<String, dynamic>> features = [
      {
        'feature': 'unlimited_likes',
        'premium_plan': true,
        'boost_plan': true,
      },
      {
        'feature': 'see_who_likes_you',
        'premium_plan': true,
        'boost_plan': false,
      },
      {
        'feature': '5_super_likes_per_week',
        'premium_plan': false,
        'boost_plan': true,
      },
      {
        'feature': 'advanced_matching_algorithm',
        'premium_plan': true,
        'boost_plan': false,
      },
      {
        'feature': 'boost_your_profile',
        'premium_plan': true,
        'boost_plan': true,
      },
      {
        'feature': 'message_read_receipts',
        'premium_plan': true,
        'boost_plan': false,
      },
      {
        'feature': 'see_who_viewed_your_profile',
        'premium_plan': true,
        'boost_plan': false,
      },
      {
        'feature': 'hide_your_profile',
        'premium_plan': true,
        'boost_plan': true,
      },
      {
        'feature': 'unlimited_rewinds',
        'premium_plan': true,
        'boost_plan': false,
      },
      {
        'feature': 'travel_pass',
        'premium_plan': true,
        'boost_plan': true,
      },
      {
        'feature': 'top_profile_in_search_results',
        'premium_plan': true,
        'boost_plan': true,
      },
      {
        'feature': 'ad_free_experience',
        'premium_plan': true,
        'boost_plan': false,
      },
      // Add more features here
    ];

    return features;
  }
}
