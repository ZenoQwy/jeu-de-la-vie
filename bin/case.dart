class Case {
  bool _estvivant;
  Case(this._estvivant);

  void changeetat() {
    this._estvivant = !_estvivant;
  }

  bool getetat() {
    return this._estvivant;
  }
}
