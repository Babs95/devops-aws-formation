# 📘 Semaine 1 : Setup et Bases AWS - IAM

> **Objectif** : Configurer l'environnement de travail et maîtriser IAM (Identity and Access Management), le service de sécurité fondamental d'AWS.

---

## 🎯 Objectifs d'Apprentissage

À la fin de cette semaine, vous serez capable de :

- ✅ Créer et sécuriser un compte AWS
- ✅ Comprendre le modèle de responsabilité partagée AWS
- ✅ Maîtriser les concepts IAM : Utilisateurs, Groupes, Rôles, Politiques
- ✅ Appliquer le principe du moindre privilège
- ✅ Configurer AWS CLI et accès programmatique
- ✅ Surveiller les coûts et configurer des alertes budgétaires

---

## 📚 Partie Théorique

### 1. Concepts Fondamentaux AWS

#### Qu'est-ce qu'AWS ?

**Analogie** : AWS est comme un centre commercial géant où chaque boutique est un service cloud :
- **EC2** = Location d'ordinateurs (serveurs)
- **S3** = Service de stockage (entrepôt)
- **RDS** = Service de bases de données managées
- **Lambda** = Service de livraison à la demande (vous ne payez que quand on livre)

#### Modèle de Responsabilité Partagée

```
┌─────────────────────────────────────────┐
│        RESPONSABILITÉ CLIENT            │
│  - Données                              │
│  - Applications                         │
│  - IAM                                  │
│  - Configuration OS, réseau, firewall   │
└─────────────────────────────────────────┘
┌─────────────────────────────────────────┐
│        RESPONSABILITÉ AWS               │
│  - Infrastructure matérielle            │
│  - Datacenters                          │
│  - Réseau physique                      │
│  - Services managés (RDS, Lambda, etc.) │
└─────────────────────────────────────────┘
```

**Important pour l'examen** : Savoir qui est responsable de quoi !

---

### 2. IAM (Identity and Access Management)

#### Pourquoi IAM est crucial ?

**Analogie** : IAM est comme le système de badges d'une entreprise :
- **Utilisateurs** = Employés avec leur badge
- **Groupes** = Départements (RH, IT, Marketing)
- **Rôles** = Fonctions temporaires (consultant externe)
- **Politiques** = Règles d'accès (qui peut entrer où)

#### Composants IAM

**1. Utilisateurs (Users)**
- Identité permanente pour une personne ou application
- Credentials : Password + Access Keys (pour CLI/API)
- **Best Practice** : 1 utilisateur = 1 personne physique

**2. Groupes (Groups)**
- Collection d'utilisateurs
- Les permissions s'appliquent à tous les membres
- Exemple : Groupe "Developers", "Admins", "ReadOnly"

**3. Rôles (Roles)**
- Identité assumable temporairement
- Utilisé par services AWS (EC2, Lambda) ou utilisateurs externes
- **Analogie** : Rôle = Casquette qu'on porte temporairement

**4. Politiques (Policies)**
- Document JSON définissant les permissions
- 2 types : Managed policies (AWS ou custom) vs Inline policies

