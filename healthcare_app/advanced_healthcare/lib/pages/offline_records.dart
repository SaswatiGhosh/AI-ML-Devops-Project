import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';


class OfflineRecords extends StatelessWidget 
{
  final File? file;
  final String? fileName;

  const OfflineRecords({
    super.key,
    this.file,
    this.fileName,
  });
  @override
Widget build(BuildContext context) {
  final isFile= fileName != null &&(fileName!.endsWith(".pdf") || fileName!.endsWith(".docx") || fileName!.endsWith("png"));
  return Scaffold
  (

  appBar: AppBar(title: const Text("Offline Records")),
  body: Center(
    child: file == null || fileName == null ? const Text("No file uploaded", style: TextStyle(fontSize: 18))
    : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("File Name: $fileName", style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 20),
        isFile
            ? Image.file(file!, height: 200)
          : const Icon(Icons.insert_drive_file, size: 100),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Back"),
          ),
         ],
        ),
      ),
      
    );
  }
}