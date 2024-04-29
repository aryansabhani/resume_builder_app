class MainTblModel {
  int resume_id;
  String resume_name;
  String fname;
  String lName;
  int number;
  String email;
  String address;
  String city;
  String state;
  String photo;
  String aboutyourself;
  String job_title;
  DateTime create_time;

  MainTblModel({
    required this.resume_id,
    required this.resume_name,
    required this.fname,
    required this.lName,
    required this.number,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.photo,
    required this.aboutyourself,
    required this.job_title,
    required this.create_time,
  });

  factory MainTblModel.fromJson(Map<String, dynamic> json) {
    return MainTblModel(
      resume_id: json['resume_id'],
      resume_name: json['resume_name'],
      fname: json['fname'],
      lName: json['lName'],
      number: json['number'],
      email: json['email'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      photo: json['photo'],
      aboutyourself: json['aboutyourself'],
      job_title: json['job_title'],
      create_time: DateTime.parse(json['create_time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resume_id': resume_id,
      'resume_name': resume_name,
      'fname': fname,
      'lName': lName,
      'number': number,
      'email': email,
      'address': address,
      'city': city,
      'state': state,
      'photo': photo,
      'aboutyourself': aboutyourself,
      'job_title': job_title,
      'create_time': create_time.toIso8601String(),
    };
  }
}
