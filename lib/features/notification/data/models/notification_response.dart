abstract class NotificationResponse {
  final String sender;
  final String? title;

  NotificationResponse({required this.sender, this.title});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('campaignName')) {
      return AdCampaignNotificationResponse.fromJson(json);
    } else if (json.containsKey('dateTime')) {
      return MatchNotificationResponse.fromJson(json);
    }
    throw Exception("Unknown notification type");
  }
}

class MatchNotificationResponse extends NotificationResponse {
  final String? dateTime;
  final String? latLng;
  final String? desc;

  MatchNotificationResponse({
    required String sender,
    this.dateTime,
    this.latLng,
    this.desc,
    String? title,
  }) : super(sender: sender, title: title ?? 'Match invitation from $sender');

  factory MatchNotificationResponse.fromJson(Map<String, dynamic> json) {
    return MatchNotificationResponse(
      sender: json['sender'] as String,
      dateTime: json['dateTime'] as String?,
      latLng: json['latLng'] as String?,
      desc: json['desc'] as String?,
      title: json['title'] as String?,
    );
  }
}

class AdCampaignNotificationResponse extends NotificationResponse {
  final String campaignName;
  final String? adDetails;

  AdCampaignNotificationResponse({
    required String sender,
    required this.campaignName,
    this.adDetails,
    String? title,
  }) : super(sender: sender, title: title ?? '[$sender] $campaignName');

  factory AdCampaignNotificationResponse.fromJson(Map<String, dynamic> json) {
    return AdCampaignNotificationResponse(
      sender: json['sender'] as String,
      campaignName: json['campaignName'] as String,
      adDetails: json['adDetails'] as String?,
      title: json['title'] as String?,
    );
  }
}