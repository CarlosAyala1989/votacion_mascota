# Diseño de la Aplicacion - Tema de Marcas de Vaca

## Paleta de Colores

La aplicacion utiliza una paleta de colores inspirada en las marcas de vaca, con tonos cafe y blanco:

### Colores Principales
- **Cafe Oscuro** (`#6B4423`) - Color principal para AppBars, botones y textos destacados
- **Cafe Medio** (`#8B5A3C`) - Color secundario para elementos complementarios
- **Blanco Cremoso** (`#FFF8F0`) - Color de fondo principal, similar al color de la piel de vaca
- **Blanco Puro** (`#FFFFFF`) - Para cards y elementos destacados

### Uso de Colores
```dart
Color(0xFF6B4423) // Cafe oscuro - Principal
Color(0xFF8B5A3C) // Cafe medio - Secundario
Color(0xFFFFF8F0) // Blanco cremoso - Fondo
Colors.white      // Blanco puro - Cards
Colors.amber      // Dorado - Detalles de ganador
```

## Elementos de Diseño

### 1. AppBar con Degradado
- Degradado de cafe oscuro a cafe medio
- Titulo en mayusculas con espaciado de letras
- Sin elevacion para un look mas limpio

### 2. Pantalla de Inicio
- Icono circular con efecto de sombra cafe
- Botones grandes con iconos en contenedores cafe
- Bordes redondeados y sombras sutiles
- Fondo blanco cremoso

### 3. Pantalla de Registro
- Campos de entrada con iconos cafe
- Botones de archivo con estilo de tarjeta
- Check verde cuando se selecciona un archivo
- Seccion de titulos con borde lateral cafe
- Boton de guardar destacado en cafe oscuro

### 4. Pantalla de Votacion
- Selector de raza en card blanco elevado
- Cards de perros con bordes redondeados
- Imagen con esquinas superiores redondeadas
- Chips de informacion con fondo cremoso
- Boton de votar destacado con icono

### 5. Pantalla de Ganadores
- Badge de ganador con degradado cafe y coronas doradas
- Card del ganador con borde cafe grueso (3px)
- Imagen con marco cafe
- Tarjetas de detalles organizadas
- Total de votos destacado con estrella dorada

## Caracteristicas del Diseño

### Minimalismo
- Espaciado generoso entre elementos
- Colores limitados y cohesivos
- Jerarquia visual clara
- Sin elementos innecesarios

### Coherencia
- Todos los botones usan el mismo estilo base
- Cards con bordes redondeados consistentes (12-16px)
- Iconos del mismo color en toda la app
- Tipografia consistente

### Patron de Manchas de Vaca
- Colores cafe y blanco que recuerdan las manchas de vaca
- Elementos organicos con bordes redondeados
- Contraste fuerte entre cafe oscuro y blanco
- Sombras sutiles color cafe

### Accesibilidad
- Contraste alto entre texto cafe y fondo blanco
- Botones grandes y faciles de tocar
- Iconos claros y reconocibles
- Texto legible con buen tamano

## Componentes Personalizados

### Botones del Menu Principal
```dart
_buildMenuButton()
```
- Fondo blanco con borde cafe
- Icono en contenedor cafe con esquinas redondeadas
- Texto cafe oscuro
- Sombra sutil

### Botones de Archivo
```dart
_buildFileButton()
```
- Card blanco con borde
- Cambia a cafe cuando se selecciona
- Icono con fondo dinamico
- Check mark cuando esta seleccionado

### Chips de Informacion
```dart
_buildInfoChip()
```
- Fondo cremoso
- Borde cafe claro
- Icono y texto cafe oscuro
- Bordes redondeados (pill shape)

### Tarjetas de Detalle
```dart
_buildDetailCard()
```
- Card pequena con icono
- Label y valor
- Borde cafe claro
- Formato compacto

## Tipografia

- **Titulos grandes**: 28px, bold, cafe oscuro
- **Titulos medianos**: 20-22px, semi-bold, cafe oscuro
- **Texto normal**: 16px, regular, cafe medio
- **Texto pequeno**: 13-14px, medium, cafe medio
- **Espaciado de letras**: 0.5-1.5 para titulos destacados

## Efectos Visuales

### Sombras
- Color: Cafe oscuro con opacidad 0.1-0.3
- Blur: 4-15px dependiendo del elemento
- Offset: (0, 2) a (0, 5) para efecto de profundidad

### Degradados
- AppBars: Cafe oscuro → Cafe medio
- Badge ganador: Cafe oscuro → Cafe medio
- Divisores: Cafe oscuro → Cafe medio

### Bordes Redondeados
- Botones: 12-16px
- Cards: 16-20px
- Inputs: 12px
- Chips: 20px (pill)
- Contenedores de iconos: 8px

## Responsive Design

La aplicacion esta diseñada para funcionar bien en diferentes tamanos:
- Maximos de ancho en cards importantes (400-500px)
- SingleChildScrollView para contenido largo
- Expanded y Flexible para adaptacion automatica
- Padding consistente (16-24px)

## Animaciones Implicitas

- Material InkWell para efectos de tap
- CircularProgressIndicator en color cafe
- Transiciones suaves de navegacion

Este diseño crea una experiencia visual coherente, minimalista y memorable inspirada en las clasicas marcas de vaca.
