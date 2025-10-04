# Solucion: Datos No Se Guardan en Firebase Database

## Problema Identificado

Las imagenes se suben a Storage correctamente, pero los datos (nombre, peso, raza) no se guardan completos en Firebase Realtime Database.

## Causa Probable

Las reglas de Firebase Realtime Database no permiten escritura, o la base de datos no esta en modo de prueba.

## SOLUCION PASO A PASO

### 1. Configurar Firebase Realtime Database

1. Ve a Firebase Console: https://console.firebase.google.com/
2. Selecciona tu proyecto
3. En el menu lateral, busca **"Realtime Database"** (NO Firestore)
4. Haz clic en la pestaña **"Reglas"** o **"Rules"**

### 2. Aplicar Reglas de Prueba

Copia y pega estas reglas en el editor:

```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

### 3. Publicar las Reglas

1. Haz clic en el boton **"Publicar"** o **"Publish"**
2. Confirma la publicacion
3. Espera el mensaje de confirmacion

### 4. Verificar la Configuracion de la Database

1. Ve a la pestaña **"Datos"** o **"Data"**
2. Deberia aparecer una estructura vacia o con datos existentes
3. La URL de tu database debe ser: `https://tu-proyecto-default-rtdb.firebaseio.com/`

## Diferencia Entre Storage y Database

**IMPORTANTE**: Son dos servicios diferentes que necesitan configuracion separada:

### Firebase Storage (Ya configurado ✅)
- Almacena archivos (imagenes, PDFs)
- Reglas que ya tienes:
```
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if true;
    }
  }
}
```

### Firebase Realtime Database (Necesita configuracion ❌)
- Almacena datos estructurados (JSON)
- Necesita estas reglas:
```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

## Mejoras Implementadas en el Codigo

### ✅ Logging Detallado

El codigo ahora imprime en consola:
```dart
print('Intentando guardar en Firebase Database...');
print('Nombre: ${_nombreController.text}');
print('Peso: ${_pesoController.text}');
print('Raza: $_razaSeleccionada');
```

Esto te ayudara a ver exactamente que datos se estan intentando guardar.

### ✅ Limpieza de Datos

```dart
'nombre': _nombreController.text.trim(),
'peso': _pesoController.text.trim(),
```

Elimina espacios en blanco que podrian causar problemas.

### ✅ Manejo de Valores Nulos

```dart
'raza': _razaSeleccionada ?? '',
'url_cert_originalidad': urlCertOriginalidad ?? '',
```

Asegura que no se envien valores null.

### ✅ Mapa de Datos Explicito

```dart
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
```

## Verificacion en la Consola de Flutter

Despues de registrar un perro, revisa la consola de Flutter. Deberias ver:

```
Intentando guardar en Firebase Database...
Nombre: Max
Peso: 25
Raza: Labrador Retriever
URL Imagen: https://firebasestorage...
Datos a guardar: {nombre: Max, peso: 25, raza: Labrador Retriever...}
Datos guardados exitosamente en Firebase Database
```

Si ves un error aqui, es probable que las reglas de Database no esten configuradas.

## Errores Comunes

### Error: "Permission Denied"
**Solucion**: Las reglas de Database no permiten escritura. Aplica las reglas de prueba.

### Error: "Database URL is null"
**Solucion**: No has activado Realtime Database. Ve a Firebase Console y activalo.

### Solo se guarda "nombreperro"
**Solucion**: Hay un problema con la escritura. Verifica las reglas y que el codigo actualizado este ejecutandose.

## Estructura Esperada en Firebase Database

Despues de registrar un perro, en Firebase Console -> Realtime Database -> Datos, deberia verse asi:

```
mascotas
  └─ -NXxxx... (ID generado automaticamente)
      ├─ nombre: "Max"
      ├─ peso: "25"
      ├─ raza: "Labrador Retriever"
      ├─ url_imagen: "https://firebasestorage..."
      ├─ url_cert_originalidad: ""
      ├─ url_cert_pedigri: ""
      ├─ votos: 0
      └─ fecha_registro: "2025-10-03T..."
```

## Reglas de Produccion (Futuro)

Cuando estes listo para produccion, usa estas reglas mas seguras:

```json
{
  "rules": {
    "mascotas": {
      ".read": true,
      ".write": true,
      "$mascotaId": {
        ".validate": "newData.hasChildren(['nombre', 'peso', 'raza', 'url_imagen', 'votos'])",
        "nombre": {
          ".validate": "newData.isString() && newData.val().length > 0"
        },
        "peso": {
          ".validate": "newData.isString()"
        },
        "raza": {
          ".validate": "newData.isString() && newData.val().length > 0"
        },
        "votos": {
          ".validate": "newData.isNumber() && newData.val() >= 0"
        }
      }
    }
  }
}
```

## Pasos Siguientes

1. ✅ Configura las reglas de Realtime Database
2. ✅ Publica las reglas
3. ✅ Reinicia la app: `flutter run`
4. ✅ Registra un perro de prueba
5. ✅ Verifica en Firebase Console que todos los campos se guardaron
6. ✅ Revisa la consola de Flutter para ver los logs

## Si el Problema Persiste

1. Verifica que estas usando **Realtime Database** y no **Firestore**
2. Asegurate de que el archivo `firebase_options.dart` tenga la URL correcta de la database
3. Ejecuta `flutter clean` y luego `flutter pub get`
4. Revisa la consola de Flutter para ver mensajes de error especificos
