class OnboardStep {
  final String title;
  final String image;
  final List<String> options;
  final bool isDoubleColumn;

  OnboardStep({
    required this.title,
    required this.image,
    required this.options,
    this.isDoubleColumn = false,
  });
}
