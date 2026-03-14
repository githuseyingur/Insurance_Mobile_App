abstract class IClaimService {
  IClaimService();

  Future<dynamic> submitClaim(
    int policyId,
    String date,
    String description,
  );
}
