# ⚡ Semaine 3 : Développement Serverless - Lambda & API Gateway

> **Objectif** : Maîtriser AWS Lambda et API Gateway pour créer des applications serverless hautement scalables sans gérer de serveurs.

---

## 🎯 Objectifs d'Apprentissage

À la fin de cette semaine, vous serez capable de :

- ✅ Créer et déployer des fonctions Lambda (Python/Node.js)
- ✅ Configurer des triggers (API Gateway, S3, DynamoDB Streams, CloudWatch Events)
- ✅ Gérer les layers et dépendances externes
- ✅ Créer des APIs REST et HTTP avec API Gateway
- ✅ Comprendre le modèle de tarification serverless
- ✅ Débugger et monitorer avec CloudWatch Logs
- ✅ Optimiser les performances (cold start, memory tuning)

---

## 📚 Partie Théorique

### 1. Qu'est-ce que le Serverless ?

#### Analogie du Restaurant

**Modèle Traditionnel (EC2)** :
- Vous possédez un restaurant complet
- Vous payez le loyer 24h/24, même quand c'est vide
- Vous gérez le personnel, l'entretien, la sécurité
- Scalabilité = Ouvrir de nouveaux restaurants

**Modèle Serverless (Lambda)** :
- Vous êtes un chef à domicile
- Vous êtes payé uniquement quand vous cuisinez
- Pas de loyer, pas de personnel fixe
- Scalabilité = Automatique (AWS envoie plus de chefs si besoin)

#### Avantages du Serverless

✅ **Pas de gestion de serveurs** : AWS s'occupe de tout (OS, scaling, patches)
✅ **Pay-per-use** : Vous payez uniquement pour le temps d'exécution (millisecondes)
✅ **Auto-scaling** : De 0 à des milliers de requêtes/seconde automatiquement
✅ **Haute disponibilité** : Multi-AZ par défaut

#### Inconvénients / Limites

❌ **Cold start** : Première invocation lente (100ms - 3s selon langage)
❌ **Timeout maximum** : 15 minutes par exécution
❌ **Stateless** : Pas de stockage persistant (utiliser S3, DynamoDB, EFS)
❌ **Vendor lock-in** : Code spécifique AWS

---

### 2. AWS Lambda en Détail

#### Anatomie d'une Fonction Lambda

```python
import json

def lambda_handler(event, context):
    """
    event: Données d'entrée (JSON) - varie selon le trigger
    context: Métadonnées (request ID, remaining time, etc.)
    """

    # Votre code métier
    name = event.get('name', 'World')

    # Retour (sera transformé en réponse HTTP par API Gateway)
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps({
            'message': f'Hello {name}!'
        })
    }
```

#### Cycle de Vie d'une Invocation

```
┌──────────────────────────────────────────────────────────┐
│ 1. COLD START (première invocation ou après inactivité) │
│    - Téléchargement du code                              │
│    - Démarrage du runtime (Python, Node.js, etc.)        │
│    - Exécution du code d'initialisation                  │
│    - ⏱️ Temps : 100ms - 3s                                │
└──────────────────────────────────────────────────────────┘
                           ↓
┌──────────────────────────────────────────────────────────┐
│ 2. WARM EXECUTION (invocations suivantes)               │
│    - Container déjà chaud                                │
│    - Exécution directe du handler                        │
│    - ⏱️ Temps : <10ms                                     │
└──────────────────────────────────────────────────────────┘
                           ↓
┌──────────────────────────────────────────────────────────┐
│ 3. IDLE TIMEOUT (~15 min sans invocation)               │
│    - Container détruit                                   │
│    - Prochaine invocation = Cold Start                   │
└──────────────────────────────────────────────────────────┘
```

#### Configuration Lambda

| Paramètre | Description | Min | Max | Recommandation |
|-----------|-------------|-----|-----|----------------|
| **Memory** | RAM allouée | 128 MB | 10 GB | ⬆️ Memory = ⬆️ CPU (start 256MB) |
| **Timeout** | Temps max d'exécution | 1 sec | 15 min | API: 30s, Batch: 15min |
| **Concurrency** | Invocations simultanées | - | 1000 (default) | Reserved concurrency pour apps critiques |
| **Ephemeral Storage** | /tmp storage | 512 MB | 10 GB | Pour fichiers temporaires |

#### Triggers Courants

