
import 'package:erpvc/pages/pdf_view/pdf_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:formz/formz.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class PdfViewerPage extends StatefulWidget {
  PdfViewerPage({Key? key,}) : super(key: key);



  static Route route() {
    return MaterialPageRoute(
        builder: (_) =>
            BlocProvider(
              create: (context) => PdfCubit(),
              child: PdfViewerPage(),
            ));
  }

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late File Pfile;
  bool isLoading = false;
  var _openResult = 'Unknown';
  Future<void> loadNetwork() async {
    // setState(() {
    //   isLoading = true;
    // });
    // var url =
    //     'https://dev.businessfinancialgroup.biz/uploads/get-file-stream/649d12c6d01ec6ad25e0f2db?show=view';
    context.read<PdfCubit>().onPdfLoad(status: FormzSubmissionStatus.inProgress);

    var url = "https://icseindia.org/document/sample.pdf"/*widget.routeArguments!.pdfUrl.toString()*/;
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    print("bytes --..$bytes");
    final filename = path.basename(url);
    print("filename --..$filename");
    final dir = await getApplicationDocumentsDirectory();
    print("dir --..$dir");
    var file = File('${dir.path}/$filename');
    print("file --..$file");
    await file.writeAsBytes(bytes, flush: true);

    context.read<PdfCubit>().onPdfLoad(pFile:file ,status: FormzSubmissionStatus.success);

    // setState(() {
    //   Pfile = file;
    // });
    // print(Pfile);
    // setState(() {
    //   isLoading = false;
    // });
  }
  Future<void> openFile() async {
    const filePath = '/data/user/0/com.app.erpvc/cache/file_picker/classroomrespolicy1.docx';
    final result = await OpenFilex.open(filePath);

    setState(() {
      _openResult = "type=${result.type}  message=${result.message}";
    });
  }
  @override
  void initState() {
    loadNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PdfCubit, PdfState>(
      builder: (context, state) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('open result: $_openResult\n'),
                  TextButton(
                    onPressed: openFile,
                    child: const Text('Tap to open file'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
