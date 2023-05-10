///
//  Generated code. Do not modify.
//  source: ans_sheet_checker_proto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'ans_sheet_checker_proto.pbenum.dart';

export 'ans_sheet_checker_proto.pbenum.dart';

class File extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'File', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnsSheetCheckerGenerated'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FileName', protoName: 'FileName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LocalFileName', protoName: 'LocalFileName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FilePath', protoName: 'FilePath')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FileSize', protoName: 'FileSize')
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FileBuffer', $pb.PbFieldType.OY, protoName: 'FileBuffer')
    ..hasRequiredFields = false
  ;

  File._() : super();
  factory File({
    $core.String? fileName,
    $core.String? localFileName,
    $core.String? filePath,
    $fixnum.Int64? fileSize,
    $core.List<$core.int>? fileBuffer,
  }) {
    final _result = create();
    if (fileName != null) {
      _result.fileName = fileName;
    }
    if (localFileName != null) {
      _result.localFileName = localFileName;
    }
    if (filePath != null) {
      _result.filePath = filePath;
    }
    if (fileSize != null) {
      _result.fileSize = fileSize;
    }
    if (fileBuffer != null) {
      _result.fileBuffer = fileBuffer;
    }
    return _result;
  }
  factory File.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory File.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  File clone() => File()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  File copyWith(void Function(File) updates) => super.copyWith((message) => updates(message as File)) as File; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static File create() => File._();
  File createEmptyInstance() => create();
  static $pb.PbList<File> createRepeated() => $pb.PbList<File>();
  @$core.pragma('dart2js:noInline')
  static File getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<File>(create);
  static File? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fileName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fileName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFileName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get localFileName => $_getSZ(1);
  @$pb.TagNumber(2)
  set localFileName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLocalFileName() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocalFileName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get filePath => $_getSZ(2);
  @$pb.TagNumber(3)
  set filePath($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFilePath() => $_has(2);
  @$pb.TagNumber(3)
  void clearFilePath() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get fileSize => $_getI64(3);
  @$pb.TagNumber(4)
  set fileSize($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFileSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearFileSize() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get fileBuffer => $_getN(4);
  @$pb.TagNumber(5)
  set fileBuffer($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFileBuffer() => $_has(4);
  @$pb.TagNumber(5)
  void clearFileBuffer() => clearField(5);
}

class FileArray extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FileArray', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnsSheetCheckerGenerated'), createEmptyInstance: create)
    ..pc<File>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'File', $pb.PbFieldType.PM, protoName: 'File', subBuilder: File.create)
    ..hasRequiredFields = false
  ;

  FileArray._() : super();
  factory FileArray({
    $core.Iterable<File>? file,
  }) {
    final _result = create();
    if (file != null) {
      _result.file.addAll(file);
    }
    return _result;
  }
  factory FileArray.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileArray.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileArray clone() => FileArray()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileArray copyWith(void Function(FileArray) updates) => super.copyWith((message) => updates(message as FileArray)) as FileArray; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FileArray create() => FileArray._();
  FileArray createEmptyInstance() => create();
  static $pb.PbList<FileArray> createRepeated() => $pb.PbList<FileArray>();
  @$core.pragma('dart2js:noInline')
  static FileArray getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileArray>(create);
  static FileArray? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<File> get file => $_getList(0);
}

