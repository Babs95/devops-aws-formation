# 🎨 Projet Fil Rouge : CloudMarket

> **Application e-commerce complète construite progressivement en intégrant chaque service AWS appris**

---

## 🎯 Vue d'ensemble

**CloudMarket** est une marketplace e-commerce que vous allez construire semaine après semaine en appliquant les concepts appris. À la fin du programme, vous aurez une application complète, hautement disponible, sécurisée et déployée automatiquement.

---

## 🏗️ Architecture Évolutive

### Semaine 2 : Version 1.0 - Site Statique

```
┌─────────────────┐
│   CloudFront    │ ← CDN global
└────────┬────────┘
         │
┌────────▼────────┐
│   S3 Bucket     │ ← Frontend React/Vue.js
│   (Static Web)  │
└─────────────────┘
```

**Fonctionnalités** :
- Page d'accueil avec liste de produits (statique)
- Design responsive
- Formulaire de contact (frontend only)

---

### Semaine 3 : Version 2.0 - Backend Serverless

```
┌─────────────────┐
│   CloudFront    │
└────────┬────────┘
         │
┌────────▼────────┐     ┌──────────────────┐
│   S3 (Frontend) │     │   API Gateway    │
└─────────────────┘     └────────┬─────────┘
                                 │
                        ┌────────▼─────────┐
                        │  Lambda Function │
                        │  - List products │
                        │  - Get product   │
                        └──────────────────┘
```

**Nouvelles fonctionnalités** :
- API REST pour récupérer produits
- Lambda handlers pour business logic
- Logs CloudWatch

---

### Semaine 4 : Version 3.0 - Persistance Données

```
┌──────────────────┐
│   API Gateway    │
└────────┬─────────┘
         │
┌────────▼─────────┐     ┌─────────────────┐
│  Lambda Functions│────→│   DynamoDB      │
│  - CRUD Products │     │  - Products     │
│  - CRUD Orders   │     │  - Orders       │
└──────────────────┘     │  - Users        │
                         └─────────────────┘
```

**Nouvelles fonctionnalités** :
- Base de données DynamoDB
- CRUD complet sur produits
- Gestion des commandes

---

### Semaine 5 : Version 4.0 - Traitement Asynchrone

```
┌──────────────────┐
│  Lambda (API)    │
└────────┬─────────┘
         │
         │ Publish    ┌─────────────────┐
         └───────────→│   SNS Topic     │
                      │  (Order Events) │
                      └────────┬────────┘
                               │
                ┌──────────────┼──────────────┐
                │              │              │
         ┌──────▼─────┐ ┌─────▼──────┐ ┌────▼─────┐
         │    SQS     │ │   Lambda   │ │  Email   │
         │ (Payments) │ │ (Analytics)│ │  Notif   │
         └────────────┘ └────────────┘ └──────────┘
```

**Nouvelles fonctionnalités** :
- Queue SQS pour traitement paiements
- SNS pour notifications (email clients)
- EventBridge pour analytics
- Architecture event-driven

---

### Semaines 6-9 : Version 5.0 - CI/CD Complet

```
┌─────────────────────────────────────────────────┐
│              CodePipeline                       │
│                                                 │
│  ┌──────────┐  ┌───────────┐  ┌─────────────┐ │
│  │CodeCommit│→ │ CodeBuild │→ │ CodeDeploy  │ │
│  │ (Source) │  │  (Build)  │  │  (Deploy)   │ │
│  └──────────┘  └───────────┘  └─────────────┘ │
└─────────────────────────────────────────────────┘
                      ↓
         ┌────────────────────────┐
         │  CloudFormation Stack  │
         │  - API Gateway         │
         │  - Lambda Functions    │
         │  - DynamoDB Tables     │
         │  - S3 Buckets          │
         │  - CloudWatch Alarms   │
         └────────────────────────┘
```

**Nouvelles fonctionnalités** :
- Infrastructure as Code (CloudFormation/SAM)
- Pipeline CI/CD automatique
- Tests automatisés
- Déploiement multi-environnements (dev, staging, prod)
- Rollback automatique en cas d'échec
- Monitoring et alerting

---

### Semaines 11-18 : Version 6.0 - Production-Ready

