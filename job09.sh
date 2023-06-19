#!/bin/bash

# Vérifier si le fichier CSV est fourni en argument
if [ $# -eq 0 ]; then
  echo "Veuillez spécifier le fichier CSV contenant les informations des utilisateurs FTP."
  exit 1
fi

# Parcourir le fichier CSV ligne par ligne
while IFS=',' read -r username password homedir role
do
  # Créer l'utilisateur FTP
  useradd -m -d "$homedir" -s /bin/false "$username"
  echo "$username:$password" | chpasswd
  
  # Autoriser l'accès FTP
  echo "RequireValidShell off" >> /etc/proftpd/proftpd.conf
  echo "DefaultRoot ~" >> /etc/proftpd/proftpd.conf

  # Donner les droits sudo (si nécessaire)
  if [ "$role" = "sudo" ]; then
    usermod -aG sudo "$username"
  fi

  # Définir l'utilisateur comme propriétaire du répertoire /home
  chown "$username":"$username" "$homedir"

  echo "Utilisateur FTP $username créé avec succès."
done < "$1"
