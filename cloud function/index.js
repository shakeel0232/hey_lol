const functions = require('firebase-functions');
const admin = require('firebase-admin');
const express = require('express');
const cors = require('cors');
var serviceAccount = require("./permission.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://heylol-c9d36.firebaseio.com"
});
const db = admin.firestore();
var listdata = [];
let videoRef;

exports.getAllData = functions.https.onRequest(async (req, res) => {
  // getAll(db);
  // Int vide=req.query.no_of_videos;
  console.log(req.query.category==null);
  if(req.query.category==null){
    videoRef = db.collection('Videos').limit(parseInt(req.query.no_of_videos.toString()));
  }else{
    videoRef = db.collection('Videos').limit(parseInt(req.query.no_of_videos.toString())).where('category', '==', req.query.category.toString());
  }
  
  const snapshot = await videoRef.get();
  
      listdata=[];
      snapshot.forEach(doc => {
        listdata.push('asd'+ doc.data())
      })

  return res.status(200).send(listdata);
 });

