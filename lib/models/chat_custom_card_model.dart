class ChatCustomCard {
  String? icon;
  String? name;
  String? lastMessage;
  String? time;
  bool? isGroup;
  String? status;
  bool isSelected = false;
  int? id;
  ChatCustomCard({
    this.icon,
    this.name,
    this.lastMessage,
    this.time,
    this.isGroup,
    this.status,
    this.isSelected = false,
    this.id,
  });
}
