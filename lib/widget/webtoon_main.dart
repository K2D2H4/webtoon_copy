import 'package:flutter/material.dart';
import 'package:webtoon_copy/models/webToon_model.dart';
import 'package:webtoon_copy/service/api_service.dart';
import 'package:webtoon_copy/widget/webtoon_detail.dart';

class WebtoonMain extends StatelessWidget {
  WebtoonMain({super.key});

  final Future<List<WebToonModel>> webtoons = ApiService.getToon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 5,
          title: Text(
            "Today's webtoon",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: FutureBuilder(
          future: webtoons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: WebToonList(snapshot),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  ListView WebToonList(AsyncSnapshot<List<WebToonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        print(index);
        var webtoon = snapshot.data![index];
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WebtoonDetail(
                        id: webtoon.id,
                        thumb: webtoon.thumb,
                      );
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Hero(
                tag: webtoon.id,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(10, 10),
                      )
                    ],
                  ),
                  width: 350,
                  child: Image.network(webtoon.thumb),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline_rounded),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  webtoon.title,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          width: 50,
        );
      },
    );
  }
}
