enum Addressing {
  // Anh
  mr,
  // Chị
  miss,
}

extension AddressingExt on Addressing {
  String toText() {
    switch (this) {
      case Addressing.mr:
        return "Anh";
      case Addressing.miss:
        return "Chị";
      default:
        throw Exception('Not Defining');
    }
  }
}
