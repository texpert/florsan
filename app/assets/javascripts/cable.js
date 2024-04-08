import { createConsumer } from '@rails/actioncable'

let consumer

const createChannel = (...args) => {
  if (!consumer) {
    consumer = createConsumer()
  }

  return consumer.subscriptions.create(...args)
}

export default createChannel
