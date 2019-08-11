import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/video.dart';

class FavoriteBloc implements BlocBase{

  Map<String, dynamic> _favoriteVideos = {};

  //Controllers
  final _favController = StreamController<dynamic>.broadcast();

  //Stream
  Stream<dynamic> get outFav => _favController.stream;

  void toggleFavorite(Video video){

    if(_favoriteVideos.containsKey(video.id))
      _favoriteVideos.remove(video.id);
    else
      _favoriteVideos[video.id] = video;

    _favController.add(_favoriteVideos);
  }

  @override
  void dispose() {
    _favController.close();
  }

}