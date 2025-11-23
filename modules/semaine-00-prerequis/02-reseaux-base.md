# 🌐 Réseaux de Base - Prérequis Formation AWS

> **Guide complet pour comprendre TCP/IP, DNS, HTTP/HTTPS avant la formation AWS**

---

## 🎯 Objectifs d'Apprentissage

À la fin de ce module, vous serez capable de :

- ✅ Comprendre le modèle OSI et TCP/IP
- ✅ Maîtriser les concepts d'adresses IP et sous-réseaux
- ✅ Comprendre TCP vs UDP
- ✅ Comprendre le fonctionnement du DNS
- ✅ Comprendre HTTP/HTTPS et les certificats SSL
- ✅ Connaître les ports courants (80, 443, 22, 3306, etc.)
- ✅ Utiliser les outils de diagnostic réseau (ping, traceroute, curl, nslookup)

---

## 🌐 Pourquoi les Réseaux pour AWS ?

**AWS = Cloud Networking !**
- **VPC** : Virtual Private Cloud (réseaux privés dans le cloud)
- **Subnets** : Sous-réseaux publics/privés
- **Security Groups** : Firewall basé sur IP/ports
- **Route 53** : Service DNS managé
- **CloudFront** : CDN (Content Delivery Network)
- **ALB/NLB** : Load Balancers réseau

**Dans la vraie vie DevOps** :
- Configurer des réseaux sécurisés
- Débugger des problèmes de connectivité
- Comprendre les architectures multi-tier
- Optimiser la latence réseau

---

## 📚 Partie 1 : Fondamentaux des Réseaux

### 1.1 Le Modèle OSI et TCP/IP

#### Modèle OSI (7 couches)

```
┌─────────────────────────────────────────────┐
│ 7. APPLICATION  │ HTTP, DNS, SSH, FTP       │ ← Vous êtes ici (DevOps)
├─────────────────────────────────────────────┤
│ 6. PRÉSENTATION │ SSL/TLS, Encryption       │
├─────────────────────────────────────────────┤
│ 5. SESSION      │ Sessions, Connexions      │
├─────────────────────────────────────────────┤
│ 4. TRANSPORT    │ TCP, UDP, Ports           │ ← Important !
├─────────────────────────────────────────────┤
│ 3. RÉSEAU       │ IP, Routing               │ ← Très important !
├─────────────────────────────────────────────┤
│ 2. LIAISON      │ Ethernet, MAC addresses   │
├─────────────────────────────────────────────┤
│ 1. PHYSIQUE     │ Câbles, WiFi, Signaux     │
└─────────────────────────────────────────────┘
```

#### Modèle TCP/IP (4 couches - plus simple, utilisé en pratique)

```
┌─────────────────────────────────────────────┐
│ APPLICATION     │ HTTP, DNS, SSH, SMTP      │
├─────────────────────────────────────────────┤
│ TRANSPORT       │ TCP, UDP                  │
├─────────────────────────────────────────────┤
│ INTERNET        │ IP (IPv4, IPv6)           │
├─────────────────────────────────────────────┤
│ ACCÈS RÉSEAU    │ Ethernet, WiFi            │
└─────────────────────────────────────────────┘
```

**Analogie Poste** :
- **Application** : Lettre que vous écrivez
- **Transport** : Enveloppe avec numéro de suivi (TCP) ou sans (UDP)
- **Internet** : Adresse postale (IP)
- **Accès Réseau** : Camion de livraison physique

---

### 1.2 Adresses IP

#### IPv4 : Format et Notation

```
192.168.1.10
│   │   │ │
│   │   │ └── Host (appareil)
│   │   └──── Sous-réseau
│   └──────── Sous-réseau
└──────────── Réseau

Format : XXX.XXX.XXX.XXX (chaque partie = 0-255)
```

**Classes d'adresses** :
```
Classe A : 10.0.0.0     à 10.255.255.255    (réseaux privés)
Classe B : 172.16.0.0   à 172.31.255.255    (réseaux privés)
Classe C : 192.168.0.0  à 192.168.255.255   (réseaux privés domestiques)
```

