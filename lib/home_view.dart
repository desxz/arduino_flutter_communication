import 'package:dio/dio.dart';
import 'package:firebase_arduino/service/blink_service.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final blinkService = BlinkService(
    Dio(
      BaseOptions(
        baseUrl:
            'https://flutter-arduino-e9560-default-rtdb.firebaseio.com/.json',
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arduino and Flutter Communication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width * 0.05,
              height: MediaQuery.of(context).size.width * 0.05,
              decoration: BoxDecoration(
                color: blinkService.isBliked ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            TextButton(
              onPressed: () {
                final blinkValue = blinkService.onBlink();
                setState(() {
                  blinkService.isBliked;
                });
              },
              child: Text(
                'Blink!',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
