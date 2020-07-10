# ----------------------------------------------------------------
# BlackBess
# ----------------------------------------------------------------

from serpwow.google_search_results import GoogleSearchResults
import json
import pandas as pd
import csv
datos = []  # para guardar las variables

#API key
serpwow = GoogleSearchResults("D7D59D53562A42AEBE6FA07653381B48")

# Parametros de busqueda
params = {
  "q" : "pizza", # Que buscar?
  "gl" : "ec", # Pais
  "hl" : "es", # Idioma
  "location" : "Quito,Pichincha,Ecuador",
  "google_domain" : "google.com.ec",
  "search_type" : "places" # Google places
}

# Resultados en formato csv
result = serpwow.get_csv(params)

# Impresion
# print(json.dumps(result, indent=2, sort_keys=True))
print (result)

# Guardar datos en Excel
#archivo = open("archivo.txt","w")
#archivo.write(df)
#archivo.close()



