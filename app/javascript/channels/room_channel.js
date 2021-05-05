import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const room_element = document.getElementById('room-id')
  const room_id = Number(room_element.getAttribute('data-room-id'))
  
  // consumer.subscriptions.subscriptions.forEach((subscription) => {
  //   consumer.subscriptions.remove(subscription)
  // })

  consumer.subscriptions.create({channel: "RoomChannel", room_id: room_id }, {
    connected() {
    	console.log('connected to ' + room_id)
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      if(data.image){
        // document.getElementById('video_container').style.display = 'block'
        $('#ima').attr( 'src', "/cam/"+ data.image + ".png")
      }else {
        console.log(data)
        const element = document.getElementById('user-id')
        const user_id = Number(element.getAttribute('data-user-id'))

        let html;
        if (user_id === data.message.user_id){
          html = data.sender
        } else {
          html = data.receiver
        }

        const messageContainer = document.getElementById('message')
        messageContainer.innerHTML = messageContainer.innerHTML + html
      }
    }
  });
})
