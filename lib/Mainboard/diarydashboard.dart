import 'package:flutter/material.dart';
import 'package:my_time/auth/utils.dart';
import 'package:my_time/models/diary.dart';

class DiaryDashboardPage extends StatefulWidget {
  @override
  _DiaryDashboardPageState createState() => _DiaryDashboardPageState();
}

class _DiaryDashboardPageState extends State<DiaryDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllDiaryByUid(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
              // if we got our data
            } else if (snapshot.hasData) {
              print("SNAPSHOT");
              print(snapshot.data);
              var diaries = snapshot.data as List<Diary>;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MY',
                        style: TextStyle(
                            fontSize: 100,
                            color: Colors.white,
                            fontFamily: "Tropical"),
                      ),
                      Text(
                        'TIME',
                        style: TextStyle(
                            fontSize: 100,
                            color: Colors.lightGreen[300],
                            fontFamily: "Tropical"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Stack(children: [
                      ListView.builder(
                        itemCount: diaries.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                        title: Text(diaries[index].title),
                                        content: new SingleChildScrollView(
                                            child:
                                                Text(diaries[index].content))));
                              },
                              leading: Icon(Icons.book),
                              title: Text(diaries[index].title),
                              trailing: Icon(Icons.more_vert),
                            ),
                          );
                        },
                      ),
                    ]),
                  ),
                ],
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
