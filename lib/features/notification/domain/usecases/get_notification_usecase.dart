import 'package:paddle_jakarta/features/notification/data/models/notification_response.dart';
import 'package:paddle_jakarta/features/notification/domain/repository/notification_repository.dart';

class GetNotificationUsecase {
  final NotificationRepository repository;

  GetNotificationUsecase(this.repository);
  
  Future<List<NotificationResponse>> call() async {
    // Fetch notifications from the repository (could be from a database, API, etc.)
    return await repository.getNotifications();
  }
}