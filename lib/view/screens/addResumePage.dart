import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder_app/controller/helper/sqfliteHelper.dart';
import 'package:resume_builder_app/controller/resumeController.dart';
import 'package:resume_builder_app/model/maintblModel.dart';

class AddResumePage extends StatefulWidget {
  const AddResumePage({super.key});

  @override
  State<AddResumePage> createState() => _AddResumePageState();
}

List<String> allfiled = [
  'Main',
  'Education',
  'Techskills',
  'Langeuages',
  'Projects',
  'Experience',
];

String selecatfild = 'Main';

class _AddResumePageState extends State<AddResumePage> {
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

  // final project_table = 'project';
  // final pro_id = 'pro_id';
  // final pro_name = 'pro_name';
  // final pro_detail = 'pro_detail';

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
    education.add(educationMap);
    projects.add(projectsMap);
    exp.add(expMap);
    techskills.add(TextEditingController());
    langeuages.add(TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Detail'),
        centerTitle: true,
        backgroundColor: Color(0XFFBDE5E1),
      ),
      bottomSheet: GestureDetector(
        onTap: () async {
          if (selecatfild == 'Main') {
            SQLiteHelper.sqLiteHelper.addmaintbl(
                fname.text,
                lname.text,
                int.parse(phone.text),
                email.text,
                address.text,
                city.text,
                state.text,
                aboutyourself.text,
                job_title.text,
                '');

          } else if (selecatfild == 'Education') {}
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
