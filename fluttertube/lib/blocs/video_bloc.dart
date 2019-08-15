import 'package:fluttertube/api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/video.dart';
import 'dart:async';

class VideoBloc implements BlocBase{

  Api api;

  List<Video> videos;

  final _videoController = StreamController<List<Video>>();
  Stream get outVideos => _videoController.stream;

  final _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideoBloc(){
    api = Api();
    _searchController.stream.listen(_search);
  }

  void _search(String search) async{

    if(search != null){
      _videoController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    _videoController.sink.add(videos);
  }

  @override
  void dispose() {
    _searchController.close();
    _videoController.close();
  }


}