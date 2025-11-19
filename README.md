# PoC – Chat en ligne avec Websocket (Spring boot + Angular)

# PoC – Chat en ligne (Client <-> Conseiller)

Ce projet est une preuve de concept permettant de valider la faisabilité d’une fonctionnalité de chat en ligne entre un client et un conseiller.

## 🎯 Objectif du PoC

- Vérifier qu’un échange en temps réel entre deux utilisateurs est fonctionnel.
- Montrer qu’un conseiller peut recevoir des messages instantanément.
- Établir les bases d’un futur chat plus complet.

## 🛠️ Stack technique
Backend (Java/Spring Boot)
- Spring WebSocket (STOMP)
- Base de données embarquée H2

Frontend (Angular)
- Client WebSocket via SockJS + StompJS
- Interface minimale (champ + liste des messages)

## 🚀 Démarrage

### Backend (Java)
1. Aller dans le dossier backend
2. Lancer `mvn spring-boot:run`
3. API + Websocket disponible sur : http://localhost:8080

### Frontend (Angular)
1. Aller dans le dossier frontend
2. Lancer `ng serve`
3. Aplication servie sur : http://localhost:4200

## 🔌 Fonctionnement du chat
- Angular se connecte à l’endpoint WebSocket : `/chat`
- L’envoi se fait vers : `/app/sendMessage` 
- Le serveur sauvegarde en H2 puis broadcast via : `/topic/messages`
- Le front met automatiquement à jour l’affichage

## 👥 Gestion des utilisateurs
- Le PoC initialise deux utilisateurs en base :
    - un client
    - un conseiller
- Plusieurs utilisateurs peuvent théoriquement se connecter, car WebSocket gère plusieurs sessions.
- Mais il n’existe qu’un seul salon global : tout le monde reçoit les mêmes messages.

## 📦 Limites du PoC
Ce PoC reste volontairement simple :
- Pas de gestion de plusieurs conversations
- Pas de files d’attente client
- Interface minimale

Le but est uniquement de prouver que le chat temps réel fonctionne avec le stack choisi.
