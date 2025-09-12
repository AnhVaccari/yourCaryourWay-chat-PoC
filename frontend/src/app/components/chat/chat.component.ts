import { Component, OnDestroy, OnInit } from '@angular/core';
import { WebsocketService } from 'src/app/services/websocket.service';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.css'],
})
export class ChatComponent implements OnInit, OnDestroy {
  messages: any[] = [];
  messageContent = '';
  currentUserId = 1; // Simuler utilisateur client
  currentUserRole = 'CLIENT';

  constructor(private websocketService: WebsocketService) {}

  ngOnInit() {
    this.websocketService.connect();
    this.websocketService.messages$.subscribe((messages) => {
      this.messages = messages;
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

  switchUser() {
    this.currentUserId = this.currentUserId === 1 ? 2 : 1;
    this.currentUserRole = this.currentUserId === 1 ? 'CLIENT' : 'CONSEILLER';
  }

  isCurrentUser(userId: number): boolean {
    return userId === this.currentUserId;
  }

  getUserRole(userId: number): string {
    return userId === 1 ? 'CLIENT' : 'CONSEILLER';
  }
}
