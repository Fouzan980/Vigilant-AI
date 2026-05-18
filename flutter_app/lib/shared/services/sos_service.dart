import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:record/record.dart';

final sosServiceProvider = Provider((ref) => SOSService());

class SOSService {
  final AudioRecorder _audioRecorder = AudioRecorder();

  Future<void> activateSOS() async {
    // Stub: Create emergency report in Firestore

    // Stub: Trigger push notification to nearby law enforcement devices

    // Send SMS via url_launcher tel scheme
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: '911',
      queryParameters: {
        'body': 'EMERGENCY: I need help at my current location.',
      },
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    }

    // Start audio recording
    if (await _audioRecorder.hasPermission()) {
      await _audioRecorder.start(
        const RecordConfig(),
        path: 'sos_recording.m4a',
      );
    }
  }

  Future<void> cancelSOS() async {
    if (await _audioRecorder.isRecording()) {
      await _audioRecorder.stop();
    }
    // Stub: Cancel emergency report status
  }
}
