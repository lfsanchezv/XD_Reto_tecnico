"""
Creacion: Miercoles 25 Mayo 2022
Reto_Programacion
Python 3.6
@autor: Luis Sanchez
"""

import requests
import json
from datetime import datetime

#Descargar_Datos

url = 'https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=perl&site=stackoverflow'
json_url = requests.get(url).json()

data = json_url['items']

#Inicio_Respuestas_Contestadas

def respuestasContestadas():
    Contestadas=0
    for item in data:
        if item['is_answered'] == True:
            Contestadas = Contestadas+1

    return{"Respuestas contestadas":Contestadas}


def pruebaRespuestascontestadas():
    result_contestadas = respuestasContestadas()
    expected_contestadas = {"Respuestas contestadas":result_contestadas["Respuestas contestadas"]}

    assert result_contestadas == expected_contestadas

#Fin_Respuestas_Contestadas 

#Inicio_Respuestas_No_Contestadas

def respuestasNocontestadas():
    NoContestadas=0
    for item in data:
        if item['is_answered'] == False:
            NoContestadas = NoContestadas+1
        
    return{"Respuestas no contestadas":NoContestadas}

def pruebaRespuestasnocontestadas():
    result_nocontestadas = respuestasNocontestadas()
    expected_nocontestadas = {"Respuestas no contestadas":result_nocontestadas["Respuestas no contestadas"]}

    assert result_nocontestadas == expected_nocontestadas   

#Fin_Respuestas_No_Contestadas

#Inicio_Respuesta_Con_Menor_Número_De_Vistas

def numeroVistas():
    Vistas = None
    for item in data:
        if Vistas is None or item ['view_count'] < Vistas:
            Vistas = item ['view_count']
    return{"Menos vistas":Vistas}

def pruebaNumerovistas():
    result_vistas = numeroVistas()
    expected_vistas = {"Menos vistas":result_vistas["Menos vistas"]}

    assert result_vistas == expected_vistas

#Fin_Respuesta_Con_Menor_Número_De_Vistas

#Inicio_Respuesta_Mas_Vieja

def respuestaVieja():
    FechaVieja = None
    for item in data:
        if FechaVieja is None or datetime.datetime.fromtimestamp(item['creation_date']) < FechaVieja:
            FechaVieja = datetime.datetime.fromtimestamp(item['creation_date'])
       
    return{"Fecha vieja":FechaVieja}

def pruebaRespuestavieja():
    result_fechavieja = respuestaVieja()
    expected_fechavieja = {"Fecha vieja":result_fechavieja["Fecha vieja"]}

    assert result_fechavieja == expected_fechavieja

#Fin_Respuesta_Mas_Vieja

#Inicio_Respuesta_Actual

def respuestaActual():
    FechaActual = None
    for item in data:
        if FechaActual is None or datetime.datetime.fromtimestamp(item['creation_date']) > FechaActual:
            FechaActual = datetime.datetime.fromtimestamp(item['creation_date'])
     
    return{"Fecha actual":FechaActual}

def pruebaRespuestaactual():
    result_fechaactual = respuestaActual()
    expected_fechaactual = {"Fecha actual":result_fechaactual["Fecha actual"]}

    assert result_fechaactual == expected_fechaactual

#Fin_Respuesta_Actual

#Inicio_Mayor_Reputacion

def mayorReputacion():
    reputacion = 0
    for item in data:
        repu = item['owner']
        rate = repu.get('reputation')
        if type(rate) == int:
            if rate > reputacion:
                reputacion = rate
        else:
            continue
    return{"Mayor reputacion":reputacion}

def pruebaMayorreputacion():
    result_reputacion = mayorReputacion()
    expected_reputacion = {"Mayor reputacion":result_reputacion["Mayor reputacion"]}

    assert result_reputacion == expected_reputacion

#Fin_Mayor_Reputacion