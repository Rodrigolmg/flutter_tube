import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase{

  Map<String, Video> _favoriteVideos = {};

  //Controllers
  final _favController = BehaviorSubject<Map<String, Video>>();

  //Stream
  Stream<Map<String, Video>> get outFav => _favController.stream;

  FavoriteBloc(){
    SharedPreferences.getInstance().then((prefs){
      if(prefs.getKeys().contains("favorites")){
        _favoriteVideos = json.decode(prefs.getString("favorites")).map(
            (key, value){
              return MapEntry(key, Video.fromJson(value));
            }
        ).cast<String, Video>();

        _favController.add(_favoriteVideos);
      }
    });
  }

  void toggleFavorite(Video video){

    if(_favoriteVideos.containsKey(video.id))
      _favoriteVideos.remove(video.id);
    else
      _favoriteVideos[video.id] = video;

    _favController.sink.add(_favoriteVideos);
    _saveFav();
  }

  void _saveFav(){
    SharedPreferences.getInstance().then(
        (prefs){
          prefs.setString("favorites", json.encode(_favoriteVideos));
        }
    );
  }

  @override
  void dispose() {
    _favController.close();
  }

}