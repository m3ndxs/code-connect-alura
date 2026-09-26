import 'package:code_connect_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomCardPost extends StatelessWidget {
  final String image;
  final String title;
  final String body;
  final String author;
  final String? authorAvatar;
  final int likes;

  const CustomCardPost({
    super.key,
    required this.image,
    required this.title,
    required this.body,
    required this.author,
    required this.likes,
    this.authorAvatar,
  });

  ImageProvider<Object> get _avatarImage {
    final url = authorAvatar;
    if (url == null || url.isEmpty) {
      return const AssetImage('lib/core/assets/images/icon.png');
    }
    return NetworkImage(url);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(color: AppTheme.cinzaClaro),
              child: Image.network(
                image,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.expand(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.cinzaClaro,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.cinzaClaro,
                    ),
                  ),
                  SizedBox(height: 64),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _footerCard(
                        context,
                        'lib/core/assets/icons/code.png',
                        likes,
                      ),
                      SizedBox(width: 32),
                      _footerCard(context, 'lib/core/assets/icons/share.png'),
                      SizedBox(width: 32),
                      _footerCard(context, 'lib/core/assets/icons/chat.png'),

                      const Spacer(),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: _avatarImage,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '@$author',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppTheme.cinzaClaro),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _footerCard(BuildContext context, String icon, [int? count]) {
    return Column(
      spacing: 4,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20, width: 20, child: Image.asset(icon)),
        if (count != null)
          Text(
            '$count',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppTheme.cinzaMedio),
          ),
      ],
    );
  }
}
