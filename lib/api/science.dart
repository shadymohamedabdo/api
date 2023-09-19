import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
class science extends StatefulWidget {
  const science({super.key});

  @override
  State<science> createState() => _apiState();
}
class _apiState extends State<science> {
  var listed =[];
  var url = 'https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=091bc366596e48a19451af917ed6d3a1';
  getData() async {
    var response = await http.get(Uri.parse(url));
    var responsebody = await jsonDecode(response.body);
    setState(() {
      listed = responsebody['articles'];
    });
  }
  @override
  void initState() {
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return
      ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          var launchurl = Uri.parse(listed[index]['url']);
          return GestureDetector(
            onTap: () async {
              if (await canLaunchUrl(launchurl)){
                await launchUrl(launchurl);
              }else{
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Failed'),
                      content: const Text('error 404'),
                    ));
              }
            },
            child:
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:
              Row(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image(image: NetworkImage(
                      '${listed[index]['urlToImage']}',
                    ),
                        fit: BoxFit.fill,
                        errorBuilder:
                            (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image(image: AssetImage('image/failed.jpg'),);}
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              '${listed[index]['title']}',
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Expanded(
                            child: Text(
                              // maxLines: 4,
                              // overflow: TextOverflow.ellipsis,
                              '${listed[index]['description']}',
                              style: TextStyle(
                                color: Colors.grey,
                              ),

                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index)=>Divider(
          thickness : 3,
          endIndent: 20,
          indent: 20,
        ),
        itemCount: listed.length,
      );

  }
}
