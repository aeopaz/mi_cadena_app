class Chain {
  int id;
  String name;
  int amount;
  int frequency;
  String startDate;
  String startDateFormat;
  String endDate;
  String endDateFormat;
  String status;
  String statusText;
  String createdAt;
  String updatedAt;
  int creatorId;
  Map userCreatorInfo;
  int participantCount;
  List participants;
  int totalContributionsPaid;
  int totalContributionsOwed;
  int lateParticipants;

  Chain(
      this.id,
      this.name,
      this.amount,
      this.frequency,
      this.startDate,
      this.startDateFormat,
      this.endDate,
      this.endDateFormat,
      this.status,
      this.statusText,
      this.createdAt,
      this.updatedAt,
      this.creatorId,
      this.userCreatorInfo,
      this.participantCount,
      this.participants,
      this.totalContributionsPaid,
      this.totalContributionsOwed,
      this.lateParticipants);

  factory Chain.fromJson(Map<String, dynamic> data) {
    return Chain(
      data["id"],
      data["name"],
      data["amount"],
      data["frequency"],
      data["start_date"],
      data["start_date_format"],
      data["end_date"],
      data["end_date_format"],
      data["status"],
      data["status_text"],
      data["created_at"],
      data["updated_at"],
      data["creator_id"],
      data["user_creator_info"],
      data["participant_count"],
      data["participants"] ?? [],
      data["total_contributions_paid"] ?? [],
      data["total_contributions_owed"] ?? [],
      data["late_participants"] ?? [],
    );
  }
}