1. **API Gateway** : Appels HTTP/HTTPS
2. **S3** : Upload/Delete d'objets
3. **DynamoDB Streams** : Changements dans une table
4. **EventBridge** : Cron jobs, événements custom
5. **SQS** : Messages dans une queue
6. **SNS** : Notifications
7. **Cognito** : Authentification (pre/post hooks)

---

### 3. API Gateway

#### Types d'APIs

| Type | Use Case | Prix | Features |
|------|----------|------|----------|
| **HTTP API** | APIs simples, modernes | Moins cher (60% vs REST) | Basique, performant |
| **REST API** | APIs complexes, legacy | Standard | Caching, WAF, Usage Plans |
| **WebSocket API** | Connexions bidirectionnelles | Par message | Chat, real-time |

#### Composants REST API

```
API Gateway
├── Resources (/users, /products)
│   ├── Methods (GET, POST, PUT, DELETE)
│   │   ├── Request (validation, transformation)
│   │   ├── Integration (Lambda, HTTP, AWS Service)
│   │   └── Response (transformation, headers)
│   └── Child Resources (/users/{id})
├── Stages (dev, staging, prod)
├── Authorizers (IAM, Cognito, Lambda)
└── Usage Plans & API Keys
```

#### Request/Response Flow

```
Client Request
     ↓
┌─────────────────┐
│  API Gateway    │
│  - Method Req   │ ← Validation (query params, headers)
│  - Mapping      │ ← Transform to Lambda event
└─────────────────┘
     ↓
┌─────────────────┐
│  Lambda         │
│  - Handler      │ ← Process request
│  - Return       │ ← Return response object
└─────────────────┘
     ↓
┌─────────────────┐
│  API Gateway    │
│  - Integration  │ ← Transform Lambda response
│  - Method Res   │ ← Add headers, status code
└─────────────────┘
     ↓
Client Response
```

---

## 🛠️ Partie Pratique

### Lab 1 : Première Fonction Lambda (30 min)

#### Étape 1 : Créer la fonction via Console

```bash
# Console AWS > Lambda > Create function

# Configuration :
# - Function name: HelloWorldFunction
# - Runtime: Python 3.11
# - Architecture: x86_64
# - Permissions: Create new role with basic Lambda permissions
```

#### Étape 2 : Code de la fonction

```python
import json
import datetime

def lambda_handler(event, context):
    """
    Simple Hello World avec informations contextuelles
    """

    # Extraire des infos de l'event
    name = event.get('name', 'Stranger')

    # Informations du context
    request_id = context.request_id
    remaining_time = context.get_remaining_time_in_millis()

    # Construire la réponse
    response = {
        'message': f'Hello {name}!',
        'timestamp': datetime.datetime.now().isoformat(),
        'request_id': request_id,
        'remaining_time_ms': remaining_time
    }

    print(f"Processed request for: {name}")  # Apparaîtra dans CloudWatch Logs

    return {
        'statusCode': 200,
        'body': json.dumps(response)
    }
```

#### Étape 3 : Tester la fonction

```json
// Test Event Configuration
{
  "name": "DevOps Engineer"
}

// Cliquer "Test" → Voir l'output
{
  "statusCode": 200,
  "body": "{\"message\": \"Hello DevOps Engineer!\", ...}"
}
```

#### Étape 4 : Voir les logs CloudWatch

```bash
# Console > CloudWatch > Log groups > /aws/lambda/HelloWorldFunction

# Ou via CLI
aws logs tail /aws/lambda/HelloWorldFunction --follow
```

**✅ Critère de validation** : Fonction exécutée avec succès, logs visibles dans CloudWatch

---

### Lab 2 : Lambda + API Gateway (60 min)

#### Objectif : Créer une API REST CRUD pour gérer des tâches (TODO app)

#### Architecture

```
Client (HTTP)
    ↓
API Gateway (/todos)
    ↓
┌─────────────────────────────────────┐
│  Lambda Function                    │
│  - GET /todos → List all            │
│  - POST /todos → Create             │
│  - GET /todos/{id} → Get one        │
│  - PUT /todos/{id} → Update         │
│  - DELETE /todos/{id} → Delete      │
└─────────────────────────────────────┘
    ↓
DynamoDB (pour la semaine prochaine, pour l'instant in-memory)
```

#### Étape 1 : Code Lambda CRUD

