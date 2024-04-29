class EducationModel {
  final int eduId;
  final int maintblId;
  final String locationName;
  final String eduJoinDate;
  final String eduLeftDate;
  final String eduType;
  final String eduScore;
  final String createTime;

  EducationModel({
    required this.eduId,
    required this.maintblId,
    required this.locationName,
    required this.eduJoinDate,
    required this.eduLeftDate,
    required this.eduType,
    required this.eduScore,
    required this.createTime,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      eduId: json['edu_id'],
      maintblId: json['maintbl_id'],
      locationName: json['location_name'],
      eduJoinDate: json['edu_join_date'],
      eduLeftDate: json['edu_left_date'],
      eduType: json['edu_type'],
      eduScore: json['edu_score'],
      createTime: json['create_time'],
    );
  }
}

