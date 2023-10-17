// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';

// import 'package:url_launcher/url_launcher.dart';

// class NewsWidget extends StatefulWidget {
//   @override
//   _NewsWidgetState createState() => _NewsWidgetState();
// }

// class _NewsWidgetState extends State<NewsWidget> {
//   Future<List> getData() async {
//     final response = await http
//         .get('https://www.berca.co.id/wp-json/wp/v2/posts?categories=44');
//     return json.decode(response.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List>(
//         future: getData(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) print(snapshot.error);
//           return snapshot.hasData
//               ? ItemList(list: snapshot.data)
//               : Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }

// class ItemList extends StatelessWidget {
//   final List list;
//   ItemList({this.list});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300,
//       child: ListView.builder(
//         itemCount: list.length,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return Container(
//             width: 270,
//             margin: EdgeInsets.symmetric(horizontal: 4),
//             child: InkWell(
//               splashColor: Colors.grey,
//               onTap: () {
//                 _openLink(list[index]['link']);
//               },
//               child: Card(
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 270,
//                       height: 140,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               list[index]['featured_media_src_url']),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(list[index]['title']['rendered']),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// void _openLink(String url) async {
//   if (await canLaunch(url)) await launch(url);
// }