```python
import json
import uuid

# Stockage temporaire (sera remplacé par DynamoDB semaine 4)
todos = {}

def lambda_handler(event, context):
    """
    CRUD API pour TODOs
    """

    http_method = event['httpMethod']
    path = event['path']

    print(f"Request: {http_method} {path}")

    # Routing
    if http_method == 'GET' and path == '/todos':
        return list_todos()
    elif http_method == 'POST' and path == '/todos':
        return create_todo(event)
    elif http_method == 'GET' and '/todos/' in path:
        todo_id = path.split('/')[-1]
        return get_todo(todo_id)
    elif http_method == 'PUT' and '/todos/' in path:
        todo_id = path.split('/')[-1]
        return update_todo(todo_id, event)
    elif http_method == 'DELETE' and '/todos/' in path:
        todo_id = path.split('/')[-1]
        return delete_todo(todo_id)
    else:
        return response(404, {'error': 'Not Found'})


def list_todos():
    return response(200, list(todos.values()))


def create_todo(event):
    body = json.loads(event['body'])
    todo_id = str(uuid.uuid4())

    todo = {
        'id': todo_id,
        'title': body['title'],
        'completed': False
    }

    todos[todo_id] = todo
    return response(201, todo)


def get_todo(todo_id):
    if todo_id in todos:
        return response(200, todos[todo_id])
    return response(404, {'error': 'Todo not found'})


def update_todo(todo_id, event):
    if todo_id not in todos:
        return response(404, {'error': 'Todo not found'})

    body = json.loads(event['body'])
    todos[todo_id].update(body)
    return response(200, todos[todo_id])


def delete_todo(todo_id):
    if todo_id in todos:
        del todos[todo_id]
        return response(204, {})
    return response(404, {'error': 'Todo not found'})


def response(status_code, body):
    return {
        'statusCode': status_code,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps(body)
    }
```

#### Étape 2 : Créer l'API Gateway

```bash
# Méthode 1 : Via Console (recommandé pour apprendre)
# API Gateway > REST API > Build

# Configuration :
# - API name: TodoAPI
# - Endpoint Type: Regional

# Créer ressources :
# Actions > Create Resource
# - Resource Name: todos
# - Resource Path: /todos

# Créer méthode GET sur /todos :
# Actions > Create Method > GET
# - Integration type: Lambda Function
# - Lambda Function: TodoAPIFunction
# - Use Lambda Proxy integration: ✅ (IMPORTANT)

# Répéter pour POST, et créer /todos/{id} avec GET, PUT, DELETE
```

#### Étape 3 : Déployer l'API

```bash
# Console > Actions > Deploy API

# Deployment stage: [New Stage]
# Stage name: dev

# Copier l'Invoke URL : https://abc123.execute-api.us-east-1.amazonaws.com/dev
```

#### Étape 4 : Tester l'API

```bash
# Définir l'URL
API_URL="https://abc123.execute-api.us-east-1.amazonaws.com/dev"

# Créer un TODO
curl -X POST $API_URL/todos \
  -H "Content-Type: application/json" \
  -d '{"title": "Learn Lambda"}'

# Output:
# {"id": "123e4567-e89b-12d3-a456-426614174000", "title": "Learn Lambda", "completed": false}

# Lister tous les TODOs
curl $API_URL/todos

# Récupérer un TODO spécifique
TODO_ID="123e4567-e89b-12d3-a456-426614174000"
curl $API_URL/todos/$TODO_ID

# Mettre à jour
curl -X PUT $API_URL/todos/$TODO_ID \
  -H "Content-Type: application/json" \
  -d '{"completed": true}'

# Supprimer
curl -X DELETE $API_URL/todos/$TODO_ID
```

**✅ Critère de validation** : Toutes les opérations CRUD fonctionnent via curl

---

### Lab 3 : Lambda Layers (45 min)

#### Problème

Vous voulez utiliser `requests` (bibliothèque Python externe) dans Lambda, mais elle n'est pas incluse par défaut.

#### Solution : Lambda Layers

**Layer** = Package de dépendances réutilisable entre plusieurs fonctions

#### Étape 1 : Créer le layer localement

```bash
# Créer structure
mkdir -p lambda-layer/python/lib/python3.11/site-packages
cd lambda-layer

# Installer requests dans le layer
pip install requests -t python/lib/python3.11/site-packages/

# Zipper le layer
zip -r requests-layer.zip python/
```

#### Étape 2 : Uploader le layer

