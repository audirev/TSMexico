class Section {
  final String id;
  final String name;
  final String zoneId;

  const Section({
    required this.id,
    required this.name,
    required this.zoneId
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      name: json['name'],
      zoneId: json['zoneId']
    );
  }
}