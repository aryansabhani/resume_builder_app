import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:resume_builder_app/controller/helper/sqfliteHelper.dart';
import 'package:resume_builder_app/model/maintblModel.dart';

import '../../model/educationModel.dart';
import '../../model/expModel.dart';
import '../../model/projectModel.dart';

class EditResumePage extends StatefulWidget {
  const EditResumePage({super.key});

  @override
  State<EditResumePage> createState() => _EditResumePageState();
}

class _EditResumePageState extends State<EditResumePage> {
  List<String> allfiled = [
    'Main',
    'Education',
    'Techskills',
    'Langeuages',
    'Projects',
    'Experience',
  ];

  String selecatfild = 'Main';
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController job_title = TextEditingController();
  TextEditingController aboutyourself = TextEditingController();

  Map<String, dynamic> educationMap = {
    'location_name': TextEditingController(),
    'joindate': TextEditingController(),
    'leftdate': TextEditingController(),
    'edu_type': TextEditingController(),
    'edu_score': TextEditingController(),
  };

  Map<String, dynamic> projectsMap = {
    'pro_name': TextEditingController(),
    'pro_detail': TextEditingController(),
  };
  Map<String, dynamic> expMap = {
    'com_name': TextEditingController(),
    'com_job_post': TextEditingController(),
    'join_date': TextEditingController(),
    'left_date': TextEditingController(),
  };

