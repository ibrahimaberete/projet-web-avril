Ce projet inclut une application web développée avec Angular et une application mobile en Flutter, toutes deux utilisant Firebase comme backend. Firebase fournit à la fois les services d'authentification des utilisateurs et le stockage des données relatives aux villes.

## Équipe de Développement

- Jérémy Weltmann
- Ibrahima Berete
- Rayan Mamache
- Brayan Kutlar

## Fonctionnalités

### Authentification avec Firebase
- **Inscription :** Créez un compte utilisateur pour accéder aux fonctionnalités avancées.
- **Connexion :** Connectez-vous avec votre compte pour gérer vos informations et vos préférences.

### Gestion des villes 
- **Ajouter une ville :** Permet aux utilisateurs d'ajouter de nouvelles villes à la base de données Firebase.
- **Supprimer une ville :** Permet de retirer des villes stockées dans Firebase.
- **Éditer une ville :** Modifiez les informations de villes existantes dans Firebase.
- **Voir la liste des villes :** Affiche toutes les villes stockées dans Firebase.
- **Voir les villes que j'ai ajoutées :** Montre les villes ajoutées par l'utilisateur connecté, stockées dans Firebase.
- **Télécharger l'image de la ville :** Téléchargez des images des villes depuis Firebase.

## Déploiement
L'application web a été déployée sur Vercel : [Application Web](https://projet-web-avril.vercel.app/).

## Gestion de Projet
Pour suivre l'avancement de notre projet, consultez notre [tableau de bord JIRA](https://projet-web-avril.atlassian.net/jira/software/projects/KAN/boards/1).

pour le docker 
Dans ce fichier Docker Compose, nous définissons deux services : web-firebase(pour l'angular) et flutter_firebase_app (pour le flutter) Chaque service est construit à partir de son propre Dockerfile et expose un port spécifique. L'application Angular est accessible sur le port 4200 et l'application Flutter sur le port 9000.

Pour démarrer les deux applications, vous pouvez exécuter la commande
```
docker-compose up 
```
 dans le terminal.
