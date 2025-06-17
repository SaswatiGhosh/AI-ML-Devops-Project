import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';


class OfflineRecords extends StatelessWidget 
{
  final File? file;
  final String? fileName;

  const OfflineRecords({
    super.key,
    this.file,
    this.fileName,
  });
  Future <Map<String, dynamic>> _loadSavedFile() async
  {
    final prefs=  await SharedPreferences.getInstance();
    final path = prefs.getString('offline_file_path');
    final name= prefs.getString('offline_file_name');

    print("Loaded path: $path");
    print("Loaded name: $name");

    if (path!= null && name!=null  && File(path).existsSync()){
      return{'file' : File(path), 'fileName' : name};
    }
    else{
      return {'file' : null, 'fileName' : null};
    }
  }
  @override
Widget build(BuildContext context) 
{
  return FutureBuilder
  (
    future: file != null && fileName != null
    ? Future.value({'file' : file, 'fileName' : fileName})
    : _loadSavedFile(),
    
    
    builder: (context,snapshot)
    {
      if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      final file = snapshot.data!['file'] as File?;
      final fileName = snapshot.data!['fileName'] as String?;
    
      final isFile= fileName != null &&(fileName.endsWith(".pdf") || fileName.endsWith(".docx") || fileName.endsWith("png"));
        return Scaffold
        (

        appBar: AppBar(title: const Text("Offline Records")),
        body: Center
        (
          child: file == null || fileName == null ? const Text("No file uploaded", style: TextStyle(fontSize: 18))
          : Column
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("File Name: $fileName", style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              isFile
                ? const Icon(Icons.description, size: 100)  // 📄 icon for docx/pdf
                : const Text("Unsupported file type"),
              const SizedBox(height: 20),
              ElevatedButton
              (
                onPressed: (){ (file != null) OpenFile.open(file.path)
                },
                child: const Text("Back"),
              ),
            ],
            ),
          ),
        );
      },
    );

  }
}
