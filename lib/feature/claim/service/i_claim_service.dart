abstract class IClaimService {
  // INTERFACE
  IClaimService();
  Future<dynamic> submitClaim(
    int policyId,
    String dateTime,
    String description,
  );
}
