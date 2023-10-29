
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'story_detail.freezed.dart';
part 'story_detail.g.dart';

StoryDetail storyDetailFromJson(String str) => StoryDetail.fromJson(json.decode(str));

String storyDetailToJson(StoryDetail data) => json.encode(data.toJson());

@freezed
class StoryDetail with _$StoryDetail {
  const factory StoryDetail({
    String? title,
    String? description,
    required String? author,
    required String? imageUrl,
    required String? webViewUrl,
    String? createdDate,
    String? publishedDate,
  }) = _StoryDetail;

  factory StoryDetail.fromJson(Map<String, dynamic> json) => _$StoryDetailFromJson(json);
}
