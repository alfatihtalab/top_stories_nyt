import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:top_stories_nyt/models/story_detail/story_detail.dart';
import 'package:shimmer/shimmer.dart';

import '../utilities/shimmer_loading_effect.dart';

class NewsListedCardWidget extends StatelessWidget {
  const NewsListedCardWidget(
      {super.key, required this.onTap, required this.storyDetail});

  final VoidCallback onTap;
  final StoryDetail storyDetail;

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery
        .of(context)
        .orientation == Orientation.portrait;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;


    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8)
      ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 120,
            padding: EdgeInsets.all(4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Flexible(

              child: CachedNetworkImage(
                imageUrl: storyDetail.imageUrl! ,
                fit: BoxFit.cover,
                placeholder: (context, url) => SizedBox(
                  child: Shimmer(
                      gradient: isDarkMode? shimmerGradientDark: shimmerGradientLight,
                      child:  const ImageLoadingPlaceholder(
                        isLoading: true,
                        // height: 90,
                        // width: 90,
                      )),
                ),
                errorWidget: (context, url, error) => const
                ImageLoadingPlaceholder(
                  isLoading: true,
                ),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,

                      // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)


                    ),
                  ),
                ),

              ),
        ),

        const SizedBox(width: 10,),
        const VerticalDivider(),
        Flexible(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  "${storyDetail.title}",
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(overflow: TextOverflow.ellipsis),
                  softWrap: false,
                  maxLines: 2,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 200,
                child: Text("${storyDetail.description}",

                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(overflow: TextOverflow.ellipsis, fontSize: 12),
                  softWrap: false, maxLines: isPortrait ? 3 : 4,),
              ),
              const SizedBox(
                height: 5,
              ),

            ],
          ),
        ),
        ])),
    )
    ,
    );
  }
}
