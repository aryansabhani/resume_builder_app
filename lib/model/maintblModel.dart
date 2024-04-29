class MainTblModel {
  int resume_id;
  String photo;
  String fName;
  String lName;
  String aboutyourself;
  String job_title;
  int number;
  String email;
  String address;
  String city;
  String state;
  DateTime create_time;

  MainTblModel({
    required this.resume_id,
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
    required this.create_time,
  });

  factory MainTblModel.fromJson(Map<String, dynamic> json) {
    return MainTblModel(
        resume_id: json['resume_id'],
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
        create_time: json['create_time']);
  }

  Map<String, dynamic> toJson() {
    return {
      'resume_id': resume_id,
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
      'create_time': create_time,
    };
  }
}
