part of app_res;

extension ShapeDecorationExtension on Shape {
  Decoration decoration(double height) {
    switch (this) {
      case Shape.square:
        return BoxDecoration(color: AppColors.secondaryColor);
      case Shape.roundedSquare:
        return BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(height / 7),
        );
      case Shape.circle:
        return BoxDecoration(
          color: AppColors.tertiaryColor,
          borderRadius: BorderRadius.circular(height),
          // shape: BoxShape.circle,
        );
      default:
        return BoxDecoration(
          color: AppColors.primaryColor,
        );
    }
  }
}