```bash
# Via CLI
aws lambda publish-layer-version \
  --layer-name requests-layer \
  --description "Requests library for Python 3.11" \
  --zip-file fileb://requests-layer.zip \
  --compatible-runtimes python3.11

# Output: Note le LayerVersionArn
# arn:aws:lambda:us-east-1:123456789012:layer:requests-layer:1
```

#### Étape 3 : Utiliser le layer dans une fonction

```python
# Fonction Lambda utilisant requests
import json
import requests  # ← Disponible grâce au layer

def lambda_handler(event, context):
    url = event.get('url', 'https://api.github.com')

    response = requests.get(url)

    return {
        'statusCode': 200,
        'body': json.dumps({
            'status_code': response.status_code,
            'data': response.json()
        })
    }
```

```bash
# Attacher le layer à la fonction
aws lambda update-function-configuration \
  --function-name MyFunctionWithRequests \
  --layers arn:aws:lambda:us-east-1:123456789012:layer:requests-layer:1
```

**✅ Critère de validation** : Fonction Lambda peut importer et utiliser `requests`

---

### Lab 4 : Trigger S3 (30 min)

#### Objectif

Créer une fonction Lambda qui se déclenche quand un fichier est uploadé sur S3 et crée une miniature (thumbnail) des images.

#### Étape 1 : Créer les buckets S3

```bash
# Bucket source (images originales)
aws s3 mb s3://my-images-source-$(date +%s)

# Bucket destination (thumbnails)
aws s3 mb s3://my-images-thumbnails-$(date +%s)
```

#### Étape 2 : Code Lambda (image processing)

```python
import boto3
import os
from PIL import Image
import io

s3 = boto3.client('s3')

def lambda_handler(event, context):
    """
    Triggered when image uploaded to S3
    Creates thumbnail and saves to destination bucket
    """

    # Extraire infos de l'event S3
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    print(f"Processing {key} from {bucket}")

    # Télécharger l'image
    response = s3.get_object(Bucket=bucket, Key=key)
    image_data = response['Body'].read()

    # Créer thumbnail avec Pillow
    image = Image.open(io.BytesIO(image_data))
    image.thumbnail((200, 200))

    # Sauvegarder en mémoire
    buffer = io.BytesIO()
    image.save(buffer, format=image.format)
    buffer.seek(0)

    # Uploader vers bucket destination
    destination_bucket = os.environ['DESTINATION_BUCKET']
    destination_key = f"thumbnails/{key}"

    s3.put_object(
        Bucket=destination_bucket,
        Key=destination_key,
        Body=buffer,
        ContentType=response['ContentType']
    )

    print(f"Thumbnail saved to {destination_bucket}/{destination_key}")

    return {
        'statusCode': 200,
        'body': f'Processed {key}'
    }
```

#### Étape 3 : Layer Pillow (traitement d'image)

```bash
# Créer layer avec Pillow
mkdir -p pillow-layer/python
pip install Pillow -t pillow-layer/python/
cd pillow-layer && zip -r ../pillow-layer.zip python/ && cd ..

# Publier layer
aws lambda publish-layer-version \
  --layer-name pillow-layer \
  --zip-file fileb://pillow-layer.zip \
  --compatible-runtimes python3.11
```

#### Étape 4 : Configurer le trigger S3

```bash
# Donner permission à S3 d'invoquer Lambda
aws lambda add-permission \
  --function-name ImageThumbnailFunction \
  --statement-id s3-trigger \
  --action lambda:InvokeFunction \
  --principal s3.amazonaws.com \
  --source-arn arn:aws:s3:::my-images-source-123456

# Configurer notification S3
aws s3api put-bucket-notification-configuration \
  --bucket my-images-source-123456 \
  --notification-configuration file://notification.json
```

`notification.json` :
```json
{
  "LambdaFunctionConfigurations": [
    {
      "LambdaFunctionArn": "arn:aws:lambda:us-east-1:123456789012:function:ImageThumbnailFunction",
      "Events": ["s3:ObjectCreated:*"],
      "Filter": {
        "Key": {
          "FilterRules": [
            {"Name": "suffix", "Value": ".jpg"},
            {"Name": "suffix", "Value": ".png"}
          ]
        }
      }
    }
  ]
}
```

#### Étape 5 : Tester

```bash
# Uploader une image
wget https://picsum.photos/800/600 -O test.jpg
aws s3 cp test.jpg s3://my-images-source-123456/

# Vérifier que le thumbnail a été créé
aws s3 ls s3://my-images-thumbnails-123456/thumbnails/
# Output: test.jpg (plus petit)
```

