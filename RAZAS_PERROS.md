# Lista de Razas de Perros en la Aplicacion

La aplicacion ahora incluye las siguientes razas de perros para el registro y votacion:

## Razas Disponibles (30 razas + Otros)

1. Labrador Retriever
2. Pastor Aleman
3. Golden Retriever
4. Bulldog Frances
5. Bulldog Ingles
6. Beagle
7. Poodle
8. Rottweiler
9. Yorkshire Terrier
10. Boxer
11. Dachshund (Salchicha)
12. Siberian Husky
13. Doberman
14. Pitbull
15. Shih Tzu
16. Chihuahua
17. Pomerania
18. Border Collie
19. Cocker Spaniel
20. Schnauzer
21. Gran Danes
22. Dalmata
23. Basset Hound
24. San Bernardo
25. Akita
26. Chow Chow
27. Mastiff
28. Terranova
29. Samoyedo
30. **Otros** (para razas no listadas)

## Cambios Realizados

### De "Mascotas" a "Razas de Perros"
- Se cambio el concepto de votacion de diferentes tipos de mascotas (Perro, Gato, Conejo, etc.)
- Ahora la aplicacion se enfoca exclusivamente en razas de perros
- Se agregaron 30 razas populares de perros mas la opcion "Otros"

### Estructura de Datos en Firebase
Los datos se guardan en Firebase Realtime Database con la siguiente estructura:

```
mascotas/  (nota: el nodo sigue llamandose "mascotas" por compatibilidad)
  ├─ [id_generado_automaticamente]/
      ├─ nombre: "Max"
      ├─ peso: "25"
      ├─ raza: "Labrador Retriever"  <-- Ahora contiene razas de perros
      ├─ url_imagen: "https://..."
      ├─ url_cert_originalidad: "https://..." (opcional)
      ├─ url_cert_pedigri: "https://..." (opcional)
      ├─ votos: 0
      └─ fecha_registro: "2025-10-03T..."
```

### Pantallas Actualizadas

1. **Pantalla de Inicio**
   - Titulo: "Votacion de Razas de Perros"
   - Boton: "Registrar Perro"

2. **Pantalla de Registro**
   - Titulo: "Registrar Perro"
   - Campo: "Nombre del perro"
   - Dropdown: "Raza del Perro" (con 30 razas + Otros)

3. **Pantalla de Votacion**
   - Titulo: "Votar por Perro"
   - Filtro por raza de perro
   - Texto: "Selecciona una raza para ver perros"
   - Texto de error: "No hay perros de esta raza"

4. **Pantalla de Ganadores**
   - Muestra el perro ganador por raza seleccionada
   - Texto de error: "No hay perros de esta raza"

## Notas
- La opcion "Otros" permite registrar perros de razas no listadas
- Todas las 30 razas estan disponibles en las tres pantallas (Registro, Votacion, Ganadores)
- Los datos se guardan correctamente en Firebase con el campo "raza" conteniendo la raza del perro
