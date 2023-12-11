import 'package:flutter/material.dart';
import 'package:test_app/app/modules/bookmarks/views/bookmark_posts_view.dart';

import '../../../widgets/global_appbar.dart';
import '../../../widgets/global_bg.dart';

class BookmarksView extends StatelessWidget {
  const BookmarksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GlobalAppBar(title: 'Bookmarks'),
      body: GlobalBG(body: BookmarksPostsView()),
    );
  }
}
