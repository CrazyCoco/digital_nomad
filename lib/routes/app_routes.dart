import 'package:digital_nomad/page/add_friend_dialog/add_friend_dialog.dart';
import 'package:digital_nomad/page/blacklist/blacklist_view.dart';
import 'package:digital_nomad/page/create_account/create_account_view.dart';
import 'package:digital_nomad/page/edit_profile/edit_profile_view.dart';
import 'package:digital_nomad/page/follow_list/follow_list_view.dart';
import 'package:digital_nomad/page/friend_request/friend_request_view.dart';
import 'package:digital_nomad/page/like_ranking/like_ranking_view.dart';
import 'package:digital_nomad/page/login_index/login_index_view.dart';
import 'package:digital_nomad/page/main_tab/main_tab_view.dart';
import 'package:digital_nomad/page/onboarding/onboarding_view.dart';
import 'package:digital_nomad/page/post_detail/post_detail_view.dart';
import 'package:digital_nomad/page/privacy_policy/privacy_policy_view.dart';
import 'package:digital_nomad/page/private_chat/private_chat_view.dart';
import 'package:digital_nomad/page/recharge/recharge_view.dart';
import 'package:digital_nomad/page/report/report_view.dart';
import 'package:digital_nomad/page/room_chat/room_chat_view.dart';
import 'package:digital_nomad/page/settings/settings_view.dart';
import 'package:digital_nomad/page/sign_in/sign_in_view.dart';
import 'package:digital_nomad/page/terms_of_service/terms_of_service_view.dart';
import 'package:digital_nomad/page/topic/topic_view.dart';
import 'package:digital_nomad/page/topic_detail/topic_detail_view.dart';
import 'package:digital_nomad/page/user_page/user_page_view.dart';
import 'package:digital_nomad/page/video_call/video_call_view.dart';
import 'package:get/get.dart';

/// 应用路由名称常量
class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String loginIndex = '/login_index';
  static const String signIn = '/sign_in';
  static const String createAccount = '/create_account';
  static const String mainTab = '/main_tab';
  static const String userPage = '/user_page';
  static const String editProfile = '/edit_profile';
  static const String followList = '/follow_list';
  static const String friendRequest = '/friend_request';
  static const String blacklist = '/blacklist';
  static const String report = '/report';
  static const String postDetail = '/post_detail';
  static const String topic = '/topic';
  static const String topicDetail = '/topic_detail';
  static const String likeRanking = '/like_ranking';
  static const String recharge = '/recharge';
  static const String settings = '/settings';
  static const String roomChat = '/room_chat';
  static const String privateChat = '/private_chat';
  static const String videoCall = '/video_call';
  static const String privacyPolicy = '/privacy_policy';
  static const String termsOfService = '/terms_of_service';
}

/// 路由页面配置
class AppPages {
  static final List<GetPage> routes = [
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingPage()),
    GetPage(name: AppRoutes.loginIndex, page: () => const LoginIndexPage()),
    GetPage(name: AppRoutes.signIn, page: () => const SignInPage()),
    GetPage(
      name: AppRoutes.createAccount,
      page: () => const CreateAccountPage(),
    ),
    GetPage(name: AppRoutes.mainTab, page: () => const MainTabPage()),
    GetPage(name: AppRoutes.userPage, page: () => const UserPagePage()),
    GetPage(name: AppRoutes.editProfile, page: () => const EditProfilePage()),
    GetPage(name: AppRoutes.followList, page: () => const FollowListPage()),
    GetPage(
      name: AppRoutes.friendRequest,
      page: () => const FriendRequestPage(),
    ),
    GetPage(name: AppRoutes.blacklist, page: () => const BlacklistPage()),
    GetPage(name: AppRoutes.report, page: () => const ReportPage()),
    GetPage(name: AppRoutes.postDetail, page: () => const PostDetailPage()),
    GetPage(name: AppRoutes.topic, page: () => const TopicPage()),
    GetPage(name: AppRoutes.topicDetail, page: () => const TopicDetailPage()),
    GetPage(name: AppRoutes.likeRanking, page: () => const LikeRankingPage()),
    GetPage(name: AppRoutes.recharge, page: () => const RechargePage()),
    GetPage(name: AppRoutes.settings, page: () => const SettingsPage()),
    GetPage(name: AppRoutes.roomChat, page: () => const RoomChatPage()),
    GetPage(name: AppRoutes.privateChat, page: () => const PrivateChatPage()),
    GetPage(name: AppRoutes.videoCall, page: () => const VideoCallPage()),
    GetPage(name: AppRoutes.privacyPolicy, page: () => const PrivacyPolicyPage()),
    GetPage(name: AppRoutes.termsOfService, page: () => const TermsOfServicePage()),
  ];
}

