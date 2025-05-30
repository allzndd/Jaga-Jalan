import axios from 'axios';
window.axios = axios;

window.axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

/**
 * Echo exposes an expressive API for subscribing to channels and listening
 * for events that are broadcast by Laravel. Echo and event broadcasting
 * allows your team to easily build robust real-time web applications.
 */

import Echo from 'laravel-echo';

window.Pusher = require('pusher-js');

window.Echo = new Echo({
    broadcaster: 'pusher',
    key: 'd82783da6b2fe32e1dec',
    cluster: 'ap1',
    encrypted: true
});

// Listen for notification events for the current user
const userId = document.querySelector('meta[name="user-id"]')?.content;

if (userId) {
    window.Echo.private(`notifications.${userId}`)
        .listen('.notification.received', (data) => {
            // Handle the notification update
            console.log('New notification received:', data);
            
            // Trigger custom event that the notification component can listen for
            const event = new CustomEvent('notificationReceived', { detail: data });
            document.dispatchEvent(event);
        });
}
