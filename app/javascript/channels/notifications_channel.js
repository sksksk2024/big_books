import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', () => {
  const userElement = document.getElementById('current-user-id');
  if (userElement) {
    const currentUserId = userElement.dataset.userId;

    consumer.subscriptions.create({ channel: "NotificationsChannel", user_id: currentUserId }, {
      connected() {
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log(data);
      }
    });
  }
});