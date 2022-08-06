class Offers {
  Offers({
    this.count,
    this.next,
    this.previous,
    this.offers,
  });

  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Offer>? offers;

  Offers copyWith({
    int? count,
    dynamic next,
    dynamic previous,
    List<Offer>? offers,
  }) =>
      Offers(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        offers: offers ?? this.offers,
      );

  factory Offers.fromJson(Map<String, dynamic> json) => Offers(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        offers: json["results"] == null
            ? null
            : List<Offer>.from(json["results"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": offers == null
            ? null
            : List<dynamic>.from(offers!.map((x) => x.toJson())),
      };
}

class Offer {
  Offer({
    this.id,
    this.title,
    this.company,
    this.city,
    this.image,
    this.contractType,
    this.description,
    this.features,
    this.timePublished,
  });

  final int? id;
  final String? title;
  final String? company;
  final String? city;
  final String? image;
  final String? contractType;
  final String? description;
  final String? features;
  final String? timePublished;

  Offer copyWith({
    int? id,
    String? title,
    String? company,
    String? city,
    String? image,
    String? contractType,
    String? description,
    String? features,
    String? timePublished,
  }) =>
      Offer(
        id: id ?? this.id,
        title: title ?? this.title,
        company: company ?? this.company,
        city: city ?? this.city,
        image: image ?? this.image,
        contractType: contractType ?? this.contractType,
        description: description ?? this.description,
        features: features ?? this.features,
        timePublished: timePublished ?? this.timePublished,
      );

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        title: json["title"],
        company: json["company"],
        city: json["city"],
        image: json["image"],
        contractType: json["contract_type"],
        description: json["description"],
        features: json["features"],
        timePublished: json["time_published"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "company": company,
        "city": city,
        "image": image,
        "contract_type": contractType,
        "description": description,
        "features": features,
        "time_published": timePublished,
      };
}