  List education = [];
  List exp = [];
  List projects = [];
  List techskills = [];
  List langeuages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // education.add(educationMap);
    // projects.add(projectsMap);
    // exp.add(expMap);
    // techskills.add(TextEditingController());
    // langeuages.add(TextEditingController());
  }

  MainTblModel? maintblData;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    maintblData = ModalRoute.of(context)!.settings.arguments as MainTblModel;
    getotherdata(maintbl_id: maintblData!.resume_id);
  }

  List<Map<String, dynamic>> expdata = [];
  List<Map<String, dynamic>> edudata = [];
  List<Map<String, dynamic>> languagesdata = [];
  List<Map<String, dynamic>> projectdata = [];
  List<Map<String, dynamic>> techskilldata = [];

  getotherdata({required int maintbl_id}) async {
    expdata = await SQLiteHelper.sqLiteHelper.getExperiences(maintbl_id);
    // log('exp data -  -------------------${expdata}');
    edudata = await SQLiteHelper.sqLiteHelper.getEducations(maintbl_id);
    // log('${edudata}');
    languagesdata = await SQLiteHelper.sqLiteHelper.getLanguages(maintbl_id);
    // log('${languagesdata}');
    projectdata = await SQLiteHelper.sqLiteHelper.getProjects(maintbl_id);
    // log('${projectdata}');
    techskilldata = await SQLiteHelper.sqLiteHelper.getTechskills(maintbl_id);
    // log('${techskilldata}');

    fname.text = maintblData!.fname;
    lname.text = maintblData!.lName;
    phone.text = maintblData!.number.toString();
    email.text = maintblData!.email;
    address.text = maintblData!.address;
    city.text = maintblData!.city;
    state.text = maintblData!.state;
    job_title.text = maintblData!.job_title;
    aboutyourself.text = maintblData!.aboutyourself;

    expdata.forEach((element) {
      ExpModal expModal = ExpModal.fromJson(element);
      exp.add({
        'com_name': TextEditingController(text: expModal.companyName),
        'com_job_post': TextEditingController(text: expModal.jobRole),
        'join_date': TextEditingController(text: expModal.joinTime),
        'left_date': TextEditingController(text: expModal.leftTime),
      });
    });
    edudata.forEach((element) {
      EducationModel educationModel = EducationModel.fromJson(element);
      education.add({
        'location_name':
            TextEditingController(text: educationModel.locationName),
        'joindate': TextEditingController(text: educationModel.eduJoinDate),
        'leftdate': TextEditingController(text: educationModel.eduLeftDate),
        'edu_type': TextEditingController(text: educationModel.eduType),
        'edu_score': TextEditingController(text: educationModel.eduScore),
      });
    });
    languagesdata.forEach((element) {
      langeuages.add(TextEditingController(text: element['lang_name']));
    });
    projectdata.forEach((element) {
      ProjectModel projectModel = ProjectModel.fromJson(element);
      projects.add({
        'pro_name': TextEditingController(text: projectModel.proName),
        'pro_detail': TextEditingController(text: projectModel.proDetail),
      });
    });
    techskilldata.forEach((element) {
      techskills.add(TextEditingController(text: element['ts_name']));
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Detail'),
        centerTitle: true,
        backgroundColor: Color(0XFFBDE5E1),
      ),
      bottomSheet: GestureDetector(
        onTap: () async {
          int? maintbl_id;
          await SQLiteHelper.sqLiteHelper.updatemaintbl(
            maintblData!.resume_id,
            fname.text,
            lname.text,
            int.parse(phone.text),
            email.text,
            address.text,
            city.text,
            state.text,
            aboutyourself.text,
            job_title.text,
          );

          List<Map<String, Object?>> data =
              await SQLiteHelper.sqLiteHelper.getmaintbl();
          maintbl_id = int.parse(data[data.length - 1]['resume_id'].toString());

          if (edudata.length == 0) {
            for (int i = 0; i < education.length; i++) {
              SQLiteHelper.sqLiteHelper.addEducation(
                maintbl_id,
                education[i]['location_name'].text,
                education[i]['joindate'].text,
                education[i]['leftdate'].text,
                education[i]['edu_type'].text,
                education[i]['edu_score'].text,
              );
            }
          } else {
            for (int i = 0; i < edudata.length; i++) {
              SQLiteHelper.sqLiteHelper
                  .deleteEducation(int.parse(edudata[i]['edu_id']));
            }

            for (int i = 0; i < education.length; i++) {
              SQLiteHelper.sqLiteHelper.addEducation(
                maintbl_id,
                education[i]['location_name'].text,
                education[i]['joindate'].text,
                education[i]['leftdate'].text,
                education[i]['edu_type'].text,
                education[i]['edu_score'].text,
              );
            }
          }

          if (projectdata.length == 0) {
            for (int i = 0; i < projects.length; i++) {
              SQLiteHelper.sqLiteHelper.addProject(
                maintbl_id,
                projects[i]['pro_name'].text,
                projects[i]['pro_detail'].text,
              );
            }
          } else {
            for (int i = 0; i < projectdata.length; i++) {
              SQLiteHelper.sqLiteHelper
                  .deleteProject(int.parse(projectdata[i]['pro_id']));
            }

            for (int i = 0; i < projects.length; i++) {
              SQLiteHelper.sqLiteHelper.addProject(
                maintbl_id,
                projects[i]['pro_name'].text,
                projects[i]['pro_detail'].text,
              );
            }
          }

          if (expdata.length == 0) {
            for (int i = 0; i < exp.length; i++) {
              SQLiteHelper.sqLiteHelper.addExperience(
                maintbl_id,
                exp[i]['com_name'].text,
                exp[i]['join_date'].text,
                exp[i]['left_date'].text,
                exp[i]['com_job_post'].text,
              );
            }
          } else {
            for (int i = 0; i < expdata.length; i++) {
              SQLiteHelper.sqLiteHelper
                  .deleteExperience(int.parse(expdata[i]['exp_id']));
            }

            for (int i = 0; i < exp.length; i++) {
              SQLiteHelper.sqLiteHelper.addExperience(
                maintbl_id,
                exp[i]['com_name'].text,
                exp[i]['join_date'].text,
                exp[i]['left_date'].text,
                exp[i]['com_job_post'].text,
              );
            }
          }

          if (techskilldata.length == 0) {
            for (int i = 0; i < techskills.length; i++) {
              SQLiteHelper.sqLiteHelper
                  .addTechskills(maintbl_id, techskills[i].text);
            }
          } else {
            for (int i = 0; i < techskilldata.length; i++) {
              SQLiteHelper.sqLiteHelper
                  .deleteTechskills(int.parse(techskilldata[i]['ts_id']));
            }

            for (int i = 0; i < techskills.length; i++) {
              SQLiteHelper.sqLiteHelper
                  .addTechskills(maintbl_id, techskills[i].text);
            }
          }

          if (languagesdata.length == 0) {
            for (int i = 0; i < langeuages.length; i++) {
              SQLiteHelper.sqLiteHelper.addLanguage(
                maintbl_id,
                langeuages[i].text,
              );
            }
          } else {
            for (int i = 0; i < languagesdata.length; i++) {
              SQLiteHelper.sqLiteHelper
                  .deleteLanguage(int.parse(languagesdata[i]['lang_id']));
            }

            for (int i = 0; i < langeuages.length; i++) {
              SQLiteHelper.sqLiteHelper.addLanguage(
                maintbl_id,
                langeuages[i].text,
              );
            }
          }
          fname.clear();
          lname.clear();
          phone.clear();
          email.clear();
          address.clear();
          city.clear();
          state.clear();
          aboutyourself.clear();
          job_title.clear();

          education.clear();
          projects.clear();
          exp.clear();
          techskills.clear();
          langeuages.clear();

          Navigator.pop(context);
        },
        child: Container(
          height: s.height * 0.1,
          width: double.maxFinite,
          padding: EdgeInsets.all(12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0XFFBDE5E1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Text(
            'Save',
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: s.height * 0.15),
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(allfiled.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        selecatfild = allfiled[index];
                        setState(() {});
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: selecatfild != allfiled[index]
                                  ? Color(0xffBDE5E1)
                                  : Colors.white),
                          color: selecatfild == allfiled[index]
                              ? Color(0xffBDE5E1)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          allfiled[index],
                          style: TextStyle(),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: s.height * 0.05,
              ),
              Visibility(
                visible: selecatfild == 'Main' ? true : false,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: fname,
                            decoration: InputDecoration(
                                labelText: 'Your First Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0XFFBDE5E1))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.redAccent))),
                          ),
                        ),
                        SizedBox(
                          width: s.width * 0.01,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: lname,
                            decoration: InputDecoration(
                                labelText: 'Your Last Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0XFFBDE5E1))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.redAccent))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: s.height * 0.02,
                    ),
                    TextFormField(
                      controller: phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                          labelText: 'Your Phone Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Color(0XFFBDE5E1))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.redAccent))),
                    ),
                    SizedBox(
                      height: s.height * 0.02,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                          labelText: 'Your Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Color(0XFFBDE5E1))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.redAccent))),
                    ),
                    SizedBox(
                      height: s.height * 0.02,
                    ),
                    TextFormField(
                      controller: address,
                      decoration: InputDecoration(
                          labelText: 'Your Address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Color(0XFFBDE5E1))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.redAccent))),
                    ),
                    SizedBox(
                      height: s.height * 0.02,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: city,
                            decoration: InputDecoration(
                                labelText: 'Your City',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0XFFBDE5E1))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.redAccent))),
                          ),
                        ),
                        SizedBox(
                          width: s.width * 0.01,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: state,
                            decoration: InputDecoration(
                                labelText: 'Your State',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Color(0XFFBDE5E1))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.redAccent))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: s.height * 0.02,
                    ),
                    TextFormField(
                      controller: job_title,
                      decoration: InputDecoration(
                          labelText: 'Your Job Title',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Color(0XFFBDE5E1))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.redAccent))),
                    ),
                    SizedBox(
                      height: s.height * 0.02,
                    ),
                    TextFormField(
                      controller: aboutyourself,
                      maxLines: 3,
                      decoration: InputDecoration(
                          labelText: 'About Your Self',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Color(0XFFBDE5E1))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.redAccent))),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: selecatfild == 'Education' ? true : false,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            education.add(educationMap);
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.greenAccent,
                          )),
                      IconButton(
                          onPressed: () {
                            if (education.length != 1) {
                              education.removeAt(education.length - 1);
                            } else {}
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Colors.redAccent,
                          )),
                    ],
                  ),
                  ...List.generate(education.length, (index) {
                    return Column(
                      children: [
                        Align(
                          child: Text(
                            '${index + 1}.Education',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        TextFormField(
                          controller: education[index]['location_name'],
                          decoration: InputDecoration(
                              labelText: 'School/Collage Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0XFFBDE5E1))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.redAccent))),
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        Row(
                          children: [
                            // 'joindate': TextEditingController(),
                            // 'leftdate': TextEditingController(),
                            // 'edu_type': TextEditingController(),
                            // 'edu_score': TextEditingController(),

                            Expanded(
                              child: TextFormField(
                                controller: education[index]['joindate'],
                                decoration: InputDecoration(
                                    labelText: 'Join Date',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Color(0XFFBDE5E1))),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent))),
                              ),
                            ),
                            SizedBox(
                              width: s.width * 0.01,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: education[index]['leftdate'],
                                decoration: InputDecoration(
                                    labelText: 'Leave Date',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Color(0XFFBDE5E1))),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        TextFormField(
                          controller: education[index]['edu_type'],
                          decoration: InputDecoration(
                              labelText: 'Education Type',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0XFFBDE5E1))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.redAccent))),
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        TextFormField(
                          controller: education[index]['edu_score'],
                          decoration: InputDecoration(
                              labelText: 'Score Great',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0XFFBDE5E1))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.redAccent))),
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                      ],
                    );
                  }),
                ]),
              ),
              Visibility(
                visible: selecatfild == 'Techskills' ? true : false,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            techskills.add(TextEditingController());
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.greenAccent,
                          )),
                      IconButton(
                          onPressed: () {
                            if (techskills.length != 1) {
                              techskills.removeAt(techskills.length - 1);
                            } else {}
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Colors.redAccent,
                          )),
                    ],
                  ),
                  ...List.generate(techskills.length, (index) {
                    return Column(
                      children: [
                        Align(
                          child: Text(
                            '${index + 1}. TechSkills',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        TextFormField(
                          controller: techskills[index],
                          decoration: InputDecoration(
                              labelText: 'Tech Skill',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0XFFBDE5E1))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.redAccent))),
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                      ],
                    );
                  }),
                ]),
              ),
              Visibility(
                visible: selecatfild == 'Langeuages' ? true : false,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            langeuages.add(TextEditingController());
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.greenAccent,
                          )),
                      IconButton(
                          onPressed: () {
                            if (langeuages.length != 1) {
                              langeuages.removeAt(langeuages.length - 1);
                            } else {}
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Colors.redAccent,
                          )),
                    ],
                  ),
                  ...List.generate(langeuages.length, (index) {
                    return Column(
                      children: [
                        Align(
                          child: Text(
                            '${index + 1}. Languages',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        TextFormField(
                          controller: langeuages[index],
                          decoration: InputDecoration(
                              labelText: 'languages',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0XFFBDE5E1))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.redAccent))),
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                      ],
                    );
                  }),
                ]),
              ),
              Visibility(
                visible: selecatfild == 'Projects' ? true : false,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            projects.add(projectsMap);
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.greenAccent,
                          )),
                      IconButton(
                          onPressed: () {
                            if (projects.length != 1) {
                              projects.removeAt(projects.length - 1);
                            } else {}
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Colors.redAccent,
                          )),
                    ],
                  ),
                  ...List.generate(projects.length, (index) {
                    return Column(
                      children: [
                        Align(
                          child: Text(
                            '${index + 1}. Project',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        TextFormField(
                          controller: projects[index]['pro_name'],
                          decoration: InputDecoration(
                              labelText: 'Project Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0XFFBDE5E1))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.redAccent))),
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        TextFormField(
                          controller: projects[index]['pro_detail'],
                          decoration: InputDecoration(
                              labelText: 'Project Detail',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0XFFBDE5E1))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.redAccent))),
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                      ],
                    );
                  }),
                ]),
              ),
              Visibility(
                visible: selecatfild == 'Experience' ? true : false,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            exp.add(expMap);
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.greenAccent,
                          )),
                      IconButton(
                          onPressed: () {
                            if (exp.length != 1) {
                              exp.removeAt(exp.length - 1);
                            } else {}
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Colors.redAccent,
                          )),
                    ],
                  ),
                  ...List.generate(exp.length, (index) {
                    return Column(
                      children: [
                        Align(
                          child: Text(
                            '${index + 1}. Project',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        TextFormField(
                          controller: exp[index]['com_name'],
                          decoration: InputDecoration(
                              labelText: 'Project Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0XFFBDE5E1))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.redAccent))),
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        TextFormField(
                          controller: exp[index]['com_job_post'],
                          decoration: InputDecoration(
                              labelText: 'Project Detail',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Color(0XFFBDE5E1))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.redAccent))),
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        Row(
                          children: [
                            // 'joindate': TextEditingController(),
                            // 'leftdate': TextEditingController(),
                            // 'edu_type': TextEditingController(),
                            // 'edu_score': TextEditingController(),

                            Expanded(
                              child: TextFormField(
                                controller: exp[index]['join_date'],
                                decoration: InputDecoration(
                                    labelText: 'Join Date',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Color(0XFFBDE5E1))),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent))),
                              ),
                            ),
                            SizedBox(
                              width: s.width * 0.01,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: exp[index]['left_join'],
                                decoration: InputDecoration(
                                    labelText: 'Leave Date',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Color(0XFFBDE5E1))),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                      ],
                    );
                  }),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