**Adresses spéciales** :
- **127.0.0.1** : Localhost (votre propre machine)
- **0.0.0.0** : Toutes les interfaces / Route par défaut
- **255.255.255.255** : Broadcast (tous les appareils du réseau)

---

#### Masque de Sous-réseau (Subnet Mask)

**Rôle** : Séparer la partie "réseau" de la partie "hôte"

```
IP :     192.168.1.10
Mask :   255.255.255.0

En binaire :
Mask :   11111111.11111111.11111111.00000000
         └────────────────────────┘└────────┘
              Partie réseau       Partie hôte
```

**Notation CIDR** (Classless Inter-Domain Routing) :
```
192.168.1.0/24
            └── /24 = les 24 premiers bits sont le réseau
                    = 255.255.255.0

Équivalences courantes :
/32 = 255.255.255.255  (1 seule adresse, host spécifique)
/24 = 255.255.255.0    (256 adresses, réseau classique)
/16 = 255.255.0.0      (65 536 adresses, grand réseau)
/8  = 255.0.0.0        (16 777 216 adresses, très grand réseau)
```

**Exemple pratique** :
```
Réseau : 192.168.1.0/24
- Première IP utilisable : 192.168.1.1
- Dernière IP utilisable : 192.168.1.254
- Broadcast : 192.168.1.255
- Total hôtes : 254 (256 - 2)
```

---

#### Adresses Publiques vs Privées

**Adresses Privées** (non routables sur Internet) :
```
10.0.0.0/8         (10.0.0.0 → 10.255.255.255)
172.16.0.0/12      (172.16.0.0 → 172.31.255.255)
192.168.0.0/16     (192.168.0.0 → 192.168.255.255)
```

**Adresses Publiques** : Toutes les autres (routables sur Internet)

**Analogie** :
- **Privée** = Numéro de bureau dans une entreprise (101, 102, 103)
- **Publique** = Adresse postale complète de l'entreprise

**NAT (Network Address Translation)** :
- Traduit adresses privées ↔ adresse publique
- Permet à tout un réseau privé de partager 1 IP publique

```
Votre PC (192.168.1.10) → Router (NAT) → Internet (IP publique 203.0.113.5)
                                   ↑
                        Translation d'adresse
```

---

## 📚 Partie 2 : Protocoles de Transport

### 2.1 TCP vs UDP

#### TCP (Transmission Control Protocol)

**Caractéristiques** :
- ✅ **Fiable** : Garantit la livraison des paquets
- ✅ **Ordonné** : Paquets arrivent dans le bon ordre
- ✅ **Contrôle d'erreurs** : Détection et retransmission
- ❌ **Plus lent** : Overhead de la fiabilité
- ❌ **Plus lourd** : 3-way handshake

**Analogie** : **Courrier recommandé avec accusé de réception**

**Utilisation** :
- HTTP/HTTPS (web)
- SSH (connexion sécurisée)
- FTP (transfert de fichiers)
- Email (SMTP)
- Toute application nécessitant fiabilité

**3-way Handshake** (établissement connexion) :
```
Client                              Serveur
  │                                    │
  │──────── SYN (Synchronize) ────────→│
  │                                    │
  │←─────── SYN-ACK (Acknowledge) ─────│
  │                                    │
  │──────── ACK ──────────────────────→│
  │                                    │
  │        Connexion établie           │
  │◄──────────────────────────────────►│
```

---

#### UDP (User Datagram Protocol)

**Caractéristiques** :
- ❌ **Non fiable** : Pas de garantie de livraison
- ❌ **Non ordonné** : Paquets peuvent arriver en désordre
- ✅ **Rapide** : Pas d'overhead
- ✅ **Léger** : Pas de handshake

**Analogie** : **Carte postale** (envoyée et oubliée)

**Utilisation** :
- DNS (requêtes rapides)
- Streaming vidéo/audio (quelques paquets perdus = OK)
- Jeux en ligne (latence faible critique)
- VoIP (appels vocaux)

---

### 2.2 Ports

**Port** = Point d'entrée pour un service sur une machine

**Format** : IP:Port
```
192.168.1.10:80
│           │
│           └── Port (service web)
└────────────── Adresse IP
```

