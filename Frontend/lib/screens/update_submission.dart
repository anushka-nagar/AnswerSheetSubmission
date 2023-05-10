import 'package:flutter/material.dart';
import '../main.dart';
import '../models/generated/ans_sheet_checker_proto.pb.dart';
import '../services/submission_list.dart';
import 'add_submission.dart';

class UpdateSubmission extends StatefulWidget {
  const UpdateSubmission({super.key, required this.submission, required this.index});
  final Submission submission;
  final int index;

  @override
  State<UpdateSubmission> createState() => UpdateSubmissionState();
}

class UpdateSubmissionState extends State<UpdateSubmission> {
  Submission formSubmission = Submission();
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
                    Title(color: Colors.teal, child: const Text("Update Submission")),
                    TextFormField(
                      initialValue: widget.submission.studentName,
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
                      initialValue: widget.submission.studentEmail,
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
                    const Padding(padding: EdgeInsets.all(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () => _formKey.currentState!.reset(),
                            child: const Text("Reset")
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        ElevatedButton(
                            onPressed: () async {
                              if(_formKey.currentState!.validate()){
                                setState(() => {
                                  _formKey.currentState!.save(),
                                  formSubmission.setField(1, widget.submission.id),
                                  _submissionList.updateSubmission(formSubmission, widget.index)
                                });
                                Navigator.pop(context);
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
}
