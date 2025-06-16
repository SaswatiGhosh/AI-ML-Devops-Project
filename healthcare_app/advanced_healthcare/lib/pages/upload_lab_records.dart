import 'package:advanced_healthcare/pages/offline_records.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;


class UploadLabReport extends StatefulWidget {
  const UploadLabReport({super.key});
  @override
  State<UploadLabReport> createState() => _UploadLabReportState();
}

class _UploadLabReportState extends State<UploadLabReport> {
  File? _selectedFile; // Stores the selected file
  String? _fileName;   // Stores the name of the selected file

  // Picks a file using the File Picker
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      File file= File(result.files.single.path!);
      String name= result.files.single.name;
      setState(() {
        _selectedFile = file;
        _fileName = name;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OfflineRecords(
            file: file,
            fileName:name ,
          ),
        ),
      );
    }
  }

Future<void> _uploadFile() async {
  if (_selectedFile == null) return;

  final uri = Uri.parse('https://your-api-endpoint.com/upload');

  // Create multipart request
  var request = http.MultipartRequest('POST', uri)..files.add(await http.MultipartFile.fromPath('file', _selectedFile!.path));

  // Send the request

  var response = await request.send();
  if (response.statusCode == 200) {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('File uploaded successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload file.')),
      );
    }
  }


  @override
  Widget build(BuildContext context) => 
  Scaffold(appBar: AppBar(title: Text("Upload Lab Records"), backgroundColor: const Color.fromARGB(255, 218, 89, 241),), 
  body: SafeArea(
    child:Column(
    
    children:[
      SizedBox(height:20),
      Text("Upload your lab reports here", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              
              if (_fileName != null)
                Text('Selected file: $_fileName'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickFile,
                child: const Text('Pick File'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectedFile != null ? _uploadFile: null,
                child: const Text('Upload File'),
              )
        ]
      ),
      )
    ]
  )
  )
);
}











