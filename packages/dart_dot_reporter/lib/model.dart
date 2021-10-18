enum State {
  success,
  skipped,
  failure,
}

class TestModel {
  int? id;
  final String name;
  final String filename;
  String? message;
  State? state;

  TestModel(this.name, this.filename);

  @override
  bool operator ==(dynamic other) {
    if (other is TestModel) {
      return id == other.id &&
          name == other.name &&
          message == other.message &&
          state == other.state &&
          filename == other.filename;
    }
    return false;
  }

  @override
  String toString() {
    return 'TestModel { $id $state $name $message $filename}';
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ message.hashCode ^ state.hashCode ^ filename.hashCode;
}
