import 'package:flutter/material.dart';

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
      body: Column(
        children: [],
      ),
      bottomSheet: Container(
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
    );
  }
}
