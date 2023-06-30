% Código visto en clase:

esUnaPersona(juan).
esUnaPersona(nahuel).
esUnaPersona(mica).
esUnaPersona(victoria).

pasa(medrano,[151,109,160]).


colectivoFacu(Linea):-
    pasa(medrano,ListaLineas),
    member(Linea,ListaLineas).
tiene(juan,daltonismo,3).
tiene(juan,hermano,1).
tiene(nahuel,hermano,5).
tiene(nahuel,hermano,15).
tiene(nahuel,lentes,3).
tiene(victoria,lentes,8).
tiene(mica,lentes,89).

cantidadCosasQueTiene(Alguien,C,Cantidad):-
    esUnaPersona(Alguien),
    tiene(_,C,_),
    findall(C ,tiene(Alguien,C,_),L),
    length(L,Cantidad).

% Enunciado de labo:
% Punto 8
/*practica(Persona, Deporte)
Posibles estadisticas de deportes (functores):
natacion(MetrosDiarios, Medallas)
futbol(Medallas, Goles, Expulsiones)
rugby(Posicion, Medallas)
*/

practica(lisa, futbol(15, 100, 3)).
practica(lisa, natacion(1200, 20)).
practica(tod, rugby(pilar, 1)).
practica(rod, rugby(wings, 0)).
practica(rod, futbol(11, 0, 100)).

% Punto 9
/*
Ojo con este punto ahora que sabemos usar findall. Si queremos saber las personas que son nadadores, podemos saberlo con múltiples respuestas:

esNadador(Quien).
Quien = lisa ;

Que queramos saber quienes son, NO implica que tengamos que usar listas. Nos alcanza con lo que sabíamos hasta ahora -> los nadadores son quienes cumplen que practican el deporte natación.
*/

esNadador(Persona):-
    practica(Persona, natacion(_,_)).


% Punto 10

esBuenDeportista(Persona):-
    practica(Persona, Deporte),
    esBueno(Deporte).

/*
Tenemos tres casos para ser bueno, uno por cada deporte que implementamos de forma diferente (¡polimorfismo!)
*/

esBueno(natacion(MetrosDiarios, _)):-
    MetrosDiarios > 1000.

esBueno(futbol(_, Goles, Expulsiones)):-
    Diferencia is Goles - Expulsiones,
    Diferencia > 5.

esBueno(rugby(wings, _)).
esBueno(rugby(pilar, _)).

% Punto 11

esExistosa(Persona):-
    practica(Persona,_),
    forall(practica(Persona, Deporte), tieneMasDe10Medallas(Deporte)).

/*tieneMasDe10Medallas es una propiedad de un deporte, que ya vendrá con las estadisticas de la persona ligadas, recordemos que los deportes los planteamos como functores:

natacion(MetrosDiarios, Medallas)
futbol(Medallas, Goles, Expulsiones)
rugby(Posicion, Medallas)

*/

tieneMasDe10Medallas(Deporte):-
    medallas(Deporte, Cantidad),
    Cantidad > 10.

medallas(natacion(_, Medallas), Medallas).

medallas(futbol(Medallas, _, _), Medallas).

medallas(rugby(_, Medallas), Medallas).

/*
Ojo, un error común en este punto es plantear lo siguiente:

tieneMasDe10Medallas(natacion(_, Medallas)):-
    Medallas > 10.

tieneMasDe10Medallas(futbol(Medallas, _, _)):-
    Medallas > 10.

tieneMasDe10Medallas(rugby(_, Medallas)):-
    Medallas > 10.


Acá estamos repitiendo la lógica de que las medallas tienen que ser más de 10 -> eso es igual para todos los deportes, por eso en la solución de más arriba (la que no está comentada) lo planteamos en el predicado tieneMasDe10Medallas y tratamos por igual a todos los deportes; y recién hacemos las implementaciones por cada deporte al momento de relacionar con la Cantidad de Medallas, que es justamente lo que tienen distinto (en distinto orden los functores).
*/

%Punto 12
medallasTotales(Persona, TotalMedallas):-
    practica(Persona, _),
    findall(Medallas, medallasDe(Persona, Medallas), ListaMedallas),
    sumlist(ListaMedallas, TotalMedallas).

medallasDe(Persona, Medallas):-
    practica(Persona, Deporte),
    medallas(Deporte, Medallas).

%Punto 13
cantidadDeportesNoBuenos(Persona, Cantidad):-
    practica(Persona, _),
    findall(Deporte, noDestacaEn(Deporte, Persona), Deportes),
    length(Deportes, Cantidad).

%% Asumiendo que lo que se pide son los deportes que la persona practica pero no se destaca.
noDestacaEn(Deporte, Persona):-
    practica(Persona, Deporte),
    not(esBueno(Deporte)).

%% Si se interpreta como los deportes que existan y que la persona no se destaca, 
%% es necesario tener información de los nombres de los deportes existentes, 
%% vincular a los functores de las estadisitcas con el nombre del deporte 
%% y la solución se complica un poco más.

nombreDeporte(rugby).
nombreDeporte(futbol).
nombreDeporte(tenins).
nombreDeporte(natacion).



