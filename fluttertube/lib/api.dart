import 'dart:convert';

import 'package:fluttertube/models/video.dart';
import "package:http/http.dart" as http;


const API_KEY = "AIzaSyBfHm4T8Q2Ak9nHBkZhe98bRklsTwrBflE";
//"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
//"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
//"http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"

class Api{

  String _search;
  String _nextToken;

  search(String search) async{
    _search = search;
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
    );

    return decode(response);
  }

  nextPage() async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
    );

    return decode(response);
  }


  decode(http.Response response){

    if(response.statusCode == 200){
      var decoded = json.decode(response.body);
      _nextToken = decoded["nextPageToken"];
      List<dynamic> videos = decoded["items"].map(
          (map){
            return Video.fromJson(map);
          }
      ).toList();

      return videos;
    } else {
      throw Exception("Failed to load videos");
    }


  }
}
