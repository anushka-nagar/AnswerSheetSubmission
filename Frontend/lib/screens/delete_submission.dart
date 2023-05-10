import 'package:flutter/material.dart';
import '../models/generated/ans_sheet_checker_proto.pb.dart';
import '../services/submission_list.dart';

class DeleteSubmission extends StatefulWidget{
  const DeleteSubmission({super.key, required this.submission, required this.index});
  final Submission submission;
  final int index;

  @override
  State<DeleteSubmission> createState() => DeleteSubmissionState();
}

class DeleteSubmissionState extends State<DeleteSubmission>{
  final SubmissionList _submissionList = SubmissionList();
  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text("Are you sure you want to delete submission ${widget.submission.id}?"),
      actions: [
        ElevatedButton(
          onPressed: () {
            _submissionList.deleteSubmission(widget.submission, widget.index);
            String msg = "Deleted successfully.";
            Navigator.pop(context);
            var snackBar =  SnackBar(content: Text(msg));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: const Text("Yes"),
        ),
        const Padding(padding: EdgeInsets.all(5)),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("No"),
        ),
      ],
    );
  }
}