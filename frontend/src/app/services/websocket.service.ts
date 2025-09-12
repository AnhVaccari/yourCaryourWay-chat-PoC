import { Injectable } from '@angular/core';
import { Client } from '@stomp/stompjs';
import { BehaviorSubject } from 'rxjs';
import * as SockJS from 'sockjs-client';

@Injectable({
  providedIn: 'root',
})
export class WebsocketService {
  private stompClient: Client | null = null;
  private messagesSubject = new BehaviorSubject<any[]>([]);
  public messages$ = this.messagesSubject.asObservable();

  constructor() {}

  connect() {
    const socket = new SockJS('http://localhost:8080/chat'); // Se connecter au backend
    this.stompClient = new Client({
      // Configure le client
      webSocketFactory: () => socket,
      debug: (str) => console.log(str),
    });

    this.stompClient.onConnect = () => {
      console.log('Connected to WebSocket');
      this.stompClient?.subscribe('/topic/messages', (message) => {
        // Quand un message arrive au serveur, on l'ajoute à la liste
        const receivedMessage = JSON.parse(message.body);
        const currentMessages = this.messagesSubject.value;
        this.messagesSubject.next([...currentMessages, receivedMessage]);
      });
    };

    this.stompClient.activate();
  }

  sendMessage(userId: number, content: string) {
    //Envoie vers /app/sendMessage di backend
    if (this.stompClient?.connected) {
      this.stompClient.publish({
        destination: '/app/sendMessage',
        body: JSON.stringify({ userId, content }),
      });
    }
  }

  disconnect() {
    this.stompClient?.deactivate();
  }
}
