import 'package:fluttertube/api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/video.dart';
import 'dart:async';

class VideoBloc implements BlocBase{

  Api api;

  List<dynamic> videos;

  VideoBloc(){
    api = Api();
    _searchController.stream.listen(_search);
  }

  final _videoController = StreamController<List<dynamic>>();
  final _searchController = StreamController<String>();

  Stream get outVideos => _videoController.stream;
  Sink get inSearch => _searchController.sink;

  void _search(String search) async{
    videos = await api.search(search);
    _videoController.sink.add(videos);
  }

  @override
  void dispose() {
    _searchController.close();
    _videoController.close();
  }


}