#### Ports Courants (à connaître par cœur)

```
┌──────┬─────────────────────────────────────────┐
│ Port │ Service                                 │
├──────┼─────────────────────────────────────────┤
│ 20   │ FTP Data                                │
│ 21   │ FTP Control                             │
│ 22   │ SSH (Secure Shell)                      │ ⭐ Très important
│ 23   │ Telnet (non sécurisé, éviter)          │
│ 25   │ SMTP (Email sortant)                    │
│ 53   │ DNS                                      │ ⭐ Très important
│ 80   │ HTTP (Web non sécurisé)                 │ ⭐ Très important
│ 110  │ POP3 (Email entrant)                    │
│ 143  │ IMAP (Email)                            │
│ 443  │ HTTPS (Web sécurisé)                    │ ⭐ Très important
│ 3306 │ MySQL                                    │
│ 5432 │ PostgreSQL                               │
│ 6379 │ Redis                                    │
│ 8080 │ HTTP alternatif (dev/proxy)             │
│ 27017│ MongoDB                                  │
└──────┴─────────────────────────────────────────┘
```

**Plages de ports** :
- **0-1023** : Ports système (bien connus)
- **1024-49151** : Ports enregistrés
- **49152-65535** : Ports dynamiques/éphémères

---

## 📚 Partie 3 : DNS (Domain Name System)

### 3.1 Qu'est-ce que le DNS ?

**Rôle** : Traduire noms de domaine ↔ adresses IP

```
google.com  ──DNS──→  142.250.185.46
   │                      │
Humain                 Machine
```

**Analogie** : DNS = **Annuaire téléphonique**
- Nom : Google → Numéro : 142.250.185.46

---

### 3.2 Hiérarchie DNS

```
                     . (Root)
                     │
        ┌────────────┼────────────┐
        │            │            │
       .com         .org         .net
        │
    ┌───┴───┐
    │       │
  google  amazon
    │
    www
    │
www.google.com
```

**De droite à gauche** :
```
www.google.com.
│   │      │  │
│   │      │  └── Root (implicite)
│   │      └───── TLD (Top-Level Domain)
│   └──────────── Domaine
└──────────────── Sous-domaine
```

---

### 3.3 Types d'Enregistrements DNS

```
┌──────┬────────────────────────────────────────────┐
│ Type │ Rôle                                       │
├──────┼────────────────────────────────────────────┤
│ A    │ Nom → IPv4                                 │ ⭐ Plus courant
│      │ example.com → 93.184.216.34                │
├──────┼────────────────────────────────────────────┤
│ AAAA │ Nom → IPv6                                 │
│      │ example.com → 2606:2800:220:1:...          │
├──────┼────────────────────────────────────────────┤
│ CNAME│ Alias (Canonical Name)                     │ ⭐ Important
│      │ www.example.com → example.com              │
├──────┼────────────────────────────────────────────┤
│ MX   │ Mail Exchange (serveurs email)             │
│      │ example.com → mail.example.com             │
├──────┼────────────────────────────────────────────┤
│ TXT  │ Texte arbitraire (SPF, DKIM, vérification) │
├──────┼────────────────────────────────────────────┤
│ NS   │ Name Server (serveurs DNS autoritaires)    │
└──────┴────────────────────────────────────────────┘
```

---

### 3.4 Processus de Résolution DNS

```
1. Vous tapez : www.google.com dans le navigateur
   │
   ↓
2. Vérification cache local
   │ (pas trouvé)
   ↓
3. Requête au résolveur DNS (ISP ou 8.8.8.8)
   │
   ↓
4. Résolveur interroge Root DNS (.com)
   │
   ↓
5. Root redirige vers serveur TLD (.com)
   │
   ↓
6. TLD redirige vers serveur autoritaire (google.com)
   │
   ↓
7. Serveur autoritaire retourne : 142.250.185.46
   │
   ↓
8. Résultat mis en cache
   │
   ↓
9. Navigateur se connecte à 142.250.185.46:443
```

**TTL (Time To Live)** : Durée de mise en cache (ex: 3600s = 1h)

