import 'package:get/get.dart';
import '../../../data/models/notification_model.dart';

class NotificationsController extends GetxController {
  final RxList<NotificationModel> notifications = <NotificationModel>[
    NotificationModel(id: '1', name: 'Vanessa Franklin', bloodType: 'A+', location: 'LAMINGO, PLATEAU STATE'),
  ].obs;
}