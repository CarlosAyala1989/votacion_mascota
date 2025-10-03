import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Votacion de Razas de Perros',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PantallaInicio(),
    );
  }
}

// Pantalla de inicio con opciones
class PantallaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Votacion de Razas de Perros')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaRegistro()),
                );
              },
              child: Text('Registrar Perro'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaVotacion()),
                );
              },
              child: Text('Ir a Votar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaGanadores()),
                );
              },
              child: Text('Ver Ganadores'),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla para registrar perros
class PantallaRegistro extends StatefulWidget {
  @override
  _PantallaRegistroState createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();

  String? _razaSeleccionada;
  XFile? _imagenSeleccionada;
  PlatformFile? _certificadoOriginalidad;
  PlatformFile? _certificadoPedigri;

  // Lista de razas de perros disponibles
  final List<String> _razas = [
    'Labrador Retriever',
    'Pastor Aleman',
    'Golden Retriever',
    'Bulldog Frances',
    'Bulldog Ingles',
    'Beagle',
    'Poodle',
    'Rottweiler',
    'Yorkshire Terrier',
    'Boxer',
    'Dachshund',
    'Siberian Husky',
    'Doberman',
    'Pitbull',
    'Shih Tzu',
    'Chihuahua',
    'Pomerania',
    'Border Collie',
    'Cocker Spaniel',
    'Schnauzer',
    'Gran Danes',
    'Dalmata',
    'Basset Hound',
    'San Bernardo',
    'Akita',
    'Chow Chow',
    'Mastiff',
    'Terranova',
    'Samoyedo',
    'Otros',
  ];

