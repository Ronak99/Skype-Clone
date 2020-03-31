import 'user.dart';

class Contact extends User{
  String uid;
  String name;
  String profilePhoto;

  Contact({
    this.uid,
    this.name,
    this.profilePhoto,
  });

  @override
  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['contact_id'] = user.uid;
    data['contact_name'] = user.name;
    data["contact_photo"] = user.profilePhoto;
    return data;
  }

  Contact.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['contact_id'];
    this.name = mapData['contact_name'];
    this.profilePhoto = mapData['contact_photo'];
  }
}
