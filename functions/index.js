const admin = require('firebase-admin');
const functions = require('firebase-functions');

// User IDs to be deleted
const UIDs = [];

// initialize the app
admin.initializeApp();




exports.deleteUser = functions.https.onRequest(async(req, res) => { 
    // get the user ID from the request
    const uid = req.body.uid;

   await admin.auth().deleteUser(uid)
    .catch(function(error) {
      console.log("Error deleting user", uid, error);
    });

    await admin.firestore().collection('users').doc(uid).delete();


    res.send("User deleted");
});


