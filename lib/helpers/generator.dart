import 'dart:math';

class Generator {
  static const String _dummyText =
      "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc. Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc";

  static String getDummyText(int words,
      {bool withTab = false, bool withEmoji = false, withStop = true}) {
    var rand = Random();
    List<String> dummyTexts = _dummyText.split(" ");

    int size = dummyTexts.length;
    String text = "";
    if (withTab) text += "\t\t\t\t";
    String firstWord = dummyTexts[rand.nextInt(size)];
    firstWord = firstWord[0].toUpperCase() + firstWord.substring(1);
    text += firstWord + " ";

    for (int i = 1; i < words; i++) {
      text += dummyTexts[rand.nextInt(size)] + (i == words - 1 ? "" : " ");
    }

    return text + (withStop ? "." : "");
  }

  static String getParagraphsText(
      {int paragraph = 1,
      int words = 20,
      int noOfNewLine = 1,
      bool withHyphen = false,
      bool withEmoji = false}) {
    String text = "";
    for (int i = 0; i < paragraph; i++) {
      if (withHyphen) {
        text += "\t\t-\t\t";
      } else {
        text += "\t\t\t\t";
      }
      text += getDummyText(words, withEmoji: withEmoji);
      if (i != paragraph - 1) {
        for (int j = 0; j < noOfNewLine; j++) {
          text += "\n";
        }
      }
    }
    return text;
  }
}
