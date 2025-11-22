# 📝 Questions Types d'Examen

> Collection de 100+ questions types pour AWS Certified Developer Associate et Solutions Architect Associate

---

## 🎯 AWS Certified Developer - Associate (DVA-C02)

### Domaine 1 : Development with AWS Services (32%)

#### Lambda & Serverless

**Q1.** Une fonction Lambda doit accéder à une table DynamoDB. Quelle est la meilleure approche ?

- [ ] A. Hardcoder les credentials AWS dans le code
- [ ] B. Utiliser les variables d'environnement pour stocker Access Key et Secret Key
- [ ] C. Créer un utilisateur IAM et stocker les credentials dans AWS Secrets Manager
- [x] D. **Attacher un rôle IAM à la fonction Lambda avec les permissions DynamoDB**

**Explication** : Les rôles IAM sont la méthode recommandée pour donner des permissions aux services AWS. Lambda assume automatiquement le rôle et obtient des credentials temporaires.

---

**Q2.** Votre fonction Lambda dépasse le timeout de 3 secondes. Quelles actions peuvent aider ? (Choisir 2)

- [x] A. **Augmenter la mémoire allouée (plus de RAM = plus de CPU)**
- [x] B. **Optimiser le code (réduire les appels réseau, utiliser le caching)**
- [ ] C. Réduire la mémoire pour accélérer le démarrage
- [ ] D. Changer le runtime de Python à Node.js

**Explication** : Plus de mémoire = plus de CPU proportionnellement. L'optimisation du code est toujours bénéfique.

---

**Q3.** Comment réduire le cold start time d'une fonction Lambda ? (Choisir 3)

- [x] A. **Utiliser Provisioned Concurrency**
- [x] B. **Réduire la taille du package de déploiement (moins de dépendances)**
- [x] C. **Augmenter la mémoire allouée**
- [ ] D. Utiliser plus de threads dans le code

**Explication** : Provisioned Concurrency garde les containers chauds. Package plus petit = chargement plus rapide. Plus de RAM = démarrage plus rapide.

---

**Q4.** Quelle est la limite de timeout maximum pour une fonction Lambda ?

- [ ] A. 5 minutes
- [ ] B. 10 minutes
- [x] C. **15 minutes**
- [ ] D. 30 minutes

**Réponse** : C (15 minutes)

---

**Q5.** Comment partager du code commun entre plusieurs fonctions Lambda ?

- [ ] A. Copier le code dans chaque fonction
- [x] B. **Utiliser Lambda Layers**
- [ ] C. Créer une fonction Lambda maître qui appelle les autres
- [ ] D. Utiliser S3 pour stocker le code partagé

**Explication** : Lambda Layers permettent de partager du code, des dépendances, ou des runtimes customs entre fonctions.

---

#### API Gateway

**Q6.** Différence principale entre REST API et HTTP API dans API Gateway ?

- [ ] A. REST API est plus rapide
- [x] B. **HTTP API est moins cher (~60% moins) et plus performant, mais avec moins de features**
- [ ] C. HTTP API ne supporte pas Lambda
- [ ] D. Pas de différence, juste des noms différents

**Explication** : HTTP API est plus moderne, moins cher, mais REST API a plus de features (caching, WAF, usage plans).

---

**Q7.** Comment implémenter l'authentification sur une API Gateway ? (Choisir 3)

- [x] A. **Cognito User Pools**
- [x] B. **Lambda Authorizer (custom logic)**
- [x] C. **IAM (SigV4)**
- [ ] D. Hardcoder des API keys dans le frontend

**Explication** : Les 3 premières sont les méthodes officielles. Jamais hardcoder de secrets.

---

**Q8.** Vous voulez limiter le nombre de requêtes par client sur votre API. Quel feature utiliser ?

- [ ] A. CloudFront rate limiting
- [x] B. **Usage Plans avec API Keys**
- [ ] C. Lambda concurrency limits
- [ ] D. WAF rate-based rules

**Explication** : Usage Plans permettent de définir des throttling et quotas par API Key.

---

#### DynamoDB

**Q9.** Vous avez une table DynamoDB avec partition key `user_id` et sort key `timestamp`. Quelle opération est la plus efficace ?

