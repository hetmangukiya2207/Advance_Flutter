class ChapterModel {
  String verse;
  String sanskrit;
  String english;
  String gujarati;
  String hindi;
  String? translation;

  ChapterModel({
    required this.verse,
    required this.sanskrit,
    required this.english,
    required this.gujarati,
    required this.hindi,
    this.translation,
  });

  factory ChapterModel.fromMap({required Map data}) {
    return ChapterModel(
      verse: data['verse'],
      sanskrit: data['san'],
      english: data['en'],
      gujarati: data['guj'],
      hindi: data['hi'],
    );
  }
}