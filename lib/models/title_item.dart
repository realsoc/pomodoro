import 'package:uuid/uuid.dart';

class TitleItem {
  final String id;
  final String title;

  TitleItem(this.title, {id}) : this.id = id != null ? id : Uuid().v1();

  @override
  bool operator ==(other) {
    return other is TitleItem && id == other.id;
  }
  @override
  int get hashCode => id.hashCode;
}