#!/bin/sh
# Variables Globales
EXECUTE_PROGRAM=true
CONNECTED_USERS=0
PWD=$(pwd)
# functions
show_free_space_in_disk(){
  # El comando df con la flag -h nos permite obtener el tamaño de cada disco
  echo "$(df -h)"
}

show_usage_of_cpu() {
 # Funciona en mac pero no en ubuntu, investigar!
 echo "El uso de la cpu es: "
 echo "=================================================="
 echo "$(top -l 1 | grep ^CPU | tail -1)"
 echo "==================================================\n"
}

show_connected_users() {
  # Who nos devuelve sesiones en nuestro sistema operativo
  # wc -l cuenta las líneas
  # xargs nos elimina los espacios en blanco existentes
  CONNECTED_USERS=$(who | wc -l | xargs)
  echo "El número de usuarios conectados es ${CONNECTED_USERS}"
}

show_last_connected_users_number(){
 echo "El último número de usuarios conectados fue de ${CONNECTED_USERS}"
}

directory_size() {
 printf "Introduce el directorio: "
 read result
 echo "Buscando en $result desde $PWD"
 # du -hs nos devuelve el tamaño del directorio. Creo que existe alguna flag para indicarle la unidad de almacenamiento a devolver
 size=$(du -hs "$result")
 echo "$size" 
}

five_last_lines(){
 printf "Introduce la dirección del fichero: "
 read result
 echo "Buscando archivo en $result desde $PWD"
 echo "$(tail -5 "$result")"
}

copy_bash_and_c_files() {
 printf "Introduce el directorio origen: "
 read from
 printf "Introduce el directorio destino: "
 read to
 mkdir -p $to
 root_dirname=$(dirname $to)
 chmod 777 -R "$(dirname $root_dirname)"
 for i in $(find "$from" -type f -name "*.sh" -o -name "*.c"); do
  basename=$(basename $i)
  if cp -r "$i" "$to/$basename"; then
    echo "$basename copiado con éxito"
  else
      echo "Error al copiar $basename"
  fi
 done  
}

echo "Directorio de trabajo $PWD"
echo "\n¡Te doy la bienvenida al Super Script!\n"

while [ EXECUTE_PROGRAM ]; do

  echo "|===================================== MENÚ DEL PROGRAMA ======================================|"
  echo "|\t1. Obtener el espacio libre del disco                                                  |"
  echo "|\t2. Obtener el tamaño ocupado por un directorio (ficheros y subdirectorios incluídos)   |"
  echo "|\t3. Uso del procesador                                                                  |"
  echo "|\t4. Número de usuarios conectados                                                       |"
  echo "|\t5. Número de usuarios conectados desde la última vez que se preguntó                   |"
  echo "|\t6. Mostrar las últimas cinco líneas de un fichero                                      |"                    
  echo "|\t7. Copiar todos los archivos .c y .sh desde origen a destino                           |"
  echo "|\t8. Salir del programa                                                                  |"
  echo "|==============================================================================================|"

  printf "Elige una opción: "
  read result

 case $result in 
   "1")
     show_free_space_in_disk
     ;;
   "2")
     directory_size
     ;;
   "3")
     show_usage_of_cpu
     ;;
   "4")
     show_connected_users
     ;;
   "5")
     show_last_connected_users_number
    ;;
   "6")
     five_last_lines
    ;;
   "7")
    copy_bash_and_c_files
    ;;
   "8")
     echo "Has elegido salir del programa. ¡Adiós!"
     # Realmente con el break es suficiente  
     EXECUTE_PROGRAM=false
     break
     ;; 
   *)
    # Limpiamos la consola
    clear
    echo "\n¡Error! La opción introducida ($result) es incorrecta\n"
    ;;
  esac
done