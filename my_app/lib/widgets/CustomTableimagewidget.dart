class CustomTableImageWidget extends chairBox {
  final String label;
  final String imagePath;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const CustomTableImageWidget({
    Key? key,
    required this.label,
    required this.imagePath,
    this.width = 60,
    this.height = 60,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            imagePath,
            width: width,
            height: height,
            fit: BoxFit.contain,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: [
                Shadow(
                  blurRadius: 2,
                  color: Colors.white,
                  offset: Offset(1, 1),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
