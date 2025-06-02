# VentaBot – Asistente Inteligente para Ventas

![.NET](https://img.shields.io/badge/.NET-4.7.2-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![API](https://img.shields.io/badge/OpenRouter-API-orange)
![OS](https://img.shields.io/badge/Windows-10%2F11-blue)

## Tabla de Contenidos

- [Descripción](#descripción)
- [Objetivos](#objetivos)
- [Características](#características)
- [Comenzando](#comenzando)
- [Uso](#uso)
- [Arquitectura](#arquitectura)
- [Configuración](#configuración)
- [Pruebas](#pruebas)
- [Versiones](#versiones)
- [Desarrollo](#desarrollo)
- [Roadmap](#roadmap)
- [Contribución](#contribución)
- [Licencia](#licencia)
- [Equipo](#equipo)


## 🎯 Objetivos

- Automatizar y facilitar el proceso de gestión de ventas.
- Proporcionar asistencia inteligente mediante un bot de Telegram.
- Agilizar las consultas de inventario, artículos y roles de usuarios.
- Ofrecer una interfaz moderna, amigable y eficiente para el usuario.


## ✨ Características Principales

### 🤖 Asistente Bot Integrado

- Interacción directa con el sistema mediante Telegram Bot.
- Comandos automáticos para consultar:
  - Productos disponibles y en stock.
  - Información del usuario (roles y permisos).
  - Funcionalidades clave del sistema desde el chat.
- Flujo de navegación sin necesidad de escribir comandos: interfaz con botones interactivos.
- Respuestas rápidas y estructuradas con formato enriquecido.

### 💻 Interfaz Gráfica Moderna

- Rediseño con componentes Guna2 para experiencia visual mejorada.
- Dashboard intuitivo con acceso a funcionalidades principales.
- Personalización de imagen de usuario y saludo dinámico.

### 📦 Gestión de Inventario

- Visualización y gestión de artículos disponibles.
- Actualización automática del stock tras cada venta.
- Filtros dinámicos por disponibilidad.

### 🛡️ Seguridad y Control de Acceso

- Autenticación con roles (por ejemplo: administrador).
- Validación de credenciales al iniciar sesión.
- Navegación segura entre formularios.

### 🛒 Gestión de Ventas y Productos

- Creación, actualización y eliminación de artículos de venta.
- Control automatizado del stock disponible por producto.
- Sistema de categorías y clasificación de productos.
- Visualización detallada de artículos (nombre, precio, stock).
- Reporte inmediato de artículos agotados o con bajo inventario.
- Validación de campos clave como precio, cantidad, categoría.

### 📊 Reportes y Consultas

- Generación de reportes de ventas.
- Consulta de artículos disponibles en tiempo real.
- Filtros por disponibilidad, precio, nombre o categoría.
- Vista de historial de ventas para fines de auditoría o control.
- Acceso mediante interfaz gráfica y vía Telegram Bot.


### ⚙️ Compatibilidad y Tecnología

- Compatible con Windows 10 y 11.
- Desarrollado en .NET Framework 4.7.2.
- Comunicación fluida con base de datos SQL Server.


## 🚀 Comenzando

### Requisitos Previos

- .NET Framework 4.7.2 o superior  
- Visual Studio 2019 o superior  
- SQL Server (para conexión a base de datos)  
- Token válido de Telegram Bot (para el asistente inteligente)  

### Instalación

1. Clona el repositorio:

```bash
git clone https://github.com/tuusuario/VentaBot.git
```

2. Abre la solución en Visual Studio:

```text
cd VentaBot  
VentaBot.sln
```

3. Restaura los paquetes NuGet (si aplica):

```bash
dotnet restore
```

4. Compila y ejecuta el proyecto:

```bash
dotnet build  
dotnet run
```

## 🖥️ Uso

VentaBot permite interactuar con el sistema de ventas a través de una interfaz gráfica y también mediante comandos a través de un Bot de Telegram.

### Comandos Disponibles en Telegram

Puedes controlar VentaBot con botones interactivos o usando comandos estructurados.

#### 📋 Comandos Estructurados

```text
/start
```
Inicia la conversación con el bot y despliega el menú interactivo de opciones.

```text
/ver_articulos
```
Muestra todos los artículos registrados en el sistema.

```text
/ver_stock
```
Filtra y muestra solo los artículos con stock disponible.

```text
/comprar
```
Permite seleccionar un artículo disponible para realizar una compra desde el bot.

#### 💬 Comandos Conversacionales

```text
@VentaBot, muéstrame qué productos están disponibles
@VentaBot, quiero comprar un artículo que tenga stock
@VentaBot, ¿qué puedo hacer aquí?
@VentaBot, enséñame mi rol o permisos
```

Estos comandos pueden ser reemplazados por botones automáticos tras iniciar con `/start`, lo que simplifica la experiencia para el usuario.

---

### 🧠 Ejemplos de Prompts

A continuación, se muestran ejemplos que podrías adaptar si el bot de VentaBot evolucionara hacia un sistema más conversacional con IA.

#### Prompts Estructurados

1. `@VentaBot mostrar artículos con stock disponible categoría tecnología`
2. `@VentaBot filtrar productos con precio menor a 100`
3. `@VentaBot comprar artículo “Teclado Gamer RGB” cantidad 1`
4. `@VentaBot listar ventas realizadas hoy`
5. `@VentaBot mostrar mi rol y permisos actuales`

#### Prompts Conversacionales

```text
@VentaBot, quiero saber qué puedo vender hoy
@VentaBot, por favor ayúdame a registrar una nueva venta
@VentaBot, muéstrame los productos más baratos
@VentaBot, ¿cuántos artículos hay disponibles?
@VentaBot, necesito actualizar el precio de un producto
```

---

### Interfaz Gráfica

Desde el entorno de escritorio (Windows Forms), puedes:

- Iniciar sesión como administrador o usuario  
- Acceder a formularios de gestión (clientes, artículos, ventas)  
- Ver reportes y actualizar registros  
- Personalizar tu perfil de usuario (imagen, nombre, rol)

## 🏗️ Arquitectura

VentaBot está construido con una arquitectura por capas que separa claramente la interfaz, la lógica de negocio y el acceso a datos, facilitando su mantenimiento y escalabilidad.

### Capas de la Aplicación

#### 1. Presentation Layer (Capa de Presentación)

- Interfaz de usuario (Windows Forms con Guna2 UI)
- Controladores de eventos
- Validación de entradas del usuario
- Animaciones, paneles de navegación y gestión visual

#### 2. Business Logic Layer (Lógica de Negocio)

- Procesamiento de comandos del bot de Telegram
- Control de flujo entre formularios (ej. abrir frmCliente, frmArticulo)
- Validaciones de reglas de negocio
- Lógica para operaciones de compra, consulta y autenticación

#### 3. Data Access Layer (DAL)

- Acceso a base de datos
- Operaciones CRUD
- Manejo de transacciones
- Validación de integridad de datos
- Sistema de respaldo y recuperación

---

### 🧩 Componentes Principales

#### 1. TelegramBotService

- Integración con la API de Telegram Bot
- Procesamiento de comandos estructurados y botones
- Respuesta automatizada mediante mensajes y botones
- Manejo de errores y reintentos
- Configuración desde archivo o entorno

#### 2. CommandHandler

- Interpretación de comandos del usuario en lenguaje natural o directo
- Validación de comandos permitidos
- Extracción y parseo de parámetros desde texto plano
- Gestión de respuestas estructuradas
- Personalización de respuestas por contexto (usuario, rol, etc.)

#### 3. DBManager

- Conexión y consultas SQL hacia la base de datos
- Ejecución de procedimientos almacenados (si aplica)
- Gestión eficiente de recursos (conexión/lectura/cierre)
- Retorno de resultados en estructuras listas para el bot o UI

## ⚙️ Configuración

### 🔐 Variables de Entorno

Asegúrate de configurar las siguientes variables de entorno en un archivo `.env` o desde el sistema operativo:

```env
TELEGRAM_BOT_TOKEN=tu_token_del_bot
SQL_SERVER=localhost
SQL_DATABASE=ventabot_db
SQL_USER=admin
SQL_PASSWORD=123456
```

---

### 🤖 Configuración del Bot

```json
{
  "BotSettings": {
    "Token": "tu_token_del_bot",
    "StartMessage": "¡Bienvenido a VentaBot!",
    "AllowedCommands": [
      "/start",
      "/ver_articulos",
      "/ver_stock",
      "/comprar"
    ]
  }
}
```

---

### 🛢️ Configuración de Base de Datos

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Database=ventabot_db;User Id=admin;Password=123456;"
  }
}
```

> ⚠️ **Importante**: Nunca subas tus archivos de configuración sensibles al repositorio. Asegúrate de incluir `.env` en tu `.gitignore`.
## 🧪 Pruebas

VentaBot incluye pruebas tanto unitarias como de integración para asegurar el correcto funcionamiento del sistema.

### ✅ Pruebas Unitarias

Ejemplo de prueba unitaria para guardar un artículo correctamente:

```csharp
[Test]
public void GuardarArticulo_DatosValidos_DeberiaGuardar()
{
    // Arrange
    var articulo = new Articulo { Nombre = "Mouse", Precio = 25, Stock = 10 };

    // Act
    var resultado = articuloServicio.Guardar(articulo);

    // Assert
    Assert.IsTrue(resultado);
}
```

### 🔄 Pruebas de Integración

Ejemplo de prueba para validar la respuesta del bot ante un comando:

```csharp
[Test]
public async Task ProcesarComando_ComandoValido_DeberiaResponderCorrectamente()
{
    // Arrange
    string comando = "/ver_articulos";

    // Act
    var respuesta = await botHandler.ProcesarComando(comando);

    // Assert
    Assert.IsTrue(respuesta.Contains("Lista de artículos"));
}
```

---

> 🧰 Las pruebas pueden ejecutarse usando el Test Explorer de Visual Studio o mediante línea de comandos con:
>
> ```bash
> dotnet test
> ```



## 📈 Roadmap

- [ ] Sincronización con servicios en la nube (Azure, Google Drive)
- [ ] Versión móvil de VentaBot para Android gracias a Telegram
- [ ] Reportes con análisis predictivo de ventas
- [ ] Integración con otros bots o servicios de mensajería

---

## 🤝 Contribución

¡Tu ayuda es bienvenida! Si deseas colaborar con VentaBot:

1. Haz un **fork** del repositorio.
2. Crea una rama para tu mejora o corrección:

```bash
git checkout -b feature/nueva-funcionalidad
```

3. Realiza tus cambios y haz commit:

```bash
git commit -m "Agregada funcionalidad de reporte semanal"
```

4. Sube tu rama a GitHub:

```bash
git push origin feature/nueva-funcionalidad
```

5. Abre un **Pull Request** explicando detalladamente los cambios.

---

## 📄 Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo [`LICENSE.md`](./LICENSE.md) para más información.

---


## 👥 Equipo

VentaBot ha sido desarrollado con esfuerzo colaborativo por:

- **Yassir Rolon**  
  GitHub: [@AlejandroRolon-Junior](https://github.com/AlejandroRolon-Junior)

- **Oscar Rivero**  
  GitHub: 
## 📦 Versiones

### Historial de Cambios

#### v1.2.0 (Actual)
- Mejora en el procesamiento de comandos por botones en Telegram
- Corrección de errores de concurrencia en operaciones de base de datos
- Optimización del rendimiento general de la aplicación
- Nuevas funcionalidades inteligentes del bot

#### v1.1.0
- Integración completa con el bot de Telegram
- Sistema de notificaciones en interfaz
- Mejoras visuales con Guna2 UI

#### v1.0.0
- Lanzamiento inicial
- Funcionalidades básicas del sistema de ventas
- Integración con SQL Server y arquitectura en capas

---

### Compatibilidad

- ✅ Windows 10
- ✅ Windows 11
- 🧱 .NET Framework 4.7.2
- 🗄️ Requiere SQL Server
- 💬 Telegram Bot Token requerido


## 👨‍💻 Desarrollo

### Guía de Estilo

#### 🧱 Nombres

```csharp
public class VentaManager { }         // PascalCase para clases
private string _nombreUsuario;        // _camelCase para campos privados
public void ProcesarVenta() { }       // PascalCase para métodos
```

#### 📝 Comentarios XML

```xml
/// <summary>
/// Procesa una venta y actualiza el inventario
/// </summary>
/// <param name="venta">La venta a procesar</param>
/// <returns>Resultado del procesamiento</returns>
```

---

### 📁 Estructura de Carpetas

```text
VentaBot/
├── Presentation/     # Interfaz de usuario (WinForms + Guna2)
├── BLL/              # Lógica de negocio
├── DAL/              # Acceso a datos
├── ENTITY/           # Modelos y entidades
├── TelegramBot/      # Controlador del bot y procesamiento de comandos
├── Tests/            # Pruebas unitarias e integración
├── Docs/             # Documentación técnica y manuales
```

---

### 🔄 Flujo de Trabajo

1. Clonar el repositorio y abrir la solución en Visual Studio.
2. Compilar y ejecutar el proyecto (`dotnet build` y `dotnet run`).
3. Ejecutar pruebas usando el explorador de pruebas o `dotnet test`.
4. Documentar los cambios en `README.md` y abrir un Pull Request.



