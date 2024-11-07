///
///
///
enum ProfileType {
  child,
  parent;



  ///
  ///
  ///
  static ProfileType fromString(final String type) {
    switch (type.toLowerCase()) {
      case 'child':
        return ProfileType.child;
      case 'parent':
        return ProfileType.parent;
      default:
        return ProfileType.child;
    }
  }
}
