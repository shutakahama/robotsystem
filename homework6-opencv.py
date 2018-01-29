import numpy as np
import cv2

cascade_path = "haarcascade_frontalface_alt2.xml"
cascade = cv2.CascadeClassifier(cascade_path)

cap = cv2.VideoCapture(0)

while(True):
    ret, frame = cap.read()

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    facerect = cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=1, minSize=(100, 100))

    for (x, y, w, h) in facerect:
            color = (0, 0, 225)
            pen_w = 3
            cv2.rectangle(gray, (x, y), (x+w, y+h), color, thickness = pen_w)
    
    cv2.imshow('frame',gray)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()

