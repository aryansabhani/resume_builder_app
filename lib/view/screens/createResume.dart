import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

class CreateResume extends StatefulWidget {
  const CreateResume({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateResume> createState() => _CreateResumeState();
}

class _CreateResumeState extends State<CreateResume> {
  final f = DateFormat('dd-MM-yyyy');

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    final ByteData data = await rootBundle.load('assets/images/ss.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final image = pw.MemoryImage(bytes);
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(children: [
            pw.Row(children: [
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Container(
                  child: pw.Image(image, height: 100, width: 100),
                ),
              ),
              pw.Spacer(),
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      "Perfect Naukari",
                      style: pw.TextStyle(
                        color: PdfColors.red,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    pw.Text(
                      "Appointment Letter",
                      style: pw.TextStyle(
                          color: PdfColors.blue900,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16),
                    ),
                  ]),
              pw.Spacer(),
            ]),
            pw.SizedBox(height: 10),
            pw.Divider(),
          ]);
        }));
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF393185),
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
        title: const Text(
          'Appointment Letter',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }
}
