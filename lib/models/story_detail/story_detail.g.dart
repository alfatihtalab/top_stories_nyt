// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryDetailImpl _$$StoryDetailImplFromJson(Map<String, dynamic> json) =>
    _$StoryDetailImpl(
      title: json['title'] as String?,
      description: json['description'] as String?,
      author: json['author'] as String?,
      imageUrl: json['imageUrl'] as String?,
      webViewUrl: json['webViewUrl'] as String?,
      createdDate: json['createdDate'] as String?,
      publishedDate: json['publishedDate'] as String?,
    );

Map<String, dynamic> _$$StoryDetailImplToJson(_$StoryDetailImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'author': instance.author,
      'imageUrl': instance.imageUrl,
      'webViewUrl': instance.webViewUrl,
      'createdDate': instance.createdDate,
      'publishedDate': instance.publishedDate,
    };