```
                    ┌────────────────┐
                    │   Route 53     │
                    │   (DNS)        │
                    └───────┬────────┘
                            │
                    ┌───────▼────────┐
                    │  CloudFront    │
                    │  (CDN Global)  │
                    └───────┬────────┘
                            │
          ┌─────────────────┴─────────────────┐
          │                                   │
  ┌───────▼──────┐                   ┌────────▼────────┐
  │  S3 Frontend │                   │   API Gateway   │
  │  Multi-région│                   │   (Regional)    │
  └──────────────┘                   └────────┬────────┘
                                              │
                              ┌───────────────┼────────────────┐
                              │               │                │
                      ┌───────▼──────┐  ┌─────▼─────┐  ┌──────▼──────┐
                      │     VPC      │  │  Lambda   │  │ Step Functions│
                      │              │  └───────────┘  └─────────────┘
                      │  ┌────────┐  │        │
                      │  │  ALB   │  │        │
                      │  └───┬────┘  │        │
                      │      │       │        │
                      │  ┌───▼────┐  │  ┌─────▼─────────┐
                      │  │ EC2/ECS│  │  │   DynamoDB    │
                      │  │Auto-   │  │  │  Global Tables│
                      │  │Scaling │  │  └───────────────┘
                      │  └────────┘  │
                      │      │       │
                      │  ┌───▼────┐  │
                      │  │   RDS  │  │
                      │  │ Aurora │  │
                      │  │Multi-AZ│  │
                      │  └────────┘  │
                      └──────────────┘
                              │
                      ┌───────▼────────┐
                      │   CloudWatch   │
                      │   X-Ray        │
                      │   Monitoring   │
                      └────────────────┘
```

**Nouvelles fonctionnalités** :
- VPC avec subnets publics/privés
- Application Load Balancer
- Auto Scaling Groups
- RDS Aurora Multi-AZ
- DynamoDB Global Tables (multi-région)
- CloudFront avec WAF
- Route 53 failover routing
- ElastiCache pour caching
- Secrets Manager pour credentials
- KMS pour encryption
- Backup automatisé
- Disaster Recovery plan

---

## 📂 Structure du Projet

```
cloudmarket/
├── frontend/                    # React/Vue.js application
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── api/                # API client
│   │   └── App.js
│   ├── public/
│   └── package.json
│
├── backend/                     # Serverless backend
│   ├── functions/
│   │   ├── products/
│   │   │   ├── list.py
│   │   │   ├── get.py
│   │   │   ├── create.py
│   │   │   └── update.py
│   │   ├── orders/
│   │   │   ├── create.py
│   │   │   ├── process.py
│   │   │   └── notify.py
│   │   └── users/
│   │       ├── register.py
│   │       └── login.py
│   ├── layers/                 # Lambda layers
│   │   └── common/
│   └── tests/                  # Unit tests
│
├── infrastructure/              # Infrastructure as Code
│   ├── cloudformation/
│   │   ├── network.yaml        # VPC, subnets
│   │   ├── database.yaml       # DynamoDB, RDS
│   │   ├── compute.yaml        # Lambda, EC2
│   │   ├── api.yaml            # API Gateway
│   │   └── master.yaml         # Main stack
│   ├── terraform/              # Alternative avec Terraform
│   └── sam/                    # SAM templates
│       └── template.yaml
│
├── cicd/                        # CI/CD configuration
│   ├── buildspec.yml           # CodeBuild
│   ├── appspec.yml             # CodeDeploy
│   └── pipeline.yaml           # CodePipeline CloudFormation
│
├── scripts/                     # Utilitaires
│   ├── deploy.sh
│   ├── cleanup.sh
│   ├── seed-data.sh            # Peupler la DB
│   └── test-api.sh
│
└── docs/                        # Documentation
    ├── architecture.md
    ├── api-spec.yaml           # OpenAPI specification
    └── runbook.md              # Opérations
```

---

## 🚀 Guide de Développement

### Semaine 2 : Frontend Statique

#### Étape 1 : Créer le frontend

```bash
# Créer app React
npx create-react-app cloudmarket-frontend
cd cloudmarket-frontend

# Structure de base
src/
├── components/
│   ├── Header.js
│   ├── ProductCard.js
│   └── ProductList.js
├── pages/
│   ├── Home.js
│   └── ProductDetail.js
└── App.js
```

#### Étape 2 : Build et déployer sur S3

```bash
# Build production
npm run build

# Créer bucket S3
BUCKET_NAME="cloudmarket-frontend-$(date +%s)"
aws s3 mb s3://$BUCKET_NAME

# Configurer website hosting
aws s3 website s3://$BUCKET_NAME \
  --index-document index.html \
  --error-document error.html

# Uploader le build
aws s3 sync build/ s3://$BUCKET_NAME --acl public-read

# Créer distribution CloudFront
aws cloudfront create-distribution \
  --origin-domain-name $BUCKET_NAME.s3.amazonaws.com \
  --default-root-object index.html
```

**✅ Validation** : Site accessible via URL CloudFront

---

### Semaine 3 : Backend API

#### Fonction Lambda - List Products