---

## 📚 Partie 4 : HTTP et HTTPS

### 4.1 HTTP (HyperText Transfer Protocol)

**Rôle** : Protocole de communication client-serveur pour le web

#### Anatomie d'une Requête HTTP

```
GET /api/users HTTP/1.1
│   │          │
│   │          └── Version du protocole
│   └──────────── Chemin (URI)
└──────────────── Méthode

Host: api.example.com
User-Agent: Mozilla/5.0
Accept: application/json
Authorization: Bearer token123

[Corps de la requête - optionnel]
```

---

#### Méthodes HTTP

```
┌────────┬────────────────────────────────────────┐
│ Méthode│ Rôle                                   │
├────────┼────────────────────────────────────────┤
│ GET    │ Récupérer une ressource                │ ⭐ Lecture
│        │ GET /users/123                         │
├────────┼────────────────────────────────────────┤
│ POST   │ Créer une ressource                    │ ⭐ Création
│        │ POST /users                            │
├────────┼────────────────────────────────────────┤
│ PUT    │ Mettre à jour (remplacer) une ressource│ ⭐ Mise à jour
│        │ PUT /users/123                         │
├────────┼────────────────────────────────────────┤
│ PATCH  │ Modifier partiellement une ressource   │
│        │ PATCH /users/123                       │
├────────┼────────────────────────────────────────┤
│ DELETE │ Supprimer une ressource                │ ⭐ Suppression
│        │ DELETE /users/123                      │
├────────┼────────────────────────────────────────┤
│ HEAD   │ Comme GET mais sans corps (metadata)   │
├────────┼────────────────────────────────────────┤
│ OPTIONS│ Découvrir les méthodes supportées      │
└────────┴────────────────────────────────────────┘
```

**Idempotence** :
- **GET, PUT, DELETE** : Idempotents (même résultat si répété)
- **POST** : Non idempotent (créera plusieurs ressources)

---

#### Codes de Statut HTTP

```
┌──────────┬────────────────────────────────────────┐
│ Code     │ Signification                          │
├──────────┼────────────────────────────────────────┤
│ 1xx      │ Information                            │
│ 100      │ Continue                               │
├──────────┼────────────────────────────────────────┤
│ 2xx      │ Succès                                 │ ⭐
│ 200      │ OK                                     │
│ 201      │ Created                                │
│ 204      │ No Content                             │
├──────────┼────────────────────────────────────────┤
│ 3xx      │ Redirection                            │
│ 301      │ Moved Permanently                      │
│ 302      │ Found (redirection temporaire)         │
│ 304      │ Not Modified (cache)                   │
├──────────┼────────────────────────────────────────┤
│ 4xx      │ Erreur Client                          │ ⭐
│ 400      │ Bad Request                            │
│ 401      │ Unauthorized (pas authentifié)         │
│ 403      │ Forbidden (pas autorisé)               │
│ 404      │ Not Found                              │
│ 429      │ Too Many Requests                      │
├──────────┼────────────────────────────────────────┤
│ 5xx      │ Erreur Serveur                         │ ⭐
│ 500      │ Internal Server Error                  │
│ 502      │ Bad Gateway                            │
│ 503      │ Service Unavailable                    │
│ 504      │ Gateway Timeout                        │
└──────────┴────────────────────────────────────────┘
```

**Mémo** :
- **2xx** = Succès ✅
- **3xx** = Redirection 🔄
- **4xx** = Erreur client (votre faute) ❌
- **5xx** = Erreur serveur (leur faute) 💥

---

#### Headers HTTP Importants

```
Requête (Client → Serveur) :
- Host: example.com
- User-Agent: Mozilla/5.0
- Accept: application/json
- Content-Type: application/json
- Authorization: Bearer token123
- Cookie: session_id=abc123

Réponse (Serveur → Client) :
- Content-Type: application/json
- Content-Length: 1234
- Cache-Control: max-age=3600
- Set-Cookie: session_id=abc123
- Access-Control-Allow-Origin: *
- X-RateLimit-Remaining: 99
```

---

### 4.2 HTTPS (HTTP Secure)