class Submission extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Submission', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnsSheetCheckerGenerated'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Id', protoName: 'Id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'StudentName', protoName: 'StudentName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'StudentEmail', protoName: 'StudentEmail')
    ..aOM<File>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'File', protoName: 'File', subBuilder: File.create)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Timestamp', protoName: 'Timestamp')
    ..hasRequiredFields = false
  ;

  Submission._() : super();
  factory Submission({
    $fixnum.Int64? id,
    $core.String? studentName,
    $core.String? studentEmail,
    File? file,
    $fixnum.Int64? timestamp,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (studentName != null) {
      _result.studentName = studentName;
    }
    if (studentEmail != null) {
      _result.studentEmail = studentEmail;
    }
    if (file != null) {
      _result.file = file;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    return _result;
  }
  factory Submission.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Submission.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Submission clone() => Submission()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Submission copyWith(void Function(Submission) updates) => super.copyWith((message) => updates(message as Submission)) as Submission; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Submission create() => Submission._();
  Submission createEmptyInstance() => create();
  static $pb.PbList<Submission> createRepeated() => $pb.PbList<Submission>();
  @$core.pragma('dart2js:noInline')
  static Submission getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Submission>(create);
  static Submission? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get studentName => $_getSZ(1);
  @$pb.TagNumber(2)
  set studentName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStudentName() => $_has(1);
  @$pb.TagNumber(2)
  void clearStudentName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get studentEmail => $_getSZ(2);
  @$pb.TagNumber(3)
  set studentEmail($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStudentEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearStudentEmail() => clearField(3);

  @$pb.TagNumber(4)
  File get file => $_getN(3);
  @$pb.TagNumber(4)
  set file(File v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasFile() => $_has(3);
  @$pb.TagNumber(4)
  void clearFile() => clearField(4);
  @$pb.TagNumber(4)
  File ensureFile() => $_ensure(3);

  @$pb.TagNumber(5)
  $fixnum.Int64 get timestamp => $_getI64(4);
  @$pb.TagNumber(5)
  set timestamp($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => clearField(5);
}

class SubmissionsArray extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubmissionsArray', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnsSheetCheckerGenerated'), createEmptyInstance: create)
    ..pc<Submission>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Submission', $pb.PbFieldType.PM, protoName: 'Submission', subBuilder: Submission.create)
    ..hasRequiredFields = false
  ;

  SubmissionsArray._() : super();
  factory SubmissionsArray({
    $core.Iterable<Submission>? submission,
  }) {
    final _result = create();
    if (submission != null) {
      _result.submission.addAll(submission);
    }
    return _result;
  }
  factory SubmissionsArray.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubmissionsArray.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubmissionsArray clone() => SubmissionsArray()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubmissionsArray copyWith(void Function(SubmissionsArray) updates) => super.copyWith((message) => updates(message as SubmissionsArray)) as SubmissionsArray; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubmissionsArray create() => SubmissionsArray._();
  SubmissionsArray createEmptyInstance() => create();
  static $pb.PbList<SubmissionsArray> createRepeated() => $pb.PbList<SubmissionsArray>();
  @$core.pragma('dart2js:noInline')
  static SubmissionsArray getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubmissionsArray>(create);
  static SubmissionsArray? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Submission> get submission => $_getList(0);
}

class ByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnsSheetCheckerGenerated'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Id', protoName: 'Id')
    ..hasRequiredFields = false
  ;

  ByIdRequest._() : super();
  factory ByIdRequest({
    $fixnum.Int64? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory ByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ByIdRequest clone() => ByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ByIdRequest copyWith(void Function(ByIdRequest) updates) => super.copyWith((message) => updates(message as ByIdRequest)) as ByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ByIdRequest create() => ByIdRequest._();
  ByIdRequest createEmptyInstance() => create();
  static $pb.PbList<ByIdRequest> createRepeated() => $pb.PbList<ByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static ByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ByIdRequest>(create);
  static ByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class ByIdsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ByIdsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnsSheetCheckerGenerated'), createEmptyInstance: create)
    ..p<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Ids', $pb.PbFieldType.K6, protoName: 'Ids')
    ..hasRequiredFields = false
  ;

  ByIdsRequest._() : super();
  factory ByIdsRequest({
    $core.Iterable<$fixnum.Int64>? ids,
  }) {
    final _result = create();
    if (ids != null) {
      _result.ids.addAll(ids);
    }
    return _result;
  }
  factory ByIdsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ByIdsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ByIdsRequest clone() => ByIdsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ByIdsRequest copyWith(void Function(ByIdsRequest) updates) => super.copyWith((message) => updates(message as ByIdsRequest)) as ByIdsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ByIdsRequest create() => ByIdsRequest._();
  ByIdsRequest createEmptyInstance() => create();
  static $pb.PbList<ByIdsRequest> createRepeated() => $pb.PbList<ByIdsRequest>();
  @$core.pragma('dart2js:noInline')
  static ByIdsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ByIdsRequest>(create);
  static ByIdsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$fixnum.Int64> get ids => $_getList(0);
}

class GetUrlRequestCounterRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUrlRequestCounterRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnsSheetCheckerGenerated'), createEmptyInstance: create)
    ..e<Url>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Url', $pb.PbFieldType.OE, protoName: 'Url', defaultOrMaker: Url.AddSubmission, valueOf: Url.valueOf, enumValues: Url.values)
    ..hasRequiredFields = false
  ;

  GetUrlRequestCounterRequest._() : super();
  factory GetUrlRequestCounterRequest({
    Url? url,
  }) {
    final _result = create();
    if (url != null) {
      _result.url = url;
    }
    return _result;
  }
  factory GetUrlRequestCounterRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUrlRequestCounterRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUrlRequestCounterRequest clone() => GetUrlRequestCounterRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUrlRequestCounterRequest copyWith(void Function(GetUrlRequestCounterRequest) updates) => super.copyWith((message) => updates(message as GetUrlRequestCounterRequest)) as GetUrlRequestCounterRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUrlRequestCounterRequest create() => GetUrlRequestCounterRequest._();
  GetUrlRequestCounterRequest createEmptyInstance() => create();
  static $pb.PbList<GetUrlRequestCounterRequest> createRepeated() => $pb.PbList<GetUrlRequestCounterRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUrlRequestCounterRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUrlRequestCounterRequest>(create);
  static GetUrlRequestCounterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Url get url => $_getN(0);
  @$pb.TagNumber(1)
  set url(Url v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => clearField(1);
}

class GetUrlRequestCounterResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUrlRequestCounterResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnsSheetCheckerGenerated'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'N', protoName: 'N')
    ..hasRequiredFields = false
  ;

  GetUrlRequestCounterResponse._() : super();
  factory GetUrlRequestCounterResponse({
    $fixnum.Int64? n,
  }) {
    final _result = create();
    if (n != null) {
      _result.n = n;
    }
    return _result;
  }
  factory GetUrlRequestCounterResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUrlRequestCounterResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUrlRequestCounterResponse clone() => GetUrlRequestCounterResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUrlRequestCounterResponse copyWith(void Function(GetUrlRequestCounterResponse) updates) => super.copyWith((message) => updates(message as GetUrlRequestCounterResponse)) as GetUrlRequestCounterResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUrlRequestCounterResponse create() => GetUrlRequestCounterResponse._();
  GetUrlRequestCounterResponse createEmptyInstance() => create();
  static $pb.PbList<GetUrlRequestCounterResponse> createRepeated() => $pb.PbList<GetUrlRequestCounterResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUrlRequestCounterResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUrlRequestCounterResponse>(create);
  static GetUrlRequestCounterResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get n => $_getI64(0);
  @$pb.TagNumber(1)
  set n($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasN() => $_has(0);
  @$pb.TagNumber(1)
  void clearN() => clearField(1);
}

class Empty extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Empty', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnsSheetCheckerGenerated'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Empty._() : super();
  factory Empty() => create();
  factory Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Empty clone() => Empty()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty)) as Empty; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => $pb.PbList<Empty>();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

