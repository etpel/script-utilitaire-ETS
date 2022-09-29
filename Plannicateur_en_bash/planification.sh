#!/bin/bash

# Ce simple script filtre le pdf de planification de l'ETS pour trouver 
# les planifications des cours dans la liste de l'argument 1

# arg 1 -> liste des cours d'interet (fichier texte)

echo "chosir le programme d'étude"
echo "1. Enseignements généraux"
echo "2. Génie de la construction"
echo "3. Génie électrique"
echo "4. Génie logiciel"
echo "5. Génie mécanique"
echo "6. Génie des opérations et de la logistique"
echo "7. Génie de la production automatisée"
echo "8. Génie des technologies de l'information"
read programme
echo "$programme"
GetPlanifLink(){
    echo "$(wget https://www.etsmtl.ca/etudiants/horaire-cours -q -O -|grep "$1"|sed -n 's/.*href="\([^"]*\).*/\1/p')"
}
case $programme in

  "1")
    link=$(GetPlanifLink "Enseignements généraux")
    ;;

  2)
    link=$(GetPlanifLink "Génie de la construction")
    ;;

  3)
    link=$(GetPlanifLink "Génie électrique") 
    ;;
  4)
    link=$(GetPlanifLink "Génie logiciel") 
    ;;
  5)
    link=$(GetPlanifLink "Génie mécanique")
    ;;
  6)
    link=$(GetPlanifLink "Génie des opérations et de la logistique")
    ;;
  7)
    link=$(GetPlanifLink "Génie de la production automatisée")
    ;;
  8)
    link=$(GetPlanifLink "Génie des technologies de l'information")
    ;;
  *)
    echo "erreur d'entrée"
    exit 1
    ;;
esac

wget $link -q -O "temp.pdf"
pdftotext -layout "./temp.pdf"
grep -f "$1" -A1 -B1 "./temp.txt"> Planification.txt

## Get head from temp.text
cat <<IN > Planification.txt 
$(head -n5 temp.txt; cat Planification.txt)
IN

echo "fichier des planif dans Planification.txt"
rm temp*