**HTTPS = HTTP + TLS/SSL**

**Pourquoi HTTPS ?** :
- 🔒 **Encryption** : Données chiffrées (impossible à lire si interceptées)
- ✅ **Authentification** : Vérifier l'identité du serveur
- 🛡️ **Intégrité** : Garantir que les données n'ont pas été modifiées

---

#### SSL/TLS Handshake

```
Client                                   Serveur
  │                                         │
  │──── 1. ClientHello ────────────────────→│
  │     (versions SSL/TLS supportées)       │
  │                                         │
  │←─── 2. ServerHello ────────────────────│
  │     (version choisie + certificat)      │
  │                                         │
  │──── 3. Vérification certificat ────────│
  │     (autorité de certification)         │
  │                                         │
  │←─── 4. Clé publique ───────────────────│
  │                                         │
  │──── 5. Génération clé session ─────────│
  │     (chiffrée avec clé publique)       │
  │                                         │
  │         6. Communication chiffrée       │
  │◄───────────────────────────────────────►│
```

---

#### Certificats SSL

**Composants d'un certificat** :
- **Nom de domaine** : example.com
- **Clé publique** : Pour chiffrer les données
- **Émetteur (CA)** : Let's Encrypt, DigiCert, etc.
- **Dates de validité** : Début et fin
- **Signature** : Garantit l'authenticité

**Autorité de Certification (CA)** :
- Let's Encrypt (gratuit) ⭐
- DigiCert (payant)
- AWS Certificate Manager (gratuit pour services AWS)

**Chaîne de confiance** :
```
Root CA (dans navigateur)
    │
    ↓
Intermediate CA
    │
    ↓
Certificat site (example.com)
```

---

## 📚 Partie 5 : Outils de Diagnostic Réseau

### 5.1 ping - Tester la Connectivité

```bash
# Tester si un serveur répond
ping google.com

# Output:
# PING google.com (142.250.185.46): 56 data bytes
# 64 bytes from 142.250.185.46: icmp_seq=0 ttl=116 time=15.2 ms
# 64 bytes from 142.250.185.46: icmp_seq=1 ttl=116 time=14.8 ms

# Envoyer seulement 4 paquets
ping -c 4 google.com

# Ping une adresse IP
ping 8.8.8.8
```

**Interprétation** :
- **time=15.2 ms** : Latence (temps aller-retour)
- **ttl=116** : Time To Live (nombre de routeurs traversés)
- **Pas de réponse ?** : Firewall bloque ICMP ou serveur down

---

### 5.2 traceroute - Tracer le Chemin

```bash
# Voir tous les routeurs entre vous et la destination
traceroute google.com

# Output (exemple):
# 1  192.168.1.1 (192.168.1.1)  1.234 ms     ← Votre routeur
# 2  10.0.0.1 (10.0.0.1)  5.678 ms           ← ISP
# 3  * * *                                    ← Routeur qui ne répond pas
# 4  142.250.185.46 (google.com)  15.2 ms    ← Destination
```

**Utilité** : Identifier où la connexion est lente ou bloquée

---

### 5.3 nslookup / dig - Requêtes DNS

#### nslookup

```bash
# Résoudre un nom de domaine
nslookup google.com

# Output:
# Server:  8.8.8.8
# Address: 8.8.8.8#53
#
# Non-authoritative answer:
# Name:    google.com
# Address: 142.250.185.46

# Spécifier un serveur DNS
nslookup google.com 1.1.1.1

# Reverse lookup (IP → nom)
nslookup 8.8.8.8
```

---

#### dig (plus détaillé)

```bash
# Requête DNS complète
dig google.com

# Seulement la réponse courte
dig +short google.com
# 142.250.185.46

# Spécifier le type d'enregistrement
dig google.com A      # IPv4
dig google.com AAAA   # IPv6
dig google.com MX     # Mail servers
dig google.com NS     # Name servers
dig google.com TXT    # Text records

# Tracer la résolution DNS complète
dig +trace google.com
```

---

### 5.4 curl - Tester HTTP/HTTPS

