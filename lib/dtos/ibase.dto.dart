abstract class IBaseDto<T> {
  T copyWith();

  Map toJSON();
}
