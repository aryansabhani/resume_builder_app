import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:resume_builder_app/controller/helper/sqfliteHelper.dart';
import 'package:resume_builder_app/model/maintblModel.dart';

class ShowAllResumeScreen extends StatefulWidget {
  const ShowAllResumeScreen({super.key});

  @override
  State<ShowAllResumeScreen> createState() => _ShowAllResumeScreenState();
}

class _ShowAllResumeScreenState extends State<ShowAllResumeScreen> {
  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFBDE5E1),
        centerTitle: true,
        title: Text('Zen Resumes'),
      ),
      body: FutureBuilder(
        future: SQLiteHelper.sqLiteHelper.getmaintbl(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MainTblModel> resumes = [];
            log('${snapshot.data}');
            snapshot.data!.forEach((element) {
              resumes.add(MainTblModel.fromJson(element));
              log(resumes.length.toString());
            });
            return ListView.builder(

              padding: EdgeInsets.all(s.height * 0.015),
              physics: BouncingScrollPhysics(),
              itemCount: resumes.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('showResume',arguments: resumes[index]);
                      },
                  title: Text(
                    resumes[index].resume_name,
                  ),
                  leading: CircleAvatar(
                    radius: s.height * 0.025,
                    // backgroundImage: NetworkImage(resumes[index].photo!),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Ink(
                        height: s.height * 0.04,
                        padding: EdgeInsets.all(s.height * 0.005),

                        child: InkWell(
                          // splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
                          onTap: () {
                            Navigator.of(context).pushNamed('editResume',arguments: resumes[index]);
                          },
                          child: Container(
                            child: Image.asset('asstes/image/editIcon.png',),
                          ),
                        ),
                      ),
                      Ink(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        height: s.height * 0.04,
                        padding: EdgeInsets.all(s.height * 0.005),


                        child: InkWell(
                          onTap: () {
                            // SQLiteHelper.sqLiteHelper.deletemaintbl(resumes[index].resume_id);
                            setState(() {

                            });
                          },
                          child: Container(
                            child: Image.asset('asstes/image/deleteIcon.png',),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('add_page').then((value) => setState(() {

          }));
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
            'Create New Resume',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
