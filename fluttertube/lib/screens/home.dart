import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/video_bloc.dart';
import 'package:fluttertube/utils/data_search.dart';

//fluttertube-248623
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/yt_logo_rgb_dark.png"),
        ),
        elevation: 8,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(""),
          ),
          IconButton(
              icon: Icon(Icons.star),
              onPressed: (){},
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async{
                String result = await showSearch(
                    context: context,
                    delegate: DataSearch()
                );

                if(result != null && result.isNotEmpty){
                  BlocProvider.of<VideoBloc>(context).inSearch.add(result);
                }
              },
          )
        ],
      ),
      body: Column(),
    );
  }
}
