import 'dart:io';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'PdfPreviewScreen.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Sales Gaji ID",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  sendMail() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;
    File file = File("$documentPath/SalesGaji.pdf");
    String username = 'suwandistefanuss@gmail.com';
    String password = '123suwandistefanus123';

    final smtpServer = gmail(username, password);

    final message = Message()
          ..from = Address(username, 'Stefanus Suwandi')
          ..recipients.add(emailsales.text)
          //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
          //..bccRecipients.add(Address('bccAddress@example.com'))
          ..attachments.add(FileAttachment(file))
          ..subject = 'Soal Test Aplikasi Flutter  ${DateTime.now()}'
        //..text = 'This is the plain text.\nThis is line 2 of the text part.'
        //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
        ;
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      Alert(
              context: context,
              title: "Email berhasil terkirim",
              type: AlertType.success)
          .show();
    } on MailerException catch (e) {
      print('Message not sent.');
      Alert(
              context: context,
              title: "Email gagal terkirim",
              type: AlertType.error)
          .show();
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    var connection = PersistentConnection(smtpServer);

    await connection.send(message);

    await connection.close();
  }

  final pdf = pw.Document();

  int _totalemployee = 0;
  int _harga = 0;
  int hargaatraining = 0;
  int hargaaimplementasi = 0;
  int hargaamodifikasi = 0;
  TextEditingController nomor = new TextEditingController();
  TextEditingController tanggal = new TextEditingController();
  TextEditingController namapt = new TextEditingController();
  TextEditingController npwp = new TextEditingController();
  TextEditingController picuser = new TextEditingController();
  TextEditingController billingpic = new TextEditingController();
  TextEditingController picposition = new TextEditingController();
  TextEditingController billingaddress = new TextEditingController();
  TextEditingController contact = new TextEditingController();
  TextEditingController billingcontact = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController billingemail = new TextEditingController();
  TextEditingController totalemployee = new TextEditingController();
  TextEditingController harga = new TextEditingController();
  TextEditingController diskon = new TextEditingController();
  TextEditingController hargaperkaryawan = new TextEditingController();
  TextEditingController ket1 = new TextEditingController();
  TextEditingController setelahdiskon = new TextEditingController();
  TextEditingController hargatraining = new TextEditingController();
  TextEditingController totalhargatraining = new TextEditingController();
  TextEditingController diskontraining = new TextEditingController();
  TextEditingController ket2 = new TextEditingController();
  TextEditingController hargaimplementasi = new TextEditingController();
  TextEditingController totalhargaimplementasi = new TextEditingController();
  TextEditingController diskonimplementasi = new TextEditingController();
  TextEditingController ket3 = new TextEditingController();
  TextEditingController hargamodifikasi = new TextEditingController();
  TextEditingController totalhargamodifikasi = new TextEditingController();
  TextEditingController diskonmodifikasi = new TextEditingController();
  TextEditingController ket4 = new TextEditingController();
  TextEditingController emailsales = new TextEditingController();

  writeOnPdf() {
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32.0),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(
              level: 0,
              child: pw.Text("Sales Gaji ID Document"),
            ),
            pw.Paragraph(text: "Nomor : " + nomor.text),
            pw.Paragraph(text: "Tanggal : " + tanggal.text),
            pw.Paragraph(text: "Nama PT : " + namapt.text),
            pw.Paragraph(text: "NPWP : " + npwp.text),
            pw.SizedBox(height: 25.0),
            pw.Paragraph(text: "PIC User : " + picuser.text),
            pw.Paragraph(text: "Billing PIC : " + billingpic.text),
            pw.Paragraph(text: "PIC Position : " + picposition.text),
            pw.Paragraph(text: "Billing Address : " + billingaddress.text),
            pw.Paragraph(text: "Contact : " + contact.text),
            pw.Paragraph(text: "Billing Contact : " + billingcontact.text),
            pw.Paragraph(text: "Email : " + email.text),
            pw.Paragraph(text: "Billing Email : " + billingemail.text),
            pw.SizedBox(height: 25.0),
            pw.Paragraph(text: "Total Employee : " + totalemployee.text),
            pw.Paragraph(text: "Harga : Rp" + harga.text),
            pw.Paragraph(text: "Diskon : " + hargaperkaryawan.text + "%"),
            pw.Paragraph(text: "Keterangan 1 : " + ket1.text),
            pw.Paragraph(text: "Setelah Diskon : Rp" + setelahdiskon.text),
            pw.SizedBox(height: 25.0),
            pw.Paragraph(text: "Harga Training : Rp" + hargatraining.text),
            pw.Paragraph(
                text: "Total Harga Training : Rp" + totalhargatraining.text),
            pw.Paragraph(
                text: "Diskon Training : " + diskontraining.text + "%"),
            pw.Paragraph(text: "Keterangan 2 : " + ket2.text),
            pw.SizedBox(height: 25.0),
            pw.Paragraph(
                text: "Harga Implementasi : Rp" + hargaimplementasi.text),
            pw.Paragraph(
                text: "Total Harga Implementasi : Rp" +
                    totalhargaimplementasi.text),
            pw.Paragraph(
                text: "Diskon Implementasi : " + diskonimplementasi.text + "%"),
            pw.Paragraph(text: "Keterangan 3 : " + ket3.text),
            pw.SizedBox(height: 25.0),
            pw.Paragraph(text: "Harga Modifikasi : Rp" + hargamodifikasi.text),
            pw.Paragraph(
                text:
                    "Total Harga Modifikasi : Rp" + totalhargamodifikasi.text),
            pw.Paragraph(
                text: "Diskon Modifikasi : " + diskonmodifikasi.text + "%"),
            pw.Paragraph(text: "Keterangan 4 : " + ket4.text),
            pw.SizedBox(height: 25.0),
            pw.Paragraph(text: "Email Sales : " + emailsales.text),
          ];
        }));
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/SalesGaji.pdf");
    file.writeAsBytesSync(pdf.save());
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Gaji ID"),
      ),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(padding: EdgeInsets.only(bottom: 8.0)),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: nomor,
                    decoration: new InputDecoration(
                      hintText: "Input Nomor",
                      labelText: "Nomor",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: tanggal,
                    keyboardType: TextInputType.datetime,
                    decoration: new InputDecoration(
                      hintText: "Input Tanggal",
                      labelText: "Tanggal",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: namapt,
                    decoration: new InputDecoration(
                      hintText: "Input Nama PT",
                      labelText: "Nama PT",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: npwp,
                    decoration: new InputDecoration(
                      hintText: "Input NPWP",
                      labelText: "NPWP",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(bottom: 25.0)),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 2.0,
                  childAspectRatio: 3),
              delegate: SliverChildListDelegate(
                [
                  TextFormField(
                    controller: picuser,
                    decoration: new InputDecoration(
                      hintText: "Input PIC User",
                      labelText: "PIC User",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    controller: billingpic,
                    decoration: new InputDecoration(
                      hintText: "Input Billing PIC",
                      labelText: "Billing PIC",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    controller: picposition,
                    decoration: new InputDecoration(
                      hintText: "Input PIC Position",
                      labelText: "PIC Position",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    controller: billingaddress,
                    decoration: new InputDecoration(
                      hintText: "Input Billing Address",
                      labelText: "Billing Address",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    controller: contact,
                    decoration: new InputDecoration(
                      hintText: "Input Contact",
                      labelText: "Contact",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    controller: billingcontact,
                    decoration: new InputDecoration(
                      hintText: "Input Billing Contact",
                      labelText: "Billing Contact",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    decoration: new InputDecoration(
                      hintText: "Input Email",
                      labelText: "Email",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    controller: billingemail,
                    decoration: new InputDecoration(
                      hintText: "Input Billing Email",
                      labelText: "Billing Email",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(bottom: 25.0)),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 2.0,
                  childAspectRatio: 3),
              delegate: SliverChildListDelegate(
                [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: totalemployee,
                    onFieldSubmitted: (value) {
                      _totalemployee = int.parse(value);
                      _totalemployee == 25
                          ? _harga = 500000
                          : _totalemployee < 50
                              ? _harga = 20000 * _totalemployee
                              : _totalemployee < 200
                                  ? _harga = 18000 * _totalemployee
                                  : _totalemployee < 350
                                      ? _harga = 15000 * _totalemployee
                                      : _totalemployee < 500
                                          ? _harga = 8500 * _totalemployee
                                          : _totalemployee < 1000
                                              ? _harga = 7000 * _totalemployee
                                              : _harga = 5500 * _totalemployee;

                      //print(_harga.toString());
                      harga.text = _harga.toString();
                      hargaperkaryawan.text =
                          (_harga / _totalemployee).toString();
                      //return value = _harga.toString();
                    },
                    decoration: new InputDecoration(
                      hintText: "Input Total Employee",
                      labelText: "Total Employee",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    controller: harga,
                    enabled: false,
                    decoration: new InputDecoration(
                      hintText: "Input Harga",
                      labelText: "Harga",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    controller: diskon,
                    onFieldSubmitted: (value) {
                      int disc = int.parse(value);
                      setelahdiskon.text =
                          (_harga - (_harga * (disc / 100))).toString();
                    },
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      hintText: "Input Diskon",
                      labelText: "Diskon",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    enabled: false,
                    controller: hargaperkaryawan,
                    decoration: new InputDecoration(
                      hintText: "Input Harga Per Karyawan",
                      labelText: "Harga Per Karyawan",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    controller: ket1,
                    decoration: new InputDecoration(
                      hintText: "Input Keterangan 1",
                      labelText: "Keterangan 1",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    controller: setelahdiskon,
                    decoration: new InputDecoration(
                      enabled: false,
                      hintText: "Input Setelah DIskon",
                      labelText: "Setelah Diskon",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(bottom: 25.0)),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 2.0,
                  childAspectRatio: 3),
              delegate: SliverChildListDelegate(
                [
                  TextFormField(
                    controller: hargatraining,
                    onFieldSubmitted: (value) {
                      hargaatraining = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      hintText: "Input Harga Training",
                      labelText: "Harga Training",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    enabled: false,
                    controller: totalhargatraining,
                    decoration: new InputDecoration(
                      hintText: "Input Total Harga Training",
                      labelText: "Total Harga Training",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: diskontraining,
                    onFieldSubmitted: (value) {
                      int diskontraining = int.parse(value);
                      totalhargatraining.text = (hargaatraining -
                              (hargaatraining * (diskontraining / 100)))
                          .toString();
                    },
                    decoration: new InputDecoration(
                      hintText: "Input Diskon Training",
                      labelText: "Diskon Training",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: ket2,
                    decoration: new InputDecoration(
                      hintText: "Input Keterangan 2",
                      labelText: "Keterangan 2",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(bottom: 25.0)),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 2.0,
                  childAspectRatio: 3),
              delegate: SliverChildListDelegate(
                [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: hargaimplementasi,
                    onFieldSubmitted: (value) {
                      hargaaimplementasi = int.parse(value);
                    },
                    decoration: new InputDecoration(
                      hintText: "Input Harga Implementasi",
                      labelText: "Harga Implementasi",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    controller: totalhargaimplementasi,
                    decoration: new InputDecoration(
                      enabled: false,
                      hintText: "Input Total Harga Implementasi",
                      labelText: "Total Harga Implementasi",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: diskonimplementasi,
                    onFieldSubmitted: (value) {
                      int disk = int.parse(value);
                      totalhargaimplementasi.text = (hargaaimplementasi -
                              (hargaaimplementasi * (disk / 100)))
                          .toString();
                    },
                    decoration: new InputDecoration(
                      hintText: "Input Diskon Implementasi",
                      labelText: "Diskon Implementasi",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: ket3,
                    decoration: new InputDecoration(
                      hintText: "Input Keterangan 3",
                      labelText: "Keterangan 3",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(bottom: 25.0)),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 2.0,
                  childAspectRatio: 3),
              delegate: SliverChildListDelegate(
                [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: hargamodifikasi,
                    onFieldSubmitted: (value) {
                      hargaamodifikasi = int.parse(value);
                    },
                    decoration: new InputDecoration(
                      hintText: "Input Harga Modifikasi",
                      labelText: "Harga Modifikasi",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  TextFormField(
                    enabled: false,
                    controller: totalhargamodifikasi,
                    decoration: new InputDecoration(
                      hintText: "Input Total Harga Modifikasi",
                      labelText: "Total Harga Modifikasi",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: diskonmodifikasi,
                    onFieldSubmitted: (value) {
                      int disk = int.parse(value);
                      totalhargamodifikasi.text =
                          (hargaamodifikasi - (hargaamodifikasi * (disk / 100)))
                              .toString();
                    },
                    decoration: new InputDecoration(
                      hintText: "Input Diskon Modifikasi",
                      labelText: "Diskon Modifikasi",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: ket4,
                    decoration: new InputDecoration(
                      hintText: "Input Keterangan 4",
                      labelText: "Keterangan 4",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(bottom: 50.0)),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailsales,
                    decoration: new InputDecoration(
                      hintText: "Input Email Sales",
                      labelText: "Email Sales",
                      //icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(bottom: 150.0)),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Stack(
          children: [
            Row(
              children: [
                RaisedButton(
                  onPressed: () async {
                    writeOnPdf();
                    await savePdf();
                    sendMail();
                  },
                  child: Text('Generate (Inggris)'),
                ),
                SizedBox(
                  width: 45.0,
                ),
                RaisedButton(
                  onPressed: () async {
                    writeOnPdf();
                    await savePdf();
                    sendMail();
                  },
                  child: Text('Generate (Indonesia)'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
