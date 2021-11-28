
import 'package:codebreaker_assignment/api/api_status.dart';

class PsResource {
  PsResource({this.status, this.message, this.data, this.list}) {
    if (message.contains('##')) {
      /**
       * Backend will reply error code within message
       * Error code and message are seperated with '##' sign
       * +
       * Error code 10001 = // Totally No Record
       * Error code 10002 = // No More Record at pagination
       */

      final List<String> messageList = message.split('##');
      if (messageList != null && messageList.length > 1) {
        errorCode = messageList[0];
        message = messageList[0];
        print(
            " Error Code...... ${errorCode.toString()}.....Message.....${message.toString()}");
      }
    }
  }
  // PsResource(this.status, this.errorCode, this.message, this.data);
  PsStatus status;

  String message;
  String errorCode;
  Map<String, dynamic> data;

  List<dynamic> list;

  // @override
  // bool operator ==(dynamic other) {
  //   print('other : ${other.data.hashCode}');
  //   print('me : ${data.hashCode}');
  //   return other.data == data;
  // }

  // @override
  // int get hashCode {
  //   if (data is List) {
  //     final List d = data as List;
  //     int i = d.length;
  //   }
  //   return hash2(data.hashCode, data.hashCode);
  // }

  // get length => null;
}
