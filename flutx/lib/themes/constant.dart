class FxConstantData {
  final double containerRadius;
  final double cardRadius;
  final double buttonRadius;

  FxConstantData({this.containerRadius = 8, this.cardRadius = 8, this.buttonRadius=8});
}

class FxConstant {
  static FxConstantData constant = FxConstantData();

  static setConstant(FxConstantData constantData) {
    constant = constantData;
  }
}
