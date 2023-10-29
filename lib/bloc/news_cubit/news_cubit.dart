import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:top_stories_nyt/data/repository/top_stories_repository.dart';
import 'package:top_stories_nyt/models/story_detail/story_detail.dart';
import 'package:top_stories_nyt/models/top_stories_response/top_stories_response.dart';
import 'package:shared_preferences/shared_preferences.dart';


part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this.topStoriesRepository) : super(NewsInitial());

  final TopStoriesRepository topStoriesRepository;
  late TopStoriesResponse topStoriesResponse;

  List<StoryDetail> storyDetailList = [];
  final List<String> _previousSearches = [];

  List<String> get previousSearches => _previousSearches;

  bool isListView = true;

// TODO get current Top Stories by section Name
  Future<void> getTopStories({required String sectionName}) async {
    // InternetProvider internetProvider = InternetProvider();
    // final hasInternet = await internetProvider.checkInternetConnection();
    emit(NewsLoading());
    storyDetailList.clear();
    await topStoriesRepository.getTopStoriesData(sectionName: sectionName)
        .then((value) {
      topStoriesResponse = value;
      emit(NewsLoaded(value));
      topStoriesResponse.results.forEach((element) {
        final multimedia =
            element.multimedia;

        final storyDetail = StoryDetail(
            title: element.title,
            description: element.abstract,
            author: element.byline,
            imageUrl: element.multimedia.isNotEmpty? element.multimedia.first.url: "no media",
            webViewUrl: element.url);
        storyDetailList.add(storyDetail);
      });

    }).onError((error, stackTrace) {
      emit(ErrorFetchNews());
    });

  }


  void saveSearches(List<String> searches) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String>? previousSearches = sharedPreferences.getStringList('searches');

    searches.addAll(previousSearches!);

    await sharedPreferences.setStringList('searches', searches);
  }

  void getPreviousSearches() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String>? previousSearches = sharedPreferences.getStringList('searches');
    _previousSearches.clear();

    _previousSearches.addAll(previousSearches!);


  }
  void filterSearch(
      String enteredKeyword) {
    List<StoryDetail> titleResults = [];
    List<StoryDetail> authorNameResults = [];
    List<StoryDetail> descResults = [];

    List<StoryDetail> totalResults = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      totalResults = storyDetailList;
    } else {
      titleResults = storyDetailList
          .where((story) => story.title!.contains(enteredKeyword))
          .toList();

      authorNameResults = storyDetailList
          .where((story) => story.author!.contains(enteredKeyword))
          .toList();

      descResults = storyDetailList
          .where((story) => story.description!.contains(enteredKeyword))
          .toList();

      totalResults.addAll(titleResults);
      totalResults.addAll(authorNameResults);
      totalResults.addAll(descResults);
      // we use the toLowerCase() method to make it case-insensitive


      _previousSearches.clear();
      totalResults.forEach((element) {
        _previousSearches.add(element.title!);
      });

    }


  }

  void changeView(bool isList){
    isListView = isList;
  }



}
