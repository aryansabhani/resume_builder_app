class IangeuageModel {
  final int langId;
  final int maintblId;
  final String langName;
  final String createTime;

  IangeuageModel({
    required this.langId,
    required this.maintblId,
    required this.langName,
    required this.createTime,
  });

  factory IangeuageModel.fromJson(Map<String, dynamic> json) {
    return IangeuageModel(
      langId: json['lang_id'],
      maintblId: json['maintbl_id'],
      langName: json['lang_name'],
      createTime: json['create_time'],
    );
  }
}

