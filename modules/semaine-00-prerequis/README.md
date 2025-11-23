# 🎓 Semaine 0 : Prérequis Techniques

> **Modules de préparation avant de commencer la formation AWS**

---

## 🎯 Objectif

Ces modules vous permettent d'acquérir les compétences de base nécessaires avant de commencer la formation AWS. Si vous maîtrisez déjà Linux et les réseaux, vous pouvez passer directement à la **Semaine 1**.

---

## 📚 Modules Disponibles

### [01 - Linux de Base](./01-linux-base.md)

**Durée estimée** : 10-15 heures

**Contenu** :
- ✅ Navigation dans le système de fichiers
- ✅ Gestion de fichiers et dossiers (cp, mv, rm, mkdir)
- ✅ Permissions Unix (chmod, chown)
- ✅ Gestion des processus (ps, top, kill)
- ✅ Éditeurs de texte (nano, vim)
- ✅ Variables d'environnement
- ✅ Pipes et redirections (|, >, >>)
- ✅ Installation de packages (apt, yum)
- ✅ Gestion utilisateurs et groupes

**Pourquoi c'est important ?**
- 80% des instances EC2 tournent sous Linux
- SSH = connexion aux serveurs AWS
- Scripts bash pour automatisation DevOps

**À la fin de ce module, vous serez capable de** :
- Vous connecter à une instance EC2 en SSH
- Naviguer et gérer des fichiers
- Installer et configurer des applications
- Débugger des problèmes sur serveurs Linux

---

### [02 - Réseaux de Base](./02-reseaux-base.md)

**Durée estimée** : 8-12 heures

**Contenu** :
- ✅ Modèle TCP/IP et OSI
- ✅ Adresses IP et sous-réseaux (CIDR, masques)
- ✅ TCP vs UDP
- ✅ Ports et protocoles (22, 80, 443, etc.)
- ✅ DNS (résolution de noms)
- ✅ HTTP/HTTPS et certificats SSL
- ✅ Outils de diagnostic (ping, traceroute, curl, nslookup)

**Pourquoi c'est important ?**
- VPC AWS = réseaux privés dans le cloud
- Subnets, Security Groups, Load Balancers
- Route 53 = DNS managé AWS
- CloudFront = CDN

**À la fin de ce module, vous serez capable de** :
- Comprendre et configurer un VPC AWS
- Diagnostiquer des problèmes de connectivité
- Sécuriser des applications avec Security Groups
- Configurer Route 53 et CloudFront

---

## 📋 Test de Niveau

### Avez-vous besoin de ces modules ?

Faites ce quiz rapide pour savoir si vous devez suivre ces prérequis :

#### Quiz Linux

- [ ] Je sais me déplacer dans les dossiers (cd, pwd, ls)
- [ ] Je sais créer/copier/supprimer des fichiers (touch, cp, mv, rm)
- [ ] Je comprends les permissions (rwx, chmod 755)
- [ ] Je sais éditer un fichier avec nano ou vim
- [ ] Je sais utiliser grep et les pipes (|)
- [ ] Je sais installer des packages (apt install)

**Si < 4 checkboxes cochées** → Suivre le module Linux

#### Quiz Réseaux

- [ ] Je comprends les adresses IP (192.168.1.10/24)
- [ ] Je connais la différence entre TCP et UDP
- [ ] Je connais les ports courants (22, 80, 443)
- [ ] Je comprends le rôle du DNS
- [ ] Je sais différencier HTTP et HTTPS
- [ ] Je sais utiliser ping, curl, nslookup

**Si < 4 checkboxes cochées** → Suivre le module Réseaux

---

## 🗓️ Planning Recommandé

### Option 1 : Complet (si débutant)
```
Semaine 0.1 (10-15h) : Linux de base
Semaine 0.2 (8-12h)  : Réseaux de base
Semaine 1            : IAM et Setup AWS
```

