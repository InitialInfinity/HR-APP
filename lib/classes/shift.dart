class Shift {
  String id = "";
  String userId = "";
  String companyId = "";
  String shiftName = "";
  String startTime = "";
  String endTime = "";
  String graceTime = "";
  String halfDayTime = "";
  String fullDayTime = "1";
  String weekOffFirst = "";
  String weekOffSecond = "";

  Shift({
    this.id = "",
    this.userId = "",
    this.companyId = "",
    this.shiftName = "",
    this.startTime = "",
    this.endTime = "",
    this.graceTime = "",
    this.halfDayTime = "",
    this.fullDayTime = "",
    this.weekOffFirst = "",
    this.weekOffSecond = "",
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      userId: json['userId'],
      id: json['Id'],
      companyId: json['companyId'],
      shiftName: json['shiftName'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      graceTime: json['graceTime'],
      halfDayTime: json['halfDayTime'],
      fullDayTime: json['fullDayTime'],
      weekOffFirst: json['weekOff_First'],
      weekOffSecond: json['weekOff_Second'],
    );
  }
}
