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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Colores inspirados en marcas de vaca
        primaryColor: Color(0xFF6B4423), // Cafe oscuro
        scaffoldBackgroundColor: Color(0xFFFFF8F0), // Blanco cremoso
        colorScheme: ColorScheme.light(
          primary: Color(0xFF6B4423), // Cafe oscuro
          secondary: Color(0xFF8B5A3C), // Cafe medio
          surface: Colors.white,
          background: Color(0xFFFFF8F0),
        ),
        // AppBar con estilo minimalista
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF6B4423),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        // Botones con estilo de manchas de vaca
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF6B4423),
            foregroundColor: Colors.white,
            elevation: 2,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        // Cards con estilo minimalista
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 3,
          shadowColor: Color(0xFF6B4423).withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Color(0xFF6B4423).withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        // Inputs con estilo cafe
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF8B5A3C)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF8B5A3C).withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF6B4423), width: 2),
          ),
          labelStyle: TextStyle(color: Color(0xFF6B4423)),
        ),
      ),
      home: PantallaInicio(),
    );
  }
}

// Pantalla de inicio con opciones - Diseno de manchas de vaca
class PantallaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VOTACION DE PERROS'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6B4423), Color(0xFF8B5A3C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          // Fondo con patron de manchas sutiles
          color: Color(0xFFFFF8F0),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono decorativo con manchas de vaca
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6B4423).withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(Icons.pets, size: 60, color: Color(0xFF6B4423)),
                ),
                SizedBox(height: 40),

                // Titulo principal
                Text(
                  'Concurso Canino',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B4423),
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Vota por tu raza favorita',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF8B5A3C),
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 50),

                // Boton Registrar con mancha de vaca
                _buildMenuButton(
                  context,
                  icon: Icons.add_photo_alternate,
                  label: 'Registrar Perro',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaRegistro(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),

                // Boton Votar
                _buildMenuButton(
                  context,
                  icon: Icons.how_to_vote,
                  label: 'Ir a Votar',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaVotacion(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),

                // Boton Ganadores
                _buildMenuButton(
                  context,
                  icon: Icons.emoji_events,
                  label: 'Ver Ganadores',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaGanadores(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para botones del menu principal con estilo de manchas
  Widget _buildMenuButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 400),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF6B4423),
          elevation: 4,
          shadowColor: Color(0xFF6B4423).withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Color(0xFF6B4423).withOpacity(0.3),
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF6B4423),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
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

  // Subir archivo a Firebase Storage con mejor manejo de errores
  Future<String> _subirArchivo(String ruta, dynamic archivo) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(ruta);

      if (archivo is XFile) {
        final file = File(archivo.path);
        if (!await file.exists()) {
          throw Exception('El archivo no existe');
        }
        await ref.putFile(file);
      } else if (archivo is PlatformFile) {
        if (archivo.path == null) {
          throw Exception('Ruta del archivo no valida');
        }
        final file = File(archivo.path!);
        if (!await file.exists()) {
          throw Exception('El archivo no existe');
        }
        await ref.putFile(file);
      }

      return await ref.getDownloadURL();
    } catch (e) {
      print('Error al subir archivo: $e');
      throw Exception('Error al subir archivo: $e');
    }
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
        builder: (context) =>
            Center(child: CircularProgressIndicator(color: Color(0xFF6B4423))),
      );

      // Subir imagen principal
      String urlImagen = '';
      try {
        urlImagen = await _subirArchivo(
          'imagenes/${DateTime.now().millisecondsSinceEpoch}.jpg',
          _imagenSeleccionada,
        );
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error al subir la imagen. Verifica tu conexion y Firebase Storage',
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
        return;
      }

      // Subir certificados (opcionales)
      String? urlCertOriginalidad;
      if (_certificadoOriginalidad != null) {
        try {
          urlCertOriginalidad = await _subirArchivo(
            'certificados/${DateTime.now().millisecondsSinceEpoch}_orig.${_certificadoOriginalidad!.extension}',
            _certificadoOriginalidad,
          );
        } catch (e) {
          print('Error al subir certificado de originalidad: $e');
          // Continuar sin el certificado
        }
      }

      String? urlCertPedigri;
      if (_certificadoPedigri != null) {
        try {
          urlCertPedigri = await _subirArchivo(
            'certificados/${DateTime.now().millisecondsSinceEpoch}_pedigri.${_certificadoPedigri!.extension}',
            _certificadoPedigri,
          );
        } catch (e) {
          print('Error al subir certificado de pedigri: $e');
          // Continuar sin el certificado
        }
      }

      // Guardar en database
      print('Intentando guardar en Firebase Database...');
      print('Nombre: ${_nombreController.text}');
      print('Peso: ${_pesoController.text}');
      print('Raza: $_razaSeleccionada');
      print('URL Imagen: $urlImagen');

      DatabaseReference ref = FirebaseDatabase.instance.ref('mascotas').push();

      Map<String, dynamic> datosPerro = {
        'nombre': _nombreController.text.trim(),
        'peso': _pesoController.text.trim(),
        'raza': _razaSeleccionada ?? '',
        'url_imagen': urlImagen,
        'url_cert_originalidad': urlCertOriginalidad ?? '',
        'url_cert_pedigri': urlCertPedigri ?? '',
        'votos': 0,
        'fecha_registro': DateTime.now().toIso8601String(),
      };

      print('Datos a guardar: $datosPerro');

      await ref.set(datosPerro);

      print('Datos guardados exitosamente en Firebase Database');

      Navigator.pop(context); // Cerrar dialogo de carga
      Navigator.pop(context); // Volver a pantalla anterior

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Perro registrado exitosamente'),
          backgroundColor: Color(0xFF6B4423),
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      print('Error completo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al registrar: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTRAR PERRO'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6B4423), Color(0xFF8B5A3C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFFFF8F0),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Titulo de seccion
                _buildSectionTitle('Informacion del Perro'),
                SizedBox(height: 16),

                // Campo nombre
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del perro',
                    prefixIcon: Icon(Icons.pets, color: Color(0xFF6B4423)),
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
                    prefixIcon: Icon(
                      Icons.monitor_weight,
                      color: Color(0xFF6B4423),
                    ),
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
                    prefixIcon: Icon(Icons.category, color: Color(0xFF6B4423)),
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
                SizedBox(height: 24),

                // Titulo de archivos
                _buildSectionTitle('Archivos del Perro'),
                SizedBox(height: 16),

                // Boton para seleccionar imagen
                _buildFileButton(
                  icon: Icons.photo_camera,
                  label: _imagenSeleccionada == null
                      ? 'Seleccionar Foto'
                      : 'Foto seleccionada',
                  isSelected: _imagenSeleccionada != null,
                  onPressed: _seleccionarImagen,
                ),
                SizedBox(height: 12),

                // Boton para certificado de originalidad
                _buildFileButton(
                  icon: Icons.verified,
                  label: _certificadoOriginalidad == null
                      ? 'Certificado de Originalidad (Opcional)'
                      : 'Certificado de Originalidad',
                  isSelected: _certificadoOriginalidad != null,
                  onPressed: _seleccionarCertificadoOriginalidad,
                ),
                SizedBox(height: 12),

                // Boton para certificado de pedigri
                _buildFileButton(
                  icon: Icons.description,
                  label: _certificadoPedigri == null
                      ? 'Certificado de Pedigri (Opcional)'
                      : 'Certificado de Pedigri',
                  isSelected: _certificadoPedigri != null,
                  onPressed: _seleccionarCertificadoPedigri,
                ),
                SizedBox(height: 32),

                // Boton guardar con estilo destacado
                Container(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _guardarMascota,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6B4423),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save, size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Registrar Perro',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para titulos de seccion
  Widget _buildSectionTitle(String title) {
    return Container(
      padding: EdgeInsets.only(left: 4, bottom: 8),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: Color(0xFF6B4423), width: 4)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 12),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6B4423),
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  // Widget para botones de archivo
  Widget _buildFileButton({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? Color(0xFF6B4423)
              : Color(0xFF8B5A3C).withOpacity(0.3),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF6B4423).withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(0xFF6B4423)
                        : Color(0xFF8B5A3C).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : Color(0xFF6B4423),
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: Color(0xFF6B4423),
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, color: Color(0xFF6B4423), size: 24),
              ],
            ),
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
      appBar: AppBar(
        title: Text('VOTAR POR PERRO'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6B4423), Color(0xFF8B5A3C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFFFF8F0),
        child: Column(
          children: [
            // Selector de raza para filtrar con estilo
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF6B4423).withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: DropdownButtonFormField<String>(
                  value: _razaSeleccionada,
                  decoration: InputDecoration(
                    labelText: 'Selecciona una raza',
                    prefixIcon: Icon(
                      Icons.filter_list,
                      color: Color(0xFF6B4423),
                    ),
                    border: InputBorder.none,
                    filled: false,
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
            ),

            // Lista de perros
            Expanded(
              child: _razaSeleccionada == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pets,
                            size: 80,
                            color: Color(0xFF8B5A3C).withOpacity(0.3),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Selecciona una raza\npara ver perros',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF8B5A3C),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    )
                  : StreamBuilder(
                      stream: FirebaseDatabase.instance
                          .ref('mascotas')
                          .orderByChild('raza')
                          .equalTo(_razaSeleccionada)
                          .onValue,
                      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF6B4423),
                            ),
                          );
                        }

                        if (!snapshot.hasData ||
                            snapshot.data!.snapshot.value == null) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 80,
                                  color: Color(0xFF8B5A3C).withOpacity(0.3),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No hay perros de esta raza',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF8B5A3C),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // Convertir datos a lista
                        Map<dynamic, dynamic> mascotas =
                            snapshot.data!.snapshot.value
                                as Map<dynamic, dynamic>;
                        List<MapEntry> listaMascotas = mascotas.entries
                            .toList();

                        return ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          itemCount: listaMascotas.length,
                          itemBuilder: (context, index) {
                            var mascotaEntry = listaMascotas[index];
                            var mascotaId = mascotaEntry.key;
                            var mascotaData = mascotaEntry.value;

                            return Card(
                              margin: EdgeInsets.only(bottom: 16),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Imagen del perro con esquinas redondeadas
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                    child: Image.network(
                                      mascotaData['url_imagen'],
                                      height: 220,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  // Informacion del perro
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Nombre del perro
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.pets,
                                              color: Color(0xFF6B4423),
                                              size: 24,
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                mascotaData['nombre'],
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF6B4423),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12),

                                        // Detalles en fila
                                        Row(
                                          children: [
                                            _buildInfoChip(
                                              Icons.monitor_weight,
                                              '${mascotaData['peso']} kg',
                                            ),
                                            SizedBox(width: 12),
                                            _buildInfoChip(
                                              Icons.how_to_vote,
                                              '${mascotaData['votos']} votos',
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16),

                                        // Boton de votar destacado
                                        SizedBox(
                                          width: double.infinity,
                                          height: 48,
                                          child: ElevatedButton(
                                            onPressed: () => _votar(
                                              mascotaId,
                                              mascotaData['votos'],
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(
                                                0xFF6B4423,
                                              ),
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              elevation: 2,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.thumb_up, size: 20),
                                                SizedBox(width: 8),
                                                Text(
                                                  'VOTAR',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
      ),
    );
  }

  // Widget para chips de informacion
  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFFFF8F0),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF8B5A3C).withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Color(0xFF6B4423)),
          SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B4423),
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
      appBar: AppBar(
        title: Text('GANADORES'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6B4423), Color(0xFF8B5A3C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFFFF8F0),
        child: Column(
          children: [
            // Selector de raza con estilo
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF6B4423).withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: DropdownButtonFormField<String>(
                  value: _razaSeleccionada,
                  decoration: InputDecoration(
                    labelText: 'Selecciona una raza',
                    prefixIcon: Icon(
                      Icons.emoji_events,
                      color: Color(0xFF6B4423),
                    ),
                    border: InputBorder.none,
                    filled: false,
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
            ),

            // Mostrar ganador
            Expanded(
              child: _razaSeleccionada == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emoji_events,
                            size: 80,
                            color: Color(0xFF8B5A3C).withOpacity(0.3),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Selecciona una raza\npara ver el ganador',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF8B5A3C),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    )
                  : StreamBuilder(
                      stream: FirebaseDatabase.instance
                          .ref('mascotas')
                          .orderByChild('raza')
                          .equalTo(_razaSeleccionada)
                          .onValue,
                      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF6B4423),
                            ),
                          );
                        }

                        if (!snapshot.hasData ||
                            snapshot.data!.snapshot.value == null) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 80,
                                  color: Color(0xFF8B5A3C).withOpacity(0.3),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No hay perros de esta raza',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF8B5A3C),
                                  ),
                                ),
                              ],
                            ),
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

                        return SingleChildScrollView(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              // Badge de ganador con corona
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF6B4423),
                                      Color(0xFF8B5A3C),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF6B4423).withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.emoji_events,
                                      color: Colors.amber,
                                      size: 28,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'GANADOR',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.emoji_events,
                                      color: Colors.amber,
                                      size: 28,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24),

                              // Card del ganador con diseño especial
                              Container(
                                constraints: BoxConstraints(maxWidth: 500),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Color(0xFF6B4423),
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF6B4423).withOpacity(0.2),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    // Imagen con borde cafe
                                    Container(
                                      margin: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Color(0xFF6B4423),
                                          width: 2,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Image.network(
                                          ganadorData['url_imagen'],
                                          height: 320,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    // Informacion del ganador
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          // Nombre destacado
                                          Text(
                                            ganadorData['nombre'],
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF6B4423),
                                              letterSpacing: 1,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 16),

                                          // Divider decorativo
                                          Container(
                                            width: 80,
                                            height: 3,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF6B4423),
                                                  Color(0xFF8B5A3C),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                          ),
                                          SizedBox(height: 16),

                                          // Detalles en cards pequeñas
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              _buildDetailCard(
                                                Icons.category,
                                                'Raza',
                                                ganadorData['raza'],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              _buildDetailCard(
                                                Icons.monitor_weight,
                                                'Peso',
                                                '${ganadorData['peso']} kg',
                                              ),
                                              _buildDetailCard(
                                                Icons.how_to_vote,
                                                'Votos',
                                                '${ganadorData['votos']}',
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 20),

                                          // Total de votos destacado
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFFF8F0),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Color(
                                                  0xFF6B4423,
                                                ).withOpacity(0.3),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 24,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Total: ${ganadorData['votos']} votos',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF6B4423),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para tarjetas de detalle
  Widget _buildDetailCard(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF8B5A3C).withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: Color(0xFF6B4423), size: 24),
            SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF8B5A3C),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B4423),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
