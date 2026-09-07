class NotificationService {
  Future<void> scheduleWaterReminder({
    required int intervalHours,
  }) async {
    // Ponto de integração para flutter_local_notifications.
    // Mantido como abstração para não acoplar a fundação a um plugin nativo.
  }
}
