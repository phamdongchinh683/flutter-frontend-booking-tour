class Prices {
  final int adult;
  final int child;

  Prices({required this.adult, required this.child});

  factory Prices.fromJson(Map<String, dynamic> json) {
    return Prices(
      adult: int.parse(json['adult']),
      child: int.parse(json['child']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult.toString(),
      'child': child.toString(),
    };
  }
}
