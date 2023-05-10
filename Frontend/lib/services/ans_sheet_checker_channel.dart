import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';

import '../models/generated/ans_sheet_checker_proto.pbgrpc.dart';

class AnsSheetCheckerChannel {
  late final channel;
  late final stub;

  AnsSheetCheckerChannel(){
    channel = ClientChannel("192.168.1.223", port: 443, options: const ChannelOptions(credentials: ChannelCredentials.insecure()));
    stub = AnsSheetCheckerClient(channel);
  }

  Future<void> close() async{
    await channel.shutdown();
  }
}