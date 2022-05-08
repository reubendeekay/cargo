import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: FutureBuilder<PDFDocument>(
      future: PDFDocument.fromAsset('assets/doc.pdf'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PDFViewer(
            document: snapshot.data!,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    )));
  }
}
