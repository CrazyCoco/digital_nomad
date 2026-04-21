import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comm/realm_service.dart';

class FriendRequestLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  // Friend requests from Realm
  List<Map<String, dynamic>> requests = [];

  @override
  void onInit() {
    super.onInit();
    loadFriendRequests();
  }

  /// Load friend requests from Realm
  void loadFriendRequests() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    if (currentUserId == null) {
      return;
    }
    
    final receivedRequests = _realmService.getReceivedFriendRequests(currentUserId);
    requests = receivedRequests.map((req) => {
      'id': req.id,
      'requesterId': req.requesterId,
      'name': req.requesterName,
      'avatar': req.requesterAvatar ?? 'images/head_1.jpg',
      'message': req.message ?? 'Hi, let\'s be friends!',
      'time': _formatTime(req.createdAt),
      'isRead': req.isRead,
    }).toList();
    
    update();
  }
  
  /// Format DateTime to readable string
  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} mins ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${dateTime.month}/${dateTime.day}';
    }
  }
  
  void acceptRequest(int index) {
    if (index >= 0 && index < requests.length) {
      final request = requests[index];
      final requestId = request['id'] as String;
      final requesterName = request['name'] as String;
      
      // Accept the request (creates mutual follow)
      _realmService.acceptFriendRequest(requestId);
      
      // Remove from list
      requests.removeAt(index);
      update();
      
      Get.snackbar(
        'Success',
        'Now following $requesterName',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }
  
  void declineRequest(int index) {
    if (index >= 0 && index < requests.length) {
      final request = requests[index];
      final requestId = request['id'] as String;
      final requesterName = request['name'] as String;
      
      // Decline the request
      _realmService.declineFriendRequest(requestId);
      
      // Remove from list
      requests.removeAt(index);
      update();
      
      Get.snackbar(
        'Declined',
        'Friend request from $requesterName declined',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }
  
  void onBack() {
    Get.back();
  }
}
