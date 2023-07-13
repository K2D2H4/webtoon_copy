import 'package:flutter/material.dart';
import 'package:webtoon_copy/service/api_service.dart';

import '../models/detail_model.dart';
import '../models/episode_model.dart';

class WebtoonDetail extends StatefulWidget {
  const WebtoonDetail({super.key, required this.id, required this.thumb});

  final String id, thumb;

  @override
  State<WebtoonDetail> createState() => _WebtoonDetailState();
}

class _WebtoonDetailState extends State<WebtoonDetail> {
  late Future<DetailModel> detail;
  late Future<EpisodeModel> episode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detail = ApiService.getDetail(widget.id);
    episode = ApiService.getEpisode(widget.id);
  }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: widget.id,
              child: Container(
                //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                child: Image.network(widget.thumb),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: detail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!.about),
                      SizedBox(
                        height: 20,
                      ),
                      Text("${snapshot.data!.age}/${snapshot.data!.genre}",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  );
                } else {
                  return Text("데이터 없음");
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            FutureBuilder(
              future: episode,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  );
                } else {
                  return Text("데이터 없음");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
