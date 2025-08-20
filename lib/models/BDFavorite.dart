class Favorite {
  String name;
  DateTime date;

  Favorite(this.name, this.date);

  factory Favorite.fromJson(dynamic json) {
    return Favorite(
        json['name'] as String,
        DateTime(
            json['date']['year'] as int,
            json['date']['month'] as int,
            json['date']['day'] as int,
            json['date']['hour'] as int,
            json['date']['minute'] as int
        )
    );
  }


  void addToFavorite(dynamic json) {
    print("Favori ajouté");
  }

  @override
  String toString() {
    return '{ '
        '"name": ${this.name}, '
        '"date": {'
        ' "year": ${this.date.year}, '
        ' "month": ${this.date.month}, '
        ' "day": ${this.date.day}, '
        ' "hour": ${this.date.hour}, '
        ' "minute": ${this.date.minute}, '
    '}';
  }
}