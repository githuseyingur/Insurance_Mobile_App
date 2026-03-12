abstract class IPolicyService {
  // INTERFACE
  IPolicyService();
  Future<dynamic> getPolicyList();
  Future<dynamic> getPolicyDetail(int id);
}
