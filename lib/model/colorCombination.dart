class ColorCombination {
  final String songId;
  final List<SectionsColor> sectionsColor;

  const ColorCombination({
    required this.songId,
    required this.sectionsColor
  });

  factory ColorCombination.fromJson(Map<String, dynamic> jsons) {
    var sectionsListJson = jsons['sections'];
    List<Map<String, dynamic>> sections = new List<Map<String, dynamic>>.from(sectionsListJson);
    Iterable dataList = sections.map((e) => e);
    var sectionsList = dataList.map((i) => SectionsColor.fromJson(i)).toList(); 

    return ColorCombination(
      songId: jsons['songId'],
      sectionsColor: sectionsList,
    );
  }
}

class SectionsColor {
  final String sectionId;
  final String colorCode;

  const SectionsColor({
    required this.sectionId,
    required this.colorCode
  });

  factory SectionsColor.fromJson(Map<String, dynamic> json) {
    return SectionsColor(
      sectionId: json['sectionId'],
      colorCode: json['colorCode'],
    );
  }
}