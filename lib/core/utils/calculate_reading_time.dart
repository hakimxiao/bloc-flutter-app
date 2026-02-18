int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;

  // time icrease for read this blog (speed = word/dataBacaGlobal)

  final readingTime = wordCount / 225;

  return readingTime.ceil();
}
