class SqfliteModel {
  final String? name;
  final String? posterPath;
  final double? voteAverage;
  final String? date;
  final String? backgroundPath;
  final int? id;
  final String? type;

  SqfliteModel({
    this.name,
    this.posterPath,
    this.voteAverage,
    this.date,
    this.backgroundPath,
    this.id,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'date': date,
      'backgroundPath': backgroundPath,
      'id': id,
      'type': type,
    };
  }
}
