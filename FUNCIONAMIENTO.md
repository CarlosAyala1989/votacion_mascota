# Aplicacion de Votacion de Mascotas

## Funcionalidades Implementadas

### 1. Registro de Mascotas
- Permite registrar mascotas con la siguiente informacion:
  - Nombre de la mascota
  - Peso en kilogramos
  - Raza (seleccion entre: Perro, Gato, Conejo, Hamster, Loro, Pez)
  - Foto de la mascota (obligatoria)
  - Certificado de originalidad (opcional, formato: PDF, JPG, PNG)
  - Certificado de pedigri (opcional, formato: PDF, JPG, PNG)

### 2. Votacion por Mascotas
- Filtro por raza: puedes seleccionar una raza para ver solo las mascotas de esa categoria
- Muestra una lista con tarjetas que incluyen:
  - Imagen de la mascota
  - Nombre
  - Peso
  - Votos actuales
  - Boton para votar
- Los votos se actualizan en tiempo real
- Puedes votar multiples veces por la misma mascota

### 3. Ver Ganadores
- Selecciona una raza para ver el ganador
- Muestra la mascota con mas votos de esa raza
- Informacion mostrada:
  - Imagen de la mascota ganadora
  - Nombre
  - Raza
  - Peso
  - Total de votos

## Estructura del Codigo

El codigo esta organizado de forma simple en un solo archivo `lib/main.dart`:

- **MiApp**: Widget principal de la aplicacion
- **PantallaInicio**: Pantalla principal con 3 botones de navegacion
- **PantallaRegistro**: Formulario para registrar nuevas mascotas
- **PantallaVotacion**: Lista de mascotas filtradas por raza para votar
- **PantallaGanadores**: Muestra el ganador por raza seleccionada

## Como Ejecutar

### Para Android:
```bash
flutter run
```

### Para Web:
```bash
flutter run -d chrome
```

## Notas Importantes

- Todas las variables estan en español (sin usar "ñ", se usa "nn")
- No se usan emojis en el codigo
- El codigo esta documentado con comentarios breves
- La estructura es simple y directa, sin arquitecturas complejas
- Firebase esta en modo de prueba (sin reglas de seguridad)
- Los archivos se suben a Firebase Storage
- Los datos se guardan en Firebase Realtime Database
