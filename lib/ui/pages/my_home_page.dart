import 'package:flutter/material.dart';
import 'package:invoices_management_app/core/themes/app_colors.dart';
import 'package:invoices_management_app/ui/pages/invoice_preview_page.dart';
import 'package:invoices_management_app/ui/widgets/custom_button.dart';
import 'package:invoices_management_app/ui/widgets/custom_text_field.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientMailController = TextEditingController();
  TextEditingController invoiceDateController = TextEditingController();

  // articles list
  List<Map<String, dynamic>> articles = [];

  // global key to validate the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (context, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: const Text(
                      'Creer une Facture',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // client infos
                  // client name
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _myHeading('Nom du Client'),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: clientNameController,
                          hintText: 'Entrer le nom du client',
                          keyboardType: TextInputType.text,
                          validator:
                              (p0) =>
                                  (p0 == null || p0.isEmpty)
                                      ? 'Entrer un nom valide'
                                      : null,
                        ),

                        // client email
                        const SizedBox(height: 20),
                        _myHeading('Email du Client'),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: clientMailController,
                          hintText: 'Entrer l\'email du client',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Entrer un email valide';
                            }
                            return null;
                          },
                        ),
                        // invoice date
                        const SizedBox(height: 20),
                        _myHeading('Date de la Facture'),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: invoiceDateController,
                          hintText: 'YYYY-MM-DD',
                          keyboardType: TextInputType.datetime,
                          suffixIcon: Icons.calendar_today,
                          readOnly: true,
                          onSuffixIconPressed: () {
                            // pick a date
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            ).then((pickedDate) {
                              if (pickedDate != null) {
                                invoiceDateController.text =
                                    '${pickedDate.toLocal()}'.split(' ')[0];
                              }
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Entrer une date valide';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Colors.grey.shade300, thickness: 1),
                  const SizedBox(height: 20),
                  _myHeading('Articles'),
                  const SizedBox(height: 10),
                  // articles list
                  Center(
                    child: Column(
                      children: [
                        articles.isEmpty
                            ? const Text('Pas d\'articles ajoutés encore.')
                            : ListView.separated(
                              separatorBuilder:
                                  (context, index) => Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                              shrinkWrap: true,
                              itemCount: articles.length,
                              itemBuilder: (context, index) {
                                final article = articles[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade500,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Text(article['name']),
                                    subtitle: Text(
                                      'Prix: \$${article['price']} | Quantite: ${article['quantity']}',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        setState(() {
                                          articles.removeAt(index);
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                        const SizedBox(height: 10),
                        // add an arricle button
                        TextButton(
                          onPressed: () {
                            // show dialog to add an article
                            _showAddArticleDialog(context);
                          },
                          child: Text('+ Ajouter un Article'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Colors.grey.shade300, thickness: 1),
                  const SizedBox(height: 20),
                  // summary section
                  _myHeading('Résumé de la Facture'),
                  const SizedBox(height: 10),
                  // total HT & TVA 20% & total TTC
                  // ht
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total HT:'),
                      Text(
                        '\$${articles.fold(0, (sum, article) => sum + double.parse((article['price'] * article['quantity']).toString()).toInt())}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // tva
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('TVA 20%:'),
                      Text(
                        '\$${(articles.fold(0, (sum, article) => sum + double.parse((article['price'] * int.parse(article['quantity'].toString())).toString()).toInt())) * 0.2}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // total ttc
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total TTC:'),
                      Text(
                        '\$${(articles.fold(0, (sum, article) => sum + double.parse((article['price'] * int.parse(article['quantity'].toString())).toString()).toInt())) * 1.2}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 10,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (articles.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Veuillez ajouter au moins un article à la facture.',
                                    ),
                                  ),
                                );
                                return;
                              }
                              final totalHT =
                                  articles
                                      .fold(
                                        0,
                                        (sum, article) =>
                                            sum +
                                            double.parse(
                                              (article['price'] *
                                                      article['quantity'])
                                                  .toString(),
                                            ).toInt(),
                                      )
                                      .toDouble();

                              final totalTVA = (totalHT * 0.2).toDouble();
                              final totalTTC = (totalHT + totalTVA).toDouble();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => InvoicePreviewPage(
                                        clientName: clientMailController.text,
                                        clientEmail: clientMailController.text,
                                        invoiceDate: invoiceDateController.text,
                                        articles: articles,
                                        totalHT: totalHT,
                                        totalTVA: totalTVA,
                                        totalTTC: totalTTC,
                                      ),
                                ),
                              );
                            }
                          },
                          label: 'Aperçu',
                          icon: Icons.visibility_outlined,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submitInvoice(context);
                            }
                          },
                          label: 'Soumettre',
                          icon: Icons.send_outlined,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
    );
  }

  void _submitInvoice(BuildContext context) {
    // clear all fields

    clientNameController.clear();
    clientMailController.clear();
    invoiceDateController.clear();
    articles.clear();
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('La facture a été soumise avec succès !')),
    );
  }

  Future<dynamic> _showAddArticleDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        TextEditingController articleNameController = TextEditingController();
        TextEditingController articlePriceController = TextEditingController();
        TextEditingController articleQntyController = TextEditingController();

        // key for validating the form
        final GlobalKey<FormState> articleFormKey = GlobalKey<FormState>();

        return AlertDialog(
          title: const Text('Ajouter un Article'),
          content: Form(
            key: articleFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: articleNameController,
                  hintText: 'Nom de l\'Article',
                  keyboardType: TextInputType.text,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Entrer un nom d\'article valide';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: articlePriceController,
                  hintText: 'Prix de l\'Article',
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Entrer un prix d\'article valide';
                    }
                    if (double.tryParse(p0) == null) {
                      return 'Enter un prix valide';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: articleQntyController,
                  hintText: 'Quantité de l\'Article',
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Entrer une quantité valide';
                    }
                    if (double.tryParse(p0) == null) {
                      return 'Entrer un numero de quantité valide';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (articleFormKey.currentState!.validate()) {
                  if (articleNameController.text.isNotEmpty &&
                      articlePriceController.text.isNotEmpty &&
                      articleQntyController.text.isNotEmpty) {
                    setState(() {
                      articles.add({
                        'name': articleNameController.text,
                        'quantity': int.parse(
                          articleQntyController.text,
                        ), // default quantity
                        'price': double.parse(articlePriceController.text),
                      });
                    });
                    Navigator.of(context).pop();
                  }
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  Text _myHeading(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clientNameController.dispose();
    clientMailController.dispose();
    invoiceDateController.dispose();
  }
}
