class ProjectModel {
  final int proId;
  final int maintblId;
  final String proName;
  final String proDetail;
  final String createTime;

  ProjectModel({
    required this.proId,
    required this.maintblId,
    required this.proName,
    required this.proDetail,
    required this.createTime,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      proId: json['pro_id'],
      maintblId: json['maintbl_id'],
      proName: json['pro_name'],
      proDetail: json['pro_detail'],
      createTime: json['create_time'],
    );
  }
}

