const admin = require("firebase-admin");
const functions = require("firebase-functions");
const twilio = require("twilio");

// User IDs to be deleted
const UIDs = [];

// initialize the app
admin.initializeApp();

exports.deleteUser = functions.https.onRequest(async (req, res) => {
  // get the user ID from the request
  const uid = req.body.uid;

  await admin
    .auth()
    .deleteUser(uid)
    .catch(function (error) {
      console.log("Error deleting user", uid, error);
    });

  await admin.firestore().collection("users").doc(uid).delete();

  res.send("User deleted");
});

//Cron job every 24 hours

exports.sendNotificationOnDelay = functions.pubsub
  .schedule("every 24 hours")
  .onRun(async (context) => {
    //Get cargo which are not delivered
    const undelivered = await admin
      .firestore()
      .collection("cargos")
      .where("delivered", "==", null)

      .get();
    const smsData = await admin
      .firestore()
      .collection("sms")
      .doc("config")
      .get();
    const accountSid = smsData.data().accountSid;
    const authToken = smsData.data().authToken;
    const twilioNumber = smsData.data().twilioNumber;
    const client = new twilio(accountSid, authToken);

    for (cargoData of undelivered.docs) {
      const deliveryDate = new Date(cargoData.data().deliveryDate.toDate());
      const today = new Date();
      const diffTime = Math.abs(deliveryDate - today);
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

      if (diffDays < 1) {
        await client.messages.create({
          body: `Dear ${
            cargoData.data().name
          }, we are sorry that your cargo of Tracking No ${
            cargoData.data().id
          } has been delayed as per the set delivery date. There is nothing to worry about. We will keep in touch for more information. Thank you for choosing Fastgate Cargo Services.`,
          to:
            "+" +
            cargoData
              .data()
              .phoneNumber.toString()
              .replace("+", "")
              .replace(" ", ""),
          from: twilioNumber,
        });
      }
    }
  });
