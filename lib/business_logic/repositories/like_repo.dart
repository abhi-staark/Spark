import 'package:spark/business_logic/models/user.dart';
import 'package:spark/data/network/network_api_services.dart';

class LikesRepo{
  NetworkApiServices networkApiServices = NetworkApiServices();
  Future<List<User>> getLikesList()async{
    await Future.delayed(const Duration(seconds: 3));

    try{
      //dynamic responseData = await networkApiServices.getGetApiResponse('url');
      //decode the response to a list
      //return list
      return [];
    }catch(error){
      rethrow;
    }
  }
  }