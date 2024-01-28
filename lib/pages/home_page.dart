import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _progress = 0.0;
  TextEditingController link = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media downloader app", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,
      ),
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text("Paste media link here: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: link,
                  cursorHeight: 20,
                  cursorRadius: Radius.circular(10),
                  decoration: InputDecoration(
                    label: Text("Enter a URL: "),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  cursorColor: Colors.blue,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: (){
                  FileDownloader.downloadFile(
                      url: link.text,
                    onDownloadCompleted: (path){
                        final File file = File(path);
                        print(file);
                        link.clear();
                    },
                      onProgress: (fileName, progress){
                        setState(() {
                          _progress = progress;
                        });
                      },
                    onDownloadError: (String error){
                        print("$error");
                    }
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.all(10),
                  child: Center(child: Text("Download", style: TextStyle(fontSize: 18, color: Colors.white),)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.indigo,
                  ),
                ),
              ),
              Container(
                height: 30,
                width: _progress * 4,
                color: Colors.blue,
              ),
              Text(_progress.toString() + "%"),
            ],
          ),
      ),
    );
  }
}
