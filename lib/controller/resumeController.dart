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

  addEducation({required List education}) {
    for (int i = 1; i <= education.length; i++) {
      educationlist.add(EducationModel(
        location_name: education[i]['location_name'],
        edu_join_date: education[i]['joindate'],
        edu_left_date: education[i]['leftdate'],
        edu_type: education[i]['edu_type'],
        edu_score: education[i]['edu_score'],
      ));
    }
  }

  addTechskill({required List techskills}) {
    for (int i = 1; i <= techskills.length; i++) {
      techskillslist.add(EducationModel(
        location_name: techskills[i]['location_name'],
        edu_join_date: techskills[i]['joindate'],
        edu_left_date: techskills[i]['leftdate'],
        edu_type: techskills[i]['edu_type'],
        edu_score: techskills[i]['edu_score'],
      ));
    }
  }
}
