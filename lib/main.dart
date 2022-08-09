import 'dart:convert';
import 'components/titles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

Future<void> main() async{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homePage(),
    );
  }
}


class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
StreamSubscription? connection;
bool isoffline=false;
  final url = "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
  final url1 = "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";

  var _datajson = {};
  Widget cont=   Center(
    child: CircularProgressIndicator(color: Colors.blueAccent,),
  );

  void fetchData() async{
    try {
      final data = await get(Uri.parse(url));
      final jsondata = jsonDecode(data.body) as Map;

    setState((){
      _datajson = jsondata;
    cont = SingleChildScrollView(
      child: Container(
        child: Column(
          children: getTitles(_datajson, context),
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
    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result){
      if(result==ConnectivityResult.none){
        setState((){
          isoffline = true;
        });
      }
      else{
        setState((){
          isoffline = false;
        });
      }
    });
    super.initState();
    fetchData();
  }

  @override
  void dispose(){
    connection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // List<Widget> lyrics = getTitles(_datajson, context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Trending',style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: !isoffline?cont:Center(
          child: Text('No Internet connection',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w300),),
        )
    );
  }
}
