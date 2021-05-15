import 'package:flutter/material.dart';
import 'package:my_time/auth/utils.dart';
import 'package:my_time/models/diary.dart';

class ShowAllPicturepage extends StatefulWidget {
  @override
  _ShowAllPicturepageState createState() => _ShowAllPicturepageState();
}

class _ShowAllPicturepageState extends State<ShowAllPicturepage> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

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
            List<String> imageLists = [];

            diaries.forEach((element) {
              if (element.picturePath != "") {
                imageLists.add(element.picturePath);
              }
            });

            return Center(
              child: GridView.builder(
                  itemCount: imageLists.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  padding: EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    print(imageLists[index]);
                    return InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                // title: new Text("My Super title"),
                                content: Image.network(imageLists[index])));
                      },
                      child: (Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(imageLists[index]))),
                      )),
                    ); //just for testing, will fill with image later
                  }),
            );
            // ListView.builder(
            //   itemCount: diaries.length,
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) {
            //     if (diaries[index].picturePath != "") {
            //       return Card(
            //           child: Container(
            //         width: MediaQuery.of(context).size.width * 0.25,
            //         height: MediaQuery.of(context).size.height * 0.25,
            //         decoration: BoxDecoration(
            //             image: DecorationImage(
            //                 image: NetworkImage(
            //                     diaries[index].picturePath))),
            //       ));
            //     } else {
            //       return Container();
            //     }
            //   },
            // ),
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
