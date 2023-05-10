import 'package:flutter/material.dart';
import '../models/generated/ans_sheet_checker_proto.pb.dart';
import '../services/submission_list.dart';
import 'view_submission.dart';

class Search extends StatefulWidget{
  const Search({super.key});

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search>{
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text("Search by Id");
  var value = TextEditingController();
  final _submissionList = SubmissionList();

  @override
  Widget build(BuildContext context){
    return ListTile(
      trailing: IconButton(
        onPressed: () {
          setState(() {
            if (customIcon.icon == Icons.search) {
              customIcon = const Icon(Icons.cancel);
              customSearchBar = ListTile(
                leading: const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 28,
                ),
                title: TextField(
                  controller: value,
                  decoration: const InputDecoration(
                    hintText: "Search by Id...",
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  onEditingComplete: (){
                    var found = false;
                    for(int i=0; i<_submissionList.submissions.length; i++){
                      Submission submission = _submissionList.submissions[i];
                      if(submission.id == int.parse(value.text)){
                        found = true;
                        showDialog(context: context, builder: (context) => ViewSubmission(submission: submission, index: i));
                      }
                    }
                    if(!found){
                      const snackBar = SnackBar(content: Text("Not found"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                ),
              );
            } else {
              customIcon = const Icon(Icons.search);
              customSearchBar = const Text("Search by Id");
            }
          });
        },
        icon: customIcon,
      ),
      title: customSearchBar,
    );
  }
}