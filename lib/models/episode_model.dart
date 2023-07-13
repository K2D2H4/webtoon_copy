class EpisodeModel {
  final String thumb, id, title, rating, date;

  EpisodeModel.fromJson(Map<String, dynamic> json)
      : thumb = json['thumb'],
        id = json['id'],
        title = json['title'],
        rating = json['rating'],
        date = json['date'];
}