#### Structure d'une Politique IAM

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::mon-bucket/*"
    }
  ]
}
```

**Éléments clés** :
- **Effect** : Allow ou Deny
- **Action** : Opérations autorisées (service:action)
- **Resource** : Sur quelles ressources (ARN)
- **Condition** : (optionnel) Conditions supplémentaires

#### Questions Fréquentes à l'Examen

**Q1** : Différence entre IAM User et IAM Role ?
- **User** : Identité permanente, credentials fixes
- **Role** : Identité temporaire, assumée par services/users

**Q2** : Comment donner accès à une application EC2 vers S3 ?
- ❌ **Mauvais** : Mettre Access Keys en dur dans le code
- ✅ **Bon** : Créer un IAM Role et l'attacher à l'instance EC2

**Q3** : Un utilisateur a une Allow policy et une Deny policy, que se passe-t-il ?
- **Réponse** : Deny l'emporte toujours (explicit deny > allow)

---

## 🛠️ Partie Pratique

### Lab 1 : Configuration Compte AWS (30 min)

#### Étape 1 : Créer le compte AWS

1. Aller sur https://aws.amazon.com/free/
2. Cliquer "Create a Free Account"
3. Fournir email, mot de passe, nom du compte
4. Entrer informations de paiement (carte bancaire requise)
   - ⚠️ **Pas d'inquiétude** : Aucun prélèvement si vous restez dans le Free Tier
5. Vérification téléphone
6. Choisir plan "Basic Support (Free)"

#### Étape 2 : Sécuriser le compte root

```bash
# Le compte root a TOUS les pouvoirs - il faut le sécuriser !

# 1. Activer MFA (Multi-Factor Authentication)
# Console AWS > Account > Security Credentials > MFA
# - Utiliser Google Authenticator ou Authy (apps mobiles)
# - Scanner le QR code
# - Entrer 2 codes MFA consécutifs

# 2. Supprimer les Access Keys du root (si créées)
# Console AWS > Account > Security Credentials > Access Keys
# - Delete all root access keys

# 3. Noter le mot de passe dans un gestionnaire sécurisé
# - Utiliser LastPass, 1Password, ou Bitwarden
```

**✅ Critère de validation** : MFA activé sur compte root visible dans Security Credentials

#### Étape 3 : Créer un utilisateur IAM Admin

```bash
# Via AWS Console :
# IAM > Users > Add User

# Configuration :
# - Username: admin-user
# - Access type: ☑ Password - AWS Management Console access
#                ☑ Programmatic access (Access Key)
# - Password: Auto-generate ou custom
# - Require password reset: ☑ (première connexion)

# Permissions :
# - Attach existing policies directly
# - Select: AdministratorAccess

# Tags (optionnel mais recommandé) :
# - Key: Environment, Value: Training
# - Key: Owner, Value: VotreNom

# ⚠️ IMPORTANT : Télécharger le fichier CSV avec les credentials
# Il contient : Access Key ID + Secret Access Key (affichés 1 seule fois)
```

**✅ Critère de validation** : Connexion réussie avec le nouveau user admin

#### Étape 4 : Configurer AWS CLI

```bash
# Installation AWS CLI v2 (Linux/macOS)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Vérification installation
aws --version
# Output attendu: aws-cli/2.x.x Python/3.x.x Linux/x.x.x

# Configuration avec les credentials du user admin
aws configure
# AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
# AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
# Default region name [None]: us-east-1
# Default output format [None]: json

# Test de la configuration
aws sts get-caller-identity
# Output attendu:
# {
#     "UserId": "AIDAI...",
#     "Account": "123456789012",
#     "Arn": "arn:aws:iam::123456789012:user/admin-user"
# }
```

**✅ Critère de validation** : `aws sts get-caller-identity` retourne vos infos

---

### Lab 2 : Maîtriser IAM (60 min)

#### Scénario

Vous êtes admin DevOps. Vous devez créer :
1. **3 développeurs** : accès lecture/écriture sur S3 et Lambda
2. **2 ops** : accès complet sur EC2, CloudWatch
3. **1 auditeur** : accès lecture seule partout

#### Étape 1 : Créer les groupes

```bash
# Via AWS CLI

# Groupe Developers
aws iam create-group --group-name Developers

# Groupe Operations
aws iam create-group --group-name Operations

# Groupe Auditors
aws iam create-group --group-name Auditors
```

#### Étape 2 : Attacher les politiques aux groupes

```bash
# Developers : S3 + Lambda
aws iam attach-group-policy \
  --group-name Developers \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess

aws iam attach-group-policy \
  --group-name Developers \
  --policy-arn arn:aws:iam::aws:policy/AWSLambda_FullAccess

# Operations : EC2 + CloudWatch
aws iam attach-group-policy \
  --group-name Operations \
  --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess

aws iam attach-group-policy \
  --group-name Operations \
  --policy-arn arn:aws:iam::aws:policy/CloudWatchFullAccess

# Auditors : ReadOnly
aws iam attach-group-policy \
  --group-name Auditors \
  --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess
```

#### Étape 3 : Créer des utilisateurs et les assigner

```bash
# Créer utilisateur
aws iam create-user --user-name dev-alice

# Générer password
aws iam create-login-profile \
  --user-name dev-alice \
  --password 'TempPassword123!' \
  --password-reset-required

# Ajouter au groupe
aws iam add-user-to-group \
  --user-name dev-alice \
  --group-name Developers

# Répéter pour dev-bob, dev-charlie, ops-david, ops-emma, audit-frank
```

#### Étape 4 : Créer une politique custom (Moindre privilège)

**Besoin** : Les développeurs doivent pouvoir créer des buckets S3, mais uniquement avec un préfixe "dev-"

```bash
# Créer le fichier de politique
cat > dev-s3-policy.json <<'EOF'
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:CreateBucket",
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": [
        "arn:aws:s3:::dev-*",
        "arn:aws:s3:::dev-*/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "s3:ListAllMyBuckets",
      "Resource": "*"
    }
  ]
}
EOF

# Créer la politique
aws iam create-policy \
  --policy-name DevS3RestrictedPolicy \
  --policy-document file://dev-s3-policy.json

# Attacher au groupe (remplacer ACCOUNT_ID)
aws iam attach-group-policy \
  --group-name Developers \
  --policy-arn arn:aws:iam::ACCOUNT_ID:policy/DevS3RestrictedPolicy
