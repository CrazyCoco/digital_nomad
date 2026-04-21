import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../comm/realm_service.dart';
import '../../model/conversation.dart';
import '../../model/chat_room.dart';
import '../../routes/app_routes.dart';

class ChatLogic extends GetxController {
  final RealmService _realmService = RealmService();
  
  int selectedTab = 0; // 0: Private Chats, 1: Room Chats
  final List<String> tabs = ['Chats', 'Rooms'];
  
  // 私聊列表（从数据库加载）
  List<Conversation> privateChats = [];
  
  // 房间聊天列表（从数据库加载）
  List<ChatRoom> chatRooms = [];
  
  @override
  void onInit() {
    super.onInit();
    loadPrivateChats();
    loadChatRooms();
  }
  
  /// 从数据库加载私聊列表
  void loadPrivateChats() {
    final box = GetStorage();
    final currentUserId = box.read('user_id') as String?;
    
    if (currentUserId != null) {
      privateChats = _realmService.getPrivateConversations(currentUserId);
      update();
    }
  }
  
  /// 从数据库加载聊天室列表
  void loadChatRooms() {
    chatRooms = _realmService.getAllChatRooms();
    print('Loaded ${chatRooms.length} chat rooms');
    for (var room in chatRooms) {
      print('Room: ${room.name}, Members: ${room.membersCount}, Hot: ${room.isHot}');
    }
    update();
  }
  
  @override
  void onReady() { 
    super.onReady(); 
  }
  
  @override
  void onClose() { 
    super.onClose(); 
  }
  
  void selectTab(int index) { 
    selectedTab = index;
    update();
  }
  
  void openPrivateChat(int index) {
    if (index < 0 || index >= privateChats.length) return;
    
    final chat = privateChats[index];
    NavigationUtil.toPrivateChat(
      userName: chat.userName,
      userAvatar: chat.userAvatar ?? '',
    );
  }
  
  void joinRoomChat(int index) {
    if (index < 0 || index >= chatRooms.length) return;
    
    final room = chatRooms[index];
    NavigationUtil.toRoomChat(roomName: room.name);
  }
}
