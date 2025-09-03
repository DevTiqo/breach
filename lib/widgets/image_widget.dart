import 'package:breach/models/post_model.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImageFullScreenWrapperWidget extends StatelessWidget {
  final List<String> images;
  final Widget child;

  final Post? post;
  final bool dark;
  final int index;

  ImageFullScreenWrapperWidget({
    required this.images,
    required this.child,
    this.post,
    this.index = 0,
    this.dark = true,
  });

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: index);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false,
            barrierColor: dark ? Colors.black : Colors.white,
            pageBuilder: (BuildContext context, _, __) {
              return FullScreenPage(
                child: PageView.builder(
                  itemCount: images.length,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ExtendedImage.network(
                        images[index],
                        fit: BoxFit.contain,
                        cache: true,
                      ),
                    );
                  },
                ),
                dark: dark,
              );
            },
          ),
        );
      },
      child: child,
    );
  }
}

class FullScreenPage extends StatefulWidget {
  FullScreenPage({required this.child, required this.dark});

  final Widget child;
  final bool dark;

  @override
  _FullScreenPageState createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: widget.dark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 333),
                curve: Curves.fastOutSlowIn,
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 4,
                  child: widget.child,
                ),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  elevation: 0,
                  padding: EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: widget.dark ? Colors.white : Colors.black,
                      size: 25,
                    ),
                  ),
                  color: widget.dark ? Colors.black12 : Colors.white70,
                  highlightElevation: 0,
                  minWidth: double.minPositive,
                  height: double.minPositive,
                  shape: CircleBorder(),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
