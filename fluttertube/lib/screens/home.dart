import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/video_bloc.dart';
import 'package:fluttertube/utils/data_search.dart';
import 'package:fluttertube/widgets/videotile.dart';

//fluttertube-248623
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<VideoBloc>(context);

    return Scaffold(
      backgroundColor: Colors.black,
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
            child: Text(
                "0",
              style: TextStyle(
                color: Colors.white
              ),
            ),
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
                  bloc.inSearch.add(result);
                }
              },
          )
        ],
      ),
      body: StreamBuilder(
        initialData: [],
        stream: bloc.outVideos,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemBuilder: (context, index){
                    if(index < snapshot.data.length){
                      return VideoTile(snapshot.data[index]);
                    } else if(index > 1){
                      bloc.inSearch.add(null);
                      return Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      );
                    } else {
                      return Container();
                    }

                  },
                itemCount: snapshot.data.length + 1,
              );
            } else {
              return Container();
            }
          }
      ),
    );
  }
}
