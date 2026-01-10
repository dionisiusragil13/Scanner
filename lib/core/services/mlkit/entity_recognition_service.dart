abstract class EntityRecognitionService {
  Future<List<RecognizedEntity>> extract(String text);
}

class RecognizedEntity {
  final String type;
  final String value;

  RecognizedEntity({
    required this.type,
    required this.value,
  });
}
