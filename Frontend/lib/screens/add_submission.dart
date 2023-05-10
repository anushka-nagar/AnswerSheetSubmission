import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../main.dart';
import '../models/generated/ans_sheet_checker_proto.pb.dart';
import '../services/submission_list.dart';


class AddSubmission extends StatefulWidget {
  const AddSubmission({super.key, this.newSubmission});
  final Submission? newSubmission;

  @override
  State<AddSubmission> createState() => AddSubmissionState();
}

class AddSubmissionState extends State<AddSubmission> {
  Submission formSubmission = Submission();
  File formFile = File();
  final _formKey = GlobalKey<FormState>();
  final SubmissionList _submissionList = SubmissionList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Answer Sheet Checker"),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsetsDirectional.only(top: 80)),
              ListTile(
                title: const Text("Home"),
                textColor: Colors.teal,
                tileColor: Colors.white,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())),
              ),
              ListTile(
                title: const Text("Add submission"),
                textColor: Colors.teal,
                tileColor: Colors.white,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddSubmission())),
              ),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Title(color: Colors.teal, child: const Text("Add Submission")),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Student Name"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return "Please enter student name";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        formSubmission.studentName = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Student Email"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(value)){
                          return "Please enter valid email";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        formSubmission.studentEmail = value!;
                      },
                    ),
                    // FormBuilderFilePicker(
                    //   name: "text file",
                    //   withData: true,
                    //   typeSelectors: [
                    //     TypeSelector(
                    //         type: FileType.any,
                    //         selector: Row(
                    //           children: const <Widget>[
                    //             Icon(Icons.file_upload_rounded),
                    //             Padding(
                    //               padding: EdgeInsets.all(8),
                    //               child: Text("Add document"),
                    //             )
                    //           ],
                    //         )
                    //     )
                    //   ],
                    //   validator: (value) {
                    //     if(value == null || value.isEmpty) {
                    //       return "Please upload submission";
                    //     }
                    //     return null;
                    //   },
                    //   onSaved: (value) => {
                    //     formFile.setField(1, value!.first.name),
                    //     formFile.setField(5, value.first.bytes!.toList()),
                    //     formSubmission.setField(4, formFile)
                    //   },
                    // ),
                    ElevatedButton(
                      onPressed: () async {
                        try{
                          final FilePickerResult? result =
                          await FilePicker.platform.pickFiles(type: FileType.any, withData: true);
                          if(result == null){
                            String msg = "Please select a file." ;
                            var snackBar =  SnackBar(content: Text(msg));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else{
                            setState(() {
                              formFile.fileName = result.files.single.name;
                              formFile.fileBuffer =result.files.single.bytes!.toList();
                              print(formFile);
                            });
                          }
                        }
                        catch(e){
                          print('Caught error file picker: $e');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Icon(Icons.file_upload_rounded),
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("Add document"),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: formFile.fileName != "",
                        child: Text(formFile.fileName)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () => {
                              _formKey.currentState!.reset(),
                              formFile = File()
                            },

                            child: const Text("Reset")
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        ElevatedButton(
                            onPressed: () => {
                              if(_formKey.currentState!.validate()){
                                setState(()=>{
                                  _formKey.currentState!.save(),
                                  formSubmission.file = formFile,
                                  print(formSubmission),
                                  _submissionList.addSubmission(formSubmission)
                                }),
                                Navigator.pop(context)
                              }
                            },
                            child: const Text("Submit")
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  Future<void> _pickFile(BuildContext context) async {
      try{
        final FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any, withData: true);
        if(result == null){
          String msg = "Please select a file." ;
          var snackBar =  SnackBar(content: Text(msg));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else{
          setState(() {
            formFile.fileName = result.files.single.name;
            formFile.fileBuffer =result.files.single.bytes!.toList();
            print(formFile);
          });
        }
      }
      catch(e){
        print('Caught error file picker: $e');
      }
      //}
    }
}

