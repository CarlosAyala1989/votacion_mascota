# Instrucciones para Configurar Firebase

## Configuracion de Firebase Database (Realtime Database)

1. Ve a Firebase Console: https://console.firebase.google.com/
2. Selecciona tu proyecto
3. En el menu lateral, busca "Realtime Database"
4. Haz clic en "Crear base de datos"
5. Selecciona una ubicacion (ejemplo: us-central1)
6. **IMPORTANTE**: Selecciona "Modo de prueba" (Test mode)
7. Las reglas deben quedar asi para modo de prueba:

```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

## Configuracion de Firebase Storage

1. En Firebase Console, ve a "Storage"
2. Haz clic en "Comenzar"
3. Selecciona "Modo de prueba" (Test mode)
4. Las reglas deben quedar asi para modo de prueba:

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

## Estructura de la Base de Datos

La aplicacion crea automaticamente esta estructura en Firebase:

```
mascotas/
  ├─ [id_generado_automaticamente]/
      ├─ nombre: "Firulais"
      ├─ peso: "15"
      ├─ raza: "Perro"
      ├─ url_imagen: "https://..."
      ├─ url_cert_originalidad: "https://..." (opcional)
      ├─ url_cert_pedigri: "https://..." (opcional)
      ├─ votos: 0
      └─ fecha_registro: "2025-10-03T..."
```

## Notas Importantes

- Esta configuracion es SOLO para desarrollo/pruebas
- En produccion debes implementar reglas de seguridad apropiadas
- Los certificados son opcionales, solo la imagen es obligatoria
- Las imagenes y certificados se guardan en Firebase Storage
- Los votos se actualizan en tiempo real
