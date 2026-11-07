enum TextPage { aboutPage, publishPage }

extension TextPageKey on TextPage {
  String get key {
    switch (this) {
      case TextPage.aboutPage:
        return 'about_page';
      case TextPage.publishPage:
        return 'publish_page';
    }
  }
}
