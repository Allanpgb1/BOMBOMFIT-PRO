class WaterEntry {
  final String id;
  final DateTime consumedAt;
  final int amountMl;

  const WaterEntry({
    required this.id,
    required this.consumedAt,
    required this.amountMl,
  });

  factory WaterEntry.fromMap(Map<String, dynamic> map) => WaterEntry(
        id: map['id'] as String,
        consumedAt: DateTime.parse(map['consumed_at'] as String),
        amountMl: (map['amount_ml'] as num).toInt(),
      );
}
