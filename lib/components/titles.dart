import 'package:flutter/material.dart';
import '../lyric.dart';

List<Widget> getTitles(var _datajson,BuildContext context){
  List lyr = _datajson['message']['body']['track_list'];
  var l = lyr.length;
  List<Widget> lyrics = [];
  for(int i=0;i<l;i++){
    lyrics.add(
        MaterialButton(
          onPressed: (){
            int id = lyr[i]['track']['track_id'];
            Navigator.push(context, MaterialPageRoute(builder: (context)=>lyric(id: id)));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2,
                    color: Colors.grey.shade300
                ),
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            height: MediaQuery.of(context).size.height*.15,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            child: Icon(Icons.library_music_outlined)
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width*.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(lyr[i]['track']['track_name']),
                              Text(lyr[i]['track']['album_name'],style: TextStyle(color: Colors.grey.shade500),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width*.3,
                  child: Text(lyr[i]['track']['artist_name']),
                )
              ],
            ),
          ),
        )
    );
  }
  return lyrics;
}