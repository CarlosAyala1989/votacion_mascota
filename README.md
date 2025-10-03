# Aplicacion de Votacion de Razas de Perros

Aplicacion Flutter para registrar y votar por diferentes razas de perros.

## Caracteristicas

- **Registro de Perros**: Registra perros con nombre, peso, raza, foto y certificados
- **Votacion**: Vota por tus perros favoritos filtrados por raza
- **Ganadores**: Ve el perro ganador de cada raza

## Razas Incluidas (30 + Otros)

La aplicacion incluye 30 razas populares de perros:
- Labrador Retriever
- Pastor Aleman
- Golden Retriever
- Bulldog Frances
- Bulldog Ingles
- Beagle
- Poodle
- Rottweiler
- Yorkshire Terrier
- Boxer
- Dachshund
- Siberian Husky
- Doberman
- Pitbull
- Shih Tzu
- Chihuahua
- Pomerania
- Border Collie
- Cocker Spaniel
- Schnauzer
- Gran Danes
- Dalmata
- Basset Hound
- San Bernardo
- Akita
- Chow Chow
- Mastiff
- Terranova
- Samoyedo
- **Otros** (para razas no listadas)

## Configuracion

Ver `INSTRUCCIONES_FIREBASE.md` para configurar Firebase Database y Storage.

## Como Ejecutar

```bash
# Android
flutter run

# Web
flutter run -d chrome
```

## Estructura de Datos en Firebase

```
mascotas/
  ├─ [id]/
      ├─ nombre: "Max"
      ├─ peso: "25"
      ├─ raza: "Labrador Retriever"
      ├─ url_imagen: "https://..."
      ├─ url_cert_originalidad: "https://..." (opcional)
      ├─ url_cert_pedigri: "https://..." (opcional)
      ├─ votos: 0
      └─ fecha_registro: "2025-10-03T..."
```
