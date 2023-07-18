class TitleUtils {
  static String idToTitle(String movieId) {
    String convertedTitle = movieId
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
    return convertedTitle;
  }
}
