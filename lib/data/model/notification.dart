import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class NotificationModel extends Equatable {
  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.image,
    required this.icon,
    required this.status,
    required this.subscription,
    required this.readAt,
    required this.createdAt,
    required this.updatedAt,
    required this.receivedAt,
    required this.imageThumb,
    required this.animation,
    required this.tracking,
    required this.subjectName,
    required this.isSubscribed,
  });

  late final String id;
  late final String type;
  late final String title;
  late final Message message;
  late final String image;
  late final String icon;
  late String status;
  late final Subscription? subscription;
  late final int readAt;
  late final int createdAt;
  late int updatedAt;
  late final int receivedAt;
  late final String imageThumb;
  late final String animation;
  late final String? tracking;
  late final String subjectName;
  late final bool isSubscribed;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    message = Message.fromJson(json['message']);
    image = json['image'];
    icon = json['icon'];
    status = json['status'];
    subscription = json['subscription'] == null
        ? null
        : Subscription.fromJson(json['subscription']);
    readAt = json['readAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    receivedAt = json['receivedAt'];
    imageThumb = json['imageThumb'];
    animation = json['animation'];
    tracking = json['tracking'];
    subjectName = json['subjectName'];
    isSubscribed = json['isSubscribed'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['title'] = title;
    _data['message'] = message.toJson();
    _data['image'] = image;
    _data['icon'] = icon;
    _data['status'] = status;
    _data['subscription'] = subscription?.toJson();
    _data['readAt'] = readAt;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['receivedAt'] = receivedAt;
    _data['imageThumb'] = imageThumb;
    _data['animation'] = animation;
    _data['tracking'] = tracking;
    _data['subjectName'] = subjectName;
    _data['isSubscribed'] = isSubscribed;
    return _data;
  }

  @override
  List<Object?> get props => [id, status, updatedAt];
}

class Message {
  Message({
    required this.text,
    required this.highlights,
  });

  late final String text;
  late final List<Highlight> highlights;

  Message.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    highlights = List.from(json['highlights'])
        .map((e) => Highlight.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['text'] = text;
    _data['highlights'] = highlights.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Highlight {
  Highlight({
    required this.offset,
    required this.length,
  });

  late final int offset;
  late final int length;

  Highlight.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['offset'] = offset;
    _data['length'] = length;
    return _data;
  }
}

class Subscription {
  Subscription({
    required this.targetId,
    required this.targetType,
    required this.targetName,
    required this.level,
  });

  late final String? targetId;
  late final String? targetType;
  late final String? targetName;
  late final int? level;

  Subscription.fromJson(Map<String, dynamic> json) {
    targetId = json['targetId'];
    targetType = json['targetType'];
    targetName = json['targetName'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['targetId'] = targetId;
    _data['targetType'] = targetType;
    _data['targetName'] = targetName;
    _data['level'] = level;
    return _data;
  }
}

enum NotificationStatus {read, unread }

extension NotificationStatusExs on NotificationStatus {
  static NotificationStatus fromString(String value) {
    if (value == 'unread') {
      return NotificationStatus.unread;
    }
    return NotificationStatus.read;
  }

  String getTextValue() {
    if (this == NotificationStatus.unread) {
      return 'unread';
    }
    return 'read';
  }
}
