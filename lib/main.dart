import 'dart:convert';

import 'package:ev_studios_news_article/constant.dart';
import 'package:ev_studios_news_article/getArticleApi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<getArticleApi>? apiList;


  @override
  void initState() {
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Articles",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if(apiList!= null)
            getList()
          ],
        ),
      ),
    );
  }
  Widget getList() {

    return Expanded(
      child: ListView.builder(
          itemCount: apiList!.length,
          itemBuilder: (BuildContext context , int index){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Text("${apiList![index].id}",style: kTextStyle,),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("${apiList![index].name?.first}",style: kTextStyle,),
                    Text("${apiList![index].name?.middle}",style: kTextStyle,),
                    Text("${apiList![index].name?.last}",style: kTextStyle,),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("${apiList![index].gender}",style: kTextStyle,),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("${apiList![index].age}",style: kTextStyle,),
                  ],
                ),
                SizedBox(
                  height: 2.5,
                ),
                Text("${apiList![index].species}",style: kTextStyle,),
                SizedBox(
                  height: 2.5,
                ),
                Text("${apiList![index].homePlanet}",style: kTextStyle,),
                SizedBox(
                  height: 2.5,
                ),
                Text("${apiList![index].occupation}",style: kTextStyle,),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(12.0),
                  alignment: Alignment.center,
                  color: Colors.black38,
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                  ),
                  child: Text("${apiList![index].sayings}"
                      "images :-${apiList![index].images?.main}"
                      "${apiList![index].images?.headShot}",style:kTextStyle

                ),
                )
              ]
            ),
            SizedBox(
              height: 10.0,
            ),

              ],
        );
      }),
    );
  }
Future<void> getApiData()async{
    String url = "https://api.sampleapis.com/futurama/characters";

    var result = await http.get(Uri.parse(url));
   apiList = jsonDecode(result.body)
    .map((item)=> getArticleApi.fromJson(item)).toList()
    .cast<getArticleApi>();
   setState(() {

   });
}
}



