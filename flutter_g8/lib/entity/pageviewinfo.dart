class PageViewInfo {
  late String avtUrl;
  late String title;
  late String content;
  PageViewInfo({this.avtUrl = "", required this.title, required this.content});
}

//MOCK DATA
var listPageViewMeeting = [
  PageViewInfo(
      title: "Nhận đường liên kết bạn có thể chia sẻ",
      content:
          "Nhấn vào Cuộc họp mời để nhận một đường liên kết mà bạn có thể gửi cho những người mình muốn họp cùng",
      avtUrl: 'assets/images/user_edu_get_a_link_light.png'),
  PageViewInfo(
    title: "Cuộc họp luôn an toàn",
    content:
        "Không ai bên ngoài tổ chức của bạn có thể tham gia cuộc họp trừ phi người tổ chức mời hoặc cho phép",
    avtUrl: 'assets/images/user_edu_safety_light.png',
  ),
];
