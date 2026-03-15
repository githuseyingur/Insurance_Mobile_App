abstract class IPolicyService {
  IPolicyService();
  Future<dynamic> getPolicyList();
  Future<dynamic> getPolicyDetail(int id);
}
