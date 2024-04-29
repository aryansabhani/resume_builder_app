class ExpModal {
  final int expId;
  final int maintblId;
  final String companyName;
  final String joinTime;
  final String leftTime;
  final String jobRole;
  final String createTime;

  ExpModal({
    required this.expId,
    required this.maintblId,
    required this.companyName,
    required this.joinTime,
    required this.leftTime,
    required this.jobRole,
    required this.createTime,
  });

  factory ExpModal.fromJson(Map<String, dynamic> json) {
    return ExpModal(
      expId: json['exp_id'],
      maintblId: json['maintbl_id'],
      companyName: json['compny_name'],
      joinTime: json['join_time'],
      leftTime: json['left_time'],
      jobRole: json['job_role'],
      createTime: json['create_time'],
    );
  }
}

