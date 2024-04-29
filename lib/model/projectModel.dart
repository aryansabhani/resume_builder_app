class ProjectModel {
  int pro_id;
  String pro_name;
  String pro_detail;
  DateTime create_time;

  ProjectModel({
    required this.pro_id,
    required this.pro_name,
    required this.pro_detail,
    required this.create_time,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
        pro_id: json['pro_id'],
        pro_name: json['pro_name'],
        pro_detail: json['pro_detail'],
        create_time: json['create_time']);
  }

  Map<String, dynamic> toJson() {
    return {
      'pro_id': pro_id,
      'pro_name': pro_name,
      'pro_detail': pro_detail,
      'create_time': create_time,
    };
  }
}
