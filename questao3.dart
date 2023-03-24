import 'dart:convert';
import 'dart:io';

Future<List<Map<String, dynamic>>> readJsonFile(String filePath) async {
  var input = await File(filePath).readAsString();
  return (jsonDecode(input) as List).cast<Map<String, dynamic>>();
}

class InvoicingModel {
  final int day;
  final double value;
  InvoicingModel({required this.day, required this.value});

  factory InvoicingModel.fromMap(map) {
    return InvoicingModel(
      day: map["dia"],
      value: map["valor"],
    );
  }
}

InvoicingModel min(List<InvoicingModel> listInvoicing) {
  final res = listInvoicing.reduce((a, b) {
    if (a.value != 0 && a.value < b.value)
      return a;
    else
      return b;
  });
  return res;
}

InvoicingModel max(List<InvoicingModel> listInvoicing) {
  final res = listInvoicing.reduce((a, b) {
    if (a.value > b.value)
      return a;
    else
      return b;
  });
  return res;
}

int aboveAverageQuantity(List<InvoicingModel> listInvoicing) {
  final total = listInvoicing.fold(0.0, (a, b) => a + b.value);
  final quantity = listInvoicing.where((e) => e.value > 0).length;
  final average = total / quantity;

  return listInvoicing.where((e) => e.value > average).length;
}

void main() async {
  final json = await readJsonFile('dados.json');
  final listInvoicing = json.map((e) => InvoicingModel.fromMap(e)).toList();

  final invoicingMin = min(listInvoicing);
  final invoicingMax = max(listInvoicing);

  print(
      "O menor valor de faturamento foi ${invoicingMin.value} e ocorreu dia ${invoicingMin.day}.");
  print(
      "O maior valor de faturamento foi ${invoicingMax.value} e ocorreu dia ${invoicingMin.day}.");
  print(
      "Número de dias no mês em que o valor de faturamento diário foi superior à média mensal: ${aboveAverageQuantity(listInvoicing)}.");
}
