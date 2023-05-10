///
//  Generated code. Do not modify.
//  source: ans_sheet_checker_proto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Url extends $pb.ProtobufEnum {
  static const Url AddSubmission = Url._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AddSubmission');
  static const Url GetSubmissionById = Url._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GetSubmissionById');
  static const Url GetAllSubmissionsByIds = Url._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GetAllSubmissionsByIds');
  static const Url GetAllSubmissions = Url._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GetAllSubmissions');
  static const Url UpdateSubmissionById = Url._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UpdateSubmissionById');
  static const Url DeleteSubmissionById = Url._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DeleteSubmissionById');
  static const Url GetUrlRequestCounter = Url._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GetUrlRequestCounter');

  static const $core.List<Url> values = <Url> [
    AddSubmission,
    GetSubmissionById,
    GetAllSubmissionsByIds,
    GetAllSubmissions,
    UpdateSubmissionById,
    DeleteSubmissionById,
    GetUrlRequestCounter,
  ];

  static final $core.Map<$core.int, Url> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Url? valueOf($core.int value) => _byValue[value];

  const Url._($core.int v, $core.String n) : super(v, n);
}

