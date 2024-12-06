# Variables Globales

EXECUTE_PROGRAM=true
CONNECTED_USERS=0
# functions
showFreeSpaceInDisk(){
  echo "$(df -h)"
}

showUsageOfCpu() {
 echo "El uso de la cpu es: "
 echo "=================================================="
 echo "$(top -l 1 | grep ^CPU | tail -1)"
 echo "==================================================\n"
}

show_connected_users() {
  CONNECTED_USERS=$(who | wc -l | xargs)
  echo "El número de usuarios conectados es ${CONNECTED_USERS}"
}

show_last_connected_users_number(){
 echo "El último número de usuarios conectados fue de ${CONNECTED_USERS}"
}

directory_size() {
 printf "Introduce el directorio: "
 read result
 echo "Buscando en $result desde $pwd"
 size=$(du -hs "$result")
 echo "$size" 
}

five_last_lines(){
 printf "Introduce la dirección del fichero: "
 read result
 echo "Buscando archivo en $result desde $pwd"
 echo "$(tail -5 "$result")"
}

copy_bash_and_c_files() {
 printf "Introduce el directorio origen: "
 read from
 echo "\n"
 printf "Introduce el directorio destino: "
 read to
 mkdir -p $to


 files=($(ls "$from" | grep '.[sh|c]$'))
 
 for i in "${files[@]}"
 do
  echo "El archivo es $i" g
  $(cp "$from/$i" "$to/$i")
 done  

}

echo "¡Te doy la bienvenida al Super Script!"

while [ EXECUTE_PROGRAM ]; do

  echo "=========== MENÚ DEL PROGRAMA ==========="
  echo "\t1. Obtener el espacio libre del disco"
  echo "\t2. Obtener el tamaño ocupado por un directorio (ficheros y subdirectorios incluídos)"
  echo "\t3. Uso del procesador"
  echo "\t4. Número de usuarios conectados"
  echo "\t5. Número de usuarios conectados desde la última vez que se preguntó"
  echo "\t6. Mostrar las últimas cinco líneas de un fichero"
  echo "\t7. Copiar todos los archivos .c y .sh desde origen a destino"
  echo "\t8. Salir del programa\n"
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
     EXECUTE_PROGRAM=false
     break
     ;; 
   *)
    echo "Opción incorrecta"
    ;;
  esac
done