  // Seleccionar imagen del perro
  Future<void> _seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagen = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imagenSeleccionada = imagen;
    });
  }

  // Seleccionar certificado de originalidad
  Future<void> _seleccionarCertificadoOriginalidad() async {
    FilePickerResult? resultado = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );
    if (resultado != null) {
      setState(() {
        _certificadoOriginalidad = resultado.files.first;
      });
    }
  }

  // Seleccionar certificado de pedigri
  Future<void> _seleccionarCertificadoPedigri() async {
    FilePickerResult? resultado = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );
    if (resultado != null) {
      setState(() {
        _certificadoPedigri = resultado.files.first;
      });
    }
  }

  // Subir archivo a Firebase Storage
  Future<String> _subirArchivo(String ruta, dynamic archivo) async {
    final ref = FirebaseStorage.instance.ref().child(ruta);

    if (archivo is XFile) {
      await ref.putFile(File(archivo.path));
    } else if (archivo is PlatformFile) {
      await ref.putFile(File(archivo.path!));
    }

    return await ref.getDownloadURL();
  }

  // Guardar perro en Firebase Database
  Future<void> _guardarMascota() async {
    if (!_formKey.currentState!.validate()) return;
    if (_razaSeleccionada == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Selecciona una raza')));
      return;
    }
    if (_imagenSeleccionada == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Selecciona una imagen')));
      return;
    }

    try {
      // Mostrar indicador de carga
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      // Subir archivos
      String urlImagen = await _subirArchivo(
        'imagenes/${DateTime.now().millisecondsSinceEpoch}.jpg',
        _imagenSeleccionada,
      );

      String? urlCertOriginalidad;
      if (_certificadoOriginalidad != null) {
        urlCertOriginalidad = await _subirArchivo(
          'certificados/${DateTime.now().millisecondsSinceEpoch}_orig.${_certificadoOriginalidad!.extension}',
          _certificadoOriginalidad,
        );
      }

      String? urlCertPedigri;
      if (_certificadoPedigri != null) {
        urlCertPedigri = await _subirArchivo(
          'certificados/${DateTime.now().millisecondsSinceEpoch}_pedigri.${_certificadoPedigri!.extension}',
          _certificadoPedigri,
        );
      }

      // Guardar en database
      DatabaseReference ref = FirebaseDatabase.instance.ref('mascotas').push();
      await ref.set({
        'nombre': _nombreController.text,
        'peso': _pesoController.text,
        'raza': _razaSeleccionada,
        'url_imagen': urlImagen,
        'url_cert_originalidad': urlCertOriginalidad,
        'url_cert_pedigri': urlCertPedigri,
        'votos': 0,
        'fecha_registro': DateTime.now().toIso8601String(),
      });

      Navigator.pop(context); // Cerrar dialogo de carga
      Navigator.pop(context); // Volver a pantalla anterior

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Perro registrado exitosamente')));
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al registrar: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Perro')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo nombre
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre del perro',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa el nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Campo peso
              TextFormField(
                controller: _pesoController,
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa el peso';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Selector de raza
              DropdownButtonFormField<String>(
                value: _razaSeleccionada,
                decoration: InputDecoration(
                  labelText: 'Raza del Perro',
                  border: OutlineInputBorder(),
                ),
                items: _razas.map((raza) {
                  return DropdownMenuItem(value: raza, child: Text(raza));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _razaSeleccionada = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // Boton para seleccionar imagen
              ElevatedButton.icon(
                onPressed: _seleccionarImagen,
                icon: Icon(Icons.photo),
                label: Text(
                  _imagenSeleccionada == null
                      ? 'Seleccionar Foto'
                      : 'Foto seleccionada',
                ),
              ),
              SizedBox(height: 16),

              // Boton para certificado de originalidad
              ElevatedButton.icon(
                onPressed: _seleccionarCertificadoOriginalidad,
                icon: Icon(Icons.document_scanner),
                label: Text(
                  _certificadoOriginalidad == null
                      ? 'Certificado de Originalidad'
                      : 'Certificado de Originalidad seleccionado',
                ),
              ),
              SizedBox(height: 16),

              // Boton para certificado de pedigri
              ElevatedButton.icon(
                onPressed: _seleccionarCertificadoPedigri,
                icon: Icon(Icons.description),
                label: Text(
                  _certificadoPedigri == null
                      ? 'Certificado de Pedigri'
                      : 'Certificado de Pedigri seleccionado',
                ),
              ),
              SizedBox(height: 24),

              // Boton guardar
              ElevatedButton(
                onPressed: _guardarMascota,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Registrar Perro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pantalla para votar por perros
class PantallaVotacion extends StatefulWidget {
  @override
  _PantallaVotacionState createState() => _PantallaVotacionState();
}

class _PantallaVotacionState extends State<PantallaVotacion> {
  String? _razaSeleccionada;
  final List<String> _razas = [
    'Labrador Retriever',
    'Pastor Aleman',
    'Golden Retriever',
    'Bulldog Frances',
    'Bulldog Ingles',
    'Beagle',
    'Poodle',
    'Rottweiler',
    'Yorkshire Terrier',
    'Boxer',
    'Dachshund',
    'Siberian Husky',
    'Doberman',
    'Pitbull',
    'Shih Tzu',
    'Chihuahua',
    'Pomerania',
    'Border Collie',
    'Cocker Spaniel',
    'Schnauzer',
    'Gran Danes',
    'Dalmata',
    'Basset Hound',
    'San Bernardo',
    'Akita',
    'Chow Chow',
    'Mastiff',
    'Terranova',
    'Samoyedo',
    'Otros',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Votar por Perro')),
      body: Column(
        children: [
          // Selector de raza para filtrar
          Padding(
            padding: EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              value: _razaSeleccionada,
              decoration: InputDecoration(
                labelText: 'Selecciona una raza',
                border: OutlineInputBorder(),
              ),
              items: _razas.map((raza) {
                return DropdownMenuItem(value: raza, child: Text(raza));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _razaSeleccionada = value;
                });
              },
            ),
          ),

          // Lista de perros
          Expanded(
            child: _razaSeleccionada == null
                ? Center(child: Text('Selecciona una raza para ver perros'))
                : StreamBuilder(
                    stream: FirebaseDatabase.instance
                        .ref('mascotas')
                        .orderByChild('raza')
                        .equalTo(_razaSeleccionada)
                        .onValue,
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData ||
                          snapshot.data!.snapshot.value == null) {
                        return Center(
                          child: Text('No hay perros de esta raza'),
                        );
                      }

                      // Convertir datos a lista
                      Map<dynamic, dynamic> mascotas =
                          snapshot.data!.snapshot.value
                              as Map<dynamic, dynamic>;
                      List<MapEntry> listaMascotas = mascotas.entries.toList();

                      return ListView.builder(
                        itemCount: listaMascotas.length,
                        itemBuilder: (context, index) {
                          var mascotaEntry = listaMascotas[index];
                          var mascotaId = mascotaEntry.key;
                          var mascotaData = mascotaEntry.value;

                          return Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Column(
                              children: [
                                // Imagen del perro
                                Image.network(
                                  mascotaData['url_imagen'],
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mascotaData['nombre'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text('Peso: ${mascotaData['peso']} kg'),
                                      Text(
                                        'Votos actuales: ${mascotaData['votos']}',
                                      ),
                                      SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed: () => _votar(
                                          mascotaId,
                                          mascotaData['votos'],
                                        ),
                                        child: Text('Votar'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Incrementar voto de mascota
  Future<void> _votar(String mascotaId, int votosActuales) async {
    try {
      await FirebaseDatabase.instance
          .ref('mascotas/$mascotaId/votos')
          .set(votosActuales + 1);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Voto registrado')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al votar: $e')));
    }
  }
}

// Pantalla para ver ganadores por raza
class PantallaGanadores extends StatefulWidget {
  @override
  _PantallaGanadoresState createState() => _PantallaGanadoresState();
}

class _PantallaGanadoresState extends State<PantallaGanadores> {
  String? _razaSeleccionada;
  final List<String> _razas = [
    'Labrador Retriever',
    'Pastor Aleman',
    'Golden Retriever',
    'Bulldog Frances',
    'Bulldog Ingles',
    'Beagle',
    'Poodle',
    'Rottweiler',
    'Yorkshire Terrier',
    'Boxer',
    'Dachshund',
    'Siberian Husky',
    'Doberman',
    'Pitbull',
    'Shih Tzu',
    'Chihuahua',
    'Pomerania',
    'Border Collie',
    'Cocker Spaniel',
    'Schnauzer',
    'Gran Danes',
    'Dalmata',
    'Basset Hound',
    'San Bernardo',
    'Akita',
    'Chow Chow',
    'Mastiff',
    'Terranova',
    'Samoyedo',
    'Otros',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ganadores')),
      body: Column(
        children: [
          // Selector de raza
          Padding(
            padding: EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              value: _razaSeleccionada,
              decoration: InputDecoration(
                labelText: 'Selecciona una raza',
                border: OutlineInputBorder(),
              ),
              items: _razas.map((raza) {
                return DropdownMenuItem(value: raza, child: Text(raza));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _razaSeleccionada = value;
                });
              },
            ),
          ),

          // Mostrar ganador
          Expanded(
            child: _razaSeleccionada == null
                ? Center(child: Text('Selecciona una raza'))
                : StreamBuilder(
                    stream: FirebaseDatabase.instance
                        .ref('mascotas')
                        .orderByChild('raza')
                        .equalTo(_razaSeleccionada)
                        .onValue,
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData ||
                          snapshot.data!.snapshot.value == null) {
                        return Center(
                          child: Text('No hay perros de esta raza'),
                        );
                      }

                      // Convertir datos y encontrar el ganador
                      Map<dynamic, dynamic> mascotas =
                          snapshot.data!.snapshot.value
                              as Map<dynamic, dynamic>;

                      var ganador = mascotas.entries.reduce((a, b) {
                        int votosA = a.value['votos'] ?? 0;
                        int votosB = b.value['votos'] ?? 0;
                        return votosA > votosB ? a : b;
                      });

                      var ganadorData = ganador.value;

                      return Center(
                        child: Card(
                          margin: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'GANADOR',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: 16),
                              Image.network(
                                ganadorData['url_imagen'],
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      ganadorData['nombre'],
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text('Raza: ${ganadorData['raza']}'),
                                    Text('Peso: ${ganadorData['peso']} kg'),
                                    Text(
                                      'Total de votos: ${ganadorData['votos']}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
