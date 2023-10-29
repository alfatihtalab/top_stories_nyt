import 'package:flutter/material.dart';

import 'app.dart';
import 'data/repository/top_stories_repository.dart';

void main() {
  runApp(
      AppProvider(topStoriesRepository: TopStoriesRepository(),));
}
