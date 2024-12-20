class Paginate<T> {
  final String? nextCursor;
  final String? prevCursor;
  final int? totalResults;
  final List<T> datas;

  Paginate({
    required this.nextCursor,
    required this.prevCursor,
    required this.totalResults,
    required this.datas,
  });

  factory Paginate.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return Paginate<T>(
      nextCursor: json['nextCursor'] as String?,
      prevCursor: json['prevCursor'] as String?,
      totalResults: json['totalResults'] as int,
      datas: (json['tours'] ?? [])
          .map<T>((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'nextCursor': nextCursor,
      'prevCursor': prevCursor,
      'totalResults': totalResults,
      'datas': datas.map((item) => toJsonT(item)).toList(),
    };
  }
}
