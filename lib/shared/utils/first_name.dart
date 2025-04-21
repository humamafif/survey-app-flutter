String firstName(String name) {
  if (name.isEmpty) {
    return "User";
  } else {
    return name.split(" ").first;
  }
}