/// 路由工具类
class NavigationUtil {
  /// 跳转到引导页
  static void toOnboarding() {
    Get.offAllNamed(AppRoutes.onboarding);
  }

  /// 跳转到登录入口页
  static void toLoginIndex() {
    Get.offAllNamed(AppRoutes.loginIndex);
  }

  /// 跳转到登录页
  static void toSignIn() {
    Get.toNamed(AppRoutes.signIn);
  }

  /// 跳转到注册页
  static void toCreateAccount() {
    Get.toNamed(AppRoutes.createAccount);
  }

  /// 跳转到主页（替换所有页面）
  static void toMainTab() {
    Get.offAllNamed(AppRoutes.mainTab);
  }

  /// 跳转到用户主页
  static void toUserPage({String? userName}) {
    Get.toNamed(AppRoutes.userPage, arguments: {'userName': userName});
  }

  /// 跳转到编辑资料
  static void toEditProfile() {
    Get.toNamed(AppRoutes.editProfile);
  }

  /// 跳转到关注/粉丝/朋友列表
  static void toFollowList({int initialTab = 0}) {
    Get.toNamed(AppRoutes.followList, arguments: {'initialTab': initialTab});
  }

  /// 跳转到好友申请
  static void toFriendRequest() {
    Get.toNamed(AppRoutes.friendRequest);
  }

  /// 跳转到黑名单
  static void toBlacklist() {
    Get.toNamed(AppRoutes.blacklist);
  }

  /// 跳转到举报页面
  static void toReport() {
    Get.toNamed(AppRoutes.report);
  }

  /// 跳转到动态详情
  static void toPostDetail({Map<String, dynamic>? postData}) {
    Get.toNamed(AppRoutes.postDetail, arguments: postData);
  }

  /// 跳转到话题列表
  static void toTopic() {
    Get.toNamed(AppRoutes.topic);
  }

  /// 跳转到话题详情
  static void toTopicDetail({String? topicTitle}) {
    Get.toNamed(AppRoutes.topicDetail, arguments: {'topicTitle': topicTitle});
  }

  /// 跳转到点赞排行
  static void toLikeRanking() {
    Get.toNamed(AppRoutes.likeRanking);
  }

  /// 跳转到充值页面
  static void toRecharge() {
    Get.toNamed(AppRoutes.recharge);
  }

  /// 跳转到设置页面
  static void toSettings() {
    Get.toNamed(AppRoutes.settings);
  }

  /// 跳转到房间聊天
  static void toRoomChat({String? roomName}) {
    Get.toNamed(AppRoutes.roomChat, arguments: {'roomName': roomName});
  }

  /// 跳转到私聊
  static void toPrivateChat({required String userName, String userAvatar = ''}) {
    Get.toNamed(
      AppRoutes.privateChat,
      arguments: {'userName': userName, 'userAvatar': userAvatar},
    );
  }

  /// 跳转到视频通话
  static void toVideoCall({String? userName}) {
    Get.toNamed(AppRoutes.videoCall, arguments: {'userName': userName});
  }

  /// 跳转到隐私政策
  static void toPrivacyPolicy() {
    Get.toNamed(AppRoutes.privacyPolicy);
  }

  /// 跳转到用户协议
  static void toTermsOfService() {
    Get.toNamed(AppRoutes.termsOfService);
  }

  /// 显示加好友弹窗
  static void showAddFriendDialog({
    required String userName,
    String userAvatar = '',
  }) {
    AddFriendDialog.show(userName: userName, userAvatar: userAvatar);
  }

  /// 返回上一页
  static void back() {
    Get.back();
  }

  /// 返回到根页面
  static void backToRoot() {
    Get.offAllNamed(AppRoutes.mainTab);
  }
}
