import 'package:flutter/material.dart';

class InvoicePreviewPage extends StatelessWidget {
  const InvoicePreviewPage({
    super.key,
    required this.clientName,
    required this.clientEmail,
    required this.invoiceDate,
    required this.articles,
    required this.totalHT,
    required this.totalTVA,
    required this.totalTTC,
  });

  final String clientName;
  final String clientEmail;
  final String invoiceDate;

  // articles
  final List<Map<String, dynamic>> articles;
  final double totalHT;
  final double totalTVA;
  final double totalTTC;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aperçu de la Facture')),
      body: LayoutBuilder(
        builder:
            (context, constraints) => Container(
              padding: const EdgeInsets.all(20),
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // client info
                  _myHeading('Les Informations du Client'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.person, size: 50),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            clientName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            clientEmail,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // invoice date
                  _myHeading('Date de la Facture'),
                  const SizedBox(height: 10),
                  Text(
                    invoiceDate,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 20),
                  // articles
                  _myHeading('Articles'),
                  const SizedBox(height: 10),
                  articles.isEmpty
                      ? Text(
                        'No articles added yet.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      )
                      : Expanded(
                        child: ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final article = articles[index];
                            return ListTile(
                              title: Text(
                                article['name'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Prix: ${article['price']} - Quantite: ${article['quantity']}',
                              ),
                              trailing: Text(
                                'Total: \$${article['price'] * article['quantity']}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      ),
                  const SizedBox(height: 20),
                  // totals & total ttc & total tva
                  _myHeading('Totaux'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total HT:', style: TextStyle(fontSize: 16)),
                      Text(
                        '$totalHT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total TVA:', style: TextStyle(fontSize: 16)),
                      Text(
                        '$totalTVA',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total TTC:', style: TextStyle(fontSize: 16)),
                      Text(
                        '$totalTTC',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
      ),
    );
  }

  Text _myHeading(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
