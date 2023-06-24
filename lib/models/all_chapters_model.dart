class AllChapterModel {
  int chapterNo;
  int versesCount;
  int id;
  String chapterSummaryEnglish;
  String chapterSummaryHindi;
  String imageName;
  String nameHindi;
  String nameMeaning;
  String nameTranslationEnglish;
  String jsonPath;

  AllChapterModel({
    required this.chapterNo,
    required this.versesCount,
    required this.id,
    required this.chapterSummaryEnglish,
    required this.chapterSummaryHindi,
    required this.imageName,
    required this.nameHindi,
    required this.nameMeaning,
    required this.nameTranslationEnglish,
    required this.jsonPath,
  });

  factory AllChapterModel.fromMap({required Map data}) {
    return AllChapterModel(
      chapterNo: data['chapter_number'],
      versesCount: data['verses_count'],
      id: data['id'],
      chapterSummaryEnglish: data['chapter_summary'],
      chapterSummaryHindi: data['chapter_summary_hindi'],
      imageName: data['image_name'],
      nameHindi: data['name'],
      nameMeaning: data['name_meaning'],
      nameTranslationEnglish: data['name_translation'],
      jsonPath: data['json_path'],
    );
  }
}

