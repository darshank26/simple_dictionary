class DictionaryModel {
  String? word;
  List<Phonetic>? phonetics;
  List<Meaning>? meanings;
  License? license;
  List<String>? sourceUrls;

  DictionaryModel({
    this.word,
    this.phonetics,
    this.meanings,
    this.license,
    this.sourceUrls,
  });

  factory DictionaryModel.fromJson(Map<String, dynamic> json) {
    return DictionaryModel(
      word: json['word'],
      phonetics: json['phonetics'] != null
          ? List<Phonetic>.from(json['phonetics'].map((x) => Phonetic.fromJson(x)))
          : null,
      meanings: json['meanings'] != null
          ? List<Meaning>.from(json['meanings'].map((x) => Meaning.fromJson(x)))
          : null,
      license: json['license'] != null ? License.fromJson(json['license']) : null,
      sourceUrls: json['sourceUrls'] != null
          ? List<String>.from(json['sourceUrls'].map((x) => x))
          : null,
    );
  }
}

class Phonetic {
  String? audio;
  String? text;
  String? sourceUrl;
  License? license;

  Phonetic({
    this.audio,
    this.text,
    this.sourceUrl,
    this.license,
  });

  factory Phonetic.fromJson(Map<String, dynamic> json) {
    return Phonetic(
      audio: json['audio'],
      text: json['text'],
      sourceUrl: json['sourceUrl'],
      license: json['license'] != null ? License.fromJson(json['license']) : null,
    );
  }
}

class License {
  String? name;
  String? url;

  License({
    this.name,
    this.url,
  });

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Meaning {
  String? partOfSpeech;
  List<DefinitionModel>? definitions;
  List<String>? synonyms;
  List<String>? antonyms;

  Meaning({
    this.partOfSpeech,
    this.definitions,
    this.synonyms,
    this.antonyms,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      partOfSpeech: json['partOfSpeech'],
      definitions: json['definitions'] != null
          ? List<DefinitionModel>.from(json['definitions'].map((x) => DefinitionModel.fromJson(x)))
          : null,
      synonyms: json['synonyms'] != null ? List<String>.from(json['synonyms'].map((x) => x)) : null,
      antonyms: json['antonyms'] != null ? List<String>.from(json['antonyms'].map((x) => x)) : null,
    );
  }
}

class DefinitionModel {
  String? definition;
  List<String>? synonyms;
  List<String>? antonyms;
  String? example;

  DefinitionModel({
    this.definition,
    this.synonyms,
    this.antonyms,
    this.example,
  });

  factory DefinitionModel.fromJson(Map<String, dynamic> json) {
    return DefinitionModel(
      definition: json['definition'],
      synonyms: json['synonyms'] != null ? List<String>.from(json['synonyms'].map((x) => x)) : null,
      antonyms: json['antonyms'] != null ? List<String>.from(json['antonyms'].map((x) => x)) : null,
      example: json['example'],
    );
  }
}
