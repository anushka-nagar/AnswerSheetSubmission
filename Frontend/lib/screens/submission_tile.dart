import '../models/generated/ans_sheet_checker_proto.pb.dart';
import 'delete_submission.dart';
import 'update_submission.dart';
import 'view_submission.dart';
import 'package:flutter/material.dart';

class SubmissionTile extends StatefulWidget{
  const SubmissionTile({super.key, required this.submission, required this.index});
  final Submission submission;
  final int index;

  @override
  State<SubmissionTile> createState() => _SubmissionTileState();
}

class _SubmissionTileState extends State<SubmissionTile>{
  late int _id;
  late String _studentName;
  late String _email;
  late String _fileName;

  @override
  Widget build(BuildContext context){
    _id = widget.submission.id.toInt();
    _studentName = widget.submission.studentName;
    _email = widget.submission.studentEmail;
    _fileName = widget.submission.file.fileName;
    return Material(
      child: GestureDetector(
        onTap: () => {
          showDialog(context: context, builder: (context) => ViewSubmission(submission: widget.submission, index: widget.index))
          //Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSubmission(submission: widget.submission, index: widget.index)))
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Title(color: Colors.black, child: const Text("Student Id: ")),
                    Text(_id.toString()),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Row(
                  children: [
                    Title(color: Colors.black, child: const Text("Student Name: ")),
                    Text(_studentName),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(2)),
                Row(
                  children: [
                    Title(color: Colors.black, child: const Text("Student Email: ")),
                    Text(_email),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(2)),
                Row(
                  children: [
                    Title(color: Colors.black, child: const Text("File Name: ")),
                    Expanded(child: Text(_fileName, overflow: TextOverflow.ellipsis, maxLines: 2,)),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateSubmission(submission: widget.submission, index: widget.index,))),
                      icon: const Icon(Icons.edit_note_rounded),
                    ),
                    const Padding(padding: EdgeInsets.all(2)),
                    IconButton(
                      onPressed: () =>showDialog(context: context, builder: (context) => DeleteSubmission(submission: widget.submission, index: widget.index)),
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}