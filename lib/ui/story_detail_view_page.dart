
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:top_stories_nyt/ui/web_view_page.dart';
import 'package:shimmer/shimmer.dart';
import '../models/story_detail/story_detail.dart';
import '../utilities/shimmer_loading_effect.dart';

class StoryDetailPage extends StatefulWidget {
  const StoryDetailPage({
    super.key,
    required this.storyDetail,
  });

  final StoryDetail storyDetail;

  @override
  State<StoryDetailPage> createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            slivers: [
              // Add the app bar to the CustomScrollView.
              SliverAppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xffffffff), Color(0xffffe8dd)]),
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffff3225)),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),

                floating: true,
                snap: true,
                // Display a placeholder widget to visualize the shrinking size.
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: widget.storyDetail.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SizedBox(
                      child: Shimmer(
                          gradient: isDarkMode
                              ? shimmerGradientDark
                              : shimmerGradientLight,
                          child: const ImageLoadingPlaceholder(
                            isLoading: true,

                          )),
                    ),
                    errorWidget: (context, url, error) =>
                        const ImageLoadingPlaceholder(
                      isLoading: true,
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,

                          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                        ),
                      ),
                    ),
                  ),
                ),
                // Make the initial height of the SliverAppBar larger than normal.
                expandedHeight: 300,
                collapsedHeight: 300,
                pinned: false,

              ),

              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.storyDetail.title!,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.storyDetail.description!,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WebViewPage(
                                  url: widget.storyDetail.webViewUrl!,
                                )));
                          },
                          child: const Text("... See more"),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.storyDetail.author!.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),

                ]),
              )
              // Next, create a SliverList
            ],
          ),
        ),
      ),


    );
  }

  @override
  void initState() {
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }
}
