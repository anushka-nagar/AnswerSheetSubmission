import '../models/generated/ans_sheet_checker_proto.pb.dart';
import 'update_submission.dart';
import 'package:flutter/material.dart';
import 'delete_submission.dart';

class ViewSubmission extends StatefulWidget{
  const ViewSubmission({super.key, required this.submission, required this.index});
  final Submission submission;
  final int index;

  @override
  State<ViewSubmission> createState() => ViewSubmissionState();
}

class ViewSubmissionState extends State<ViewSubmission>{
  @override
  Widget build(BuildContext context){
    return SimpleDialog(
      insetPadding: const EdgeInsets.all(16.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(10)),
              Text("Student Id: ${widget.submission.id}"),
              const Padding(padding: EdgeInsets.all(10)),
              Text("Student Name: ${widget.submission.studentName}"),
              const Padding(padding: EdgeInsets.all(10)),
              Text("Student Email: ${widget.submission.studentEmail}"),
              const Padding(padding: EdgeInsets.all(10)),
              Text("File Name: ${widget.submission.file.fileName}"),
              const Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateSubmission(submission: widget.submission, index: widget.index,))),
                    icon: const Icon(Icons.edit_note_rounded),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteSubmission(submission: widget.submission, index: widget.index))),
                    icon: const Icon(Icons.delete),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}