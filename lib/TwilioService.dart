import 'package:twilio_flutter/twilio_flutter.dart';

class TwilioService {
  static final TwilioService _singleton = TwilioService._internal();
  late TwilioFlutter twilioFlutter;

  factory TwilioService() {
    return _singleton;
  }

  TwilioService._internal() {
    twilioFlutter = TwilioFlutter(
      accountSid: 'ACf4f89221f22f43cd869487d7b0c274be',
      authToken: 'HQXF3ATLU9SXAALN8HNC2QKD',
      twilioNumber: '7994524629',
    );
  }

  Future<void> sendSMS(String toNumber, String message) async {
    await twilioFlutter.sendSMS(
      toNumber: toNumber,
      messageBody: message,
    );
  }
}
