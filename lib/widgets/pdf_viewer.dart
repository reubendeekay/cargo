import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class MyPdfViewer extends StatelessWidget {
  MyPdfViewer({Key? key}) : super(key: key);
  final pdfController = PdfController(
    document: PdfDocument.openAsset('assets/images/pdf.pdf'),
  );

  @override
  Widget build(BuildContext context) {
    return PdfView(
      controller: pdfController,
    );
  }
}
