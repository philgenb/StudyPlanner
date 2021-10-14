class InputFieldWrapper {

  String? _inputTitle;
  int? _inputValue;

  InputFieldWrapper() {
    _inputTitle = "";
    _inputValue = 0;
  }

  String getInputTitle() {
    return _inputTitle!;
  }

  int getInputValue() {
    return _inputValue!;
  }

  setInputTitle(String newTitle) {
    this._inputTitle = newTitle;
  }

  setInputValue(int newValue) {
    this._inputValue = newValue;
  }

}