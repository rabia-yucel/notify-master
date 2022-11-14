
const { v4: uuid_v4 } = require('uuid');
const functions = require("firebase-functions");

// TODO functions folder should not be in app deployment ?

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// The Firebase Admin SDK to access Firestore.
const admin = require('firebase-admin');

admin.initializeApp();

// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /notification_messages/:documentId/original
exports.addMessage = functions.https.onRequest(async (req, res) => {

  const auth = {login: 'Zakir', password: 'Ahmedov!!?'} // TODO change this -- read from table

  // parse login and password from headers
  const b64auth = (req.headers.authorization || '').split(' ')[1] || ''
  const [login, password] = Buffer.from(b64auth, 'base64').toString().split(':')

  // Verify login and password are set and correct
  if (login && password && login === auth.login && password === auth.password) {

      // Access granted...
      // Grab the parameter
      const title = req.query.title;
      const body = req.query.body;
      const topic = req.query.topic;
      const phone_number = req.query.phone_number.replace(' ', '+'); // '+' is deleted somehow so add it again
      const avatar = req.query.avatar;
      const image = req.query.image;

      // Push the new message into Firestore using the Firebase Admin SDK.
      const writeResult = await admin.firestore().collection('notification_messages').add(
      { message_id: uuid_v4(), title: title, body: body, topic: topic, phone_number: phone_number, avatar: avatar,
        image: image, instance_time: admin.firestore.FieldValue.serverTimestamp() });

      // Send back a message that we've successfully written the message
      res.json({result: `Message with ID: ${writeResult.id} added.`});

  } else {

      // Access denied...
      res.set('WWW-Authenticate', 'Basic realm="401"') // change this
      res.status(401).send('Authentication required.') // custom message
  }

});

// Listens for new messages added to /messages/:documentId/original and creates an
// uppercase version of the message to /messages/:documentId/uppercase
exports.sendNotification = functions.firestore.document('/notification_messages/{documentId}')
    .onCreate(async (snap, context) => {
      // Grab the current value of what was written to Firestore.
    const message_id = snap.data().message_id;
    const title = snap.data().title;
    const body = snap.data().body;
    const topic = snap.data().topic;
    const phone_number = snap.data().phone_number;
    const avatar = snap.data().avatar;
    const image = snap.data().image;

    // Access the parameter `{documentId}` with `context.params`
    functions.logger.log('Sending notification', context.params.documentId, phone_number);

    const payLoad = {
        notification:{
            title: title,
            body: body,
            sound: "default"
        }
    };

    const options = {
        priority: "high",
        timeToLive: 60*60*2
    };


    if ((phone_number !== null) && (phone_number !== '')) {

          var instance_time = admin.firestore.FieldValue.serverTimestamp();

          const writeResult = await admin.firestore().collection('user_notifications').add(
          { message_id: message_id, phone_number: phone_number, is_deleted: false, is_read: false,
            instance_time: instance_time, update_time: instance_time, });

          var tokens;
          const snapshot = await admin.firestore()
              .collection("user_info")
              .where('phone_number', '==', phone_number)
              .get()
              .then((snapshot) => {
                 snapshot.docs.forEach( doc => {
                     tokens = doc.data().tokens;
                     admin.messaging().sendToDevice(tokens, payLoad, options);
                 })
              });

          return true;

    } else {

          var instance_time = admin.firestore.FieldValue.serverTimestamp();

          const snapshot = await admin.firestore()
              .collection("user_info")
              .get()
              .then((snapshot) => {
                 snapshot.docs.forEach( async doc => {

                     if (((topic == 'bank') && (doc.data().allow_bank_notifications == true)) ||
                          ((topic == 'merchant') && (doc.data().allow_merchant_notifications == true))) {

                        instance_time = admin.firestore.FieldValue.serverTimestamp();
                        const writeResult = await admin.firestore().collection('user_notifications').add(
                        { message_id: message_id, phone_number: doc.data().phone_number , is_deleted: false, is_read: false,
                          instance_time: instance_time, update_time: instance_time, });

                          tokens = doc.data().tokens;
                          admin.messaging().sendToDevice(tokens, payLoad, options);
                      }
                 })
              });

           return true;
    }



});
//test 