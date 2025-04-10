import 'dart:io';

import 'package:dio/dio.dart';
import 'package:golocal/src/event/domain/eventtype_enum.dart';
import 'package:golocal/src/event/domain/location.dart';
import 'package:golocal/src/shared/model_base.dart';
import 'package:golocal/src/event/domain/tag.dart';
import 'package:golocal/src/user/domain/user.dart';

/// Represents an event with details such as title, description, organizers, and location.
///
/// Attributes:
/// - `eventOrganizers`: List of users who are organizing the event.
/// - `title`: The title of the event.
/// - `description`: The description of the event.
/// - `imageUrl`: The URL of the event's image (optional).
/// - `isAdultOnly`: Indicates if the event is for adults only.
/// - `eventType`: The type of the event.
/// - `tags`: List of tags associated with the event.
/// - `isPromoted`: Indicates if the event is promoted.
/// - `startDate`: The start date and time of the event.
/// - `endDate`: The end date and time of the event (optional).
/// - `location`: The location of the event (optional).
class Event extends Model {
  List<User> eventOrganizers;
  String title;
  String description;
  String? imageUrl;
  bool isAdultOnly;
  EventType eventType;
  List<Tag> tags;
  bool isPromoted;

  DateTime startDate;
  DateTime? endDate;

  Location? location;

  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  Event({
    required super.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.startDate,
    required this.eventOrganizers,
    this.imageUrl,
    this.eventType = EventType.other,
    this.isAdultOnly = false,
    this.location,
    this.endDate,
    this.isPromoted = false,
  }) : assert(
          endDate == null || endDate.isAfter(startDate),
          eventOrganizers.isNotEmpty,
        );

  Event.fromJson(super.json)
      : title = json['title'],
        description = json['description'],
        imageUrl = json['image'] ?? '',
        isAdultOnly = json['isAdultOnly'],
        eventType = EventType.fromString(json['event_type']),
        tags = json["event_tags"] != null
            ? (json['event_tags'] as List).map((e) => Tag.fromJson(e)).toList()
            : [],
        startDate = DateTime.parse(json['startDate']),
        endDate = json['finishDate'] != null
            ? DateTime.parse(json['finishDate'])
            : null,
        location = json['location'] != null
            ? Location.fromJson(json['location'])
            : null,
        eventOrganizers = json['eventOrganizers'] != null
            ? (json['eventOrganizers'] as List)
                .map((e) => User.fromJson(e))
                .toList()
            : [],
        isPromoted = json['isPromoted'] ?? false,
        super.fromJson();

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['title'] = title;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['isAdultOnly'] = isAdultOnly;
    data['eventType'] = eventType;
    data['tags'] = tags.map((e) => e.toJson()).toList();
    data['startDate'] = startDate.toString();
    data['endDate'] = endDate?.toString();
    data['location'] = location?.toJson() ?? {};
    data['eventOrganizers'] = eventOrganizers.map((e) => e.toJson()).toList();
    data['isPromoted'] = isPromoted;
    return data;
  }
}

/// Data Transfer Object for creating or updating an event.
///
/// Attributes:
/// - `organizers`: List of IDs of the event organizers.
/// - `title`: The title of the event.
/// - `description`: The description of the event.
/// - `image`: The image file of the event.
/// - `startDate`: The start date and time of the event.
/// - `endDate`: The end date and time of the event.
/// - `isAdultOnly`: Indicates if the event is for adults only.
/// - `eventType`: The type of the event.
/// - `tags`: List of tags associated with the event.
/// - `lon`: The longitude of the event location.
/// - `lat`: The latitude of the event location.
class EventDTO {
  List<int> organizers;
  String title;
  String description;
  File image;
  DateTime startDate;
  DateTime endDate;
  bool isAdultOnly;
  String eventType;
  List<String> tags;
  String lon;
  String lat;

  EventDTO({
    required this.organizers,
    required this.title,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.isAdultOnly,
    required this.eventType,
    required this.tags,
    required this.lat,
    required this.lon,
  });

  Future<FormData> toFormData() async {
    var filename = image.path.split('/').last;
    var imageFile =
        await MultipartFile.fromFile(image.path, filename: filename);

    final data = FormData.fromMap({
      'organizers': organizers,
      'title': title,
      'description': description,
      'image': imageFile,
      'startDate': startDate.toIso8601String(),
      'finishDate': endDate.toIso8601String(),
      'isAdultOnly': isAdultOnly,
      'eventType': eventType,
      'tags': tags,
      'lon': lon,
      'lat': lat,
    });
    return data;
  }
}
