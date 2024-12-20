class BookTour {
  final String guideId;
  final int numberOfVisitors;
  final String startTour;
  final String startTime;
  final String endTime;
  final int status;
  final String cardNumber;
  final double totalAmount;

  BookTour({
    required this.guideId,
    required this.numberOfVisitors,
    required this.startTour,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.cardNumber,
    required this.totalAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      'guideId': guideId,
      'numberVisitor': numberOfVisitors,
      'startTour': startTour,
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
      'cardNumber': cardNumber,
      'totalAmount': totalAmount,
    };
  }

  factory BookTour.fromJson(Map<String, dynamic> json) {
    return BookTour(
      guideId: json['guideId'],
      numberOfVisitors: json['numberVisitor'],
      startTour: json['startTour'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      status: json['status'],
      cardNumber: json['cardNumber'],
      totalAmount: json['totalAmount'].toDouble(),
    );
  }
}
