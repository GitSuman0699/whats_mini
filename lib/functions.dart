// Function to copy text to clipboard
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void copyText(String text, BuildContext context) async {
  await Clipboard.setData(ClipboardData(text: text));
  // Optional: Show a snackbar or notification to the user
}

Future<void> gotoUrl({required String url, LaunchMode? launchMode}) async {
  final Uri uri = Uri.parse(url.toString());

  if (!await launchUrl(
    uri,
    mode: launchMode ?? LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $uri';
  }
}

String convert24to12({
  required DateTime dateTime,
}) {
  String hour = dateTime.hour.toString();
  String minute = dateTime.minute.toString();

  int hours = int.parse(hour);
  if (minute.length == 1) {
    minute = "0$minute";
  }

  String period = "AM";
  if (hours >= 12) {
    hours -= 12;
    period = "PM";
  }
  if (hours == 0) {
    hours = 12;
  }
  return "$hours:$minute $period";
}
