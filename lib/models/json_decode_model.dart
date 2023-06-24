class ChapterJsonDecodeModel {
  String data;
  List decodedList;
  List allChapter;

  ChapterJsonDecodeModel({
    required this.data,
    required this.decodedList,
    required this.allChapter,
  });
}

class ShlokJsonDecodeModel {
  String data;
  List decodedList;
  List allShloks;

  ShlokJsonDecodeModel({
    required this.data,
    required this.decodedList,
    required this.allShloks,
  });
}

int chapterIndex = 0;
int shlokIndex = 0;
