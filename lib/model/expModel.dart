class ExpModal {


  int exp_id;
  String compny_name;
  DateTime join_time;
  DateTime left_time;
  String job_role;
  DateTime create_time;

  ExpModal({
    required this.exp_id,
    required this.compny_name,
    required this.join_time,
    required this.left_time,
    required this.job_role,
    required this.create_time,
  });

  factory ExpModal.fromJson(Map<String, dynamic> json) {
    return ExpModal(
        exp_id: json['exp_id'],
        compny_name: json['compny_name'],
        join_time: json['join_time'],
        left_time: json['left_time'],
        job_role: json['job_role'],
        create_time: json['create_time']);
  }

  Map<String, dynamic> toJson() {
    return {
      'exp_id': exp_id,
      'compny_name': compny_name,
      'join_time': join_time,
      'left_time': left_time,
      'job_role': job_role,
      'create_time': create_time,
    };
  }
}
