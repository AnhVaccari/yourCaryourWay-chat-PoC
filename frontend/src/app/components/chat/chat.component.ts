import { Component, OnDestroy, OnInit } from '@angular/core';
import { User, UserService } from 'src/app/services/user.service';
import { WebsocketService } from 'src/app/services/websocket.service';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.css'],
})
export class ChatComponent implements OnInit, OnDestroy {
  messages: any[] = [];
  messageContent = '';
  currentUserId = 2; // Fixé en tant que conseiller
  currentUserRole = 'CONSEILLER';
  users: User[] = [];

  // Mapping des noms
  userNames: { [key: number]: string } = {
    1: 'Jean Petit',
    2: 'Laura Dupont',
  };

  constructor(
    private websocketService: WebsocketService,
    private userService: UserService
  ) {}

  ngOnInit() {
    this.websocketService.connect();
    this.websocketService.messages$.subscribe((messages) => {
      this.messages = messages;
    });

    // Récupérer la liste des utilisateurs
    this.userService.getAllUsers().subscribe((users) => {
      this.users = users;
    });
  }

  ngOnDestroy() {
    this.websocketService.disconnect();
  }

  sendMessage() {
    if (this.messageContent.trim()) {
      this.websocketService.sendMessage(
        this.currentUserId,
        this.messageContent
      );
      this.messageContent = '';
    }
  }

  isCurrentUser(userId: number): boolean {
    return userId === this.currentUserId;
  }

  getUserRole(userId: number): string {
    return userId === 1 ? 'CLIENT' : 'CONSEILLER';
  }

  getUserName(userId: number): string {
    return this.userNames[userId] || `User ${userId}`;
  }

  // Méthode pour changer d'utilisateur actif
  switchToUser(userId: number) {
    this.currentUserId = userId;
    this.currentUserRole = userId === 1 ? 'CLIENT' : 'CONSEILLER';
  }
}
