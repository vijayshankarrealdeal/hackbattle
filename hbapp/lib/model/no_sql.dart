import 'package:flutter/material.dart';

class NoSqlModel {
  NoSqlModel({
    required this.trending,
    required this.data,
  });
  late final String trending;
  late final List<Data> data;

  NoSqlModel.fromJson(Map<String, dynamic> json) {
    trending = json['trending'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['trending'] = trending;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.avgRating,
    required this.name,
    required this.pos,
    required this.neg,
    required this.categories,
  });
  late final String id;
  late final List<String> categories;
  late final num avgRating;
  late final String name;
  late final num pos;
  late final num neg;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avgRating = json['avg_rating'];
    name = json['name'];
    pos = json['pos'];
    neg = json['neg'];
    categories =
        List.from(json['categories']).map((e) => e.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['avg_rating'] = avgRating;
    _data['name'] = name;
    _data['pos'] = pos;
    _data['neg'] = neg;
    return _data;
  }
}

class SecondDataPage {
  SecondDataPage({
    required this.id,
    required this.text,
    required this.label,
    required this.score,
    required this.name,
    required this.categories,
    required this.doRecommend,
    required this.rating,
    required this.primaryCategories,
    required this.username,
    required this.color,
  });
  late final String id;
  Color color = Colors.blue.shade200;
  late final String text;
  late final String label;
  late final double score;
  late final String name;
  late final String categories;
  late final bool doRecommend;
  late final int rating;
  late final String primaryCategories;
  late final String username;

  SecondDataPage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['reviews.text'];
    label = json['label'];
    score = json['score'];
    name = json['name'];
    categories = json['categories'];
    doRecommend = json['reviews.doRecommend'];
    rating = json['reviews.rating'];
    primaryCategories = json['primaryCategories'];
    username = json['reviews.username'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['reviews.text'] = text;
    _data['label'] = label;
    _data['score'] = score;
    _data['name'] = name;
    _data['categories'] = categories;
    _data['reviews.doRecommend'] = doRecommend;
    _data['reviews.rating'] = rating;
    _data['primaryCategories'] = primaryCategories;
    _data['reviews.username'] = username;
    return _data;
  }
}
