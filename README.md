# [Blog] La science des données vue d'un unixien
Ce repository contient le code source illustrant l'article de mon blog <i><a href="http://blog.inovia-conseil.fr/?p=226">La science des données vue d'un unixien</a></i>

## Introduction
[Baptiste Coulmont](http://coulmont.com/bac/nuage.html), un universitaire spécialiste de la sociologie des prénoms, diffuse chaque année le classement des prénoms de candidats ayant obtenu une mention *Très Bien* au baccalauréat. Comme pour les années précédentes, ses résultats mettent en évidence une forme de déterminisme social où **Apolline**, par exemple, est beaucoup plus susceptible d’obtenir une mention que **Jordan**.

La médiatisation de ces travaux a suscité ma curiosité. En bon Unixien, je me suis adonné à la pratique de la science des données (*data science*) en ligne de commande, en prenant pour objet d’étude les résultats du brevet des collèges 2015 (série générale).

Sur le plan de l’analyse sociologique, j’aboutis aux mêmes conclusions que Baptiste Coulmont :

- **Adèle**, **Apolline**, **Alix**, **Louise** (entre autres) sont sur-représentées chez les détenteurs de la mention *Très Bien* au brevet des collèges alors que **Steven**, **Alan**, **Dylan**, **Jordan** ou **Bryan** sont les moins bien représentés
- par ailleurs, les filles obtiennent de bien meilleurs résultats scolaires que les garçons

La représentation visuelle du nuage des prénoms est réalisée avec **GNU Plot**, avec le pourcentage des mentions TB en abscisse et le nombre d’élèves en ordonnée (cliquer sur l’image pour l’agrandir).

![Prenoms](https://github.com/ksahnine/datascience-brevet-mentions/raw/master/img/brevet-mentions-2015.png "Nuage des prenoms")

