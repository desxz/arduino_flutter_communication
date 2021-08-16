import 'package:dio/dio.dart';

abstract class FirebaseService {
  final Dio dio;

  FirebaseService(this.dio);

  Future<bool> onBlink();
}