**✅ Critère de validation** : Upload image → Thumbnail créé automatiquement

---

## 🔄 Intégration DevOps

### Lambda dans CI/CD

#### Déploiement avec SAM (Serverless Application Model)

```yaml
# template.yaml
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31

Resources:
  TodoApiFunction:
    Type: AWS::Serverless::Function
    Properties:
      Handler: app.lambda_handler
      Runtime: python3.11
      CodeUri: src/
      MemorySize: 256
      Timeout: 30
      Environment:
        Variables:
          TABLE_NAME: !Ref TodosTable
      Events:
        ListTodos:
          Type: Api
          Properties:
            Path: /todos
            Method: GET
        CreateTodo:
          Type: Api
          Properties:
            Path: /todos
            Method: POST

  TodosTable:
    Type: AWS::DynamoDB::Table
    Properties:
      AttributeDefinitions:
        - AttributeName: id
          AttributeType: S
      KeySchema:
        - AttributeName: id
          KeyType: HASH
      BillingMode: PAY_PER_REQUEST
```

#### Déploiement

```bash
# Build
sam build

# Deploy
sam deploy --guided

# Outputs: API URL, Function ARN, etc.
```

#### Pipeline CodePipeline pour Lambda

```yaml
# buildspec.yml
version: 0.2

phases:
  install:
    runtime-versions:
      python: 3.11

  build:
    commands:
      - pip install -r requirements.txt -t .
      - aws cloudformation package --template-file template.yaml --s3-bucket deployment-bucket --output-template-file packaged.yaml

artifacts:
  files:
    - packaged.yaml
```

---

## 🎯 Ce qui est Testé à la Certification

### Developer Associate (Focus Lambda & API Gateway)

**Domaine 1: Development with AWS Services** (32%)

#### Questions Types

**Q1**: Comment une fonction Lambda peut-elle accéder à une base DynamoDB ?
- ❌ Mettre des Access Keys dans les variables d'environnement
- ✅ **Attacher un rôle IAM avec permissions DynamoDB à la fonction**
- ❌ Utiliser le compte root
- ❌ Créer un utilisateur IAM

**Q2**: Quelle est la limite de timeout maximum pour Lambda ?
- ❌ 5 minutes
- ❌ 10 minutes
- ✅ **15 minutes**
- ❌ 30 minutes

**Q3**: Comment réduire le cold start time ?
- ✅ **Augmenter la mémoire allouée**
- ✅ **Utiliser Provisioned Concurrency**
- ✅ **Réduire la taille du package de déploiement**
- ❌ Augmenter le timeout

**Q4**: API Gateway : Différence entre REST API et HTTP API ?
- ✅ **HTTP API est moins cher et plus performant, mais moins de features**
- REST API supporte caching, WAF, usage plans
- HTTP API recommandé pour nouveaux projets simples

**Q5**: Comment implémenter l'authentification sur API Gateway ?
- Cognito User Pools
- Lambda Authorizer (custom logic)
- IAM
- ❌ Hardcoded API keys dans le code

---

## 📖 Ressources Complémentaires

### Documentation Officielle ⭐

