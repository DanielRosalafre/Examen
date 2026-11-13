#!/usr/bin/env bash
set -euo pipefail

url="${API_URL:-http://127.0.0.1:8000}/api/animales"
respuesta="$(mktemp)"
trap 'rm -f "$respuesta"' EXIT

peticion() {
    local esperado="$1" metodo="$2" destino="$3" estado
    shift 3
    estado="$(curl -sS -o "$respuesta" -w '%{http_code}' \
        -X "$metodo" "$destino" "$@")"
    printf '%s %s -> %s\n' "$metodo" "${destino#*://*/}" "$estado" >&2
    if [[ -s "$respuesta" ]]; then
        cat "$respuesta" >&2
        printf '\n' >&2
    fi
    [[ "$estado" == "$esperado" ]]
}

# Saco el id de la respuesta para que la prueba funcione más de una vez.
peticion 201 POST "$url" -H 'Content-Type: application/json' \
    -d '{"nombre":"Luna","especie":"Perro","raza":"Mestiza","edad":3}'
id="$(php -r 'echo json_decode(stream_get_contents(STDIN), true, 512, JSON_THROW_ON_ERROR)["id"];' < "$respuesta")"
detalle="${url}/${id}"

peticion 200 GET "$url"
peticion 200 GET "$detalle"
peticion 200 PUT "$detalle" -H 'Content-Type: application/json' \
    -d '{"nombre":"Luna","especie":"Perro","raza":"Mestiza","edad":4}'
peticion 200 PATCH "$detalle" -H 'Content-Type: application/json' -d '{"edad":5}'
peticion 422 PATCH "$detalle" -H 'Content-Type: application/json' -d '{"edad":-1}'
peticion 204 DELETE "$detalle"
peticion 404 GET "$detalle"
