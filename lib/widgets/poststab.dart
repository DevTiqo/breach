import 'package:breach/models/post_model.dart';
import 'package:breach/notifiers/providers.dart';
import 'package:breach/theme/palette.dart';
import 'package:breach/widgets/post_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsTab extends ConsumerStatefulWidget {
  const PostsTab({super.key});

  @override
  ConsumerState<PostsTab> createState() => _PostsTabState();
}

class _PostsTabState extends ConsumerState<PostsTab>
    with TickerProviderStateMixin {
  late TabController tabController;

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          fit: StackFit.passthrough,
          children: [
            Container(
              color: ref.read(themeNotifier).data.scaffoldBackgroundColor,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                controller: tabController,
                labelColor: AppTheme.primaryColor,
                indicatorWeight: 3.0,
                indicatorColor: AppTheme.primaryColor,
                indicatorPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 0,
                ),
                padding: EdgeInsets.only(top: 4),
                labelStyle: AppTheme.smallText(context).copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w800,
                ),
                onTap: ((value) {
                  if (value == 0) {
                  } else if (value == 1) {
                  } else if (value == 2) {}
                }),
                unselectedLabelColor: ref.read(themeNotifier).darkTheme
                    ? AppTheme.white
                    : AppTheme.grayColor,
                unselectedLabelStyle: AppTheme.smallText(context).copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Featured',
                          style: AppTheme.normalText(
                            context,
                          ).copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Popular',
                          style: AppTheme.normalText(
                            context,
                          ).copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Recent',
                          style: AppTheme.normalText(
                            context,
                          ).copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ref.read(themeNotifier).darkTheme
                      ? AppTheme.white.withValues(alpha: 0.4)
                      : AppTheme.grayColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.5),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              ref.read(postsNotifierProvider).postsFeatured.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 2.5),
                        Text(
                          "No Featured posts",
                          textAlign: TextAlign.center,
                          style: AppTheme.smallText(context).copyWith(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF828282),
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 12),
                        Consumer(
                          builder: (context, ref, child) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: ref
                                  .watch(postsNotifierProvider)
                                  .postsFeatured
                                  .length,
                              itemBuilder: ((context, index) {
                                Post thispost = ref
                                    .watch(postsNotifierProvider)
                                    .postsFeatured[index];
                                return PostContainer(
                                  key: Key(thispost.id.toString()),
                                  post: thispost,
                                );
                              }),
                            );
                          },
                        ),

                        // postloading
                        //     ? Center(child: CircularProgress())
                        //     : (ref.watch(postsNotifierProvider).hasMorePosts !=
                        //               null &&
                        //           !ref.watch(postsNotifierProvider).hasMorePosts!)
                        //     ? Icon(
                        //         Icons.circle,
                        //         size: 12,
                        //         color: ref.watch(themeNotifier).data.cardColor,
                        //       )
                        //     : SizedBox(),
                        SizedBox(height: 100.0),
                      ],
                    ),
              ref.read(postsNotifierProvider).postsPopular.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 2.5),
                        Text(
                          "No Popular posts",
                          textAlign: TextAlign.center,
                          style: AppTheme.smallText(context).copyWith(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF828282),
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 12),
                        Consumer(
                          builder: (context, ref, child) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: ref
                                  .watch(postsNotifierProvider)
                                  .postsPopular
                                  .length,
                              itemBuilder: ((context, index) {
                                Post thispost = ref
                                    .watch(postsNotifierProvider)
                                    .postsPopular[index];
                                return PostContainer(
                                  key: Key(thispost.id.toString()),
                                  post: thispost,
                                );
                              }),
                            );
                          },
                        ),

                        SizedBox(height: 30),

                        SizedBox(height: 100.0),
                      ],
                    ),

              ref.read(postsNotifierProvider).postsRecent.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 2.5),
                        Text(
                          "No Recent posts",
                          textAlign: TextAlign.center,
                          style: AppTheme.smallText(context).copyWith(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF828282),
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 12),
                        Consumer(
                          builder: (context, ref, child) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: ref
                                  .watch(postsNotifierProvider)
                                  .postsRecent
                                  .length,
                              itemBuilder: ((context, index) {
                                Post thispost = ref
                                    .watch(postsNotifierProvider)
                                    .postsRecent[index];
                                return PostContainer(
                                  key: Key(thispost.id.toString()),
                                  post: thispost,
                                );
                              }),
                            );
                          },
                        ),

                        SizedBox(height: 30),
                        // postloading
                        //     ? Center(child: CircularProgress())
                        //     : (ref.watch(postsNotifierProvider).hasMorePosts !=
                        //               null &&
                        //           !ref.watch(postsNotifierProvider).hasMorePosts!)
                        //     ? Icon(
                        //         Icons.circle,
                        //         size: 12,
                        //         color: ref.watch(themeNotifier).data.cardColor,
                        //       )
                        //     : SizedBox(),
                        SizedBox(height: 100.0),
                      ],
                    ),
            ],
          ),
        ),
        SizedBox(height: 0.0),
      ],
    );
  }
}
