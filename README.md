HEAD
# waste_classifier_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# ai-waste-classifier-app
 AI-powered image classification system for waste detection.
ef8313014972d4ebd8766f8ebb39b5cd342cc551

# 🧠 AI Waste Classifier App

An AI-powered waste classification system that identifies types of waste from images using deep learning. This project aims to improve waste segregation at the source by assisting users in identifying the correct category (e.g., Cardboard, Glass, Metal, Paper, Plastic, Trash) of waste.

---

## 🧪 Tech Stack

| Layer        | Technology Used         |
|--------------|--------------------------|
| Frontend     | Flutter (for Mobile UI)  |
| Backend API  | Python Flask             |
| ML Model     | TensorFlow / Keras       |
| Web UI       | HTML, CSS, JS            |
| Others       | GitHub, Colab (Training), Android Emulator |

---

## ▶️ How to Run

### 🔧 Backend (Flask API)

1. **Navigate to backend folder**:
    cd backend-flask
2. **Install requirements**:
    pip install -r requirements.txt
3. **Run the Flask server**:
    python app.py
    Make sure it runs on http://127.0.0.1:5000/.


## 📱 Mobile App (Flutter)

1. Open the Flutter project in VS Code / Android Studio.
2. Connect emulator or real device.
3. Run:
    flutter pub get
    flutter run
Make sure the Flask server is running before testing prediction.

## 📂 Folder Structure

ai-waste-classifier-app/
│
├── backend-flask/
│   ├── model/
│   ├── app.py
│   └── ...
│
├── flutter-app/
│   ├── lib/
│   ├── assets/
│   └── ...
│
├── web-app/
│   ├── static/
│   ├── templates/
│   └── app.py
│
├── images/
│   ├── flutter_demo.png
│   └── web_dashboard.png
│
├── README.md
└── requirements.txt

## 🙋‍♂️ Team

1. Achit Salvi
2. Rajat Baviskar
3. Saish Yadav
4. Prem Patil
