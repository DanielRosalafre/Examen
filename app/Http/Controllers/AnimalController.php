<?php

namespace App\Http\Controllers;

use App\Models\Animal;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class AnimalController extends Controller
{
    public function index(): JsonResponse
    {
        return response()->json(Animal::orderBy('id')->get());
    }

    public function store(Request $request): JsonResponse
    {
        $animal = Animal::create($this->validar($request));

        return response()->json($animal->refresh(), 201);
    }

    public function show(Animal $animal): JsonResponse
    {
        return response()->json($animal);
    }

    public function update(Request $request, Animal $animal): JsonResponse
    {
        $animal->update($this->validar($request));

        return response()->json($animal->refresh());
    }

    public function destroy(Animal $animal): Response
    {
        $animal->delete();

        return response()->noContent();
    }

    private function validar(Request $request): array
    {
        // Con PATCH puedo mandar solo el campo que quiero cambiar.
        $presencia = $request->isMethod('PATCH') ? ['sometimes', 'required'] : ['required'];

        return $request->validate([
            'nombre' => [...$presencia, 'string', 'max:100'],
            'especie' => [...$presencia, 'string', 'max:80'],
            'raza' => [...$presencia, 'string', 'max:80'],
            'edad' => [...$presencia, 'integer', 'between:0,65535'],
        ]);
    }
}
