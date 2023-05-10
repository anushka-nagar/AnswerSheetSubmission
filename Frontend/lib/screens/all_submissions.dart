import '../services/submission_list.dart';
import 'search.dart';
import 'submission_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllSubmissions extends StatelessWidget {
  AllSubmissions({super.key});
  final _submissionList = SubmissionList();

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<SubmissionList>(context, listen: true);
    // final _submissionList = provider.getAllSubmissions();
    return Material(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Search(),
              Consumer<SubmissionList>(builder: (context, submissionList, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for(int i=0; i<_submissionList.submissions.length; i++)
                    SubmissionTile(submission: _submissionList.submissions.elementAt(i), index: i),
                ],
              ),
              )
            ],
          ),
        ),
      ),
    );
  }


}