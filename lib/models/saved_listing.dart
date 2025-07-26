class SavedListing {
  final String id;
  final String userOrGroupId;
  final String listingId;
  final bool isTeamSave;

  SavedListing({
    required this.id,
    required this.userOrGroupId,
    required this.listingId,
    this.isTeamSave = false,
  });

  factory SavedListing.fromMap(String id, Map<String, dynamic> data) {
    return SavedListing(
      id: id,
      userOrGroupId: data['userOrGroupId'] ?? '',
      listingId: data['listingId'] ?? '',
      isTeamSave: data['isTeamSave'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userOrGroupId': userOrGroupId,
      'listingId': listingId,
      'isTeamSave': isTeamSave,
    };
  }
} 