class IangeuageModel {




  int lang_id;
  String lang_name;
  DateTime create_time;

  IangeuageModel({
    required this.lang_id,
    required this.lang_name,
    required this.create_time,
  });

  factory IangeuageModel.fromJson(Map<String, dynamic> json) {
    return IangeuageModel(
        lang_id: json['lang_id'],
        lang_name: json['lang_name'],
        create_time: json['create_time']);
  }

  Map<String, dynamic> toJson() {
    return {
      'lang_id': lang_id,
      'lang_name': lang_name,
      'create_time': create_time,
    };
  }
}
