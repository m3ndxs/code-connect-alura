import 'package:code_connect_app/core/routes/routes.dart';
import 'package:code_connect_app/features/about/presentation/about_page.dart';
import 'package:code_connect_app/features/feed/presentation/feed_page.dart';
import 'package:code_connect_app/features/profile/presentation/profile_page.dart';
import 'package:code_connect_app/features/publish/presentation/pages/publish_page.dart';
import 'package:code_connect_app/core/shared/layout/main_layout.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: Routes.feed,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: Routes.feed,
          builder: (_, _) {
            return const FeedPage();
          },
        ),
        GoRoute(
          path: Routes.profile,
          builder: (_, _) {
            return const ProfilePage();
          },
        ),
        GoRoute(
          path: Routes.about,
          builder: (_, _) {
            return const AboutPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: Routes.publish,
      builder: (_, _) {
        return const PublishPage();
      },
    ),
  ],
);
