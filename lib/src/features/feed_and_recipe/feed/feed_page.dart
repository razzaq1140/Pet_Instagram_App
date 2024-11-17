import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_project/src/common/constants/app_colors.dart';
import 'package:pet_project/src/features/feed_and_recipe/widget/recipe_detail_widget.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widget/custom_search_delegate.dart';
import '../../../common/widget/custom_text_field.dart';
import '../../../router/routes.dart';
import '../../home/model/home_model.dart';
import '../../home/widget/old_post_widget.dart';
import '../../home/widget/post_home_widget.dart';
import '../recipe/recipe_page.dart';
import '../widget/expnadable_recipe_text_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int selectedIndex = 0;
  bool isFeedSelected = true;
  final PageController _pageController = PageController(initialPage: 0);

  final List<PostsModel> posts = [
    PostsModel(
      category: 'Dogs',
      postMedia: [
        'https://www.akc.org/wp-content/uploads/2021/10/Two-Golden-Retriever-puppies-eating-kibble-from-the-same-bowl.jpg',
        'https://videos.pexels.com/video-files/2796078/2796078-uhd_2560_1440_25fps.mp4',
      ],
      userName: 'Furry Pals',
      userImage:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      postTime: '12 ${'minutes_ago'.tr()}',
      likes: "6M",
      comments: 3000,
      description: 'This is a dog-related post.',
    ),
    PostsModel(
      category: 'Cats',
      postMedia: [
        "https://4368135.fs1.hubspotusercontent-na1.net/hubfs/4368135/Google%20Drive%20Integration/How%20cats%20are%20fed%20in%20a%20multi-cat%20household-1.png",
        'https://videos.pexels.com/video-files/6865077/6865077-uhd_1440_2732_25fps.mp4'
      ],
      userName: 'Cat Lover',
      userImage:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      postTime: '20 ${'minutes_ago'.tr()}',
      likes: "4M",
      comments: 1500,
      description: 'This is a cat-related post.',
    ),
    PostsModel(
      category: 'Birds',
      postMedia: [
        "https://media.audubon.org/editorial-card-images/article/gbbc_blackcapped_chickadee_helena_garcia_quebec_n398_2011_kk.jpg?width=1400&auto=webp&quality=90&fit=bounds&disable=upscale",
        'https://videos.pexels.com/video-files/4186980/4186980-hd_1920_1080_25fps.mp4'
      ],
      userName: 'Birds Lover',
      userImage:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      postTime: '20 ${'minutes_ago'.tr()}',
      likes: "4M",
      comments: 1500,
      description: 'This is a Birds-related post.',
    ),
    PostsModel(
      category: 'Fish',
      postMedia: [
        "https://media.istockphoto.com/id/181954091/photo/feeding-fish.jpg?s=1024x1024&w=is&k=20&c=lDEXOucXhCj2YkX3pwct7q2osJycVV5zyMMYEPq59jo="
      ],
      userName: 'Fish Lover',
      userImage:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      postTime: '40 ${'minutes_ago'.tr()}',
      likes: "120M",
      comments: 1500,
      description: 'This is a Fish-related post.',
    ),
  ];

  // Categories list
  final List<String> categories = [
    'all'.tr(),
    'dogs'.tr(),
    'cats'.tr(),
    'birds'.tr(),
    'fish'.tr()
  ];

  @override
  Widget build(BuildContext context) {
    List<PostsModel> filteredPosts = selectedIndex == 0
        ? posts
        : posts
            .where((post) => post.category == categories[selectedIndex])
            .toList();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorScheme(context).surface,
        elevation: 0,
        title: isFeedSelected
            ? GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                      searchTerms: [
                        'dogs'.tr(),
                        'cats'.tr(),
                        'birds'.tr(),
                        'fish'.tr()
                      ],
                    ),
                  );
                },
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(AppIcons.outlineSearch),
                    ),
                    readOnly: true,
                    hint: 'search_hint'.tr(),
                    borderColor: colorScheme(context).outline.withOpacity(0.4),
                    fillColor: colorScheme(context).surface,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: SvgPicture.asset(AppIcons.filter),
                    ),
                    suffixConstraints: const BoxConstraints(minHeight: 20),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'my_recipe_post'.tr(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 20, color: colorScheme(context).onSurface),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                      onTap: () => context.pushNamed(AppRoute.notificationPage),
                      child: SvgPicture.asset(AppIcons.notiIcon)),
                ],
              ),
        bottom: isFeedSelected
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return ChoiceChip(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color:
                                  colorScheme(context).outline.withOpacity(0.4),
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          label: Text(categories[index]),
                          selected: selectedIndex == index,
                          showCheckmark: false,
                          onSelected: (selected) {
                            setState(() {
                              selectedIndex = selected ? index : 0;
                            });
                          },
                          selectedColor: colorScheme(context).primary,
                          backgroundColor: Colors.transparent,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 10);
                      },
                    ),
                  ),
                ),
              )
            : null,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    isFeedSelected = index == 0;
                  });
                },
                children: [
                  ListView.builder(
                    itemCount: filteredPosts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final post = filteredPosts[index];
                      return OldPostWidget(
                        post: post,
                        showDescription: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'recipe_name'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: colorScheme(context).outline),
                            ),
                            Text(
                              'From Puppy',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: colorScheme(context).outline),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'recipe_category'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: colorScheme(context).outline),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: ExpandableTextWidget(
                                initialText: 'initial_text'.tr(),
                                fullText: 'full_text'.tr(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            RecipeViewDetailsWidget(
                              index: index,
                              post: posts[index],
                            ),
                            const SizedBox(height: 10),
                            RecipeViewDetailsWidget(
                              index: index,
                              post: posts[index],
                            ),
                            const SizedBox(height: 10),
                            RecipeViewDetailsWidget(
                              index: index,
                              post: posts[index],
                            ),
                            const SizedBox(height: 10),
                            RecipeViewDetailsWidget(
                              index: index,
                              post: posts[index],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const RecipePage(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: Container(
                color: colorScheme(context).surface,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorScheme(context).onPrimary,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: colorScheme(context)
                                  .outline
                                  .withOpacity(0.06),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFeedSelected = true;
                                    });
                                    _pageController.animateToPage(0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    decoration: BoxDecoration(
                                      color: isFeedSelected
                                          ? colorScheme(context).primary
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'feed'.tr(),
                                          style: TextStyle(
                                            color: isFeedSelected
                                                ? colorScheme(context).surface
                                                : colorScheme(context)
                                                    .outline
                                                    .withOpacity(0.4),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(Icons.grid_view_outlined,
                                            color: isFeedSelected
                                                ? colorScheme(context)
                                                    .onSecondary
                                                : AppColor.hintText),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFeedSelected = false;
                                    });
                                    _pageController.animateToPage(1,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    decoration: BoxDecoration(
                                      color: !isFeedSelected
                                          ? colorScheme(context).primary
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'recipe'.tr(),
                                          style: TextStyle(
                                            color: !isFeedSelected
                                                ? colorScheme(context).surface
                                                : colorScheme(context)
                                                    .outline
                                                    .withOpacity(0.4),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(MdiIcons.dockLeft,
                                            color: !isFeedSelected
                                                ? colorScheme(context)
                                                    .onSecondary
                                                : AppColor.hintText),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoute.uploadRecipe);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                colorScheme(context).primary.withOpacity(0.5),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme(context).primary,
                            ),
                            child: Icon(
                              Icons.add_box_outlined,
                              size: 24,
                              color: colorScheme(context).surface,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
