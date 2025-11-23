# 🚀 Programme de Formation DevOps AWS avec Certifications

> **Programme complet de 16-20 semaines pour obtenir les certifications AWS Developer Associate et Solutions Architect Associate tout en maîtrisant le DevOps sur AWS**

## 📋 Table des Matières

- [Vue d'ensemble](#-vue-densemble)
- [Architecture du Programme](#-architecture-du-programme)
- [Prérequis Techniques](#-prérequis-techniques)
- [Timeline Détaillée](#-timeline-détaillée)
- [Modules de Formation](#-modules-de-formation)
- [Projet Fil Rouge](#-projet-fil-rouge)
- [Préparation aux Examens](#-préparation-aux-examens)
- [Ressources et Outils](#-ressources-et-outils)
- [Checklist de Validation](#-checklist-de-validation)

---

## 🎯 Vue d'ensemble

### Objectifs

✅ **AWS Certified Developer - Associate** (DVA-C02)
✅ **AWS Certified Solutions Architect - Associate** (SAA-C03)
✅ **Maîtrise des pratiques DevOps modernes avec AWS**

### Approche Pédagogique

- **80/20** : Focus sur ce qui est réellement testé et utilisé en production
- **Learn by Doing** : Chaque concept suivi d'une pratique immédiate
- **Budget-Friendly** : Priorité au Free Tier AWS et ressources gratuites
- **Optimisé pour connexion standard** : Labs testés avec bande passante limitée

### Durée Totale

**16-20 semaines** (4-5 mois) avec 15-20h d'étude par semaine

---

## 🏗️ Architecture du Programme

### Stratégie d'Apprentissage Recommandée

**Phase 1 : Fondations (Semaines 1-2)**
- Configuration environnement
- Bases AWS et DevOps

**Phase 2 : Developer Associate (Semaines 3-10)**
- Focus sur le développement d'applications AWS
- Automatisation et CI/CD
- **Passage examen Developer** : Fin semaine 10

**Phase 3 : Solutions Architect Associate (Semaines 11-18)**
- Architecture et design patterns
- Networking et sécurité avancée
- **Passage examen Solutions Architect** : Fin semaine 18

**Phase 4 : Consolidation (Semaines 19-20)**
- Projet final intégré
- Révisions et best practices

### Pourquoi Developer d'abord ?

1. **Progression naturelle** : Du code vers l'architecture
2. **Feedback rapide** : Labs plus hands-on et gratifiants
3. **Fondations solides** : Les services de base sont bien couverts
4. **Momentum** : Première certif = motivation pour la seconde

### Temps d'Étude Hebdomadaire

- **Théorie** : 5-7h (vidéos, documentation, lectures)
- **Pratique** : 8-10h (labs, mini-projets, CLI)
- **Révisions** : 2-3h (QCM, flashcards, notes)

**Total** : 15-20h/semaine

---

## 🔧 Prérequis Techniques

### Avant de Commencer

#### Compétences Requises

- [ ] **Linux de base** : Navigation terminal, permissions, processus
- [ ] **Git** : Clone, commit, push, branches, merge
- [ ] **Programmation** : Python ou JavaScript (niveau intermédiaire)
- [ ] **Réseaux** : TCP/IP, DNS, HTTP/HTTPS concepts de base
- [ ] **JSON/YAML** : Lecture et écriture de fichiers de configuration

> 💡 **Besoin de renforcer vos bases ?**
>
> **[→ Semaine 0 : Modules Prérequis Détaillés](./modules/semaine-00-prerequis/)**
> - **[Linux de Base](./modules/semaine-00-prerequis/01-linux-base.md)** (10-15h) : Navigation, permissions, processus, éditeurs
> - **[Réseaux de Base](./modules/semaine-00-prerequis/02-reseaux-base.md)** (8-12h) : TCP/IP, DNS, HTTP/HTTPS, outils de diagnostic
>
> Ces modules sont OPTIONNELS. Si vous maîtrisez déjà Linux et les réseaux, passez directement à la Semaine 1.

#### Setup Initial

```bash
# 1. Installation AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

# 2. Configuration AWS CLI
aws configure
# AWS Access Key ID: [votre clé]
# AWS Secret Access Key: [votre secret]
# Default region: us-east-1
# Default output format: json

# 3. Installation outils DevOps
# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Terraform (optionnel, pour IaC avancé)
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
unzip terraform_1.6.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# 4. Éditeur de code
# VSCode avec extensions: AWS Toolkit, CloudFormation, Python
```

#### Compte AWS

1. **Créer un compte AWS** : https://aws.amazon.com/free/
2. **Activer MFA** sur le compte root
3. **Créer un utilisateur IAM** avec droits admin pour la formation
4. **Configurer Budget Alerts** : Alert à 5$ et 10$
5. **Comprendre le Free Tier** : https://aws.amazon.com/free/

---

## 📅 Timeline Détaillée

### Phase 0 : Prérequis (Optionnel, avant de commencer)

**Semaine 0 : Linux et Réseaux** *(Si besoin de renforcement)*
- Linux de base : Navigation, permissions, processus, éditeurs (10-15h)
- Réseaux : TCP/IP, DNS, HTTP/HTTPS, outils diagnostic (8-12h)
- **Validation** : Checklists à 80%+
- **[→ Voir les modules détaillés](./modules/semaine-00-prerequis/)**

### Phase 1 : Fondations (Semaines 1-2)

**Semaine 1 : Setup et Bases AWS**
- Configuration compte et environnement
- IAM : Utilisateurs, groupes, rôles, politiques
- Concepts de facturation et Free Tier
- **Mini-projet** : Créer une organisation IAM sécurisée

**Semaine 2 : Compute et Storage Fondamentaux**
- EC2 : Instances, types, pricing models
- S3 : Buckets, versioning, lifecycle
- **Mini-projet** : Déployer un site statique sur S3

### Phase 2 : AWS Developer Associate (Semaines 3-10)

**Semaine 3 : Développement Serverless**
- Lambda : Fonctions, triggers, layers
- API Gateway : REST et HTTP APIs
- **Mini-projet** : API REST serverless

**Semaine 4 : Bases de Données**
- DynamoDB : Tables, indexes, queries
- RDS : PostgreSQL/MySQL, read replicas
- **Mini-projet** : CRUD app avec DynamoDB

**Semaine 5 : Messaging et Integration**
- SQS : Queues standard et FIFO
- SNS : Topics et subscriptions
- EventBridge : Event-driven architecture
- **Mini-projet** : Système de traitement asynchrone

**Semaine 6 : CI/CD Pipeline (Partie 1)**
- CodeCommit : Repository Git managé
- CodeBuild : Build automation
- **Mini-projet** : Pipeline de build automatisé

**Semaine 7 : CI/CD Pipeline (Partie 2)**
- CodeDeploy : Déploiements blue/green
- CodePipeline : Orchestration complète
- **Mini-projet** : Pipeline CI/CD end-to-end

**Semaine 8 : Monitoring et Debugging**
- CloudWatch : Logs, métriques, alarmes
- X-Ray : Distributed tracing
- CloudTrail : Audit des API calls
- **Mini-projet** : Monitoring dashboard complet

**Semaine 9 : Infrastructure as Code**
- CloudFormation : Templates, stacks, change sets
- SAM : Serverless Application Model
- **Mini-projet** : Déployer une app complète via IaC

**Semaine 10 : Révisions Developer + Examen Blanc**
- Révision tous les domaines
- 3 examens blancs complets
- Correction des points faibles
- **Passage certification Developer**

### Phase 3 : Solutions Architect Associate (Semaines 11-18)

**Semaine 11 : Architecture Patterns Fondamentaux**
- Well-Architected Framework : 6 piliers
- Haute disponibilité et fault tolerance
- Scalabilité horizontale vs verticale
- **Mini-projet** : Analyser et améliorer une architecture

**Semaine 12 : Networking Avancé (VPC)**
- VPC : Subnets, routing tables, IGW, NAT
- Security Groups vs NACLs
- VPC Peering et Transit Gateway
- **Mini-projet** : Architecture multi-tier VPC

**Semaine 13 : Load Balancing et Auto Scaling**
- ALB, NLB, GLB : Différences et use cases
- Auto Scaling Groups : Policies et lifecycle hooks
- Target Tracking et Step Scaling
- **Mini-projet** : App hautement disponible avec ASG

**Semaine 14 : Content Delivery et DNS**
- CloudFront : CDN, distributions, origins
- Route 53 : Hosted zones, routing policies
- Global Accelerator
- **Mini-projet** : Site global avec faible latence

**Semaine 15 : Storage Avancé**
- EBS : Volumes, snapshots, encryption
- EFS : File system partagé
- S3 : Storage classes, replication, events
- Storage Gateway : Hybrid cloud
- **Mini-projet** : Solution de backup multi-région

**Semaine 16 : Databases et Caching**
- Aurora : Serverless, global database
- ElastiCache : Redis vs Memcached
- Database migration strategies
- **Mini-projet** : Migration RDS vers Aurora

**Semaine 17 : Sécurité Avancée**
- KMS : Encryption keys management
- Secrets Manager : Rotation automatique
- WAF et Shield : Protection DDoS
- GuardDuty et Security Hub
- **Mini-projet** : Sécuriser une application complète

**Semaine 18 : Révisions Architect + Examen Blanc**
- Révision tous les domaines
- 3 examens blancs complets
- Design patterns et case studies
- **Passage certification Solutions Architect**

### Phase 4 : Consolidation (Semaines 19-20)

**Semaine 19 : Projet Final Intégré**
- Application complète multi-tier
- CI/CD complet
- Monitoring et alerting
- Multi-région et disaster recovery

**Semaine 20 : DevOps Best Practices**
- Observability avancée
- Cost optimization
- Security hardening
- Documentation et runbooks

---

## 📚 Modules de Formation

Chaque module suit cette structure :
1. **Théorie** : Concepts clés avec analogies
2. **Pratique** : Hands-on labs
3. **DevOps** : Intégration dans pipelines
4. **Examen** : Questions types

Voir dossier `/modules` pour les détails de chaque semaine.

---

## 🎨 Projet Fil Rouge

### Application : **"CloudMarket" - Marketplace e-commerce**

Une plateforme de marketplace que vous allez construire progressivement en intégrant chaque nouveau service AWS appris.

#### Architecture Finale

```
┌─────────────────────────────────────────────────────────────┐
│                        CloudFront (CDN)                      │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────┴──────────────────────────────────────┐
│                    Route 53 (DNS)                            │
└──────────────────────┬──────────────────────────────────────┘
                       │
        ┌──────────────┴──────────────┐
        │                             │
┌───────▼────────┐           ┌────────▼────────┐
│  S3 (Frontend) │           │   API Gateway    │
│  React SPA     │           │   + Lambda       │
└────────────────┘           └────────┬─────────┘
                                      │
                    ┌─────────────────┼─────────────────┐
                    │                 │                 │
            ┌───────▼──────┐  ┌──────▼──────┐  ┌──────▼──────┐
            │  DynamoDB    │  │     SQS      │  │     SNS     │
            │  (Products)  │  │   (Orders)   │  │ (Notifications)│
            └──────────────┘  └──────────────┘  └─────────────┘
                    │
            ┌───────▼──────┐
            │  CloudWatch  │
            │  + X-Ray     │
            └──────────────┘
```

#### Évolution Progressive

**Semaine 2** : Site statique sur S3
**Semaine 3** : API Lambda + API Gateway
**Semaine 4** : Base de données DynamoDB
**Semaine 5** : File d'attente SQS pour commandes
**Semaine 6-7** : Pipeline CI/CD complet
**Semaine 8** : Monitoring CloudWatch + X-Ray
**Semaine 9** : Infrastructure as Code (CloudFormation)
**Semaines 11-18** : Ajout VPC, ALB, Auto Scaling, Multi-région

Voir `/projet-fil-rouge` pour le code et les instructions détaillées.

---

## 📝 Préparation aux Examens

### Domaines d'Examen

#### AWS Certified Developer - Associate (DVA-C02)

| Domaine | Poids | Durée étude |
|---------|-------|-------------|
| 1. Développement avec AWS Services | 32% | 25h |
| 2. Sécurité | 26% | 20h |
| 3. Déploiement | 24% | 20h |
| 4. Troubleshooting et optimisation | 18% | 15h |

#### AWS Certified Solutions Architect - Associate (SAA-C03)

| Domaine | Poids | Durée étude |
|---------|-------|-------------|
| 1. Design d'architectures sécurisées | 30% | 25h |
| 2. Design d'architectures résilientes | 26% | 22h |
| 3. Design d'architectures performantes | 24% | 20h |
| 4. Design d'architectures optimisées (coûts) | 20% | 18h |

### Stratégies de Réponse QCM

1. **Élimination** : Éliminez les réponses clairement fausses
2. **Mots-clés** : "Most cost-effective" → S3, "Lowest latency" → ElastiCache
3. **Best practices** : AWS privilégie managed services, automation, security
4. **Free Tier trap** : Ne pas choisir une option juste car elle est gratuite
5. **Over-engineering** : AWS préfère solutions simples et scalables

### Questions Types par Service

Voir `/examen-preparation/questions-types.md` pour 500+ questions pratiques.

### Simulateurs Recommandés

#### Gratuits
- **AWS Skill Builder** : https://skillbuilder.aws/
- **AWS Exam Readiness** : Cours officiels gratuits
- **Tutorialsdojo FREE** : 20 questions gratuites par examen

#### Payants (Recommandés)
- **Tutorialsdojo Practice Exams** (~15$/examen) ⭐ **MEILLEUR RAPPORT QUALITÉ/PRIX**
- **Stephane Maarek Ultimate AWS Certified** sur Udemy (~12$ en promo)
- **A Cloud Guru** : Si budget permet (29$/mois)

### Planning Dernières Semaines

**S-3 semaines**
- 1 examen blanc complet
- Identifier les points faibles
- Révision ciblée

**S-2 semaines**
- 2 examens blancs
- Flashcards services AWS
- Relire documentation officielle

**S-1 semaine**
- 2 examens blancs
- Révision FAQs services clés
- Repos et confiance !

**Jour J**
- Bien dormi
- Arriver 15min en avance (si centre de test)
- Lire TOUTES les questions attentivement
- Marquer les questions douteuses pour révision
- **Objectif** : 75%+ (le passing score varie mais ~72%)

---

## 🛠️ Ressources et Outils

### Cours Vidéo

#### Gratuits
- **AWS Skill Builder** : https://skillbuilder.aws/ (officiel) ⭐
- **freeCodeCamp AWS YouTube** : Cours complets 10h+
- **AWS Official YouTube Channel** : This is My Architecture

#### Payants (Recommandés)
- **Stephane Maarek** (Udemy) : Developer + Solutions Architect (~12$ chacun en promo) ⭐
- **Adrian Cantrill** : Très détaillé, excellent pour SA (40$)
- **A Cloud Guru / Pluralsight** : Bonne qualité mais plus cher (29$/mois)

### Livres

- **AWS Certified Developer Official Study Guide** (Sybex) - Référence officielle
- **AWS Certified Solutions Architect Official Study Guide** (Sybex)
- **AWS Cookbook** (O'Reilly) - Recettes pratiques

### Labs Hands-on

#### Gratuits
- **AWS Free Tier** : https://aws.amazon.com/free/ ⭐
- **AWS Workshops** : https://workshops.aws/
- **AWS Hands-on Tutorials** : https://aws.amazon.com/getting-started/hands-on/
- **Qwiklabs FREE** : Quelques labs gratuits par mois

#### Payants
- **A Cloud Guru Sandbox** : Environnement AWS temporaire (inclus abonnement)
- **CloudAcademy Labs** : Bonne qualité (29$/mois)

### Documentation Officielle

- **AWS Documentation** : https://docs.aws.amazon.com/
- **AWS Well-Architected Framework** : https://aws.amazon.com/architecture/well-architected/
- **AWS Whitepapers** : https://aws.amazon.com/whitepapers/
- **Service FAQs** : Lire les FAQs des services clés (très testés !)

### Outils CLI et Scripts

```bash
# AWS CLI essentials
aws sts get-caller-identity  # Vérifier identité
aws ec2 describe-instances   # Lister EC2
aws s3 ls                     # Lister buckets S3
aws dynamodb list-tables     # Lister tables DynamoDB
aws cloudformation list-stacks  # Lister stacks CF

# Monitoring coûts
aws ce get-cost-and-usage \
  --time-period Start=2024-01-01,End=2024-01-31 \
  --granularity MONTHLY \
  --metrics BlendedCost

# Cleanup script (à exécuter après chaque lab !)
./scripts/cleanup-aws-resources.sh
```

### Communautés et Forums

- **AWS re:Post** : https://repost.aws/ (officiel)
- **/r/AWSCertifications** : Reddit très actif ⭐
- **Discord AWS Certification** : Communauté d'entraide
- **LinkedIn Groups** : AWS Certification Study Group
- **ExamTopics** : Questions d'examen (utiliser avec précaution, vérifier réponses)

### Flashcards et Mémorisation

- **Anki** : Créer decks personnalisés
- **Quizlet** : Flashcards AWS publiques
- **Tutorialsdojo Cheat Sheets** : https://tutorialsdojo.com/aws-cheat-sheets/ ⭐

---

## ✅ Checklist de Validation

### Phase 1 : Fondations

#### Semaine 1 - IAM et Setup
- [ ] Compte AWS créé avec MFA activé
- [ ] Utilisateur IAM créé (pas de root usage)
- [ ] AWS CLI installé et configuré
- [ ] Comprendre la différence entre utilisateurs, groupes, rôles
- [ ] Créer une politique IAM custom
- [ ] Budget alerts configurés (5$ et 10$)
- [ ] Savoir lire AWS Cost Explorer

#### Semaine 2 - EC2 et S3
- [ ] Lancer une instance EC2 et s'y connecter en SSH
- [ ] Comprendre les types d'instances (t2, t3, m5, c5, r5)
- [ ] Créer un bucket S3 avec versioning
- [ ] Upload/download fichiers via CLI
- [ ] Configurer un site statique S3 + CloudFront
- [ ] Lifecycle policies S3 configurées

### Phase 2 : Developer Associate

#### Semaine 3 - Serverless
- [ ] Créer une fonction Lambda (Python ou Node.js)
- [ ] Configurer un trigger API Gateway
- [ ] Tester l'API avec curl ou Postman
- [ ] Comprendre les layers Lambda
- [ ] Gérer les variables d'environnement
- [ ] Voir les logs dans CloudWatch

#### Semaine 4 - Databases
- [ ] Créer une table DynamoDB avec GSI
- [ ] Effectuer PutItem, GetItem, Query, Scan
- [ ] Comprendre RCU/WCU et pricing
- [ ] Lancer une instance RDS (PostgreSQL)
- [ ] Se connecter à RDS depuis EC2
- [ ] Créer un read replica

#### Semaine 5 - Messaging
- [ ] Créer une queue SQS standard
- [ ] Envoyer et recevoir des messages
- [ ] Configurer une Dead Letter Queue
- [ ] Créer un topic SNS avec email subscription
- [ ] Comprendre SQS FIFO vs Standard
- [ ] EventBridge rule pour automatisation

#### Semaine 6 - CI/CD Partie 1
- [ ] Repository CodeCommit créé
- [ ] Push code via Git
- [ ] Projet CodeBuild configuré
- [ ] Buildspec.yaml fonctionnel
- [ ] Build réussie avec artifacts
- [ ] Intégrer tests unitaires dans build

#### Semaine 7 - CI/CD Partie 2
- [ ] Application déployée via CodeDeploy
- [ ] Déploiement blue/green fonctionnel
- [ ] Pipeline CodePipeline end-to-end
- [ ] Rollback automatique en cas d'échec
- [ ] Notifications SNS sur événements pipeline
- [ ] AppSpec.yaml maîtrisé

#### Semaine 8 - Monitoring
- [ ] CloudWatch Dashboard créé
- [ ] Métriques custom envoyées
- [ ] Alarmes configurées avec actions SNS
- [ ] Logs centralisés dans CloudWatch Logs
- [ ] X-Ray tracing activé sur Lambda
- [ ] Comprendre les segments et subsegments X-Ray

#### Semaine 9 - Infrastructure as Code
- [ ] Template CloudFormation écrit (YAML)
- [ ] Stack créée et mise à jour
- [ ] Comprendre les change sets
- [ ] Utiliser SAM pour serverless
- [ ] Outputs et exports entre stacks
- [ ] Nested stacks pour modularité

#### Semaine 10 - Révisions Developer
- [ ] Score 80%+ sur 3 examens blancs
- [ ] Tous les domaines > 75%
- [ ] Comprendre TOUS les services Developer
- [ ] Lire FAQs : Lambda, DynamoDB, API Gateway, CodePipeline
- [ ] Connaître les limites des services (quotas)
- [ ] **CERTIFICATION DEVELOPER PASSÉE** ✅

### Phase 3 : Solutions Architect Associate

#### Semaine 11 - Architecture Patterns
- [ ] Comprendre les 6 piliers Well-Architected
- [ ] Différencier HA, fault tolerance, disaster recovery
- [ ] Calculer availability (99.9%, 99.99%, etc.)
- [ ] RTO vs RPO maîtrisés
- [ ] Analyser des architectures multi-tier
- [ ] Identifier les SPOF (Single Point of Failure)

#### Semaine 12 - VPC Networking
- [ ] Créer un VPC custom avec subnets publics/privés
- [ ] Configurer IGW et NAT Gateway
- [ ] Route tables correctement configurées
- [ ] Security Groups vs NACLs : différences claires
- [ ] VPC Peering fonctionnel
- [ ] VPC Flow Logs activés

#### Semaine 13 - Load Balancing
- [ ] ALB créé avec target groups
- [ ] Health checks configurés
- [ ] Auto Scaling Group fonctionnel
- [ ] Scaling policies testées (target tracking)
- [ ] Comprendre NLB vs ALB vs GLB
- [ ] Tester scale-out et scale-in

#### Semaine 14 - CloudFront et Route 53
- [ ] Distribution CloudFront créée
- [ ] Origin S3 ou ALB configuré
- [ ] Cache behaviors optimisés
- [ ] Hosted zone Route 53 avec domaine
- [ ] Routing policies testées (failover, geolocation, weighted)
- [ ] Certificat ACM provisionné

#### Semaine 15 - Storage Avancé
- [ ] Volume EBS attaché et formaté
- [ ] Snapshot EBS créé et restauré
- [ ] EFS monté sur plusieurs EC2
- [ ] S3 Cross-Region Replication configurée
- [ ] Storage classes S3 maîtrisées
- [ ] Lifecycle transitions testées

#### Semaine 16 - Databases Avancées
- [ ] Cluster Aurora créé
- [ ] Aurora Serverless testé
- [ ] ElastiCache Redis déployé
- [ ] Comprendre read replicas vs Multi-AZ
- [ ] Database migration avec DMS (optionnel)
- [ ] Stratégies de backup et restore

#### Semaine 17 - Sécurité Avancée
- [ ] KMS key créée et utilisée
- [ ] Encryption at rest et in transit
- [ ] Secrets Manager pour credentials
- [ ] WAF rules configurées
- [ ] GuardDuty activé
- [ ] Security Hub et findings

#### Semaine 18 - Révisions Architect
- [ ] Score 80%+ sur 3 examens blancs
- [ ] Tous les domaines > 75%
- [ ] Maîtriser design patterns (microservices, event-driven, etc.)
- [ ] Lire FAQs : VPC, ELB, Route 53, RDS, S3
- [ ] Case studies analysés
- [ ] **CERTIFICATION SOLUTIONS ARCHITECT PASSÉE** ✅

### Phase 4 : Consolidation

#### Semaine 19-20 - Projet Final
- [ ] Application complète déployée
- [ ] Multi-région avec failover
- [ ] CI/CD complet fonctionnel
- [ ] Monitoring et alerting configurés
- [ ] Documentation technique écrite
- [ ] Disaster recovery testé
- [ ] Coûts optimisés < 10$/mois

---

## 💰 Gestion du Budget AWS

### Principes Free Tier

- **EC2** : 750h/mois t2.micro (1 an)
- **S3** : 5 GB storage (permanent)
- **Lambda** : 1M requests/mois (permanent)
- **DynamoDB** : 25 GB storage (permanent)
- **CloudFront** : 50 GB out/mois (1 an)
- **RDS** : 750h/mois t2.micro (1 an)

### Coûts Estimés par Phase

| Phase | Services | Coût estimé/mois |
|-------|----------|------------------|
| Semaines 1-4 | EC2, S3, DynamoDB | 0-2$ |
| Semaines 5-10 | + CodePipeline, Lambda | 2-5$ |
| Semaines 11-18 | + VPC, ALB, Route53 | 5-10$ |
| Total formation | Moyenne | **3-7$/mois** |

### Script de Nettoyage

```bash
#!/bin/bash
# cleanup-aws-resources.sh - À exécuter après chaque lab !

# Terminer instances EC2
aws ec2 terminate-instances --instance-ids $(aws ec2 describe-instances \
  --query 'Reservations[].Instances[?State.Name==`running`].InstanceId' \
  --output text)

# Supprimer buckets S3 (vider d'abord)
for bucket in $(aws s3 ls | awk '{print $3}'); do
  aws s3 rm s3://$bucket --recursive
  aws s3 rb s3://$bucket
done

# Supprimer stacks CloudFormation
for stack in $(aws cloudformation list-stacks --query \
  'StackSummaries[?StackStatus!=`DELETE_COMPLETE`].StackName' --output text); do
  aws cloudformation delete-stack --stack-name $stack
done

# Supprimer NAT Gateways (coûteux !)
for nat in $(aws ec2 describe-nat-gateways --query 'NatGateways[].NatGatewayId' --output text); do
  aws ec2 delete-nat-gateway --nat-gateway-id $nat
done

# Supprimer Load Balancers
for alb in $(aws elbv2 describe-load-balancers --query 'LoadBalancers[].LoadBalancerArn' --output text); do
  aws elbv2 delete-load-balancer --load-balancer-arn $alb
done

echo "Cleanup terminé ! Vérifiez AWS Console pour confirmer."
```

---

## 🎓 Conseils de l'Expert

### Pièges Courants à Éviter

1. **Ne pas lire la question complètement** : "Most cost-effective" ≠ "Lowest latency"
2. **Oublier de supprimer les ressources** : NAT Gateway coûte 0.045$/h
3. **Utiliser le compte root** : Toujours IAM user
4. **Ignorer les logs CloudWatch** : Indispensables pour debug
5. **Ne pas tester le rollback** : Planifier toujours le plan B

### Best Practices Production

- **Tagging** : Tous les ressources avec Environment, Project, Owner
- **Multi-AZ** : Toujours pour production
- **Backup** : Automatisé avec AWS Backup
- **Monitoring** : CloudWatch Alarms sur métriques critiques
- **Security** : Principle of least privilege (moindre privilège)
- **IaC** : Infrastructure as Code pour tout (CloudFormation, Terraform)
- **Documentation** : Architecture diagrams et runbooks

### Astuces Apprentissage

1. **Pratiquer tous les jours** : 2h/jour > 14h/week-end
2. **Enseigner pour apprendre** : Expliquer les concepts à quelqu'un
3. **Visualiser l'architecture** : Dessiner les diagrammes
4. **Flashcards** : Pour mémoriser limites et quotas
5. **Pause active** : Marcher en écoutant des podcasts AWS
6. **Communauté** : Rejoindre les forums, poser des questions

### Jour de l'Examen

- ☕ **Bien dormi** : 8h de sommeil minimum
- 🥐 **Bien mangé** : Petit-déjeuner léger
- 📱 **Téléphone éteint** : Zéro distraction
- ⏰ **Arriver tôt** : 15min d'avance
- 📖 **Lire attentivement** : Chaque mot compte
- 🚩 **Marquer les doutes** : Pour révision finale
- 💪 **Confiance** : Vous avez pratiqué, vous êtes prêt !

---

## 🚀 Prochaines Étapes

1. ⬜ **Lire ce README complètement**
2. ⬜ **Vérifier les prérequis techniques**
   - Si besoin : **[Semaine 0 - Prérequis](./modules/semaine-00-prerequis/)** (Linux + Réseaux)
3. ⬜ **Créer compte AWS et configurer MFA**
4. ⬜ **Installer AWS CLI et outils**
5. ⬜ **Démarrer Semaine 1** → `/modules/semaine-01/`

---

## 📞 Support et Communauté

- **Questions** : Ouvrir une issue sur ce repo
- **Partage d'expérience** : Discussions GitHub
- **Ressources additionnelles** : `/resources`
- **Votre progression** : `/ma-progression.md`

---

## 🌟 Motivation

> "The expert in anything was once a beginner." - Helen Hayes

Vous êtes sur le point de maîtriser l'une des compétences les plus demandées du marché. Les certifications AWS ouvrent des portes et valident vos compétences auprès des employeurs du monde entier.

**16-20 semaines de travail acharné = Des années d'opportunités professionnelles**

Bon courage et bienvenue dans votre parcours DevOps AWS ! 🚀☁️

---

**Dernière mise à jour** : Novembre 2024
**Version** : 1.0.0
**Licence** : MIT
**Auteur** : Programme de formation DevOps AWS
