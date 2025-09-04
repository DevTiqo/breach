import 'package:breach/modules/livesockets.dart';
import 'package:breach/notifiers/socket_notifier.dart';
import 'package:breach/theme/palette.dart';
import 'package:breach/utils/imageconsts.dart';
import 'package:breach/widgets/post_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Streams extends ConsumerStatefulWidget {
  final dynamic callDrawer;
  const Streams({required this.callDrawer, super.key});

  @override
  ConsumerState<Streams> createState() => _StreamsState();
}

class _StreamsState extends ConsumerState<Streams>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceInOut,
    );
  }

  connectToServer() async {}

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(webSocketMessagesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Streams',
          style: AppTheme.bigText(
            context,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            widget.callDrawer();
          },
          icon: Icon(Icons.view_list),
        ),
        centerTitle: false,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      'Discover trending content from topics you care about in real time',
                      style: AppTheme.normalText(
                        context,
                      ).copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: posts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' Syncing you to your best ',
                        style: AppTheme.mediumText(
                          context,
                        ).copyWith(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        ' Streams ',
                        style: AppTheme.extralargeText(context).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(height: 24),

                      ScaleTransition(
                        scale: _animation,
                        child: Icon(
                          Icons.flash_on,
                          color: AppTheme.primaryColor,
                          size: 300,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final msg = posts[index];

                    return Align(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[300]?.withAlpha(1),
                          borderRadius: BorderRadius.circular(1),
                        ),
                        child: PostContainer(post: posts[index]),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
