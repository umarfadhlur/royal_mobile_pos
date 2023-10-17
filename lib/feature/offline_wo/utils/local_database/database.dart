import 'package:royal_mobile_pos/feature/offline_wo/utils/local_database/table_createwo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WorkOrderDatabase {
  static final WorkOrderDatabase instance = WorkOrderDatabase._init();
  static Database _database;
  WorkOrderDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('wo.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int newVersion) async {
    //Create WO Offline
    await db.execute('CREATE TABLE $tableCreateWorkOrder'
        '(${WorkOrderFields.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${WorkOrderFields.customerNumber} TEXT, '
        '${WorkOrderFields.contactName} TEXT, '
        '${WorkOrderFields.prefix} TEXT, '
        '${WorkOrderFields.phone} TEXT, '
        '${WorkOrderFields.equipNumber} TEXT, '
        '${WorkOrderFields.invItemNumber} TEXT, '
        '${WorkOrderFields.failureDesc} TEXT, '
        '${WorkOrderFields.reqFinishDate} TEXT, '
        '${WorkOrderFields.reqFinishTime} TEXT, '
        '${WorkOrderFields.notes} TEXT, '
        '${WorkOrderFields.woNumber} TEXT)');
  }

  Future<WorkOrder> create(WorkOrder workOrder) async {
    final db = await instance.database;
    final id = await db.insert(tableCreateWorkOrder, workOrder.toJson());
    return workOrder.copy(columnId: id);
  }

  Future<WorkOrder> readWorkOrder(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableCreateWorkOrder,
      columns: WorkOrderFields.values,
      where: '${WorkOrderFields.columnId} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return WorkOrder.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<WorkOrder>> readAllWorkOrder() async {
    final db = await instance.database;
    final result = await db.query(tableCreateWorkOrder);

    return result.map((json) => WorkOrder.fromJson(json)).toList();
  }

  Future<int> update(WorkOrder workOrder) async {
    final db = await instance.database;
    print(workOrder.columnId);
    return db.update(
      tableCreateWorkOrder,
      workOrder.toJson(),
      where: '${WorkOrderFields.columnId} = ?',
      whereArgs: [workOrder.columnId],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableCreateWorkOrder,
      where: '${WorkOrderFields.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future deleteAll() async {
    final db = await instance.database;
    return await db.delete(tableCreateWorkOrder);
  }

  // Future close() async {
  //   final db = await instance.database;
  //
  //   db.close();
  // }
}
