import 'package:spark/business_logic/models/user.dart';
import 'package:spark/data/network/network_api_services.dart';

class HomeRepository {
  NetworkApiServices networkApiServices = NetworkApiServices();

  Future<List<User>> fetchMatchesList() async {
    
  try{
    //dynamic responseData= await networkApiServices.getGetApiResponse('url');
    //map to a list
    // return the list
     Future.delayed(const Duration(seconds: 3));
      List<User> userList = [
      User(
        userName: 'Abhishek Patil',
        age: '23',
        locality: 'Bengaluru',
        subLocality: 'Whitefield',
        profilePicUrl: 'https://i.ibb.co/XtjMJpZ/20240301-163055-1.jpg',
        aboutUser:
            'I am a software engineer passionate about creating innovative solutions to real-world problems. In my free time, I enjoy exploring new technologies and building projects that challenge me.',
        basics: ['Flutter Enthusiast', 'Tech Enthusiast'],
        interests: [
          'Mobile App Development',
          'Machine Learning',
          'Photography'
        ],
        moreImages: [
          'https://i.ibb.co/XtjMJpZ/20240301-163055-1.jpg',
          'https://i.ibb.co/XtjMJpZ/20240301-163055-1.jpg',
        ],
      ),
      User(
        userName: 'Alice Smith',
        age: '25',
        locality: 'Town',
        subLocality: 'Village',
        profilePicUrl:
            'https://e0.pxfuel.com/wallpapers/847/286/desktop-wallpaper-man-style-beard-men.jpg',
        aboutUser:
            'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        basics: ['Flutter Enthusiast', 'Tech Enthusiast'],
        interests: [
          'Mobile App Development',
          'Machine Learning',
          'Photography'
        ],
        moreImages: [
          'https://e0.pxfuel.com/wallpapers/847/286/desktop-wallpaper-man-style-beard-men.jpg',
          'https://e0.pxfuel.com/wallpapers/847/286/desktop-wallpaper-man-style-beard-men.jpg',
        ],
      ),
      User(
        userName: 'Bob Johnson',
        age: '35',
        locality: 'Metropolis',
        subLocality: 'Downtown',
        profilePicUrl:
            'https://e0.pxfuel.com/wallpapers/847/286/desktop-wallpaper-man-style-beard-men.jpg',
        aboutUser:
            'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        basics: ['Flutter Enthusiast', 'Tech Enthusiast'],
        interests: [
          'Mobile App Development',
          'Machine Learning',
          'Photography'
        ],
        moreImages: [
          'https://e0.pxfuel.com/wallpapers/847/286/desktop-wallpaper-man-style-beard-men.jpg',
          'https://e0.pxfuel.com/wallpapers/847/286/desktop-wallpaper-man-style-beard-men.jpg',
        ],
      ),
    ];
    
    return userList;
  }catch(error){
    rethrow;
  }
   
  }
}
