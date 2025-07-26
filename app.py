# flutter_app.py
from flask import Flask, request, jsonify
from flask_cors import CORS
import tensorflow as tf
from tensorflow.keras.models import load_model
import numpy as np
from PIL import Image
import io

app = Flask(__name__)
CORS(app)  # This allows your Flutter app to connect (especially on Android emulator)

# Load your trained model
model = load_model("model/final_model.h5")

# Define class labels (update this to your actual model's classes)
class_labels = ['cardboard', 'glass', 'metal', 'paper', 'plastic', 'trash']

@app.route('/')
def index():
    return jsonify({'message': 'Waste classifier backend is running.'})

@app.route('/predict', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return jsonify({'prediction': 'No file part'}), 400

    file = request.files['file']

    if file.filename == '':
        return jsonify({'prediction': 'No selected file'}), 400

    try:
        image = Image.open(file.stream)
        image = image.convert("RGB")
        image = image.resize((224, 224))  # Adjust based on model input size
        image_array = np.array(image) / 255.0
        image_array = np.expand_dims(image_array, axis=0)

        prediction = model.predict(image_array)
        predicted_class = class_labels[np.argmax(prediction)]

        return jsonify({'prediction': predicted_class})

    except Exception as e:
        print("Error:", str(e))
        return jsonify({'prediction': 'Error: Prediction failed'}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
