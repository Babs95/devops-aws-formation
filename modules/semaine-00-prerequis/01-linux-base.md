# 🐧 Linux de Base - Prérequis Formation AWS

> **Guide complet pour maîtriser les commandes Linux essentielles avant la formation AWS**

---

## 🎯 Objectifs d'Apprentissage

À la fin de ce module, vous serez capable de :

- ✅ Naviguer dans le système de fichiers Linux
- ✅ Gérer les fichiers et dossiers (créer, copier, déplacer, supprimer)
- ✅ Comprendre et gérer les permissions Unix
- ✅ Gérer les processus (lister, tuer, arrière-plan)
- ✅ Utiliser les éditeurs de texte (nano, vim)
- ✅ Comprendre les variables d'environnement
- ✅ Utiliser les pipes et redirections
- ✅ Installer des packages (apt, yum)
- ✅ Gérer les utilisateurs et groupes

---

## 🖥️ Pourquoi Linux pour AWS ?

**AWS = Linux partout !**
- **EC2** : 80% des instances tournent sous Linux
- **Lambda** : Runtime basé sur Amazon Linux
- **ECS/EKS** : Containers Linux
- **SSH** : Connexion aux serveurs

**Dans la vraie vie DevOps** :
- Déploiements sur serveurs Linux
- Scripts bash pour automatisation
- Debugging en production via terminal
- Infrastructure as Code (fichiers texte)

---

## 📚 Partie 1 : Navigation et Fichiers

### 1.1 Le Système de Fichiers Linux

#### Arborescence Linux (tout est fichier !)

```
/                           ← Root (racine)
├── home/                   ← Dossiers utilisateurs
│   ├── user1/
│   └── user2/
├── etc/                    ← Fichiers de configuration
│   ├── hosts
│   └── ssh/
├── var/                    ← Fichiers variables (logs, cache)
│   ├── log/
│   └── www/
├── usr/                    ← Programmes utilisateur
│   ├── bin/               ← Binaires (commandes)
│   └── local/
├── tmp/                    ← Fichiers temporaires
├── opt/                    ← Applications optionnelles
└── bin/                    ← Binaires système essentiels
```