- [x] A. **Query avec user_id (récupère tous les items d'un user)**
- [ ] B. Scan avec filter sur user_id
- [ ] C. GetItem avec user_id uniquement
- [ ] D. BatchGetItem

**Explication** : Query est très efficace quand on connaît la partition key. Scan est coûteux (lit toute la table).

---

**Q10.** Comment gérer les pics de trafic imprévisibles sur DynamoDB ?

- [ ] A. Provisionner beaucoup de RCU/WCU en avance
- [x] B. **Utiliser On-Demand pricing mode**
- [ ] C. Utiliser Auto Scaling (mais peut avoir du lag)
- [ ] D. Créer plusieurs tables

**Explication** : On-Demand mode s'adapte automatiquement instantanément, parfait pour trafic imprévisible.

---

**Q11.** Vous devez faire des requêtes sur un attribut qui n'est pas la clé primaire. Que faire ?

- [ ] A. Faire un Scan avec filter
- [x] B. **Créer un Global Secondary Index (GSI) sur cet attribut**
- [ ] C. Créer une nouvelle table
- [ ] D. Utiliser RDS à la place

**Explication** : GSI permet de query sur d'autres attributs que la clé primaire.

---

#### S3

**Q12.** Comment héberger un site web statique sur S3 avec HTTPS ?

- [ ] A. S3 seul (S3 website endpoint supporte HTTPS)
- [x] B. **S3 + CloudFront (CloudFront fournit HTTPS)**
- [ ] C. S3 + ALB
- [ ] D. Impossible, utiliser EC2

**Explication** : S3 website endpoint ne supporte pas HTTPS. Il faut CloudFront devant.

---

**Q13.** Quelle storage class S3 pour des backups rarement accédés mais qui doivent être récupérables instantanément ?

- [ ] A. S3 Standard
- [x] B. **S3 Standard-IA (Infrequent Access)**
- [ ] C. S3 Glacier
- [ ] D. S3 One Zone-IA

**Explication** : Standard-IA = accès peu fréquent mais retrieval instantané. Glacier a un délai de retrieval.

---

**Q14.** Comment déclencher une fonction Lambda quand un objet est uploadé sur S3 ?

- [ ] A. Lambda poll S3 toutes les minutes
- [x] B. **S3 Event Notification vers Lambda**
- [ ] C. CloudWatch Events
- [ ] D. SQS entre S3 et Lambda

**Explication** : S3 peut directement invoquer Lambda via Event Notifications.

---

#### CodePipeline / CI-CD

**Q15.** Votre pipeline CodePipeline échoue à chaque fois au stage de build. Où voir les logs ?

- [ ] A. CodePipeline console
- [x] B. **CloudWatch Logs (CodeBuild logs)**
- [ ] C. S3 artifacts bucket
- [ ] D. AWS Config

**Explication** : CodeBuild envoie tous ses logs vers CloudWatch Logs.

---

**Q16.** Comment déployer automatiquement une application Lambda via CI/CD ?

- [x] A. **CodePipeline → CodeBuild (sam build) → CloudFormation (sam deploy)**
- [ ] B. CodePipeline → Zip → S3 → Lambda direct upload
- [ ] C. Jenkins sur EC2
- [ ] D. Manuellement via console

**Explication** : SAM (Serverless Application Model) est la méthode recommandée pour déployer serverless apps.

---

**Q17.** Quel fichier définit les étapes de build dans CodeBuild ?

- [ ] A. build.yaml
- [x] B. **buildspec.yml**
- [ ] C. Dockerfile
- [ ] D. pipeline.json

**Réponse** : B (buildspec.yml)

---

### Domaine 2 : Security (26%)

**Q18.** Où stocker les credentials de base de données pour une application Lambda ?

- [ ] A. Variables d'environnement Lambda (en clair)
- [x] B. **AWS Secrets Manager ou Systems Manager Parameter Store (encrypted)**
- [ ] C. Hardcodé dans le code
- [ ] D. Dans un fichier .env commité dans Git

**Explication** : Secrets Manager ou Parameter Store permettent encryption, rotation, et audit.

---

**Q19.** Comment chiffrer les données at rest dans DynamoDB ?

- [ ] A. Implémenter le chiffrement dans le code application
- [x] B. **Activer DynamoDB encryption at rest (KMS)**
- [ ] C. Utiliser S3 avec encryption devant DynamoDB
- [ ] D. DynamoDB ne supporte pas l'encryption

**Explication** : DynamoDB a l'encryption at rest built-in avec KMS.

---

**Q20.** Une application EC2 a besoin d'accéder à S3. Comment gérer les credentials ?

- [ ] A. Créer un IAM user, downloader les access keys, les mettre sur EC2
- [x] B. **Créer un IAM role et l'attacher à l'instance EC2**
- [ ] C. Utiliser le compte root AWS
- [ ] D. Pas besoin de credentials, S3 est public

**Explication** : Toujours utiliser IAM roles pour les services AWS (pas d'access keys).

---

**Q21.** Quelle politique IAM permet à une Lambda de logger dans CloudWatch ?

- [ ] A. AmazonS3FullAccess
- [x] B. **AWSLambdaBasicExecutionRole (CreateLogGroup, CreateLogStream, PutLogEvents)**
- [ ] C. CloudWatchFullAccess
- [ ] D. AdminAccess

**Réponse** : B

---

### Domaine 3 : Deployment (24%)

**Q22.** Comment faire un déploiement blue/green d'une application Lambda via API Gateway ?

- [ ] A. Créer deux fonctions Lambda différentes
- [x] B. **Utiliser Lambda versions et alias + API Gateway stage variables**
- [ ] C. Déployer sur deux régions différentes
- [ ] D. Impossible avec Lambda

**Explication** : Alias Lambda (ex: "prod" pointant vers version 2) + stage variables API Gateway.

---

**Q23.** Quelle stratégie de déploiement minimise le downtime ?

- [ ] A. All-at-once
- [ ] B. In-place
- [x] C. **Blue/Green**
- [ ] D. Rolling (peut avoir mixed versions)

**Explication** : Blue/Green = zero downtime, rollback instantané.

---

**Q24.** Comment automatiquement rollback un déploiement Lambda en cas d'erreurs accrues ?

- [ ] A. Manuellement via console
- [x] B. **CloudWatch Alarms + CodeDeploy hooks**
- [ ] C. Lambda a un auto-rollback intégré
- [ ] D. Impossible

**Explication** : CodeDeploy peut monitorer des CloudWatch alarms et rollback automatiquement.

---

### Domaine 4 : Troubleshooting & Optimization (18%)

**Q25.** Comment débugger une requête lente qui traverse API Gateway → Lambda → DynamoDB ?

- [ ] A. Ajouter des print statements
- [x] B. **Utiliser AWS X-Ray pour distributed tracing**
- [ ] C. Vérifier CloudWatch Logs uniquement
- [ ] D. Augmenter le timeout

**Explication** : X-Ray montre le temps passé dans chaque segment (API Gateway, Lambda, DynamoDB).

---

**Q26.** Votre fonction Lambda écrit des logs mais vous ne les voyez pas dans CloudWatch. Pourquoi ?

- [ ] A. CloudWatch Logs n'est pas disponible dans votre région
- [x] B. **Le rôle IAM de la Lambda n'a pas les permissions CloudWatch Logs (logs:CreateLogGroup, logs:CreateLogStream, logs:PutLogEvents)**
- [ ] C. Il faut activer manuellement les logs dans la console Lambda
- [ ] D. Lambda n'envoie pas automatiquement les logs

**Explication** : Sans permissions CloudWatch Logs dans le rôle IAM, les logs sont perdus.

---

**Q27.** Comment réduire les coûts d'une API qui fait beaucoup de requêtes identiques ?

- [x] A. **Activer le caching API Gateway**
- [ ] B. Augmenter le timeout Lambda
- [ ] C. Utiliser DynamoDB On-Demand
- [ ] D. Réduire la mémoire Lambda

**Explication** : API Gateway caching évite d'invoquer Lambda pour chaque requête identique.

---

**Q28.** Vous constatez des erreurs 502 Bad Gateway sur votre API. Où chercher ?

- [x] A. **CloudWatch Logs de la fonction Lambda (erreurs runtime)**
- [ ] B. S3 access logs
- [ ] C. IAM policies
- [ ] D. VPC Flow Logs

**Explication** : 502 = erreur Lambda (timeout, crash, out of memory). Voir CloudWatch Logs Lambda.

---

---

## 🎯 AWS Certified Solutions Architect - Associate (SAA-C03)

### Domaine 1 : Design Secure Architectures (30%)

#### VPC & Networking

**Q29.** Une application web 3-tier doit être hautement disponible. Comment architecturer le VPC ?

- [ ] A. Tout dans un subnet public dans une seule AZ
- [x] B. **Subnets publics (web tier) et privés (app/DB tiers) dans au moins 2 AZs**
- [ ] C. Tout dans des subnets privés
- [ ] D. Une AZ avec beaucoup de ressources

**Explication** : Multi-AZ = haute disponibilité. Public subnets pour web (ALB), private subnets pour app/DB.

---

**Q30.** Différence entre Security Group et Network ACL ?

- [x] A. **SG = stateful (return traffic automatique), NACL = stateless (règles explicites in/out)**
- [ ] B. SG = subnet level, NACL = instance level
- [ ] C. SG supporte Deny, NACL ne supporte que Allow
- [ ] D. Pas de différence

**Explication** : Security Group = stateful (si vous autorisez in, out est automatique). NACL = stateless (règles in et out explicites).

---

**Q31.** Comment permettre à des instances EC2 dans un subnet privé d'accéder à Internet ?

- [ ] A. Attacher un Internet Gateway
- [x] B. **Utiliser un NAT Gateway dans un subnet public**
- [ ] C. Créer une VPN connection
- [ ] D. Attacher des Elastic IPs

**Explication** : NAT Gateway (dans subnet public) permet aux instances privées d'initier des connexions sortantes vers Internet.

---

**Q32.** Une entreprise veut connecter son datacenter on-premise à AWS de manière sécurisée et privée. Quelle solution ?

- [ ] A. Internet public avec HTTPS
- [x] B. **AWS Direct Connect ou VPN**
- [ ] C. SSH tunneling
- [ ] D. VPC Peering

**Explication** : Direct Connect (connexion dédiée) ou VPN (sur Internet mais chiffré) pour hybrid cloud.

---

#### IAM & Security

**Q33.** Comment donner accès à un bucket S3 dans le compte A à un utilisateur du compte B ?

- [ ] A. Partager les access keys du compte A
- [x] B. **Bucket policy dans compte A autorisant le compte B + IAM role dans compte B**
- [ ] C. Rendre le bucket public
- [ ] D. Impossible, créer un nouveau bucket dans compte B

**Explication** : Cross-account access via bucket policy + IAM role à assumer.

---

**Q34.** Vous devez auditer toutes les actions effectuées sur votre compte AWS. Quel service ?

- [ ] A. CloudWatch Logs
- [x] B. **AWS CloudTrail**
- [ ] C. VPC Flow Logs
- [ ] D. AWS Config

**Explication** : CloudTrail enregistre toutes les API calls (qui, quoi, quand, depuis où).

---

**Q35.** Comment chiffrer un volume EBS existant non chiffré ?

- [ ] A. Activer l'encryption dans les propriétés du volume
- [x] B. **Créer un snapshot, copier le snapshot avec encryption, créer un nouveau volume depuis le snapshot chiffré**
- [ ] C. Utiliser AWS KMS directement sur le volume
- [ ] D. Impossible, créer un nouveau volume chiffré et migrer les données

**Explication** : On ne peut pas chiffrer un volume existant in-place. Il faut passer par snapshot.

---

### Domaine 2 : Design Resilient Architectures (26%)

**Q36.** Quelle architecture offre la meilleure haute disponibilité pour une application web ?

```
A. EC2 instance unique avec EBS
B. 2 EC2 instances dans la même AZ derrière un ALB
C. ✅ EC2 Auto Scaling Group avec instances dans 3 AZs derrière un ALB
D. EC2 instance avec Elastic IP
```

**Explication** : Multi-AZ + Auto Scaling + Load Balancer = haute disponibilité et scalabilité.

---

**Q37.** Différence entre RDS Multi-AZ et Read Replicas ?

- [x] A. **Multi-AZ = haute disponibilité (failover automatique), Read Replicas = scalabilité lecture**
- [ ] B. Multi-AZ est moins cher
- [ ] C. Read Replicas sont synchrones, Multi-AZ asynchrone
- [ ] D. Pas de différence

**Explication** :
- Multi-AZ : Réplication synchrone vers standby (failover auto en cas de panne)
- Read Replicas : Réplication asynchrone (distribuer la charge de lecture)

---

**Q38.** Votre application stocke des fichiers sur EBS. L'instance EC2 crash, vous perdez les données. Comment améliorer ?

- [x] A. **Utiliser S3 au lieu de EBS pour storage persistant**
- [x] B. **Activer des snapshots EBS automatiques**
- [ ] C. Augmenter la taille EBS
- [ ] D. Utiliser instance store

**Explication** : S3 est plus durable (11 9s vs EBS), ou utiliser EBS snapshots pour backup.

---

**Q39.** Comment concevoir un système avec RTO < 1h et RPO < 15min ?

- [ ] A. Backups quotidiens
- [x] B. **Snapshots EBS automatiques toutes les 15min + AMI de l'application**
- [ ] C. Réplication manuelle hebdomadaire
- [ ] D. Espérer que ça ne plante pas

**Explication** :
- RTO (Recovery Time Objective) : Temps pour restaurer
- RPO (Recovery Point Objective) : Perte de données acceptable
→ Snapshots fréquents (15min) pour RPO, AMI prête pour RTO rapide

---

**Q40.** Application critique qui ne doit JAMAIS être down. Quelle architecture ?

- [ ] A. Multi-AZ dans une région
- [x] B. **Multi-région avec Route 53 failover routing**
- [ ] C. Single AZ avec backups
- [ ] D. CloudFront devant EC2

**Explication** : Multi-région protège contre failure d'une région entière. Route 53 failover bascule automatiquement.

---

### Domaine 3 : Design High-Performing Architectures (24%)

**Q41.** Comment réduire la latence pour des utilisateurs répartis dans le monde ?

- [ ] A. Augmenter la taille des instances EC2
- [x] B. **Utiliser CloudFront (CDN) pour cacher le contenu près des utilisateurs**
- [ ] C. Déployer dans toutes les régions AWS
- [ ] D. Utiliser des Elastic IPs

**Explication** : CloudFront met en cache le contenu dans 400+ edge locations proches des users.

---

**Q42.** Votre base de données RDS est saturée en lecture. Comment scaler ?

- [ ] A. Augmenter la taille de l'instance (vertical scaling)
- [x] B. **Créer des Read Replicas et distribuer les requêtes de lecture**
- [x] C. **Ajouter ElastiCache devant RDS**
- [ ] D. Migrer vers DynamoDB

**Explication** : Read Replicas (horizontal scaling) + ElastiCache (caching) réduisent la charge sur la DB primaire.

---

**Q43.** Différence entre ElastiCache Redis et Memcached ?

- [x] A. **Redis : Persistance, replication, snapshots, data structures complexes**
- [ ] B. Memcached : Plus de features
- [ ] C. Redis : Seulement pour caching, Memcached : pour sessions
- [x] D. **Memcached : Simple, multi-threaded, bon pour caching pur**

**Explication** : Redis = plus de features (persistence, pub/sub, clustering). Memcached = simple et rapide pour caching pur.

---

**Q44.** Application qui traite des vidéos uploadées par les users. Architecture optimale ?

```
A. EC2 instance qui attend et traite les uploads
B. ✅ S3 (upload) → S3 Event → SQS → Lambda (ou EC2 workers) → S3 (output)
C. EC2 qui poll S3 toutes les minutes
D. Upload direct vers EC2 via FTP
```

**Explication** : S3 events → SQS (buffer) → workers = découplé, scalable, résilient.

---

**Q45.** Quel type de Load Balancer pour une application WebSocket ?

- [ ] A. Classic Load Balancer
- [x] B. **Network Load Balancer (Layer 4, supporte TCP long-lived connections)**
- [ ] C. Application Load Balancer
- [ ] D. Load Balancer n'est pas nécessaire

**Explication** : NLB ou ALB (qui supporte aussi WebSocket). NLB est optimal pour TCP long-lived.

---

### Domaine 4 : Design Cost-Optimized Architectures (20%)

**Q46.** Application web avec trafic prévisible (constant). Quel pricing model EC2 ?

- [ ] A. On-Demand
- [x] B. **Reserved Instances (1 ou 3 ans)**
- [ ] C. Spot Instances
- [ ] D. Dedicated Hosts

**Explication** : Reserved Instances = jusqu'à 75% de réduction vs On-Demand pour usage prévisible.

---

**Q47.** Workload batch non urgent, peut être interrompu. Quel pricing model ?

- [ ] A. On-Demand
- [ ] B. Reserved Instances
- [x] C. **Spot Instances (jusqu'à 90% de réduction)**
- [ ] D. Savings Plans

**Explication** : Spot = très cheap mais peut être interrompu avec 2min de préavis. Parfait pour batch jobs flexibles.

---

**Q48.** Comment optimiser les coûts de stockage S3 pour des logs rarement accédés ?

- [ ] A. Garder dans S3 Standard
- [x] B. **Lifecycle policy : S3 Standard → S3 IA (30j) → S3 Glacier (90j) → Delete (365j)**
- [ ] C. Télécharger localement et supprimer de S3
- [ ] D. Compresser les fichiers

**Explication** : Lifecycle policies automatiques transitionnent vers storage classes moins chères.

---

**Q49.** Base de données DynamoDB avec trafic imprévisible et spiky. Quel mode de pricing ?

- [ ] A. Provisioned avec Auto Scaling
- [x] B. **On-Demand**
- [ ] C. Provisionner pour le pic maximum
- [ ] D. Utiliser RDS à la place

**Explication** : On-Demand = pay-per-request, parfait pour trafic imprévisible (pas de capacity planning).

---

**Q50.** Comment réduire les coûts de data transfer ?

- [x] A. **Utiliser CloudFront (data transfer out de CloudFront moins cher que EC2/S3 direct)**
- [x] B. **Garder les données dans la même région/AZ quand possible**
- [ ] C. Utiliser des instances plus grandes
- [ ] D. Acheter plus de bande passante

**Explication** : Data transfer entre AZs et vers Internet coûte cher. CloudFront réduit les coûts et améliore performance.

---

---

## 📊 Stratégies de Réponse

### Mots-Clés Importants

| Mot-clé | Service AWS probable |
|---------|---------------------|
| "Most cost-effective" | S3, Lambda, DynamoDB On-Demand, Spot Instances |
| "Lowest latency" | ElastiCache, CloudFront, DynamoDB Accelerator (DAX) |
| "Highest availability" | Multi-AZ, Multi-région, Auto Scaling |
| "Secure" | KMS, IAM roles, Private subnets, Secrets Manager |
| "Scalable" | Auto Scaling, DynamoDB, Lambda, S3 |
| "Serverless" | Lambda, API Gateway, DynamoDB, S3, Step Functions |
| "Real-time" | Kinesis, DynamoDB Streams, EventBridge |
| "Long-term storage" | S3 Glacier, S3 Glacier Deep Archive |
| "Relational database" | RDS, Aurora |
| "NoSQL" | DynamoDB |
| "File storage" | EFS (shared), S3 (object) |

### Pièges Fréquents

1. **Over-engineering** : AWS préfère solutions simples (managed services > self-managed)
2. **Sécurité** : Jamais hardcoder credentials, toujours IAM roles pour services
3. **Coûts** : "Most cost-effective" ≠ "Free Tier" (choisir vraiment le moins cher en prod)
4. **HA vs DR** : Multi-AZ = HA (minutes), Multi-région = DR (potential hours)
5. **Shared Responsibility** : Savoir qui (AWS vs Client) est responsable de quoi

---

## 🎯 Prochain Étape

Voir `/examen-preparation/examens-blancs/` pour des examens blancs complets (65 questions, 130 min).

Bon courage pour les certifications ! 💪🎓
