# API REST de animales

Laravel 12, PHP y MySQL. Las rutas quedan abiertas para la práctica.
La tabla guarda nombre, especie, raza y edad en años, además del id y las fechas.

## Levantar en local

Con PHP 8.2 o superior, la extensión `pdo_mysql`, Composer y MySQL iniciado:

```bash
mysql -u root -p < preparar_mysql.sql
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve --host=127.0.0.1 --port=8000
```

Si tu MySQL usa otro puerto o contraseña, cambia los valores en `.env`.

## Probar

En otra terminal, desde esta carpeta:

```bash
bash probar_api.sh
```

El script usa curl para crear, listar, consultar, editar y borrar un animal.
También verifica que una edad negativa dé 422 y que el registro borrado dé 404.

| Método | Ruta | Respuesta |
| --- | --- | --- |
| GET | /api/animales | 200 |
| POST | /api/animales | 201 |
| GET | /api/animales/{id} | 200 |
| PUT | /api/animales/{id} | 200 |
| PATCH | /api/animales/{id} | 200 |
| DELETE | /api/animales/{id} | 204 |

PUT recibe los cuatro atributos. PATCH permite mandar solo lo que cambió.
