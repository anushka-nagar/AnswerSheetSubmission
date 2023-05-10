///
//  Generated code. Do not modify.
//  source: ans_sheet_checker_proto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use urlDescriptor instead')
const Url$json = const {
  '1': 'Url',
  '2': const [
    const {'1': 'AddSubmission', '2': 0},
    const {'1': 'GetSubmissionById', '2': 1},
    const {'1': 'GetAllSubmissionsByIds', '2': 2},
    const {'1': 'GetAllSubmissions', '2': 3},
    const {'1': 'UpdateSubmissionById', '2': 4},
    const {'1': 'DeleteSubmissionById', '2': 5},
    const {'1': 'GetUrlRequestCounter', '2': 6},
  ],
};

/// Descriptor for `Url`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List urlDescriptor = $convert.base64Decode('CgNVcmwSEQoNQWRkU3VibWlzc2lvbhAAEhUKEUdldFN1Ym1pc3Npb25CeUlkEAESGgoWR2V0QWxsU3VibWlzc2lvbnNCeUlkcxACEhUKEUdldEFsbFN1Ym1pc3Npb25zEAMSGAoUVXBkYXRlU3VibWlzc2lvbkJ5SWQQBBIYChREZWxldGVTdWJtaXNzaW9uQnlJZBAFEhgKFEdldFVybFJlcXVlc3RDb3VudGVyEAY=');
@$core.Deprecated('Use fileDescriptor instead')
const File$json = const {
  '1': 'File',
  '2': const [
    const {'1': 'FileName', '3': 1, '4': 1, '5': 9, '10': 'FileName'},
    const {'1': 'LocalFileName', '3': 2, '4': 1, '5': 9, '10': 'LocalFileName'},
    const {'1': 'FilePath', '3': 3, '4': 1, '5': 9, '10': 'FilePath'},
    const {'1': 'FileSize', '3': 4, '4': 1, '5': 3, '10': 'FileSize'},
    const {'1': 'FileBuffer', '3': 5, '4': 1, '5': 12, '10': 'FileBuffer'},
  ],
};

/// Descriptor for `File`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileDescriptor = $convert.base64Decode('CgRGaWxlEhoKCEZpbGVOYW1lGAEgASgJUghGaWxlTmFtZRIkCg1Mb2NhbEZpbGVOYW1lGAIgASgJUg1Mb2NhbEZpbGVOYW1lEhoKCEZpbGVQYXRoGAMgASgJUghGaWxlUGF0aBIaCghGaWxlU2l6ZRgEIAEoA1IIRmlsZVNpemUSHgoKRmlsZUJ1ZmZlchgFIAEoDFIKRmlsZUJ1ZmZlcg==');
@$core.Deprecated('Use fileArrayDescriptor instead')
const FileArray$json = const {
  '1': 'FileArray',
  '2': const [
    const {'1': 'File', '3': 1, '4': 3, '5': 11, '6': '.AnsSheetCheckerGenerated.File', '10': 'File'},
  ],
};

/// Descriptor for `FileArray`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileArrayDescriptor = $convert.base64Decode('CglGaWxlQXJyYXkSMgoERmlsZRgBIAMoCzIeLkFuc1NoZWV0Q2hlY2tlckdlbmVyYXRlZC5GaWxlUgRGaWxl');
@$core.Deprecated('Use submissionDescriptor instead')
const Submission$json = const {
  '1': 'Submission',
  '2': const [
    const {'1': 'Id', '3': 1, '4': 1, '5': 3, '10': 'Id'},
    const {'1': 'StudentName', '3': 2, '4': 1, '5': 9, '10': 'StudentName'},
    const {'1': 'StudentEmail', '3': 3, '4': 1, '5': 9, '10': 'StudentEmail'},
    const {'1': 'File', '3': 4, '4': 1, '5': 11, '6': '.AnsSheetCheckerGenerated.File', '10': 'File'},
    const {'1': 'Timestamp', '3': 5, '4': 1, '5': 3, '10': 'Timestamp'},
  ],
};

