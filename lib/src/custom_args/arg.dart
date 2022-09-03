class Arg {
  final String name;
  final String abbr;
  final String description;
  final bool negatable;
  final String? defaultValue;

  Arg(this.name, this.abbr, this.description,
      {this.negatable = false, this.defaultValue});
}
