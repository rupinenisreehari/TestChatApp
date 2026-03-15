# TestChatApp
I have created 2 projects. One is xcode project. Another one is Test server. 

First we have to configure and run the test server.

1).
I have created test server using nodejs. 
Follow below link to install and configure NodeJS.
https://nodejs.org/en/download

Then install "express" and "socket.io" to run the test server.
npm install socket.io express

Then run "node server.js". Server will be running in port no 3000.

2).
Included 2 dependencies in iOS project.
1. Firebase (https://github.com/firebase/firebase-ios-sdk)
2. Socket IO (https://github.com/socketio/socket.io-client-swift)

if you are running the test server in the same machine, then you can run the xcode project without any changes.
Else, you have to change the server url in "TestChatApp/networking/SocketService.swift" file.

Then, register with any gmail account eg: "asdf@gmail.com" and "password"
After registration, use the same gmail id to login.
After login, you can enter another gmail id (which is registered in another device. eg: "asdf1@gmail.com") to start the chat.
