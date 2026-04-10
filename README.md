# HealthTrack

HealthTrack es una aplicación de ejemplo para seguimiento de salud y nutrición, basada en la arquitectura y las ideas del documento aportado.

## Estructura

- `lib/main.dart`: Entrada principal de la aplicación.
- `lib/app.dart`: Configuración básica de la app y proveedor de rutas.
- `lib/core/`: Constantes, servicios y utilidades compartidas.
- `lib/features/`: Módulos de `diary`, `health_sync` y `scanner`.
- `lib/l10n/`: Internacionalización en inglés, español y catalán.

## Instrucciones

1. Instalar Flutter.
2. Ejecutar `flutter pub get`.
3. Ejecutar `flutter run`.

## Firebase

Para conectar la app a Firebase debes:

1. Crear un proyecto en https://console.firebase.google.com.
2. Añadir una app iOS y una app Android al proyecto.
3. Descargar `GoogleService-Info.plist` y copiarlo en `ios/Runner/`.
4. Descargar `google-services.json` y copiarlo en `android/app/`.
5. Instalar `flutterfire_cli` con:
   - `dart pub global activate flutterfire_cli`
6. Ejecutar en `HealthTrack`:
   - `flutterfire configure --project <project-id> --out=lib/firebase_options.dart --ios-bundle-id com.example.healthtrack --android-package-name com.example.healthtrack`
7. Reemplazar `lib/firebase_options.dart` con las opciones generadas.

Después de esto la aplicación se inicializará con Firebase cuando se ejecuten los comandos:

- `flutter pub get`
- `flutter run`

## Subir a Apple Store / TestFlight

1. En macOS, abre `ios/Runner.xcworkspace` con Xcode.
2. En `Runner` > `Signing & Capabilities`, selecciona tu Apple Developer Team y configura un `Bundle Identifier` único.
3. Habilita `Push Notifications` si vas a usar notificaciones.
4. Asegúrate de que `GoogleService-Info.plist` está en `ios/Runner/`.
5. En la barra superior de Xcode, selecciona un dispositivo `Any iOS Device (arm64)`.
6. Construye un archivo:
   - `Product` > `Archive`
7. En Xcode Organizer, selecciona el build y elige `Distribute App` > `App Store Connect` > `Upload`.
8. En App Store Connect, crea un registro de la app y usa TestFlight para distribuirlo a testers.

## Pruebas locales

- Para iOS (Mac): `flutter run -d <device_id>`.
- Para Android: `flutter run -d <device_id>`.
- Para generar una compilación release de iOS: `flutter build ios --release --no-codesign`.
- Para generar una compilación release de Android: `flutter build apk --release`.

## Notas

Este proyecto es una base inicial para una app de salud distinta de `Peligros`.
