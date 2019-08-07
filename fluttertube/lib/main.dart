import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/api.dart';
import 'package:fluttertube/screens/home.dart';

import 'blocs/video_bloc.dart';

void main(){

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideoBloc(),
      child: MaterialApp(
        title: "FlutterTube Play",
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
