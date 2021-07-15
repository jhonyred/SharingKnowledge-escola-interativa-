import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:escola_interativa/app/core/app_colors.dart';
import 'package:flutter/material.dart';

class PdfViewer extends StatefulWidget {
  PdfViewer({required this.disciplina, required this.file});

  final String disciplina;
  final String file;

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    String docFile = widget.file;
    document = await PDFDocument.fromURL(docFile);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.disciplina),
        centerTitle: true,
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
        // ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PDFViewer(
              document: document,
              zoomSteps: 1,
              pickerButtonColor: AppColors.red,
            ),
    );
  }
}
