import 'dart:collection';
import 'package:answe_sheet_checker_grpc/models/generated/ans_sheet_checker_proto.pbgrpc.dart';
import 'package:answe_sheet_checker_grpc/services/ans_sheet_checker_channel.dart';
import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';

class SubmissionList extends ChangeNotifier{
  static final SubmissionList _instance = SubmissionList.initialize();
  static List<Submission> _submissionList = [];

  UnmodifiableListView<Submission> get submissions => UnmodifiableListView(_submissionList);

  factory SubmissionList(){
    return _instance;
  }

  SubmissionList.initialize(){
    _submissionList = [];
    getAllSubmissions();
  }

  // final List<Submission> _submissionList = [];
  //
  // SubmissionList(){
  //   getAllSubmissions();
  // }

  void getAllSubmissions() async {
    AnsSheetCheckerChannel channel = AnsSheetCheckerChannel();
    try{
      var response = await channel.stub.getAllSubmissions(Empty());
      print(response);
      for (var submission in response.submission) {
        _submissionList.add(submission);
      }
      notifyListeners();
    } on GrpcError catch(exception){

    } catch(exception){
      print('Caught error: $exception');
    }
    await channel.close();
  }

  void addSubmission(Submission submission) async {
    AnsSheetCheckerChannel channel = AnsSheetCheckerChannel();
    try{
      var response = await channel.stub.addSubmission(submission);
      _submissionList.add(response);
      notifyListeners();
    }catch(exception){
      print('Caught error: $exception');
    }
    await channel.close();
  }

  Future<bool> updateSubmission(Submission submission, int index) async {
    AnsSheetCheckerChannel channel = AnsSheetCheckerChannel();
    try{
      var response = await channel.stub.updateSubmissionById(submission);
      _submissionList.elementAt(index).studentName = submission.studentName;
      _submissionList.elementAt(index).studentEmail = submission.studentEmail;
      notifyListeners();
      return true;
    }catch(exception){
      print('Caught error: $exception');
    }
    await channel.close();
    return false;
  }

  Future<bool> deleteSubmission(Submission submission, int index) async {
    AnsSheetCheckerChannel channel = AnsSheetCheckerChannel();
    try{
      ByIdRequest request = ByIdRequest(id: submission.id);
      var response = await channel.stub.deleteSubmissionById(request);
      _submissionList.removeAt(index);
      notifyListeners();
      return true;
    }catch(exception){
      print('Caught error: $exception');
    }
    await channel.close();
    return false;
  }
}