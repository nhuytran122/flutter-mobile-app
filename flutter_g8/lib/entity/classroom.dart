class Classroom {
  late String semester;
  late String subject;
  late String id;
  late int totalStudent;
  late String bgUrl;
  Classroom(this.id, this.semester, this.subject, this.totalStudent,
      {this.bgUrl = ""});
}

String url1 =
    "https://plus.unsplash.com/premium_photo-1669748157617-a3a83cc8ea23?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
String url2 =
    "https://media.istockphoto.com/id/872884710/vi/anh/b%C3%ACnh-minh-t%E1%BA%A1i-b%C3%A3i-bi%E1%BB%83n-akumal-v%E1%BB%8Bnh-thi%C3%AAn-%C4%91%C6%B0%E1%BB%9Dng-t%E1%BA%A1i-riviera-maya-b%E1%BB%9D-bi%E1%BB%83n-caribbean-c%E1%BB%A7a-mexico.jpg?s=2048x2048&w=is&k=20&c=tylb32iQkzB_GXrZCKdOp_dF1X0qIXFP2Y8eYwZImCI=";

//Mock data
var listClassroom = [
  Classroom(
      "2024-2025.1.TIN4013.006", "2024-2025.1", "Java nâng cao - Nhóm 6", 40,
      bgUrl: url1),
  Classroom("2024-2025.1.TIN4013.005", "2024-2025.1",
      "Lập trình di động - Nhóm 6", 50,
      bgUrl: url2),
  Classroom("2024-2025.1.TIN4013.004", "2024-2025.1",
      "Lập trình ứng dụng Web - Nhóm 4", 40),
  Classroom("2024-2025.1.TIN4013.003", "2024-2025.1",
      "Đồ án công nghệ phần mềm - Nhóm 4", 40),
  Classroom("2024-2025.1.TIN4013.002", "2024-2025.1",
      "Thực tập viết niên luận - Nhóm 6", 40),
];
