import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class lyric extends StatefulWidget {
lyric({required this.id});
int id;

  @override
  State<lyric> createState() => _lyricState();
}

class _lyricState extends State<lyric> {
  static int lid=0;

  var _datajson = {};
  var _datajson1 = {};
  Widget cont=    Center(
    child: CircularProgressIndicator(color: Colors.blueAccent,),
  );

  void fetchData() async{
    try {
      setState((){
        lid = widget.id;
      });
      final url = "https://api.musixmatch.com/ws/1.1/track.get?track_id=${lid}&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
      final data = await get(Uri.parse(url));
      final jsondata = jsonDecode(data.body) as Map;

      setState((){
        _datajson = jsondata;
      });

    }
    catch(err){

    }

  }
  void fetchData1() async{
    try {
      final url1 = "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${lid}&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
      final data1 = await get(Uri.parse(url1));
      final jsondata1 = jsonDecode(data1.body) as Map;

      setState((){
        _datajson1 = jsondata1;
        cont = SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 15,left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w900),),
                  Text(_datajson['message']['body']['track']['track_name'].toString(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w400),),

                  SizedBox(height: 25,),

                  Text('Artist',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w900),),
                  Text(_datajson['message']['body']['track']['artist_name'].toString(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w400),),

                  SizedBox(height: 25,),

                  Text('Album Name',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w900),),
                  Text(_datajson['message']['body']['track']['album_name'].toString(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w400),),

                  SizedBox(height: 25,),

                  Text('Explicit',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w900),),
                  Text(_datajson['message']['body']['track']['explicit']==1?"True":"False",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w400),),

                  SizedBox(height: 25,),

                  Text('Rating',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w900),),
                  Text(_datajson['message']['body']['track']['track_rating'].toString(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w400),),

                  SizedBox(height: 25,),

                  Text('Lyrics',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w900),),
                  Text(_datajson1['message']['body']['lyrics']['lyrics_body'].toString(),style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w400),),

                ],
              ),
            ),
          ),
        );
      });

    }
    catch(err){

    }

  }
  @override
  void initState(){
    super.initState();
    fetchData();
    fetchData1();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text('Track details',style: TextStyle(color: Colors.black),),
        ),
        body: cont

      ),
    );
  }
}