**Concepts importants** :
- **/** = Racine (root), point de départ de tout
- **~** = Répertoire personnel (home) de l'utilisateur actuel
- **.** = Répertoire courant
- **..** = Répertoire parent

---

### 1.2 Commandes de Navigation

#### pwd - Print Working Directory

```bash
# Afficher le répertoire courant
pwd
# Output: /home/user/documents
```

**Analogie** : "Où suis-je actuellement ?"

---

#### ls - List (lister les fichiers)

```bash
# Lister les fichiers du répertoire courant
ls

# Lister avec détails (permissions, taille, date)
ls -l
# Output:
# drwxr-xr-x 2 user user 4096 Nov 22 10:30 documents
# -rw-r--r-- 1 user user  156 Nov 22 10:25 fichier.txt

# Lister incluant fichiers cachés (commencent par .)
ls -a

# Lister avec taille lisible (K, M, G)
ls -lh

# Combinaison (très utilisé)
ls -lah

# Trier par date de modification (le plus récent en bas)
ls -lt

# Trier par taille
ls -lS
```

**Décodage de `ls -l`** :
```
-rw-r--r-- 1 user user 156 Nov 22 10:25 fichier.txt
│││││││││  │  │    │    │       │        └─ Nom du fichier
│││││││││  │  │    │    │       └─ Date de modification
│││││││││  │  │    │    └─ Taille (en bytes)
│││││││││  │  │    └─ Groupe propriétaire
│││││││││  │  └─ Utilisateur propriétaire
│││││││││  └─ Nombre de liens
│││││││││
│││└┴┴┴┴┴─ Permissions (autres utilisateurs): r-- (lecture seule)
││└────── Permissions (groupe): r-- (lecture seule)
│└─────── Permissions (propriétaire): rw- (lecture + écriture)
└──────── Type: - = fichier, d = dossier, l = lien symbolique
```

---

#### cd - Change Directory

```bash
# Aller dans le dossier documents
cd documents

# Aller dans le dossier parent
cd ..

# Aller dans le répertoire personnel
cd ~
# ou simplement
cd

# Aller à la racine
cd /

# Aller dans le dossier précédent
cd -

# Chemins absolus vs relatifs
cd /home/user/documents          # Absolu (depuis la racine)
cd ../downloads                   # Relatif (depuis où je suis)
```

---

### 1.3 Commandes de Gestion de Fichiers

#### mkdir - Make Directory

```bash
# Créer un dossier
mkdir mon_dossier

# Créer plusieurs dossiers d'un coup
mkdir dossier1 dossier2 dossier3

# Créer une arborescence complète (parents automatiques)
mkdir -p projet/src/components/header
# Crée : projet/ puis src/ puis components/ puis header/

# Créer avec permissions spécifiques
mkdir -m 755 public_folder
```

---

#### touch - Créer un fichier vide

```bash
# Créer un fichier vide
touch fichier.txt

# Créer plusieurs fichiers
touch file1.txt file2.txt file3.txt

# Mettre à jour la date de modification d'un fichier existant
touch fichier_existant.txt
```

---

#### cp - Copy (copier)

```bash
# Copier un fichier
cp source.txt destination.txt

# Copier vers un autre dossier
cp fichier.txt /home/user/backup/

# Copier un dossier entier (récursif)
cp -r dossier/ backup_dossier/

# Copier en conservant les attributs (permissions, dates)
cp -a original/ copie/

# Copier avec confirmation si écrasement
cp -i source.txt destination.txt

# Copier en mode verbeux (afficher ce qui est copié)
cp -v fichier.txt backup/
```

---

#### mv - Move (déplacer ou renommer)

```bash
# Renommer un fichier
mv ancien_nom.txt nouveau_nom.txt

# Déplacer un fichier vers un autre dossier
mv fichier.txt /home/user/documents/

# Déplacer plusieurs fichiers
mv file1.txt file2.txt file3.txt /destination/

# Déplacer un dossier
mv dossier/ /nouvelle/location/

# Renommer avec confirmation
mv -i ancien.txt nouveau.txt
```

---

#### rm - Remove (supprimer)

```bash
# Supprimer un fichier
rm fichier.txt

# Supprimer avec confirmation
rm -i fichier.txt

# Supprimer un dossier vide
rmdir dossier_vide/

# Supprimer un dossier et tout son contenu (ATTENTION !)
rm -r dossier/

# Forcer la suppression sans confirmation (DANGEREUX !)
rm -rf dossier/

# Supprimer tous les fichiers .txt du dossier courant
rm *.txt

# ⚠️ ATTENTION : Il n'y a PAS de corbeille ! Une fois supprimé = perdu !
```

**Astuce sécurité** :
```bash
# Toujours vérifier d'abord avec ls
ls *.log
# Puis supprimer
rm *.log
```

---

### 1.4 Visualiser le Contenu de Fichiers

#### cat - Concatenate (afficher tout)

```bash
# Afficher le contenu d'un fichier
cat fichier.txt

# Afficher plusieurs fichiers à la suite
cat file1.txt file2.txt

# Afficher avec numéros de lignes
cat -n fichier.txt

# Créer un fichier rapidement (CTRL+D pour terminer)
cat > nouveau.txt
Tapez votre texte ici
Ligne 2
^D
```

---

#### less - Afficher page par page

```bash
# Lire un fichier long page par page
less fichier.txt

# Navigation dans less :
# - ESPACE : page suivante
# - b : page précédente
# - / : rechercher
# - n : occurrence suivante
# - q : quitter

# Exemple pratique
less /var/log/syslog
```

---

#### head et tail - Début et fin de fichier

```bash
# Afficher les 10 premières lignes
head fichier.txt

# Afficher les 20 premières lignes
head -n 20 fichier.txt

# Afficher les 10 dernières lignes
tail fichier.txt

# Afficher les 50 dernières lignes
tail -n 50 fichier.txt

# Suivre un fichier en temps réel (TRÈS UTILE pour logs)
tail -f /var/log/apache2/access.log

# Suivre les 100 dernières lignes en temps réel
tail -n 100 -f application.log
```

---

#### grep - Rechercher dans des fichiers

```bash
# Chercher un mot dans un fichier
grep "erreur" log.txt

# Recherche insensible à la casse
grep -i "ERROR" log.txt

# Afficher le numéro de ligne
grep -n "TODO" code.py

# Recherche récursive dans tous les fichiers du dossier
grep -r "password" /etc/

# Inverser la recherche (lignes qui ne contiennent PAS le motif)
grep -v "DEBUG" log.txt

# Compter le nombre d'occurrences
grep -c "error" log.txt

# Recherche avec expressions régulières
grep -E "^[0-9]{3}" fichier.txt  # Lignes commençant par 3 chiffres
```

---

## 📚 Partie 2 : Permissions et Propriétés

### 2.1 Comprendre les Permissions

#### Notation rwx

```
r = Read (4)       → Lire le fichier / Lister le dossier
w = Write (2)      → Modifier le fichier / Créer/Supprimer dans le dossier
x = Execute (1)    → Exécuter le fichier / Entrer dans le dossier
```

**Exemple** :
```
-rw-r--r--
│││ │ │ │
│││ │ │ └─ Autres : r-- (4) = lecture seule
│││ │ └─── Groupe : r-- (4) = lecture seule
│││ └───── Propriétaire : rw- (6) = lecture + écriture
││└─────── w = Write
│└──────── r = Read
└───────── - = Fichier normal

drwxr-xr-x
│││ │ │ │
│└─┴─┴─┴─┴─ rwxr-xr-x = 755
└─────────── d = Directory (dossier)
```

---

### 2.2 chmod - Change Mode (modifier permissions)

#### Notation numérique (octale)

```bash
# Formule : Owner + Group + Others
# r=4, w=2, x=1

# Exemples courants :
chmod 644 fichier.txt    # rw-r--r-- (fichier classique)
chmod 755 script.sh      # rwxr-xr-x (script exécutable)
chmod 600 secret.key     # rw------- (fichier privé)
chmod 777 public/        # rwxrwxrwx (TOUT LE MONDE, dangereux !)

# Calcul :
# 7 = 4+2+1 = rwx
# 6 = 4+2   = rw-
# 5 = 4+1   = r-x
# 4 = 4     = r--
```

#### Notation symbolique

```bash
# u = user (propriétaire)
# g = group
# o = others
# a = all (tous)

# Ajouter permission d'exécution au propriétaire
chmod u+x script.sh

# Retirer permission d'écriture au groupe
chmod g-w fichier.txt

# Ajouter lecture pour tout le monde
chmod a+r document.txt

# Définir exactement rwxr-xr-x
chmod u=rwx,g=rx,o=rx script.sh

# Récursif (tous les fichiers du dossier)
chmod -R 755 website/
```

---

### 2.3 chown - Change Owner (changer propriétaire)

```bash
# Changer le propriétaire
sudo chown user fichier.txt

# Changer propriétaire et groupe
sudo chown user:group fichier.txt

# Changer seulement le groupe
sudo chown :group fichier.txt

# Récursif
sudo chown -R user:www-data /var/www/
```

---

## 📚 Partie 3 : Processus

### 3.1 Afficher les Processus

#### ps - Process Status

```bash
# Processus de l'utilisateur courant
ps

# Tous les processus (format complet)
ps aux

# Processus en arbre (hiérarchie)
ps auxf

# Filtrer un processus spécifique
ps aux | grep nginx
```

---

#### top - Monitoring en temps réel

```bash
# Afficher les processus en temps réel (comme Task Manager Windows)
top

# Navigation dans top :
# - q : quitter
# - k : tuer un processus (demande le PID)
# - M : trier par utilisation mémoire
# - P : trier par utilisation CPU

# Version améliorée : htop (plus user-friendly)
htop
```

---

### 3.2 Gérer les Processus

#### kill - Terminer un processus

```bash
# Tuer un processus par son PID (Process ID)
kill 1234

# Forcer la fermeture (SIGKILL)
kill -9 1234

# Tuer tous les processus par nom
pkill nginx

# Tuer tous les processus d'un utilisateur
pkill -u username
```

---

#### Background et Foreground

```bash
# Lancer une commande en arrière-plan (background)
long_process &

# Mettre un processus en pause
# CTRL + Z

# Liste des jobs en arrière-plan
jobs

# Reprendre un job en arrière-plan
bg %1

# Ramener un job en avant-plan
fg %1

# Exemple pratique
sleep 100 &          # Lance sleep en background
jobs                 # Voir les jobs
# [1]+  Running    sleep 100 &
fg %1                # Ramène en foreground
# CTRL+Z             # Pause
bg %1                # Reprend en background
```

---

## 📚 Partie 4 : Pipes et Redirections

### 4.1 Redirections

```bash
# Rediriger la sortie vers un fichier (écrase le fichier)
echo "Hello" > fichier.txt

# Rediriger en ajoutant à la fin (append)
echo "World" >> fichier.txt

# Rediriger les erreurs
command 2> errors.log

# Rediriger sortie standard ET erreurs
command &> output_and_errors.log

# Rediriger sortie vers un fichier et erreurs vers un autre
command > output.log 2> errors.log

# Jeter la sortie (trou noir)
command > /dev/null
```

---

### 4.2 Pipes (|)

**Le pipe permet de chaîner des commandes : la sortie de A devient l'entrée de B**

```bash
# Compter le nombre de fichiers
ls | wc -l

# Trouver les processus nginx
ps aux | grep nginx

# Afficher les 10 plus gros fichiers
ls -lh | sort -k5 -hr | head -n 10

# Chercher dans des logs et compter
cat /var/log/syslog | grep "error" | wc -l

# Pipeline complexe
cat access.log | grep "404" | awk '{print $1}' | sort | uniq -c | sort -nr | head -10
# Expliqué :
# 1. Lire access.log
# 2. Filtrer lignes avec "404"
# 3. Extraire la première colonne (IP)
# 4. Trier les IPs
# 5. Compter les occurrences uniques
# 6. Trier par nombre (décroissant)
# 7. Afficher le top 10
```

---

## 📚 Partie 5 : Éditeurs de Texte

### 5.1 nano (Simple et user-friendly)

```bash
# Ouvrir un fichier
nano fichier.txt

# Raccourcis importants :
# CTRL+O : Sauvegarder (Write Out)
# CTRL+X : Quitter
# CTRL+K : Couper la ligne
# CTRL+U : Coller
# CTRL+W : Rechercher
# CTRL+G : Aide

# Ouvrir à une ligne spécifique
nano +25 fichier.txt
```

---

### 5.2 vim (Puissant mais courbe d'apprentissage)

```bash
# Ouvrir un fichier
vim fichier.txt

# VIM a 2 modes principaux :
# - Mode NORMAL (par défaut) : Navigation et commandes
# - Mode INSERT : Édition de texte

# Mode NORMAL → Mode INSERT :
i       # Insert avant le curseur
a       # Insert après le curseur
o       # Nouvelle ligne en dessous
O       # Nouvelle ligne au-dessus

# Mode INSERT → Mode NORMAL :
ESC     # Touche Échap

# Commandes en mode NORMAL :
:w      # Sauvegarder (Write)
:q      # Quitter
:wq     # Sauvegarder et quitter
:q!     # Quitter sans sauvegarder
dd      # Supprimer la ligne
yy      # Copier la ligne
p       # Coller
u       # Undo
/mot    # Rechercher "mot"
n       # Occurrence suivante

# Exemple d'usage :
# 1. vim fichier.txt
# 2. Appuyer sur 'i' pour entrer en mode INSERT
# 3. Taper votre texte
# 4. Appuyer sur ESC
# 5. Taper :wq et ENTER
```

**Mémo minimal vim** :
```
i → écrire → ESC → :wq → ENTER
```

---

## 📚 Partie 6 : Variables d'Environnement

### 6.1 Afficher et Définir des Variables

```bash
# Afficher toutes les variables d'environnement
env

# Afficher une variable spécifique
echo $HOME
echo $PATH
echo $USER

# Définir une variable temporaire (session courante)
MY_VAR="hello"
echo $MY_VAR

# Exporter une variable (disponible pour les sous-processus)
export API_KEY="abc123"

# Définir de manière permanente (ajouter dans ~/.bashrc ou ~/.bash_profile)
echo 'export API_KEY="abc123"' >> ~/.bashrc
source ~/.bashrc  # Recharger le fichier
```

---

### 6.2 Variables Importantes

```bash
# Répertoire personnel
echo $HOME
# /home/user

# Utilisateur courant
echo $USER
# user

# Chemin de recherche des commandes
echo $PATH
# /usr/local/bin:/usr/bin:/bin

# Shell actuel
echo $SHELL
# /bin/bash

# Répertoire courant
echo $PWD
# /home/user/documents
```

---

## 📚 Partie 7 : Installation de Packages

### 7.1 APT (Debian, Ubuntu)

```bash
# Mettre à jour la liste des packages
sudo apt update

# Mettre à jour tous les packages installés
sudo apt upgrade

# Installer un package
sudo apt install nginx

# Installer plusieurs packages
sudo apt install curl wget git

# Rechercher un package
apt search python3

# Voir les infos d'un package
apt show nginx

# Supprimer un package
sudo apt remove nginx

# Supprimer un package et ses fichiers de configuration
sudo apt purge nginx

# Nettoyer les packages inutiles
sudo apt autoremove
```

---

### 7.2 YUM/DNF (CentOS, RedHat, Amazon Linux)

```bash
# Mettre à jour tous les packages
sudo yum update

# Installer un package
sudo yum install httpd

# Rechercher
yum search python

# Supprimer
sudo yum remove httpd

# Lister les packages installés
yum list installed

# DNF (version moderne de YUM)
sudo dnf install package-name
```

---

## 📚 Partie 8 : Utilisateurs et Groupes

### 8.1 Gestion Utilisateurs

```bash
# Créer un utilisateur
sudo useradd -m -s /bin/bash john

# Définir un mot de passe
sudo passwd john

# Supprimer un utilisateur
sudo userdel john

# Supprimer utilisateur et son home
sudo userdel -r john

# Modifier un utilisateur (ajouter au groupe)
sudo usermod -aG docker john

# Changer de shell
sudo usermod -s /bin/zsh john

# Voir les infos d'un utilisateur
id john
# uid=1001(john) gid=1001(john) groups=1001(john),27(sudo)
```

---

### 8.2 Gestion Groupes

```bash
# Créer un groupe
sudo groupadd developers

# Ajouter un utilisateur à un groupe
sudo usermod -aG developers john

# Supprimer un groupe
sudo groupdel developers

# Lister les membres d'un groupe
getent group developers
```

---

## 📚 Partie 9 : Commandes Utiles Diverses

### 9.1 Recherche de Fichiers

#### find

```bash
# Trouver tous les fichiers .txt dans le dossier courant
find . -name "*.txt"

# Trouver tous les fichiers modifiés dans les dernières 24h
find . -mtime -1

# Trouver fichiers de plus de 100MB
find . -size +100M

# Trouver et supprimer
find . -name "*.log" -delete

# Trouver et exécuter une commande
find . -name "*.jpg" -exec chmod 644 {} \;
```

#### which et whereis

```bash
# Trouver le chemin d'une commande
which python3
# /usr/bin/python3

# Trouver binaire, source et man page
whereis nginx
# nginx: /usr/sbin/nginx /etc/nginx /usr/share/nginx /usr/share/man/man8/nginx.8.gz
```

---

### 9.2 Compression et Archives

```bash
# Créer une archive tar
tar -cvf archive.tar dossier/

# Créer une archive tar.gz (compressée)
tar -czvf archive.tar.gz dossier/

# Extraire une archive tar
tar -xvf archive.tar

# Extraire une archive tar.gz
tar -xzvf archive.tar.gz

# Lister le contenu sans extraire
tar -tzf archive.tar.gz

# Zipper un fichier
gzip fichier.txt           # Crée fichier.txt.gz
gunzip fichier.txt.gz      # Décompresse

# Zipper/dézipper (format .zip)
zip archive.zip fichier.txt
unzip archive.zip
```

**Mémo tar** :
- **c** = create
- **x** = extract
- **v** = verbose (afficher les fichiers)
- **f** = file (spécifier le nom)
- **z** = gzip compression

---

### 9.3 Réseau

```bash
# Télécharger un fichier
wget https://example.com/file.zip

# Télécharger avec curl
curl -O https://example.com/file.zip

# Afficher l'IP
ip addr
# ou
ifconfig

# Tester la connectivité
ping google.com

# Afficher les ports ouverts
sudo netstat -tuln
# ou
sudo ss -tuln

# DNS lookup
nslookup google.com
dig google.com

# Tracer la route
traceroute google.com
```

---

### 9.4 Informations Système

```bash
# Utilisation du disque
df -h

# Espace utilisé par dossier
du -sh *
du -h --max-depth=1 /home

# Utilisation RAM et CPU
free -h
top
htop

# Informations système
uname -a         # Kernel et OS
hostname         # Nom de la machine
uptime          # Depuis combien de temps le système tourne

# Voir la distribution Linux
cat /etc/os-release

# Historique des commandes
history
# Réexécuter la commande 42
!42
# Réexécuter la dernière commande
!!
```

---

## 🛠️ Lab Pratique : Exercice Complet

### Scénario : Créer un environnement de projet

```bash
# 1. Créer une structure de projet
mkdir -p ~/projet-aws/{src,logs,config,scripts}
cd ~/projet-aws

# 2. Créer des fichiers
touch src/app.py
touch config/settings.json
touch logs/app.log
touch scripts/deploy.sh

# 3. Ajouter du contenu
cat > src/app.py <<'EOF'
#!/usr/bin/env python3
print("Hello AWS!")
EOF

cat > scripts/deploy.sh <<'EOF'
#!/bin/bash
echo "Déploiement en cours..."
python3 ../src/app.py
EOF

# 4. Rendre le script exécutable
chmod +x scripts/deploy.sh

# 5. Créer un fichier de log
echo "$(date) - Application démarrée" >> logs/app.log

# 6. Lister la structure
tree
# ou
ls -R

# 7. Exécuter le script
cd scripts
./deploy.sh

# 8. Voir les logs
tail logs/app.log

# 9. Créer une archive
cd ~
tar -czvf projet-aws-backup.tar.gz projet-aws/

# 10. Vérifier l'archive
tar -tzf projet-aws-backup.tar.gz | head -10
```

---

## ✅ Checklist de Validation

### Navigation et Fichiers
- [ ] Je sais me déplacer dans les dossiers (cd, pwd)
- [ ] Je sais lister les fichiers avec détails (ls -lah)
- [ ] Je sais créer des dossiers et fichiers (mkdir, touch)
- [ ] Je sais copier, déplacer, supprimer (cp, mv, rm)
- [ ] Je sais visualiser le contenu de fichiers (cat, less, head, tail)
- [ ] Je sais rechercher dans des fichiers (grep)

### Permissions
- [ ] Je comprends rwx et la notation 755, 644, etc.
- [ ] Je sais modifier les permissions (chmod)
- [ ] Je sais changer le propriétaire (chown)

### Processus
- [ ] Je sais lister les processus (ps, top)
- [ ] Je sais tuer un processus (kill, pkill)
- [ ] Je sais lancer un processus en arrière-plan (&, bg, fg)

### Pipes et Redirections
- [ ] Je sais rediriger vers un fichier (>, >>)
- [ ] Je sais utiliser les pipes (|)
- [ ] Je sais combiner plusieurs commandes

### Éditeurs
- [ ] Je sais éditer un fichier avec nano
- [ ] Je connais les bases de vim (i, ESC, :wq)

### Variables
- [ ] Je sais afficher une variable ($HOME, $PATH)
- [ ] Je sais définir et exporter une variable

### Packages
- [ ] Je sais installer un package (apt install ou yum install)
- [ ] Je sais mettre à jour le système

### Utilisateurs
- [ ] Je sais créer/supprimer un utilisateur
- [ ] Je sais ajouter un utilisateur à un groupe

### Divers
- [ ] Je sais rechercher un fichier (find)
- [ ] Je sais créer/extraire une archive (tar)
- [ ] Je sais télécharger un fichier (wget, curl)
- [ ] Je sais voir l'utilisation disque (df, du)

---

## 🎯 Exercices de Validation

### Exercice 1 : Navigation
```bash
# 1. Aller dans votre home
# 2. Créer dossier "linux-training"
# 3. Créer sous-dossiers: docs, scripts, data
# 4. Créer 3 fichiers vides dans docs/
# 5. Lister avec permissions et tailles
```

<details>
<summary>Solution</summary>

```bash
cd ~
mkdir -p linux-training/{docs,scripts,data}
cd linux-training/docs
touch file1.txt file2.txt file3.txt
ls -lh
```
</details>

---

### Exercice 2 : Permissions
```bash
# 1. Créer un script hello.sh
# 2. Ajouter du contenu (echo "Hello")
# 3. Le rendre exécutable
# 4. L'exécuter
```

<details>
<summary>Solution</summary>

```bash
cat > hello.sh <<'EOF'
#!/bin/bash
echo "Hello from script!"
EOF

chmod +x hello.sh
./hello.sh
```
</details>

---

### Exercice 3 : Recherche et Filtrage
```bash
# 1. Créer un fichier log.txt avec plusieurs lignes contenant "ERROR" et "INFO"
# 2. Afficher seulement les lignes avec ERROR
# 3. Compter combien de lignes contiennent ERROR
# 4. Rediriger les erreurs dans errors.txt
```

<details>
<summary>Solution</summary>

```bash
cat > log.txt <<'EOF'
INFO: Application started
ERROR: Failed to connect to database
INFO: Retrying connection
ERROR: Connection timeout
INFO: Application running
EOF

grep "ERROR" log.txt
grep -c "ERROR" log.txt
grep "ERROR" log.txt > errors.txt
cat errors.txt
```
</details>

---

## 📖 Ressources Complémentaires

### Cheat Sheets
- **Linux Command Line Cheat Sheet** : https://cheatography.com/davechild/cheat-sheets/linux-command-line/
- **Bash Scripting Cheat Sheet** : https://devhints.io/bash

### Tutoriels Interactifs
- **Linux Journey** : https://linuxjourney.com/ (gratuit, excellent)
- **OverTheWire Bandit** : https://overthewire.org/wargames/bandit/ (apprendre en jouant)

### Livres
- "The Linux Command Line" par William Shotts (gratuit en PDF)

### Vidéos
- **freeCodeCamp - Linux for Beginners** (YouTube, 4h)
- **Traversy Media - Linux Crash Course** (YouTube, 1h)

---

## 💡 Conseils

1. **Pratiquer quotidiennement** : 15-30min par jour > 3h le week-end
2. **Utiliser Linux** : Installer Ubuntu sur VirtualBox ou utiliser WSL2 (Windows)
3. **Éviter la souris** : Forcer vous à tout faire au clavier
4. **Lire les man pages** : `man ls` pour voir toutes les options de ls
5. **Expérimenter** : Vous ne casserez rien (sauf avec sudo rm -rf /)

---

## 🚀 Prochaine Étape

Une fois cette checklist validée à 100%, vous êtes prêt pour :
- **Module suivant** : Réseaux (TCP/IP, DNS, HTTP/HTTPS)
- **Puis** : Semaine 1 du programme AWS (IAM et Setup)

---

**Temps estimé pour maîtriser** : 10-15 heures de pratique

💪 **Bon courage ! Linux est une compétence qui vous servira toute votre carrière !**
