import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_stories_nyt/bloc/news_cubit/news_cubit.dart';
import 'package:top_stories_nyt/models/story_detail/story_detail.dart';
import 'package:top_stories_nyt/ui/story_detail_view_page.dart';
import '../utilities/constant.dart';
import '../widgets/news_grided_card_widget.dart';
import '../widgets/news_listed_card_widget.dart';

class TopStoriesListPage extends StatefulWidget {
  const TopStoriesListPage({super.key});

  @override
  State<TopStoriesListPage> createState() => _TopStoriesListPageState();
}

class _TopStoriesListPageState extends State<TopStoriesListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _searchController;
  late FocusNode focusNode;
  List<StoryDetail> foundNewsList = [];

  String? dropdownValue = sectionNames.first;
  bool isSearchFocus = false;

  bool isListView = true;

  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().getTopStories(sectionName: sectionNames.first);
    _searchController = TextEditingController();
    _controller = AnimationController(vsync: this);
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = BlocProvider.of<NewsCubit>(context, listen: false);
    return Scaffold(


      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _searchBarWidget(context, newsProvider),
              ),



              //  TODO depending on view GridView or ListView
              Expanded(
                child: BlocConsumer<NewsCubit, NewsState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is NewsLoaded) {
                      List<StoryDetail> currentStories = [];
                      if(foundNewsList.isNotEmpty || _searchController.text.isNotEmpty){
                        currentStories = foundNewsList;
                      }else{
                        currentStories = newsProvider.storyDetailList;

                      }

                      return currentStories.isNotEmpty? isListView
                          ? ListView.separated(
                                  itemCount:
                                  currentStories.length,
                                  itemBuilder: (context, index) {
                                    return NewsListedCardWidget(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StoryDetailPage(
                                                      storyDetail: currentStories[
                                                          index],
                                                    )));
                                      },
                                      storyDetail:
                                      currentStories[index],
                                    );
                                  }, separatorBuilder: (BuildContext context, int index) {
                                    return Divider(thickness: 1,);
                      },)
                          : GridView.builder(
                                  itemCount:
                                  currentStories.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 2/3,
                                          crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    return NewsGridedCardWidget(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StoryDetailPage(
                                                      storyDetail: currentStories[
                                                          index],
                                                    )));
                                      },
                                      storyDetail:
                                      currentStories[index],
                                    );
                                  }): const Center(
                        child: Text("No Story is founded"),
                      );
                    }
                    if (state is ErrorFetchNews) {
                      return Column(
                        children: [
                          const Center(child: Text("Error fetching top stories!")),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () async {
                                await newsProvider.getTopStories(
                                    sectionName: sectionNames.first);
                              },
                              child: const Text("Try again"))
                        ],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _searchBarWidget(BuildContext context, NewsCubit newsProvider) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: SearchBar(
                    elevation: MaterialStateProperty.all(2),
                    controller: _searchController,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),

                    onChanged: (enteredKeyword)
                    {

                      _runFilter(enteredKeyword, context, newsProvider);
                      setState(() {
                        isSearchFocus = enteredKeyword.isNotEmpty;
                      });

                      },
                    leading: const Icon(Icons.search),
                    trailing: <Widget>[
                      Tooltip(
                        message: 'Change brightness mode',
                        child: IconButton(
                          // isSelected: isDark,
                          onPressed:()=>
                              _dialogSectionsBuilder(context, onConfirm: (String section) async{
                                await context.read<NewsCubit>().getTopStories(
                                    sectionName: section).then((value){
                                  setState(() {
                                    
                                  });
                                });
                              }),


                          icon: const Icon(Icons.filter_alt),
                          // selectedIcon: const Icon(Icons.brightness_2_outlined),
                        ),
                      )
                    ],
                  )
                ),
                const SizedBox(
                  width: 2,
                ),

                Row(
                        children: [

                          IconButton(
                              onPressed: () async {
                                if (!isListView) {
                                  // await newsProvider.getTopStories(
                                  //     sectionName: dropdownValue);
                                  setState(() {
                                    isListView = true;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.list,
                                // size: 20,
                              )),
                          IconButton(
                              onPressed: () async {
                                if (isListView) {
                                  // await newsProvider.getTopStories(
                                  //     sectionName: dropdownValue);

                                  setState(() {
                                    isListView = false;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.grid_view_sharp,
                                // size: 20,
                              )),
                        ],
                      ),
              ],
            );
  }




  Future<void> _dialogSectionsBuilder(BuildContext context,
      {required Function(String section) onConfirm}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Choose your favorite section:'),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 5.0,
                    children: List<Widget>.generate(
                      sectionNames.length,
                          (int index) {
                        return ChoiceChip(
                          label: Text(sectionNames[index]),
                          selected: dropdownValue == sectionNames[index],
                          onSelected: (bool selected)async {
                            setState(() {
                              dropdownValue = sectionNames[index];
                            });
                            setState(() {
                              dropdownValue = selected ? sectionNames[index] : null;
                            });

                            Navigator.pop(context);
                            onConfirm(sectionNames[index]);

                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
                Divider(),

              ],
            ),
          ],
        );
      },
    );
  }

  // This function is called whenever the text field changes
  void _runFilter(
      String enteredKeyword, BuildContext context, NewsCubit newsCubit) {
    List<StoryDetail> titleResults = [];
    List<StoryDetail> authorNameResults = [];

    List<StoryDetail> totalResults = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      totalResults = newsCubit.storyDetailList;
    } else {
      titleResults = newsCubit.storyDetailList
          .where((story) => story.title!.contains(enteredKeyword))
          .toList();

      authorNameResults = newsCubit.storyDetailList
          .where((story) => story.author!.contains(enteredKeyword))
          .toList();

      totalResults.addAll(titleResults);
      totalResults.addAll(authorNameResults);
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    print(foundNewsList);
    setState(() {
      foundNewsList = totalResults;
    });
  }
}