### Option 2 : Révision (si connaissances partielles)
```
Jours 1-3 (5h)  : Lire les modules et pratiquer les exercices
Jour 4          : Validation checklist
Semaine 1       : IAM et Setup AWS
```

### Option 3 : Skip (si expert)
```
Jour 1     : Valider les checklists
Semaine 1  : IAM et Setup AWS
```

---

## 🛠️ Setup Initial

### 1. Environnement Linux

**Si vous êtes sur Windows** :
- **Option A** : WSL2 (Windows Subsystem for Linux) ⭐ Recommandé
  ```powershell
  wsl --install -d Ubuntu
  ```
- **Option B** : VirtualBox + Ubuntu
- **Option C** : Cloud Shell AWS (gratuit, dans le navigateur)

**Si vous êtes sur macOS** :
- Terminal natif (macOS = Unix)
- Installer Homebrew pour les packages

**Si vous êtes sur Linux** :
- Vous êtes déjà prêt ! 🎉

### 2. Outils à Installer

```bash
# Mettre à jour le système
sudo apt update && sudo apt upgrade -y

# Outils réseau
sudo apt install -y curl wget net-tools dnsutils traceroute

# Éditeurs
sudo apt install -y nano vim

# Utilitaires
sudo apt install -y tree htop git
```

---

## 📊 Checklist Globale Prérequis

### Compétences Linux
- [ ] Navigation système de fichiers (cd, ls, pwd)
- [ ] Gestion fichiers (cp, mv, rm, mkdir, touch)
- [ ] Visualisation contenu (cat, less, head, tail, grep)
- [ ] Permissions (chmod, chown)
- [ ] Processus (ps, top, kill, bg, fg)
- [ ] Éditeurs (nano ou vim)
- [ ] Pipes et redirections (|, >, >>)
- [ ] Installation packages (apt/yum)
- [ ] Variables d'environnement ($PATH, export)

### Compétences Réseaux
- [ ] Comprendre TCP/IP et modèle OSI
- [ ] Adressage IP et sous-réseaux (/24, CIDR)
- [ ] TCP vs UDP
- [ ] Ports courants (22, 80, 443, 3306)
- [ ] DNS et résolution de noms
- [ ] HTTP/HTTPS et codes de statut
- [ ] Certificats SSL/TLS
- [ ] Outils : ping, traceroute, nslookup/dig, curl, netstat/ss

---

## 🎯 Critères de Validation

**Vous êtes prêt pour la Semaine 1 si** :

✅ **Linux** : Score checklist > 80% ET exercices pratiques réussis
✅ **Réseaux** : Score checklist > 80% ET exercices pratiques réussis
✅ **Temps total investi** : 15-25 heures (selon niveau initial)

---

## 💡 Conseils

1. **Ne pas précipiter** : Ces bases sont CRUCIALES pour AWS
2. **Pratiquer, ne pas juste lire** : Faire TOUS les labs pratiques
3. **Créer un environnement de test** : VM ou WSL2 pour expérimenter
4. **Poser des questions** : Rejoindre les communautés Linux/réseau
5. **Revenir si besoin** : Utiliser ces modules comme référence

---

## 🚀 Prochaine Étape

Une fois ces prérequis validés :

➡️ **[Semaine 1 : Setup et IAM](../semaine-01/)**
- Configuration compte AWS
- Identity and Access Management
- AWS CLI
- Budget alerts

---

## 📖 Ressources Complémentaires

### Linux
- **Linux Journey** : https://linuxjourney.com/
- **OverTheWire Bandit** : https://overthewire.org/wargames/bandit/
- Livre : "The Linux Command Line" (gratuit en PDF)

### Réseaux
- **freeCodeCamp - Networking Course** (YouTube)
- **Subnet Calculator** : https://www.subnet-calculator.com/
- **DNS Checker** : https://dnschecker.org/

---

**Temps total estimé Semaine 0** : 15-25 heures

💪 **Prenez le temps de bien maîtriser ces bases, elles vous serviront toute votre carrière !**
