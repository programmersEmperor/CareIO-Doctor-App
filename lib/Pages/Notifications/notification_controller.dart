import 'package:careio_doctor_version/Models/Notification.dart' as model;
import 'package:careio_doctor_version/Services/Api/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationController extends GetxController {
  // List<noti.Notification> notifications = [
  //   noti.Notification(
  //       id: 1, title: 'Hello', body: "Hello", createdAt: "now", isRead: false),
  //   noti.Notification(
  //       id: 2, title: 'Hi', body: "Hi", createdAt: "2 min ago", isRead: true)
  // ];
  final _pageSize = 10;
  final PagingController<int, model.Notification> pagingController = PagingController(firstPageKey: 1);
  final NotificationApiService _apiService = Get.find<NotificationApiService>();

  RxBool get isLoading => _apiService.isLoading;

  void fetchNotifications({required int pageKey}) async {
    try{
      final List<model.Notification> notifications =[];
      isLoading(true);
      var response = await _apiService.fetchNotifications(params: {'page': pageKey });
      isLoading(false);
      if (response == null) return;
      debugPrint("notifications: ${response.data['result']['data']}");
      for (var notification in response.data['result']['data']) {
        notifications.add(model.Notification.fromJson(notification));
      }

      if(response.data['result']['meta']['last_page'] <= pageKey){
        pagingController.appendLastPage(notifications);
      }
      else{
        pagingController.appendPage(notifications, pageKey+1);
      }
    }catch(e){
      isLoading(false);
      debugPrint("Error in notifications is $e");
      pagingController.error = e;
    }
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchNotifications(pageKey: pageKey);
    });
    // fetchNotifications(pageKey: 1);
    pagingController.refresh();
    super.onInit();
  }
}
