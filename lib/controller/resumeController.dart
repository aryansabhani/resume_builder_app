import 'package:flutter/cupertino.dart';
import 'package:resume_builder_app/model/educationModel.dart';

import '../model/maintblModel.dart';

class ResumeController extends ChangeNotifier {
  late MainTblModel maintblmap;

  List educationlist = [];
  List techskillslist = [];
  List langeuageslist = [];
  List projectlist = [];
  List experiencelist = [];
}
