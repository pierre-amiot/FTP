#!/bin/bash

# Chemin du répertoire de sauvegarde
backup_dir="/sauvegardes"

# Nom du fichier de sauvegarde basé sur la date et l'heure
backup_file="backup_$(date +"%d-%m-%Y_%H:%M").tar.gz"

# Déplacer dans le répertoire de sauvegarde
cd "$backup_dir"

# Compresser les fichiers et dossiers souhaités
tar -czvf "$backup_dir/$backup_file" --absolute-names /dossier/dossier_1 /dossier/dossier_2


# Envoyer le fichier de sauvegarde vers une autre machine (utilisation de SCP)
scp "$backup_dir/$backup_file" 192.168.147.1:/chemin/vers/dossier_destination