```bash
# Faire une requête GET
curl https://api.github.com

# Voir les headers de réponse
curl -I https://google.com

# Requête POST avec données JSON
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name": "John", "email": "john@example.com"}'

# Suivre les redirections
curl -L https://google.com

# Voir la requête ET la réponse détaillées
curl -v https://api.github.com

# Sauvegarder dans un fichier
curl -o page.html https://example.com

# Télécharger un fichier
curl -O https://example.com/file.zip

# Tester avec authentification
curl -u username:password https://api.example.com

# Ignorer les erreurs SSL (dev seulement)
curl -k https://self-signed-cert.example.com
```

---

### 5.5 netstat / ss - Voir les Connexions

```bash
# Voir toutes les connexions actives
netstat -tuln

# Explication des flags:
# -t : TCP
# -u : UDP
# -l : Listening (en écoute)
# -n : Numérique (pas de résolution DNS)

# Output:
# Proto Recv-Q Send-Q Local Address     Foreign Address   State
# tcp        0      0 0.0.0.0:22        0.0.0.0:*         LISTEN
# tcp        0      0 127.0.0.1:3306    0.0.0.0:*         LISTEN

# Version moderne : ss (plus rapide)
ss -tuln

# Voir quel processus écoute sur un port
sudo ss -tulnp
```

---

### 5.6 telnet - Tester un Port

```bash
# Tester si un port est ouvert
telnet example.com 80

# Si connexion réussie:
# Trying 93.184.216.34...
# Connected to example.com.
# Escape character is '^]'.

# Puis vous pouvez taper une requête HTTP:
GET / HTTP/1.1
Host: example.com

# Tester MySQL
telnet db.example.com 3306

# Tester SSH
telnet server.example.com 22
```

---

## 🛠️ Lab Pratique : Exercice Complet

### Scénario : Diagnostiquer un Site Web

```bash
# 1. Tester si le site répond
ping example.com

# 2. Tracer la route réseau
traceroute example.com

# 3. Vérifier la résolution DNS
nslookup example.com
dig +short example.com

# 4. Tester le port HTTP (80)
telnet example.com 80

# 5. Faire une requête HTTP complète
curl -v http://example.com

# 6. Tester HTTPS et voir le certificat
curl -v https://example.com 2>&1 | grep -A 10 "Server certificate"

# 7. Voir les headers de réponse
curl -I https://example.com

# 8. Vérifier les redirections
curl -L -I https://example.com

# 9. Tester depuis un serveur DNS spécifique
dig @8.8.8.8 example.com
dig @1.1.1.1 example.com

# 10. Voir les connexions actives sur votre machine
ss -tuln
```

---

## 📚 Concepts AWS Réseau (Aperçu)

### VPC (Virtual Private Cloud)

```
┌─────────────────── VPC (10.0.0.0/16) ────────────────────┐
│                                                           │
│  ┌───── Public Subnet (10.0.1.0/24) ─────┐              │
│  │                                        │              │
│  │  • EC2 (10.0.1.10)                    │              │
│  │  • Load Balancer (10.0.1.20)          │              │
│  │                                        │              │
│  └────────────────────────────────────────┘              │
│                    │                                      │
│              Internet Gateway                             │
│                    │                                      │
│  ┌───── Private Subnet (10.0.2.0/24) ────┐              │
│  │                                        │              │
│  │  • EC2 (10.0.2.10)                    │              │
│  │  • RDS (10.0.2.20)                    │              │
│  │                                        │              │
│  └────────────────────────────────────────┘              │
│                    │                                      │
│                NAT Gateway                                │
│                                                           │
└───────────────────────────────────────────────────────────┘
```

**Concepts à retenir** :
- **CIDR blocks** : 10.0.0.0/16 (définit la plage IP du VPC)
- **Subnets** : Subdivision du VPC
- **Public subnet** : Accès Internet (via Internet Gateway)
- **Private subnet** : Pas d'accès direct Internet (via NAT Gateway)
- **Security Groups** : Firewall basé sur IP/ports

---

## ✅ Checklist de Validation

### Concepts Généraux
- [ ] Je comprends le modèle TCP/IP
- [ ] Je sais différencier TCP et UDP
- [ ] Je connais les ports courants (22, 80, 443, 3306, etc.)

