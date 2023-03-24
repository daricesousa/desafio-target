enum State {
  SP,RJ,MG,ES,Outros;

  double invoicing(){
    if(this.name == 'SP') return 67836.43;
    if(this.name == 'RJ') return 36678.66;
    if(this.name == 'MG') return 29229.88;
    if(this.name == 'ES') return 27165.48;
    if(this.name == 'outros') return 19849.53;
    return 0;
  }
}

double percentage (State state) {
  final sum = State.values.fold(0.0, (p, e) => p + e.invoicing());
  return state.invoicing() / sum * 100;
}

void main(){
  State.values.forEach((e) {
    print("${e.name}: ${percentage(e).toStringAsFixed(2)} \%");
  });
}