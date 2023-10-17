final String tableCreateWorkOrder = 'createWorkOrder';

class WorkOrderFields {
  static final List<String> values = [
    columnId,
    customerNumber,
    contactName,
    prefix,
    phone,
    equipNumber,
    invItemNumber,
    failureDesc,
    reqFinishDate,
    reqFinishTime,
    notes,
    woNumber
  ];

  static final String columnId = 'id';
  static final String customerNumber = 'customerNumber';
  static final String contactName = 'contactName';
  static final String prefix = 'prefix';
  static final String phone = 'phone';
  static final String equipNumber = 'equipNumber';
  static final String invItemNumber = 'invItemNumber';
  static final String failureDesc = 'failureDesc';
  static final String reqFinishDate = 'reqFinishDate';
  static final String reqFinishTime = 'reqFinishTime';
  static final String notes = 'notes';
  static final String woNumber = 'woNumber';
}

class WorkOrder {
  final int columnId;
  final String customerNumber;
  final String contactName;
  final String prefix;
  final String phone;
  final String equipNumber;
  final String invItemNumber;
  final String failureDesc;
  final String reqFinishDate;
  final String reqFinishTime;
  final String notes;
  final String woNumber;

  WorkOrder({
    this.columnId,
    this.customerNumber,
    this.contactName,
    this.prefix,
    this.phone,
    this.equipNumber,
    this.invItemNumber,
    this.failureDesc,
    this.reqFinishDate,
    this.reqFinishTime,
    this.notes,
    this.woNumber,
  });

  WorkOrder copy({
    int columnId,
    String customerNumber,
    String contactName,
    String prefix,
    String phone,
    String equipNumber,
    String invItemNumber,
    String failureDesc,
    String reqFinishDate,
    String reqFinishTime,
    String notes,
    String woNumber,
  }) =>
      WorkOrder(
        columnId: columnId ?? this.columnId,
        customerNumber: customerNumber ?? this.customerNumber,
        contactName: contactName ?? this.contactName,
        prefix: prefix ?? this.prefix,
        phone: phone ?? this.phone,
        equipNumber: equipNumber ?? this.equipNumber,
        invItemNumber: invItemNumber ?? this.invItemNumber,
        failureDesc: failureDesc ?? this.failureDesc,
        reqFinishDate: reqFinishDate ?? this.reqFinishDate,
        reqFinishTime: reqFinishTime ?? this.reqFinishTime,
        notes: notes ?? this.notes,
        woNumber: woNumber ?? this.woNumber,
      );

  static WorkOrder fromJson(Map<String, Object> json) => WorkOrder(
        columnId: json[WorkOrderFields.columnId] as int,
        customerNumber: json[WorkOrderFields.customerNumber] as String,
        contactName: json[WorkOrderFields.contactName] as String,
        prefix: json[WorkOrderFields.prefix] as String,
        phone: json[WorkOrderFields.phone] as String,
        equipNumber: json[WorkOrderFields.equipNumber] as String,
        invItemNumber: json[WorkOrderFields.invItemNumber] as String,
        failureDesc: json[WorkOrderFields.failureDesc] as String,
        reqFinishDate: json[WorkOrderFields.reqFinishDate] as String,
        reqFinishTime: json[WorkOrderFields.reqFinishTime] as String,
        notes: json[WorkOrderFields.notes] as String,
        woNumber: json[WorkOrderFields.woNumber] as String,
      );

  Map<String, Object> toJson() => {
        WorkOrderFields.columnId: columnId,
        WorkOrderFields.customerNumber: customerNumber,
        WorkOrderFields.contactName: contactName,
        WorkOrderFields.prefix: prefix,
        WorkOrderFields.phone: phone,
        WorkOrderFields.equipNumber: equipNumber,
        WorkOrderFields.invItemNumber: invItemNumber,
        WorkOrderFields.failureDesc: failureDesc,
        WorkOrderFields.reqFinishDate: reqFinishDate,
        WorkOrderFields.reqFinishTime: reqFinishTime,
        WorkOrderFields.notes: notes,
        WorkOrderFields.woNumber: woNumber,
      };
}
