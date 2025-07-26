class AnalyticsEvent {
  final String name;
  final Map<String, dynamic> parameters;
  final DateTime timestamp;

  AnalyticsEvent({
    required this.name,
    required this.parameters,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'parameters': parameters,
      'timestamp': timestamp.toIso8601String(),
    };
  }
} 