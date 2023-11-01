class Salary {
  String userId = "";
  String id = "";
  String companyId = "";
  String staffId = "";
  String basicSalary = "";
  String tax = "";
  String bonus = "";
  String otherAllowance = "1";
  String presentdays = "1";
  String month = "1";
  String year = "1";
  int pfAmount = 0;
  int esicAmount = 0;
  int overtime = 0;
  String overtimePerHour = "0";

  Salary({
    this.userId = "",
    this.id = "",
    this.companyId = "",
    this.staffId = "",
    this.basicSalary = "",
    this.tax = "",
    this.bonus = "",
    this.otherAllowance = "",
    this.presentdays = "",
    this.month = "",
    this.year = "",
    this.pfAmount = 0,
    this.esicAmount = 0,
    this.overtime = 0,
    this.overtimePerHour = "0",
  });

  factory Salary.fromJson(Map<String, dynamic> json) {
    return Salary(
      userId: json['userId'],
      id: json['Id'],
      companyId: json['CompanyId'],
      staffId: json['StaffId'],
      basicSalary: json['basic_Salary'],
      tax: json['tax'],
      bonus: json['bonus'],
      otherAllowance: json['otherAllowance'],
      presentdays: json['PresentDays'],
      month: json['month'],
      pfAmount: json['PF_Amt'],
      esicAmount: json['ESIC_AMT'],
      overtime: json['Overtime'],
      overtimePerHour: json['Overtime_Per_hrs'],
    );
  }
}
