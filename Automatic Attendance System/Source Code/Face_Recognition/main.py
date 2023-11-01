import pickle

import cv2
import face_recognition
import os
import glob

import werkzeug.utils
from flask import Flask,request,jsonify,json

app=Flask(__name__)
filename=""
uploadedPath=""
namee=""
@app.route("/postImage", methods=['POST'])
def post():
        notfound=True
        imagefile = request.files['image'] # getting the response data
        filename=werkzeug.utils.secure_filename(imagefile.filename)
        global uploadedPath
        uploadedPath="./uploaded/"+filename
        imagefile.save(uploadedPath)
        data = pickle.loads(open('face_enc', "rb").read())
        frame = cv2.imread(uploadedPath)

        frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        faces = face_recognition.face_locations(frame_rgb)
        for face in faces:  # top, right, bottom, left
            face_code = face_recognition.face_encodings(frame_rgb, [face])[0]
            results = face_recognition.compare_faces(data['encodings'], face_code, tolerance=0.6)
            if any(results):
             namee = data['names'][results.index(True)]
             notfound = False

             break

        if notfound==True:
         namee = 'unknown'
        print(namee);
        return jsonify({'nameid': namee})

if __name__=='__main__':
    app.run(debug=True,host='192.168.1.11',port=5000)