### Adressage IP
- [ ] Je comprends le format IPv4 (192.168.1.10)
- [ ] Je comprends les masques de sous-réseau (/24, /16)
- [ ] Je sais différencier IP publique vs privée
- [ ] Je comprends le NAT

### DNS
- [ ] Je comprends le rôle du DNS (nom → IP)
- [ ] Je connais les types d'enregistrements (A, CNAME, MX)
- [ ] Je comprends le processus de résolution DNS
- [ ] Je comprends le TTL

### HTTP/HTTPS
- [ ] Je connais les méthodes HTTP (GET, POST, PUT, DELETE)
- [ ] Je connais les codes de statut (200, 404, 500)
- [ ] Je comprends la différence HTTP vs HTTPS
- [ ] Je comprends le rôle du certificat SSL

### Outils
- [ ] Je sais utiliser ping
- [ ] Je sais utiliser traceroute
- [ ] Je sais utiliser nslookup / dig
- [ ] Je sais utiliser curl
- [ ] Je sais utiliser netstat / ss
- [ ] Je sais utiliser telnet pour tester un port

---

## 🎯 Exercices de Validation

### Exercice 1 : Diagnostic Site Web

```bash
# Le site "example.com" ne répond pas. Diagnostiquer.
# 1. Tester la connectivité
# 2. Vérifier le DNS
# 3. Tracer la route
# 4. Tester les ports 80 et 443
# 5. Faire une requête HTTP
```

<details>
<summary>Solution</summary>

```bash
ping example.com
nslookup example.com
traceroute example.com
telnet example.com 80
telnet example.com 443
curl -v http://example.com
curl -v https://example.com
```
</details>

---

### Exercice 2 : Calculer un Sous-réseau

```
Réseau : 172.16.0.0/20

Questions :
1. Quelle est la première IP utilisable ?
2. Quelle est la dernière IP utilisable ?
3. Combien d'hôtes peut contenir ce réseau ?
4. Quel est le masque en notation décimale ?
```

<details>
<summary>Solution</summary>

```
/20 = 255.255.240.0

Première IP : 172.16.0.1
Dernière IP : 172.16.15.254
Broadcast : 172.16.15.255
Nombre d'hôtes : 2^(32-20) - 2 = 4096 - 2 = 4094
```
</details>

---

### Exercice 3 : Comprendre les Headers HTTP

```bash
# Faire une requête et analyser les headers
curl -v https://www.google.com

# Questions :
# 1. Quel est le code de statut ?
# 2. Y a-t-il une redirection ?
# 3. Quel serveur web est utilisé ?
# 4. Quelle est la taille du contenu ?
```

---

## 📖 Ressources Complémentaires

### Tutoriels Interactifs
- **Subnet Calculator** : https://www.subnet-calculator.com/
- **DNS Propagation Checker** : https://dnschecker.org/

### Vidéos
- **freeCodeCamp - Computer Networking Course** (YouTube, 9h)
- **Networking Fundamentals** par NetworkChuck (YouTube)

### Outils en Ligne
- **Wireshark** : Analyser le trafic réseau (avancé)
- **Postman** : Tester APIs HTTP (alternative à curl)

### Livres
- "TCP/IP Illustrated" par Richard Stevens (référence)

---

## 💡 Conseils

1. **Pratiquer avec curl** : Tester différentes APIs publiques
2. **Explorer votre réseau** : `ip addr`, `route -n`
3. **Analyser les logs** : Regarder les logs d'un serveur web
4. **Dessiner** : Faire des diagrammes réseau
5. **Capture de paquets** : Utiliser Wireshark pour voir le trafic

---

## 🚀 Prochaine Étape

Une fois cette checklist validée à 100%, vous êtes prêt pour :
- **Semaine 1 du programme AWS** : IAM et Setup
- **Semaine 12** : VPC Networking (concepts avancés)

---

**Temps estimé pour maîtriser** : 8-12 heures de pratique

💪 **Bon courage ! La compréhension des réseaux est CRUCIALE pour AWS !**
