import cv2
import face_recognition
import os
import glob
import pickle
filename=""
uploadedPath=""







known_faces = []
known_names = []
known_faces_paths = []

registered_faces_path = 'registered/'
for name in os.listdir(registered_faces_path):
        images_mask = '%s%s/*.jpg' % (registered_faces_path, name)
        images_paths = glob.glob(images_mask)
        known_faces_paths += images_paths
        known_names += [name for x in images_paths]



def get_encodings(img_path):
        image = face_recognition.load_image_file(img_path)
        encoding = face_recognition.face_encodings(image)
        return encoding[0]

known_faces = [get_encodings(img_path) for img_path in known_faces_paths]

f = open("face_enc", "wb")
data = {"encodings": known_faces, "names": known_names}
f.write(pickle.dumps(data))
f.close()
data = pickle.loads(open('face_enc', "rb").read())

notfound=True
frame = cv2.imread(uploadedPath)

frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
faces = face_recognition.face_locations(frame_rgb)
for face in faces:  # top, right, bottom, left

        face_code = face_recognition.face_encodings(frame_rgb, [face])[0]

        results = face_recognition.compare_faces(data['encodings'], face_code, tolerance=0.6)
        if any(results):
            namee = data['names'][results.index(True)]
            notfound=False
            break

if notfound:
        namee='unknown'


print(namee)


#if __name__=='__main__':
    #app.run(debug=True,host='0.0.0.0')
'''

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
    #if (request.method == 'POST'):
        imagefile = request.files['image'] # getting the response data
        filename=werkzeug.utils.secure_filename(imagefile.filename)
        global uploadedPath
        uploadedPath="./uploaded/"+filename
        #print(uploadedPath)
        imagefile.save(uploadedPath)


        data = pickle.loads(open('face_enc', "rb").read())
        frame = cv2.imread(uploadedPath)

        frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        faces = face_recognition.face_locations(frame_rgb)
        for face in faces:  # top, right, bottom, left
    # top, right, bottom, left = face
    # cv2.rectangle(frame, (left, top), (right, bottom),(0,0,255), 2)
            face_code = face_recognition.face_encodings(frame_rgb, [face])[0]

            results = face_recognition.compare_faces(data['encodings'], face_code, tolerance=0.6)
            if any(results):
             namee = data['names'][results.index(True)]
             notfound = False
             break

        if notfound:
         namee = 'unknown'
    # cv2.putText(frame, name, (left, bottom + 20), cv2.FONT_HERSHEY_PLAIN, 2, (0,0,255), 2)
        print(namee)
        return jsonify({'nameid': namee})
        #imagepath = json.loads(request_data.decode('utf-8'))  # converting it from json to key value pair
       # name = request_data['name']  # assigning it to name
   # cv2.imread()
#vc = cv2.VideoCapture(0)




#cv2.destroyAllWindows()
#vc.release()







if __name__=='__main__':
    app.run(debug=True,host='0.0.0.0')

'''