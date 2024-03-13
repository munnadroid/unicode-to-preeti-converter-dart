class UnicodeToPreeti {
  static const Map<String, String> _unicodePreetiMap = {
    "अ": "c",
    "आ": "cf",
    "ा": "f",
    "इ": "O",
    "ई": "O{",
    "र्": "{",
    "उ": "p",
    "ए": "P",
    "े": "]",
    "ै": "}",
    "ो": "f]",
    "ौ": "f}",
    "ओ": "cf]",
    "औ": "cf}",
    "ं": "+",
    "ँ": "F",
    "ि": "l",
    "ी": "L",
    "ु": "'",
    "ू": "\"",
    "क": "s",
    "ख": "v",
    "ग": "u",
    "घ": "3",
    "ङ": "ª",
    "च": "r",
    "छ": "5",
    "ज": "h",
    "झ": "´",
    "ञ": "`",
    "ट": "6",
    "ठ": "7",
    "ड": "8",
    "ढ": "9",
    "ण": "0f",
    "त": "t",
    "थ": "y",
    "द": "b",
    "ध": "w",
    "न": "g",
    "प": "k",
    "फ": "km",
    "ब": "a",
    "भ": "e",
    "म": "d",
    "य": "o",
    "र": "/",
    "रू": "?",
    "ृ": "[",
    "ल": "n",
    "व": "j",
    "स": ";",
    "श": "z",
    "ष": "if",
    "ज्ञ": "1",
    "ह": "x",
    "१": "!",
    "२": "@",
    "३": "#",
    "४": "\$",
    "५": "%",
    "६": "^",
    "७": "&",
    "८": "*",
    "९": "(",
    "०": ")",
    "।": ".",
    "्": "\\",
    "ऊ": "pm",
    "-": " ",
    "(": "-",
    ")": "_",
  };

  static String _normalizeUnicode(String unicodetext) {
    String normalized = '';
    for (int i = 0; i < unicodetext.length; i++) {
      String currentChar = unicodetext[i];
      try {
        if (currentChar != 'र') {
          if (unicodetext[i + 1] == '्' &&
              unicodetext[i + 2] != ' ' &&
              unicodetext[i + 2] != '।' &&
              unicodetext[i + 2] != ',') {
            if (unicodetext[i + 2] != 'र') {
              if ("wertyuxasdghjkzvn"
                  .contains(_unicodePreetiMap[unicodetext[i]]!)) {
                normalized += String.fromCharCode(
                    int.parse(_unicodePreetiMap[unicodetext[i]]!) - 32);
                i++;
                continue;
              } else if (currentChar == 'स') {
                normalized += ":";
                i++;
                continue;
              } else if (currentChar == 'ष') {
                normalized += 'i';
                i++;
                continue;
              }
            }
          }
        }
        if (unicodetext[i - 1] != 'र' &&
            currentChar == '्' &&
            unicodetext[i + 1] == 'र') {
          if (unicodetext[i - 1] != 'ट' &&
              unicodetext[i - 1] != 'ठ' &&
              unicodetext[i - 1] != 'ड') {
            normalized += '|';
            i++;
            continue;
          } else {
            normalized += '«';
            i++;
            continue;
          }
        }
      } catch (err) {}
      normalized += currentChar;
    }
    return normalized.replaceAll("त|", "q");
  }

  static String unicodeToPreeti(String text) {
    String normalizedUnicodeText = _normalizeUnicode(text);
    String converted = '';
    for (int i = 0; i < normalizedUnicodeText.length; i++) {
      String currentChar = normalizedUnicodeText[i];
      if (currentChar == '\ufeff') continue;
      try {
        String? mappedChar = _unicodePreetiMap[currentChar];
        if (mappedChar != null) {
          converted += mappedChar;
        } else {
          converted += currentChar;
        }
      } catch (err) {
        converted += currentChar;
      }
    }
    String finalString = converted;
    finalString = finalString.replaceAll("Si", "I");
    finalString = finalString.replaceAll("H`", "1");
    finalString = finalString.replaceAll("b\\\\w", "4");
    finalString = finalString.replaceAll("z|", ">");
    finalString = finalString.replaceAll("/'", "?");
    finalString = finalString.replaceAll("Tt", "Q");
    finalString = finalString.replaceAll("b\\\\lj", "lå");
    finalString = finalString.replaceAll("b\\\\\\j", "å");
    finalString = finalString.replaceAll("0f\\", "0");
    finalString = finalString.replaceAll("`\\", "~");
    finalString = finalString.replaceAllMapped(
        RegExp(r"(.)[l][|]"), (Match m) => "l${m[1]}|");
    finalString = finalString.replaceAllMapped(
        RegExp(r"[k][l][m][|]"), (Match m) => "lk|m");
    return finalString;
  }
}
