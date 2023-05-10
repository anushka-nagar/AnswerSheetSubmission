///
//  Generated code. Do not modify.
//  source: ans_sheet_checker_proto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'ans_sheet_checker_proto.pb.dart' as $0;
export 'ans_sheet_checker_proto.pb.dart';

class AnsSheetCheckerClient extends $grpc.Client {
  static final _$addSubmission =
      $grpc.ClientMethod<$0.Submission, $0.Submission>(
          '/AnsSheetCheckerGenerated.AnsSheetChecker/AddSubmission',
          ($0.Submission value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Submission.fromBuffer(value));
  static final _$getSubmissionById =
      $grpc.ClientMethod<$0.ByIdRequest, $0.Submission>(
          '/AnsSheetCheckerGenerated.AnsSheetChecker/GetSubmissionById',
          ($0.ByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Submission.fromBuffer(value));
  static final _$getAllSubmissionsByIds =
      $grpc.ClientMethod<$0.ByIdsRequest, $0.SubmissionsArray>(
          '/AnsSheetCheckerGenerated.AnsSheetChecker/GetAllSubmissionsByIds',
          ($0.ByIdsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SubmissionsArray.fromBuffer(value));
  static final _$getAllSubmissions =
      $grpc.ClientMethod<$0.Empty, $0.SubmissionsArray>(
          '/AnsSheetCheckerGenerated.AnsSheetChecker/GetAllSubmissions',
          ($0.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SubmissionsArray.fromBuffer(value));
  static final _$updateSubmissionById =
      $grpc.ClientMethod<$0.Submission, $0.Submission>(
          '/AnsSheetCheckerGenerated.AnsSheetChecker/UpdateSubmissionById',
          ($0.Submission value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Submission.fromBuffer(value));
  static final _$deleteSubmissionById =
      $grpc.ClientMethod<$0.ByIdRequest, $0.Empty>(
          '/AnsSheetCheckerGenerated.AnsSheetChecker/DeleteSubmissionById',
          ($0.ByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$getUrlRequestCounter = $grpc.ClientMethod<
          $0.GetUrlRequestCounterRequest, $0.GetUrlRequestCounterResponse>(
      '/AnsSheetCheckerGenerated.AnsSheetChecker/GetUrlRequestCounter',
      ($0.GetUrlRequestCounterRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUrlRequestCounterResponse.fromBuffer(value));
  static final _$downloadFiles = $grpc.ClientMethod<$0.Empty, $0.File>(
      '/AnsSheetCheckerGenerated.AnsSheetChecker/DownloadFiles',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.File.fromBuffer(value));
  static final _$uploadFiles = $grpc.ClientMethod<$0.File, $0.FileArray>(
      '/AnsSheetCheckerGenerated.AnsSheetChecker/uploadFiles',
      ($0.File value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.FileArray.fromBuffer(value));

  AnsSheetCheckerClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Submission> addSubmission($0.Submission request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addSubmission, request, options: options);
  }

  $grpc.ResponseFuture<$0.Submission> getSubmissionById($0.ByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSubmissionById, request, options: options);
  }

  $grpc.ResponseFuture<$0.SubmissionsArray> getAllSubmissionsByIds(
      $0.ByIdsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllSubmissionsByIds, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.SubmissionsArray> getAllSubmissions($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllSubmissions, request, options: options);
  }

  $grpc.ResponseFuture<$0.Submission> updateSubmissionById(
      $0.Submission request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSubmissionById, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> deleteSubmissionById($0.ByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteSubmissionById, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUrlRequestCounterResponse> getUrlRequestCounter(
      $0.GetUrlRequestCounterRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUrlRequestCounter, request, options: options);
  }

  $grpc.ResponseStream<$0.File> downloadFiles($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$downloadFiles, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.FileArray> uploadFiles($async.Stream<$0.File> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$uploadFiles, request, options: options)
        .single;
  }
}

abstract class AnsSheetCheckerServiceBase extends $grpc.Service {
  $core.String get $name => 'AnsSheetCheckerGenerated.AnsSheetChecker';

  AnsSheetCheckerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Submission, $0.Submission>(
        'AddSubmission',
        addSubmission_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Submission.fromBuffer(value),
        ($0.Submission value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ByIdRequest, $0.Submission>(
        'GetSubmissionById',
        getSubmissionById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ByIdRequest.fromBuffer(value),
        ($0.Submission value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ByIdsRequest, $0.SubmissionsArray>(
        'GetAllSubmissionsByIds',
        getAllSubmissionsByIds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ByIdsRequest.fromBuffer(value),
        ($0.SubmissionsArray value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.SubmissionsArray>(
        'GetAllSubmissions',
        getAllSubmissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.SubmissionsArray value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Submission, $0.Submission>(
        'UpdateSubmissionById',
        updateSubmissionById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Submission.fromBuffer(value),
        ($0.Submission value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ByIdRequest, $0.Empty>(
        'DeleteSubmissionById',
        deleteSubmissionById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ByIdRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUrlRequestCounterRequest,
            $0.GetUrlRequestCounterResponse>(
        'GetUrlRequestCounter',
        getUrlRequestCounter_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUrlRequestCounterRequest.fromBuffer(value),
        ($0.GetUrlRequestCounterResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.File>(
        'DownloadFiles',
        downloadFiles_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.File value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.File, $0.FileArray>(
        'uploadFiles',
        uploadFiles,
        true,
        false,
        ($core.List<$core.int> value) => $0.File.fromBuffer(value),
        ($0.FileArray value) => value.writeToBuffer()));
  }

  $async.Future<$0.Submission> addSubmission_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Submission> request) async {
    return addSubmission(call, await request);
  }

  $async.Future<$0.Submission> getSubmissionById_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ByIdRequest> request) async {
    return getSubmissionById(call, await request);
  }

  $async.Future<$0.SubmissionsArray> getAllSubmissionsByIds_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ByIdsRequest> request) async {
    return getAllSubmissionsByIds(call, await request);
  }

  $async.Future<$0.SubmissionsArray> getAllSubmissions_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getAllSubmissions(call, await request);
  }

  $async.Future<$0.Submission> updateSubmissionById_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Submission> request) async {
    return updateSubmissionById(call, await request);
  }

  $async.Future<$0.Empty> deleteSubmissionById_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ByIdRequest> request) async {
    return deleteSubmissionById(call, await request);
  }

  $async.Future<$0.GetUrlRequestCounterResponse> getUrlRequestCounter_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUrlRequestCounterRequest> request) async {
    return getUrlRequestCounter(call, await request);
  }

  $async.Stream<$0.File> downloadFiles_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* downloadFiles(call, await request);
  }

  $async.Future<$0.Submission> addSubmission(
      $grpc.ServiceCall call, $0.Submission request);
  $async.Future<$0.Submission> getSubmissionById(
      $grpc.ServiceCall call, $0.ByIdRequest request);
  $async.Future<$0.SubmissionsArray> getAllSubmissionsByIds(
      $grpc.ServiceCall call, $0.ByIdsRequest request);
  $async.Future<$0.SubmissionsArray> getAllSubmissions(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Submission> updateSubmissionById(
      $grpc.ServiceCall call, $0.Submission request);
  $async.Future<$0.Empty> deleteSubmissionById(
      $grpc.ServiceCall call, $0.ByIdRequest request);
  $async.Future<$0.GetUrlRequestCounterResponse> getUrlRequestCounter(
      $grpc.ServiceCall call, $0.GetUrlRequestCounterRequest request);
  $async.Stream<$0.File> downloadFiles(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.FileArray> uploadFiles(
      $grpc.ServiceCall call, $async.Stream<$0.File> request);
}