- [Lambda Developer Guide](https://docs.aws.amazon.com/lambda/latest/dg/)
- [Lambda Best Practices](https://docs.aws.amazon.com/lambda/latest/dg/best-practices.html)
- [API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/)
- [Serverless Application Model (SAM)](https://docs.aws.amazon.com/serverless-application-model/)

### Vidéos

- **AWS re:Invent - Lambda Deep Dive** (YouTube)
- **Stephane Maarek - Lambda & API Gateway** (Udemy, 4h)

### Outils

- **AWS SAM CLI** : Développement local de serverless apps
- **Serverless Framework** : Alternative à SAM (plus features)
- **LocalStack** : Émuler AWS localement (free tier)

---

## ⚠️ Pièges Courants

### 1. Cold Start non géré

```python
# ❌ MAUVAIS : Initialisation dans handler
def lambda_handler(event, context):
    db = boto3.resource('dynamodb')  # ← Créé à chaque invocation
    table = db.Table('MyTable')
    ...

# ✅ BON : Initialisation hors handler (réutilisée)
import boto3
db = boto3.resource('dynamodb')  # ← Créé 1 fois (warm container)
table = db.Table('MyTable')

def lambda_handler(event, context):
    # Utiliser table directement
    ...
```

### 2. Memory sous-dimensionnée

```bash
# ❌ 128 MB : Trop peu, exécution lente
# ✅ 512-1024 MB : Sweet spot pour la plupart des apps
# Memory ⬆️ = CPU ⬆️ = Exécution ⬇️ = Coût total ⬇️ (parfois)
```

### 3. Oublier CORS sur API Gateway

```python
# Toujours inclure ces headers pour APIs publiques
{
    'statusCode': 200,
    'headers': {
        'Access-Control-Allow-Origin': '*',  # ← CORS
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
    },
    'body': json.dumps(data)
}
```

### 4. Ne pas utiliser Lambda Proxy Integration

```bash
# API Gateway > Method > Integration Request
# ✅ Cocher "Use Lambda Proxy integration"

# Sinon vous devez configurer manuellement :
# - Request mapping templates
# - Response mapping templates
# - Method response
# (Complexe et error-prone)
```

---

## ✅ Checklist de Validation Semaine 3

### Théorie
- [ ] Comprendre le modèle serverless et ses avantages/inconvénients
- [ ] Différencier cold start vs warm execution
- [ ] Connaître les limites Lambda (timeout, memory, storage)
- [ ] Comprendre les différents triggers Lambda
- [ ] Différencier REST API vs HTTP API vs WebSocket API
- [ ] Comprendre Lambda Proxy Integration

### Pratique
- [ ] Créer une fonction Lambda Python/Node.js
- [ ] Tester avec différents events
- [ ] Voir les logs dans CloudWatch Logs
- [ ] Créer une API Gateway REST API
- [ ] Déployer l'API sur un stage (dev)
- [ ] Tester toutes les méthodes HTTP (GET, POST, PUT, DELETE)
- [ ] Créer et utiliser un Lambda Layer
- [ ] Configurer un trigger S3
- [ ] Tester image processing avec Pillow
- [ ] Configurer variables d'environnement
- [ ] Optimiser memory allocation (tester 128MB, 512MB, 1GB)

### DevOps
- [ ] Écrire un template SAM
- [ ] Déployer avec `sam deploy`
- [ ] Comprendre le déploiement via CloudFormation
- [ ] Intégrer Lambda dans un pipeline CodePipeline (conceptuellement)

### Examen
- [ ] Lire Lambda FAQ
- [ ] Lire API Gateway FAQ
- [ ] Faire 30 questions Lambda/API Gateway (Tutorialsdojo)
- [ ] Score > 80% sur questions Serverless

---

## 💰 Optimisation des Coûts

### Pricing Lambda

```
Coût = (Requests × $0.20 / 1M) + (Duration × Memory × $0.0000166667 / GB-second)

Exemple :
- 1M requests/mois
- 512 MB memory
- 200ms duration average

Requests: 1M × $0.20 / 1M = $0.20
Duration: 1M × 0.2s × 0.5GB × $0.0000166667 = $1.67

TOTAL = $1.87/mois

Free Tier:
- 1M requests/mois (permanent)
- 400,000 GB-seconds/mois (permanent)
```

### Tips Optimisation

1. **Right-size memory** : Tester 256MB, 512MB, 1GB et comparer coûts totaux
2. **Minimiser cold starts** : Provisioned Concurrency (payant) pour apps critiques
3. **Éviter polling** : Utiliser EventBridge/SQS triggers au lieu de cron dans Lambda
4. **Batch processing** : Traiter plusieurs items par invocation

---

## 🚀 Mini-Projet : API REST Complète

### Objectif Final

Créer une API de gestion de blog avec :
- Authentification (Cognito ou JWT custom)
- CRUD articles (Lambda + API Gateway)
- Upload d'images (S3 + trigger Lambda pour thumbnails)
- Recherche full-text (ElasticSearch ou DynamoDB)

Voir `/modules/semaine-03/projet-blog-api/` pour le code complet.

---

## 🎉 Prochaine Étape

**Semaine 4 : Bases de Données (DynamoDB + RDS)**

Vous allez connecter vos APIs Lambda à DynamoDB pour persister les données, et découvrir RDS pour les bases relationnelles.

---

**Temps estimé Semaine 3** : 15-20h
- Théorie : 4h
- Labs pratiques : 10-12h
- Mini-projet : 3-4h
- QCM et révisions : 2h

💪 **Félicitations !** Vous maîtrisez maintenant le serverless, une compétence très demandée !
