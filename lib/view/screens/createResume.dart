import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:resume_builder_app/model/maintblModel.dart';
import 'package:resume_builder_app/model/techskillsModel.dart';

import '../../controller/helper/sqfliteHelper.dart';
import '../../model/educationModel.dart';
import '../../model/expModel.dart';
import '../../model/projectModel.dart';

class CreateResume extends StatefulWidget {
  const CreateResume({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateResume> createState() => _CreateResumeState();
}

class _CreateResumeState extends State<CreateResume> {
  final f = DateFormat('dd-MM-yyyy');

  MainTblModel? argdata;
  List<Map<String, dynamic>> expdata = [];
  List<Map<String, dynamic>> edudata = [];
  List<Map<String, dynamic>> languagesdata = [];
  List<Map<String, dynamic>> projectdata = [];
  List<Map<String, dynamic>> techskilldata = [];

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

  List<EducationModel> education = [];
  List<ExpModal> exp = [];
  List<ProjectModel> projects = [];
  List<TextEditingController> techskills = [];
  List<TextEditingController> langeuages = [];

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

    expdata.forEach((element) {
      ExpModal expModal = ExpModal.fromJson(element);
      exp.add(expModal);
    });
    edudata.forEach((element) {
      EducationModel educationModel = EducationModel.fromJson(element);
      education.add(educationModel);
    });
    languagesdata.forEach((element) {
      langeuages.add(TextEditingController(text: element['lang_name']));
    });
    projectdata.forEach((element) {
      ProjectModel projectModel = ProjectModel.fromJson(element);
      projects.add(projectModel);
    });
    techskilldata.forEach((element) {
      techskills.add(TextEditingController(text: element['ts_name']));
    });
    setState(() {});
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    // final ByteData data = await rootBundle.load('assets/images/ss.png');
    // final Uint8List bytes = data.buffer.asUint8List();
    // final image = pw.MemoryImage(bytes);
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4.copyWith(
            marginLeft: 20, marginRight: 20, marginBottom: 20, marginTop: 20),
        build: (context) {
          // return pw.Column(children: [
          //   pw.Row(children: [
          //     pw.Align(
          //       alignment: pw.Alignment.centerLeft,
          //       child: pw.Container(
          //         decoration: pw.BoxDecoration(
          //           border: pw.Border.all(),
          //         )
          //         // child: pw.Image(image),
          //       ),
          //     ),
          //     pw.Spacer(),
          //     pw.Column(
          //         crossAxisAlignment: pw.CrossAxisAlignment.center,
          //         children: [
          //           pw.Text(
          //             "Perfect Naukari",
          //             style: pw.TextStyle(
          //               color: PdfColors.red,
          //               fontWeight: pw.FontWeight.bold,
          //               fontSize: 16,
          //             ),
          //           ),
          //           pw.Text(
          //             "Appointment Letter",
          //             style: pw.TextStyle(
          //                 color: PdfColors.blue900,
          //                 fontWeight: pw.FontWeight.bold,
          //                 fontSize: 16),
          //           ),
          //         ]),
          //     pw.Spacer(),
          //   ]),
          //   pw.SizedBox(height: 10),
          //   pw.Divider(),
          // ]);
          return pw.Row(children: [
            pw.Expanded(
                flex: 1,
                child: pw.Container(
                    color: PdfColor.fromInt(0xFF393185),
                    padding: pw.EdgeInsets.only(bottom: 18, top: 18, left: 18),
                    child: pw.Column(children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.only(right: 15),
                        child: pw.Container(
                            height: 130,
                            width: 130,
                            decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              shape: pw.BoxShape.circle,
                            )),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Contact',
                            style: pw.TextStyle(
                                fontSize: 20,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white)),
                      ),
                      pw.Divider(
                        color: PdfColors.white,
                      ),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Phone',
                            style: pw.TextStyle(
                                fontSize: 13,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white)),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(argdata!.number.toString(),
                            style: pw.TextStyle(
                                fontSize: 11,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white)),
                      ),
                      pw.SizedBox(height: 15),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Email',
                            style: pw.TextStyle(
                                fontSize: 13,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white)),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(argdata!.email.toString(),
                            style: pw.TextStyle(
                                fontSize: 11,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white)),
                      ),
                      pw.SizedBox(height: 15),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Address',
                            style: pw.TextStyle(
                                fontSize: 13,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white)),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                            argdata!.address.toString() +
                                ', ' +
                                argdata!.city.toString() +
                                ', ' +
                                argdata!.state.toString(),
                            style: pw.TextStyle(
                                fontSize: 11,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white)),
                      ),
                      pw.SizedBox(height: 20),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Education',
                            style: pw.TextStyle(
                                fontSize: 20,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white)),
                      ),
                      pw.Divider(
                        color: PdfColors.white,
                      ),
                      pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisSize: pw.MainAxisSize.min,
                              children:
                                  List.generate(education.length, (index) {
                                return pw.Column(
                                    mainAxisSize: pw.MainAxisSize.min,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        '${education[index].eduJoinDate}  -  ${education[index].eduLeftDate}',
                                        style: pw.TextStyle(
                                            color: PdfColors.white),
                                      ),
                                      pw.Text(
                                        '${education[index].eduType}  -  ${education[index].eduScore}',
                                        style: pw.TextStyle(
                                            color: PdfColors.white,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.Text(
                                        '${education[index].locationName} ',
                                        style: pw.TextStyle(
                                            color: PdfColors.white),
                                      ),
                                    ]);
                              }))),
                      pw.SizedBox(height: 20),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Technical Skills',
                            style: pw.TextStyle(
                                fontSize: 20,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white)),
                      ),
                      pw.Divider(
                        color: PdfColors.white,
                      ),
                      pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisSize: pw.MainAxisSize.min,
                              children:
                                  List.generate(techskills.length, (index) {
                                return pw.Column(
                                    mainAxisSize: pw.MainAxisSize.min,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        '${techskills[index].text}}',
                                        style: pw.TextStyle(
                                            color: PdfColors.white),
                                      ),
                                    ]);
                              }))),
                    ]))),
            pw.Expanded(
                flex: 2,
                child: pw.Padding(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                              height: 138,
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Row(children: [
                                      pw.Align(
                                          alignment: pw.Alignment.centerLeft,
                                          child: pw.Text('${argdata!.fname}',
                                              style: pw.TextStyle(
                                                  fontSize: 26,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  color: PdfColor.fromInt(
                                                      0xFF393185)))),
                                      pw.SizedBox(width: 15),
                                      pw.Align(
                                          alignment: pw.Alignment.centerLeft,
                                          child: pw.Text('${argdata!.lName}',
                                              style: pw.TextStyle(
                                                  fontSize: 26,
                                                  // fontWeight: pw.FontWeight.bold,
                                                  color: PdfColor.fromInt(
                                                      0xFF393185))))
                                    ]),
                                    pw.SizedBox(height: 5),
                                    pw.Text('${argdata!.job_title}',
                                        style: pw.TextStyle(
                                            fontSize: 16,
                                            color: PdfColor.fromInt(0xFF393185),
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Text('${argdata!.aboutyourself}',
                                        style: pw.TextStyle(
                                            fontSize: 16,
                                            color: PdfColor.fromInt(0xFF393185),
                                            fontWeight: pw.FontWeight.bold)),
                                  ])),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('Experience',
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromInt(0xFF393185))),
                          ),
                          pw.Divider(
                            color: PdfColor.fromInt(0xFF393185),
                          ),
                          pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  mainAxisSize: pw.MainAxisSize.min,
                                  children: List.generate(exp.length, (index) {
                                    return pw.Column(
                                        mainAxisSize: pw.MainAxisSize.min,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            '${exp[index].joinTime}  -  ${exp[index].leftTime}',
                                            style: pw.TextStyle(
                                                color: PdfColor.fromInt(
                                                    0xFF393185),
                                                fontWeight: pw.FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          pw.Text(
                                            '${exp[index].companyName}',
                                            style: pw.TextStyle(
                                                color: PdfColor.fromInt(
                                                    0xFF393185),
                                                fontSize: 14),
                                          ),
                                          pw.Text(
                                            '${exp[index].jobRole} ',
                                            style: pw.TextStyle(
                                                color: PdfColor.fromInt(
                                                    0xFF393185),
                                                fontWeight: pw.FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ]);
                                  }))),
                          pw.SizedBox(height: 20),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('Projects',
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromInt(0xFF393185))),
                          ),
                          pw.Divider(
                            color: PdfColor.fromInt(0xFF393185),
                          ),
                          pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  mainAxisSize: pw.MainAxisSize.min,
                                  children:
                                      List.generate(projects.length, (index) {
                                    return pw.Column(
                                        mainAxisSize: pw.MainAxisSize.min,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            '${projects[index].proName}',
                                            style: pw.TextStyle(
                                                color: PdfColor.fromInt(
                                                    0xFF393185),
                                                fontSize: 16),
                                          ),
                                          pw.SizedBox(height: 5),
                                          pw.Row(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              children: [
                                                pw.Container(
                                                    height: 5,
                                                    width: 5,
                                                    decoration:
                                                        pw.BoxDecoration(
                                                            color: PdfColor
                                                                .fromInt(
                                                                    0xFF393185),
                                                            shape: pw.BoxShape
                                                                .circle)),
                                                pw.SizedBox(width: 5),
                                                pw.Text(
                                                  '${projects[index].proDetail}',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                      color: PdfColor.fromInt(
                                                          0xFF393185),
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                      fontSize: 10),
                                                ),
                                              ])
                                        ]);
                                  }))),
                          pw.SizedBox(height: 20),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('Languages',
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromInt(0xFF393185))),
                          ),
                          pw.Divider(
                            color: PdfColor.fromInt(0xFF393185),
                          ),
                          pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  mainAxisSize: pw.MainAxisSize.min,
                                  children:
                                      List.generate(langeuages.length, (index) {
                                    return pw.Column(
                                        mainAxisSize: pw.MainAxisSize.min,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Row(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              children: [
                                                pw.Container(
                                                    height: 5,
                                                    width: 5,
                                                    decoration:
                                                        pw.BoxDecoration(
                                                            color: PdfColor
                                                                .fromInt(
                                                                    0xFF393185),
                                                            shape: pw.BoxShape
                                                                .circle)),
                                                pw.SizedBox(width: 5),
                                                pw.Text(
                                                  '${langeuages[index].text}',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                      color: PdfColor.fromInt(
                                                          0xFF393185),
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                      fontSize: 10),
                                                ),
                                              ])
                                        ]);
                                  }))),
                        ]))),
          ]);
        }));
    return pdf.save();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    argdata = ModalRoute.of(context)!.settings.arguments as MainTblModel;
    getotherdata(maintbl_id: argdata!.resume_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF393185),
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
        title: const Text(
          'Resume',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }
}