/// Descriptor for `Submission`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submissionDescriptor = $convert.base64Decode('CgpTdWJtaXNzaW9uEg4KAklkGAEgASgDUgJJZBIgCgtTdHVkZW50TmFtZRgCIAEoCVILU3R1ZGVudE5hbWUSIgoMU3R1ZGVudEVtYWlsGAMgASgJUgxTdHVkZW50RW1haWwSMgoERmlsZRgEIAEoCzIeLkFuc1NoZWV0Q2hlY2tlckdlbmVyYXRlZC5GaWxlUgRGaWxlEhwKCVRpbWVzdGFtcBgFIAEoA1IJVGltZXN0YW1w');
@$core.Deprecated('Use submissionsArrayDescriptor instead')
const SubmissionsArray$json = const {
  '1': 'SubmissionsArray',
  '2': const [
    const {'1': 'Submission', '3': 1, '4': 3, '5': 11, '6': '.AnsSheetCheckerGenerated.Submission', '10': 'Submission'},
  ],
};

/// Descriptor for `SubmissionsArray`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submissionsArrayDescriptor = $convert.base64Decode('ChBTdWJtaXNzaW9uc0FycmF5EkQKClN1Ym1pc3Npb24YASADKAsyJC5BbnNTaGVldENoZWNrZXJHZW5lcmF0ZWQuU3VibWlzc2lvblIKU3VibWlzc2lvbg==');
@$core.Deprecated('Use byIdRequestDescriptor instead')
const ByIdRequest$json = const {
  '1': 'ByIdRequest',
  '2': const [
    const {'1': 'Id', '3': 1, '4': 1, '5': 3, '10': 'Id'},
  ],
};

/// Descriptor for `ByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List byIdRequestDescriptor = $convert.base64Decode('CgtCeUlkUmVxdWVzdBIOCgJJZBgBIAEoA1ICSWQ=');
@$core.Deprecated('Use byIdsRequestDescriptor instead')
const ByIdsRequest$json = const {
  '1': 'ByIdsRequest',
  '2': const [
    const {'1': 'Ids', '3': 1, '4': 3, '5': 3, '10': 'Ids'},
  ],
};

/// Descriptor for `ByIdsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List byIdsRequestDescriptor = $convert.base64Decode('CgxCeUlkc1JlcXVlc3QSEAoDSWRzGAEgAygDUgNJZHM=');
@$core.Deprecated('Use getUrlRequestCounterRequestDescriptor instead')
const GetUrlRequestCounterRequest$json = const {
  '1': 'GetUrlRequestCounterRequest',
  '2': const [
    const {'1': 'Url', '3': 1, '4': 1, '5': 14, '6': '.AnsSheetCheckerGenerated.Url', '10': 'Url'},
  ],
};

/// Descriptor for `GetUrlRequestCounterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUrlRequestCounterRequestDescriptor = $convert.base64Decode('ChtHZXRVcmxSZXF1ZXN0Q291bnRlclJlcXVlc3QSLwoDVXJsGAEgASgOMh0uQW5zU2hlZXRDaGVja2VyR2VuZXJhdGVkLlVybFIDVXJs');
@$core.Deprecated('Use getUrlRequestCounterResponseDescriptor instead')
const GetUrlRequestCounterResponse$json = const {
  '1': 'GetUrlRequestCounterResponse',
  '2': const [
    const {'1': 'N', '3': 1, '4': 1, '5': 3, '10': 'N'},
  ],
};

/// Descriptor for `GetUrlRequestCounterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUrlRequestCounterResponseDescriptor = $convert.base64Decode('ChxHZXRVcmxSZXF1ZXN0Q291bnRlclJlc3BvbnNlEgwKAU4YASABKANSAU4=');
@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode('CgVFbXB0eQ==');
