enum TextPage { aboutPage, publishPage, loginPage }

extension TextPageKey on TextPage {
  String get key {
    switch (this) {
      case TextPage.aboutPage:
        return 'about_page';
      case TextPage.publishPage:
        return 'publish_page';
      case TextPage.loginPage:
        return 'login_page';
    }
  }
}
