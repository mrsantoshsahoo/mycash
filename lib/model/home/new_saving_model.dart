class SavingOdel {
  SavingOdel({
    this.savingTitle,
    this.savingSubTitle,
    this.price,
  });

  String? savingTitle;
  String? savingSubTitle;
  int? price;

  factory SavingOdel.fromJson(Map<String, dynamic> json) => SavingOdel(
        savingTitle: json["saving_title"],
        savingSubTitle: json["saving_sub_title"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "saving_title": savingTitle,
        "saving_sub_title": savingSubTitle,
        "price": price,
      };
}
