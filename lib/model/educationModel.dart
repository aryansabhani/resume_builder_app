class EducationModel {




  int edu_id;
  String location_name;
  DateTime edu_join_date;
  DateTime edu_left_date;
  String edu_type;
  String edu_score;
  DateTime create_time;

  EducationModel({
    required this.edu_id,
    required this.location_name,
    required this.edu_join_date,
    required this.edu_left_date,
    required this.edu_type,
    required this.edu_score,
    required this.create_time,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
        edu_id: json['edu_id'],
        location_name: json['location_name'],
        edu_join_date: json['edu_join_date'],
        edu_left_date: json['edu_left_date'],
        edu_type: json['edu_type'],
        edu_score: json['edu_score'],
        create_time: json['create_time']);
  }

  Map<String, dynamic> toJson() {
    return {
      'edu_id': edu_id,
      'location_name': location_name,
      'edu_join_date': edu_join_date,
      'edu_left_date': edu_left_date,
      'edu_type': edu_type,
      'edu_score': edu_score,
      'create_time': create_time,
    };
  }
}
