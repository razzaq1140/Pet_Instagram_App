import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/src/features/feed_and_recipe/recipe/controller/recipe_controller.dart';
import 'package:provider/provider.dart';
import '../../../common/constants/global_variables.dart';
import '../../home/model/home_model.dart';
import '../../home/widget/old_post_widget.dart';
import '../widget/expnadable_recipe_text_widget.dart';
import '../widget/recipe_detail_widget.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final List<PostsModel> posts = [
    PostsModel(
      postMedia: [
        'https://azestfor.com/cdn/shop/files/chicken-rice-carrots-002.png?v=1721402742&width=720',
        'https://videos.pexels.com/video-files/2796078/2796078-uhd_2560_1440_25fps.mp4',
      ],
      userName: 'Fromm Puppy',
      userImage:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      postTime: '12 ${'minutes_ago'.tr()}',
      likes: "6M",
      comments: 3000,
      description:
          'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
    ),
  ];
  late UploadRecipeController _recipeController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _recipeController =
          Provider.of<UploadRecipeController>(context, listen: false);
      _recipeController.fetchRecipeFeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      body: ListView.builder(
        itemCount: posts.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return OldPostWidget(
            post: posts[index],
            showDescription: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'recipe_name'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: colorScheme(context).outline),
                ),
                Text(
                  'From Puppy',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: colorScheme(context).outline),
                ),
                const SizedBox(height: 8),
                Text(
                  'recipe_category'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: colorScheme(context).outline),
                ),
                Text(
                  'Dog',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: colorScheme(context).outline),
                ),
                const SizedBox(height: 8),
                Text(
                  'preparation_steps'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: colorScheme(context).outline),
                ),
                Text(
                  '1: cook the protine :',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: colorScheme(context).outline),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: ExpandableTextWidget(
                    initialText: 'initial_text'.tr(),
                    fullText: 'full_text'.tr(),
                  ),
                ),
                const SizedBox(height: 20),
                // RecipeViewDetailsWidget(
                //   index: index,
                //   post: posts[index],
                // ),
                // const SizedBox(height: 10),
                // RecipeViewDetailsWidget(
                //   index: index,
                //   post: posts[index],
                // ),
                // const SizedBox(height: 10),
                // RecipeViewDetailsWidget(
                //   index: index,
                //   post: posts[index],
                // ),
                // const SizedBox(height: 10),
                // RecipeViewDetailsWidget(
                //   index: index,
                //   post: posts[index],
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