```python
# backend/functions/products/list.py
import json
import boto3
from decimal import Decimal

# Mock data (sera remplacé par DynamoDB semaine 4)
PRODUCTS = [
    {
        'id': '1',
        'name': 'AWS Certified Developer Course',
        'price': 49.99,
        'category': 'Education',
        'image': 'https://via.placeholder.com/300'
    },
    {
        'id': '2',
        'name': 'Cloud Architecture Book',
        'price': 29.99,
        'category': 'Books',
        'image': 'https://via.placeholder.com/300'
    }
]

def lambda_handler(event, context):
    """
    GET /products
    Returns list of all products
    """

    # Query params (pour filtrage futur)
    query_params = event.get('queryStringParameters', {}) or {}
    category = query_params.get('category')

    # Filtrer par catégorie si spécifié
    products = PRODUCTS
    if category:
        products = [p for p in products if p['category'] == category]

    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps({
            'products': products,
            'count': len(products)
        })
    }
```

#### Déployer avec SAM

```yaml
# infrastructure/sam/template.yaml
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31

Description: CloudMarket Backend API

Globals:
  Function:
    Timeout: 30
    Runtime: python3.11
    Environment:
      Variables:
        STAGE: dev

Resources:
  CloudMarketAPI:
    Type: AWS::Serverless::Api
    Properties:
      StageName: dev
      Cors:
        AllowOrigin: "'*'"
        AllowHeaders: "'Content-Type,Authorization'"
        AllowMethods: "'GET,POST,PUT,DELETE,OPTIONS'"

  ListProductsFunction:
    Type: AWS::Serverless::Function
    Properties:
      CodeUri: ../../backend/functions/products/
      Handler: list.lambda_handler
      Events:
        ListProducts:
          Type: Api
          Properties:
            RestApiId: !Ref CloudMarketAPI
            Path: /products
            Method: GET

  GetProductFunction:
    Type: AWS::Serverless::Function
    Properties:
      CodeUri: ../../backend/functions/products/
      Handler: get.lambda_handler
      Events:
        GetProduct:
          Type: Api
          Properties:
            RestApiId: !Ref CloudMarketAPI
            Path: /products/{id}
            Method: GET

Outputs:
  ApiUrl:
    Description: API Gateway endpoint URL
    Value: !Sub https://${CloudMarketAPI}.execute-api.${AWS::Region}.amazonaws.com/dev
```

```bash
# Déployer
cd infrastructure/sam
sam build
sam deploy --guided
```

**✅ Validation** : `curl https://api-url/dev/products` retourne la liste

---

### Semaine 4 : DynamoDB Integration

#### Table DynamoDB

```yaml
# Ajouter au template.yaml
ProductsTable:
  Type: AWS::DynamoDB::Table
  Properties:
    TableName: cloudmarket-products
    AttributeDefinitions:
      - AttributeName: id
        AttributeType: S
      - AttributeName: category
        AttributeType: S
    KeySchema:
      - AttributeName: id
        KeyType: HASH
    GlobalSecondaryIndexes:
      - IndexName: category-index
        KeySchema:
          - AttributeName: category
            KeyType: HASH
        Projection:
          ProjectionType: ALL
    BillingMode: PAY_PER_REQUEST
```

#### Lambda avec DynamoDB

```python
# backend/functions/products/list.py (v2 avec DynamoDB)
import json
import boto3
from boto3.dynamodb.conditions import Key
from decimal import Decimal

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('cloudmarket-products')

class DecimalEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Decimal):
            return float(obj)
        return super(DecimalEncoder, self).default(obj)

def lambda_handler(event, context):
    query_params = event.get('queryStringParameters', {}) or {}
    category = query_params.get('category')

    try:
        if category:
            # Query by GSI
            response = table.query(
                IndexName='category-index',
                KeyConditionExpression=Key('category').eq(category)
            )
        else:
            # Scan all
            response = table.scan()

        products = response['Items']

        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({
                'products': products,
                'count': len(products)
            }, cls=DecimalEncoder)
        }

    except Exception as e:
        print(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps({'error': 'Internal server error'})
        }
```

#### Script de peuplement

```python
# scripts/seed-data.py
import boto3
from decimal import Decimal

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('cloudmarket-products')

products = [
    {
        'id': '1',
        'name': 'AWS Certified Developer Course',
        'price': Decimal('49.99'),
        'category': 'Education',
        'description': 'Complete course for AWS Developer certification',
        'stock': 100
    },
    {
        'id': '2',
        'name': 'Cloud Architecture Book',
        'price': Decimal('29.99'),
        'category': 'Books',
        'description': 'Best practices for cloud architecture',
        'stock': 50
    },
    # ... 20+ more products
]

# Insert
for product in products:
    table.put_item(Item=product)
    print(f"Added: {product['name']}")

print("Seeding complete!")
```

