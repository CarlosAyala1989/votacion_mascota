# Solucion al Error de Firebase Storage

## Error: [firebase_storage/object-not-found]

Este error ocurre porque Firebase Storage no esta configurado correctamente. Aqui esta la solucion paso a paso:

## Pasos para Solucionar

### 1. Verificar que Firebase Storage este Activado

1. Ve a Firebase Console: https://console.firebase.google.com/
2. Selecciona tu proyecto
3. En el menu lateral, haz clic en "Storage"
4. Si no esta activado, haz clic en "Comenzar" o "Get Started"
5. Selecciona una ubicacion (ejemplo: us-central1)
6. Haz clic en "Listo"

### 2. Configurar Reglas de Storage en Modo de Prueba

En Firebase Console -> Storage -> Rules, copia y pega estas reglas:

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if true;
    }
  }
}
```

**IMPORTANTE**: Estas reglas son SOLO para desarrollo/pruebas. En produccion debes usar reglas mas seguras.

### 3. Publicar las Reglas

Despues de pegar las reglas:
1. Haz clic en el boton "Publicar" o "Publish"
2. Espera a que se confirme la publicacion

### 4. Verificar la Configuracion del Bucket

1. En Storage, verifica que haya un bucket creado
2. La URL debe verse como: `gs://tu-proyecto.appspot.com`
3. Si no existe, Firebase lo crea automaticamente al publicar las reglas

### 5. Reiniciar la Aplicacion

Despues de configurar Storage:
1. Cierra la aplicacion completamente
2. Ejecuta: `flutter clean`
3. Ejecuta: `flutter pub get`
4. Ejecuta: `flutter run`

## Mejoras Implementadas en el Codigo

El codigo ahora incluye:

### ✅ Mejor Manejo de Errores
- Validacion de que los archivos existen antes de subirlos
- Mensajes de error mas descriptivos
- Los certificados son opcionales (si fallan, continua el registro)

### ✅ Validaciones Adicionales
```dart
// Verifica que el archivo existe
if (!await file.exists()) {
  throw Exception('El archivo no existe');
}
```

### ✅ Try-Catch Separados
- Intenta subir la imagen principal
- Si falla, muestra error especifico
- Los certificados se intentan subir pero no bloquean el registro si fallan

### ✅ Indicadores Visuales
- CircularProgressIndicator con color cafe
- SnackBars con colores (verde para exito, rojo para error)
- Duracion extendida para mensajes de error (5 segundos)

## Alternativa: Trabajar Sin Storage Temporalmente

Si quieres probar la app sin Storage, puedes:

1. Comentar temporalmente el codigo de subida de archivos
2. Usar URLs de ejemplo:
```dart
String urlImagen = 'https://via.placeholder.com/400';
```

## Verificacion Final

Para confirmar que Storage funciona:

1. Ve a Firebase Console -> Storage
2. Deberia aparecer una carpeta "imagenes/" despues de registrar un perro
3. Los archivos subidos apareceran en la lista
4. Puedes hacer clic en ellos para verlos

## Reglas de Produccion (Futuro)

Cuando estes listo para produccion, usa estas reglas mas seguras:

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /imagenes/{imageId} {
      allow read: if true;
      allow write: if request.resource.size < 5 * 1024 * 1024 // 5MB
                   && request.resource.contentType.matches('image/.*');
    }
    match /certificados/{certId} {
      allow read: if true;
      allow write: if request.resource.size < 10 * 1024 * 1024; // 10MB
    }
  }
}
```

Estas reglas:
- Permiten lectura publica
- Limitan el tamano de imagenes a 5MB
- Limitan el tamano de certificados a 10MB
- Solo permiten imagenes en la carpeta imagenes/

## Soporte Adicional

Si el problema persiste:
1. Verifica que tengas conexion a internet
2. Revisa la consola de Flutter para ver el error completo
3. Verifica que firebase_storage este en pubspec.yaml
4. Asegurate de que google-services.json (Android) este actualizado
