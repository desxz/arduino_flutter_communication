import 'package:dio/src/dio.dart';
import 'dart:io';
import 'firebase_service.dart';

class BlinkService extends FirebaseService {
  BlinkService(Dio dio) : super(dio);

  bool isBliked = false;

  @override
  Future<bool> onBlink() async {
    final response = await dio.put(
        'https://flutter-arduino-e9560-default-rtdb.firebaseio.com/.json',
        data: {'isBlinked': '$isBliked'});

    if (response.statusCode == HttpStatus.ok) {
      isBliked = !isBliked;
      return true;
    } else {
      return false;
    }
  }
}