**✅ Validation** : API retourne les produits depuis DynamoDB

---

### Semaines 6-9 : Pipeline CI/CD

#### buildspec.yml

```yaml
version: 0.2

phases:
  install:
    runtime-versions:
      python: 3.11
      nodejs: 18
    commands:
      - pip install aws-sam-cli
      - npm install -g npm@latest

  pre_build:
    commands:
      - echo "Running tests..."
      - cd backend && python -m pytest tests/
      - cd ../frontend && npm install && npm test

  build:
    commands:
      - echo "Building backend..."
      - cd ../infrastructure/sam
      - sam build

      - echo "Building frontend..."
      - cd ../../frontend
      - npm run build

  post_build:
    commands:
      - echo "Packaging SAM application..."
      - cd ../infrastructure/sam
      - sam package --s3-bucket deployment-artifacts-bucket --output-template-file packaged.yaml

artifacts:
  files:
    - infrastructure/sam/packaged.yaml
    - frontend/build/**/*
```

#### Pipeline CloudFormation

```yaml
# cicd/pipeline.yaml
Resources:
  CodePipeline:
    Type: AWS::CodePipeline::Pipeline
    Properties:
      RoleArn: !GetAtt CodePipelineRole.Arn
      Stages:
        - Name: Source
          Actions:
            - Name: SourceAction
              ActionTypeId:
                Category: Source
                Owner: AWS
                Provider: CodeCommit
                Version: 1
              Configuration:
                RepositoryName: cloudmarket
                BranchName: main
              OutputArtifacts:
                - Name: SourceOutput

        - Name: Build
          Actions:
            - Name: BuildAction
              ActionTypeId:
                Category: Build
                Owner: AWS
                Provider: CodeBuild
                Version: 1
              Configuration:
                ProjectName: !Ref CodeBuildProject
              InputArtifacts:
                - Name: SourceOutput
              OutputArtifacts:
                - Name: BuildOutput

        - Name: Deploy
          Actions:
            - Name: DeployBackend
              ActionTypeId:
                Category: Deploy
                Owner: AWS
                Provider: CloudFormation
                Version: 1
              Configuration:
                ActionMode: CREATE_UPDATE
                StackName: cloudmarket-backend
                TemplatePath: BuildOutput::infrastructure/sam/packaged.yaml
                Capabilities: CAPABILITY_IAM

            - Name: DeployFrontend
              ActionTypeId:
                Category: Deploy
                Owner: AWS
                Provider: S3
                Version: 1
              Configuration:
                BucketName: !Ref FrontendBucket
                Extract: true
              InputArtifacts:
                - Name: BuildOutput
```

**✅ Validation** : Commit → Build → Deploy automatique

---

## 📊 Métriques de Succès

### Performance
- **Frontend** : Lighthouse score > 90
- **API Latency** : p99 < 500ms
- **Availability** : 99.9% uptime

### Coûts
- **Semaines 1-10** : < 5$/mois (Free Tier)
- **Semaines 11-18** : < 15$/mois (avec VPC, ALB, RDS)
- **Production** : Optimisé pour < 50$/mois (petit trafic)

### Qualité Code
- **Test Coverage** : > 80%
- **No Critical Security Issues** : AWS Security Hub
- **Infrastructure** : 100% IaC (pas de clickops)

---

## 🎓 Compétences Acquises

En complétant ce projet, vous maîtriserez :

✅ **Frontend** : React/Vue.js, S3 static hosting, CloudFront
✅ **Backend** : Lambda, API Gateway, serverless patterns
✅ **Database** : DynamoDB (NoSQL), RDS Aurora (SQL)
✅ **Messaging** : SQS, SNS, EventBridge
✅ **CI/CD** : CodePipeline, CodeBuild, CodeDeploy
✅ **IaC** : CloudFormation, SAM
✅ **Networking** : VPC, subnets, ALB, Route 53
✅ **Security** : IAM, KMS, Secrets Manager, WAF
✅ **Monitoring** : CloudWatch, X-Ray, CloudTrail
✅ **Best Practices** : Well-Architected Framework

---

## 📚 Code Complet

Voir les sous-dossiers :
- `/projet-fil-rouge/semaine-02/` : Frontend statique
- `/projet-fil-rouge/semaine-03/` : Backend serverless
- `/projet-fil-rouge/semaine-04/` : DynamoDB integration
- `/projet-fil-rouge/semaines-06-09/` : CI/CD complet
- `/projet-fil-rouge/semaines-11-18/` : Production architecture

---

**Bon courage !** 🚀

Ce projet vous donnera une expérience concrète et complète du DevOps sur AWS, parfaite pour les certifications et pour votre portfolio professionnel.
