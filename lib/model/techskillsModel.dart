class TechskillsModal {
  final int tsId;
  final int maintblId;
  final String tsName;
  final String createTime;

  TechskillsModal({
    required this.tsId,
    required this.maintblId,
    required this.tsName,
    required this.createTime,
  });

  factory TechskillsModal.fromJson(Map<String, dynamic> json) {
    return TechskillsModal(
      tsId: json['ts_id'],
      maintblId: json['maintbl_id'],
      tsName: json['ts_name'],
      createTime: json['create_time'],
    );
  }
}


