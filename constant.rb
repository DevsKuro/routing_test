#!/usr/bin/env ruby -wKU

# Towns available to select
TOWN = [
  "Cerrillos",
  "Cerro Navia",
  "Conchalí",
  "El Bosque",
  "Estación Central",
  "Huechuraba",
  "Independencia",
  "La Cisterna",
  "La Granja",
  "La Florida",
  "La Pintana",
  "La Reina",
  "Las Condes",
  "Lo Barnechea",
  "Lo Espejo",
  "Lo Prado",
  "Macul",
  "Maipú",
  "Ñuñoa",
  "Pedro Aguirre Cerda",
  "Peñalolén",
  "Providencia",
  "Pudahuel",
  "Quilicura",
  "Quinta Normal",
  "Recoleta",
  "Renca",
  "San Miguel",
  "San Joaquín",
  "San Ramón",
  "Santiago",
  "Vitacura"
]

# Data load format
DATA_SEPARATOR = "#####"
MIN_DATA_DRIVERS = 5;
MIN_DATA_ROUTES = 8;
MIN_DATA_VEHICLES = 3;

DEFAULT_INDEX_UNASSIGNED = 0
