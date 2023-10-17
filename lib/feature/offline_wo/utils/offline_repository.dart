abstract class OfflineRepository {
  Future<String> pushWorkOrder(Map data);
}

class OfflineRepositoryImpl extends OfflineRepository {
  @override
  Future<String> pushWorkOrder(Map data) async {}
}
