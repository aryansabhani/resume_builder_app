class MainTblModel {
  String photo;
  String fName;
  String lName;
  String aboutyourself;
  String job_title;
  String number;
  String email;
  String address;
  String city;
  String state;

  MainTblModel({
    required this.photo,
    required this.fName,
    required this.lName,
    required this.aboutyourself,
    required this.job_title,
    required this.number,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
  });

  factory MainTblModel.fromJson(Map<String, dynamic> json) {
    return MainTblModel(
        photo: json['photo'],
        fName: json['fName'],
        lName: json['lName'],
        aboutyourself: json['aboutyourself'],
        job_title: json['job_title'],
        number: json['number'],
        email: json['email'],
        address: json['address'],
        city: json['city'],
        state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photo': photo,
      'fName': fName,
      'lName': lName,
      'aboutyourself': aboutyourself,
      'job_title': job_title,
      'number': number,
      'email': email,
      'address': address,
      'city': city,
      'state': state,
    };
  }
}
