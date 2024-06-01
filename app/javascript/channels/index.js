// app/javascript/channels/index.js
import { createConsumer } from "@rails/actioncable";

const consumer = createConsumer();

// Include all channels
const channels = require.context('.', true, /_channel\.js$/);
channels.keys().forEach(channels);

export default consumer;