```

**✅ Critère de validation** : Tester avec `dev-alice`, elle peut créer `dev-test` mais pas `prod-test`

---

### Lab 3 : IAM Roles pour EC2 (45 min)

#### Objectif

Permettre à une instance EC2 de lire un bucket S3 sans mettre de credentials en dur.

#### Étape 1 : Créer le rôle

```bash
# Créer trust policy (qui peut assumer le rôle)
cat > ec2-trust-policy.json <<'EOF'
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

# Créer le rôle
aws iam create-role \
  --role-name EC2-S3ReadOnly-Role \
  --assume-role-policy-document file://ec2-trust-policy.json

# Attacher la politique S3ReadOnly
aws iam attach-role-policy \
  --role-name EC2-S3ReadOnly-Role \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess

# Créer instance profile (wrapper pour attacher à EC2)
aws iam create-instance-profile \
  --instance-profile-name EC2-S3ReadOnly-Profile

# Ajouter le rôle à l'instance profile
aws iam add-role-to-instance-profile \
  --instance-profile-name EC2-S3ReadOnly-Profile \
  --role-name EC2-S3ReadOnly-Role
```

#### Étape 2 : Lancer EC2 avec le rôle

```bash
# Lancer instance avec le rôle (détails EC2 en semaine 2)
aws ec2 run-instances \
  --image-id ami-0c55b159cbfafe1f0 \
  --instance-type t2.micro \
  --iam-instance-profile Name=EC2-S3ReadOnly-Profile \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=test-iam-role}]'

# Note : L'AMI ID varie selon la région
```

#### Étape 3 : Tester depuis l'instance

```bash
# Se connecter à l'instance (via EC2 Instance Connect ou SSH)
# Une fois connecté :

# Vérifier le rôle attaché
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/

# Lister les buckets S3 (devrait fonctionner)
aws s3 ls

# Essayer d'upload un fichier (devrait échouer - ReadOnly)
echo "test" > test.txt
aws s3 cp test.txt s3://mon-bucket/test.txt
# Error: Access Denied ✅ (normal, ReadOnly)
```

**✅ Critère de validation** : L'instance peut lister S3 mais pas écrire

---

### Lab 4 : Budget et Alertes (30 min)

#### Configuration Budget Alert

```bash
# Via Console (plus simple pour débutants)
# Billing Dashboard > Budgets > Create Budget

# Configuration :
# - Budget type: Cost budget
# - Period: Monthly
# - Budgeted amount: $10.00
# - Budget name: MonthlyTrainingBudget

# Alert 1 : 50% du budget
# - Threshold: 50% of budgeted amount
# - Email: votre-email@example.com

# Alert 2 : 80% du budget
# - Threshold: 80% of budgeted amount
# - Email: votre-email@example.com

# Alert 3 : 100% du budget (dépassement)
# - Threshold: 100% of budgeted amount
# - Email: votre-email@example.com
```

#### Cost Explorer

```bash
# Console > Cost Explorer > Launch Cost Explorer

# Analyser :
# - Last Month : Voir les coûts du mois précédent
# - Service : Grouper par service AWS
# - Daily : Granularité journalière

# Créer un rapport custom :
# - Filter: Service = EC2
# - Group by: Usage Type
# - Time range: Last 7 days
```

**✅ Critère de validation** : Budget créé, 3 alertes configurées, email de confirmation reçu

---

## 🔄 Intégration DevOps

### IAM dans un Pipeline CI/CD

#### Scenario : Pipeline CodePipeline

```yaml
# Rôles nécessaires dans un pipeline typique

1. CodePipeline-Service-Role
   → Permissions: codepipeline, s3, codecommit, codebuild, codedeploy

2. CodeBuild-Service-Role
   → Permissions: logs, s3, ecr (pour Docker images)

3. CodeDeploy-Service-Role
   → Permissions: ec2, autoscaling, elb

4. Lambda-Execution-Role (si déploiement serverless)
   → Permissions: logs, s3, dynamodb, etc.
```

#### Best Practices Production

1. **Rotation des credentials** : Access Keys expiration policy
2. **MFA pour actions critiques** : Require MFA to delete resources
3. **CloudTrail activé** : Audit de toutes les actions IAM
4. **Politiques basées sur tags** : Accès conditionnel selon tags
5. **Cross-account roles** : Pour environnements multi-comptes

#### Exemple : Policy avec condition MFA

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:TerminateInstances",
      "Resource": "*",
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    }
  ]
}
```

---

## 🎯 Ce qui est Testé à la Certification

### Developer Associate

