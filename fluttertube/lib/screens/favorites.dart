import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';

class Favorites extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<FavoriteBloc>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<dynamic>(
        initialData: {},
          builder: (context, snapshot){
            return ListView(
              children: snapshot.data.values.map<Widget>(
                  (video){
                    return InkWell(
                      onTap: (){

                      },
                      onLongPress: (){
                        bloc.toggleFavorite(video);
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100, height: 50,
                            child: Image.network(video.thumb),
                          ),
                          Expanded(
                              child: Text(
                                video.title,
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                                maxLines: 2,
                              )
                          )
                        ],
                      ),
                    );
                  }
              ).toList(),
            );
          }
      ),
    );
  }

}