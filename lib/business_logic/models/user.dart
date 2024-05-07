class User {
  String? userName;
  String? age;
  String? locality;
  String? subLocality;
  String? profilePicUrl;
  String? aboutUser;
  List<String>? basics;
  List<String>? interests;
  List<String>? moreImages;

  User(
      {this.userName,
      this.age,
      this.locality,
      this.subLocality,
      this.profilePicUrl,
      this.aboutUser,
      this.basics,
      this.interests,
      this.moreImages});

  User.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    age = json['age'];
    locality = json['locality'];
    subLocality = json['subLocality'];
    profilePicUrl = json['profilePicUrl'];
    aboutUser = json['aboutUser'];
    basics = json['basics'].cast<String>();
    interests = json['interests'].cast<String>();
    moreImages = json['moreImages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['userName'] = userName;
    data['age'] = age;
    data['locality'] = locality;
    data['subLocality'] = subLocality;
    data['profilePicUrl'] = profilePicUrl;
    data['aboutUser'] = aboutUser;
    data['basics'] = basics;
    data['interests'] = interests;
    data['moreImages'] = moreImages;
    return data;
  }
}