**Domain 2: Security** (26% de l'examen)

- Différence Users vs Roles vs Groups
- Policies : Structure JSON, Effect, Action, Resource
- Comment donner accès à un service AWS (ex: Lambda vers DynamoDB)
- Credentials rotation et best practices
- **Question type** : "How can a Lambda function access DynamoDB?"
  - ✅ Attach IAM role with DynamoDB permissions
  - ❌ Embed access keys in environment variables

### Solutions Architect Associate

**Domain 1: Secure Architectures** (30% de l'examen)

- Multi-account strategy (AWS Organizations)
- Cross-account access avec roles
- Resource-based policies vs Identity-based policies
- Service Control Policies (SCPs)
- **Question type** : "How to give Account B access to S3 bucket in Account A?"
  - ✅ Bucket policy allowing Account B + IAM role in Account B
  - ❌ Share access keys between accounts

---

## 📖 Ressources Complémentaires

### Documentation Officielle

- [IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html) ⭐ **À LIRE**
- [IAM Policy Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies.html)
- [IAM FAQ](https://aws.amazon.com/iam/faqs/) ⭐ **Très testé**

### Vidéos Recommandées

- **AWS re:Invent - IAM Deep Dive** (YouTube, 45 min)
- **Stephane Maarek - IAM Section** (Udemy, 2h)

### Pratique Supplémentaire

- **IAM Policy Simulator** : https://policysim.aws.amazon.com/ (tester vos policies)
- **AWS IAM Access Analyzer** : Identifier les ressources partagées

---

## ⚠️ Pièges Courants

### 1. Confusion Role vs User

```
❌ MAUVAIS : Créer un user pour une application Lambda
✅ BON : Créer un role et l'assigner à Lambda
```

### 2. Embedded Credentials

```python
# ❌ MAUVAIS
import boto3
s3 = boto3.client('s3',
    aws_access_key_id='AKIAIOSFODNN7EXAMPLE',
    aws_secret_access_key='wJalr...')

# ✅ BON (utilise le rôle EC2/Lambda automatiquement)
import boto3
s3 = boto3.client('s3')
```

### 3. Root Account Usage

```
❌ MAUVAIS : Utiliser le root account pour tâches quotidiennes
✅ BON : Créer IAM users, verrouiller le root avec MFA
```

### 4. Wildcard Permissions

```json
// ❌ MAUVAIS : Trop permissif
{
  "Effect": "Allow",
  "Action": "*",
  "Resource": "*"
}

// ✅ BON : Least privilege
{
  "Effect": "Allow",
  "Action": "s3:GetObject",
  "Resource": "arn:aws:s3:::specific-bucket/*"
}
```

---

## ✅ Checklist de Validation Semaine 1

### Théorie
- [ ] Comprendre le modèle de responsabilité partagée
- [ ] Différencier Users, Groups, Roles, Policies
- [ ] Comprendre la structure d'une politique IAM (JSON)
- [ ] Connaître le principe du moindre privilège
- [ ] Savoir quand utiliser Roles vs Users

### Pratique
- [ ] Compte AWS créé avec MFA activé sur root
- [ ] Utilisateur IAM admin créé et utilisé (pas le root)
- [ ] AWS CLI installé et configuré
- [ ] `aws sts get-caller-identity` fonctionne
- [ ] 3 groupes créés avec politiques attachées
- [ ] 6 utilisateurs créés et assignés aux groupes
- [ ] Politique custom créée et testée
- [ ] Rôle EC2 créé et attaché à une instance
- [ ] Testé accès S3 depuis EC2 via rôle
- [ ] Budget alert configuré (seuils : 50%, 80%, 100%)
- [ ] Cost Explorer exploré

### DevOps
- [ ] Comprendre les rôles de service (CodePipeline, Lambda, etc.)
- [ ] Savoir créer un trust policy pour un service AWS
- [ ] Comprendre l'importance de CloudTrail pour audit

### Examen
- [ ] Lire IAM FAQ complètement
- [ ] Faire 20 questions IAM sur Tutorialsdojo/Udemy
- [ ] Score > 80% sur questions IAM

---

## 🚀 Prochaine Étape

**Semaine 2 : Compute et Storage (EC2, S3)**

Maintenant que vous maîtrisez la sécurité et les accès avec IAM, vous allez apprendre à lancer des serveurs (EC2) et stocker des données (S3).

**Mini-projet Semaine 2** : Déployer un site web statique sur S3 avec CloudFront, sécurisé avec IAM.

---

**Temps estimé Semaine 1** : 15-20h
- Théorie : 5h
- Labs pratiques : 10h
- QCM et révisions : 3-5h

💪 **Félicitations d'avoir complété la Semaine 1 !** Vous avez posé des fondations solides pour la suite !
