<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Animal extends Model
{
    // Le pongo el nombre de la tabla porque Laravel pluraliza en inglés.
    protected $table = 'animales';

    protected $fillable = ['nombre', 'especie', 'raza', 'edad'];
}
