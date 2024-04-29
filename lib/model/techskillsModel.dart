class TechskillsModal {


  int ts_id;
  String ts_name;
  String sub_ts_name;
  DateTime create_time;

  TechskillsModal({
    required this.ts_id,
    required this.ts_name,
    required this.sub_ts_name,
    required this.create_time,
  });

  factory TechskillsModal.fromJson(Map<String, dynamic> json) {
    return TechskillsModal(
        ts_id: json['ts_id'],
        ts_name: json['ts_name'],
        sub_ts_name: json['sub_ts_name'],
        create_time: json['create_time']);
  }

  Map<String, dynamic> toJson() {
    return {
      'ts_id': ts_id,
      'ts_name': ts_name,
      'sub_ts_name': sub_ts_name,
      'create_time': create_time,
    };
  }
}
