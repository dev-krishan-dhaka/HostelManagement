## 🏨 Hostel Management Platform

A cross-platform Hostel Management System built with Flutter (Dart), Firebase, and Cloudinary.
This system replaces the manual complaint process in hostels, where students previously had to visit the warden and record issues in writing.

With this platform, students can log complaints online and directly send them to the respective service providers (electrician, plumber, etc.), making the system faster, more secure, and transparent.

## 🚀 Features

👨‍🎓 Student Dashboard – Students log in and submit complaints online.

🛠️ Service Provider Dashboard – Complaints are assigned to the correct service provider (electrician, plumber, etc.).

🧑‍💼 Warden Dashboard – Wardens can monitor all complaints, verify work status, and maintain transparency.

🔐 Secure Login – Different roles (Student, Service Provider, Warden) with dedicated login credentials.

☁️ Cloud Storage – Complaints can include images (via Cloudinary) for better issue reporting.

📱 Cross-Platform – Works seamlessly on Android, iOS, and Web.

## 🖼️ Use Case Example

A student’s fan stops working.

The student logs in via the Student portal and submits a complaint with details + optional photo.

The complaint is automatically assigned to the Electrician.

The Service Provider fixes the issue and updates the status.

The Warden verifies and closes the complaint.

## 🛠️ Tech Stack

Frontend: Flutter (Dart)

Backend & Auth: Firebase (Firestore + Firebase Auth)

Storage: Firebase Cloud Storage + Cloudinary (for images)

Hosting: Firebase Hosting / App Store / Play Store

## ⚙️ Installation

Clone the repository:

git clone https://github.com/dev-krishan-dhaka/HostelManagement/
cd hostel-management


Install dependencies:

flutter pub get


Run the project:

flutter run

## 📌 Roadmap

 Push notifications for new complaint updates

 Analytics dashboard for wardens (pending vs solved issues)

 Student feedback system after complaint resolution

 Multi-language support

## 🤝 Contributing

Contributions are welcome!

Fork the repo

Create a new branch (git checkout -b feature-name)

Commit your changes (git commit -m "Add feature")

Push to your branch (git push origin feature-name)

Open a Pull Request

## 📜 License

This project is licensed under the MIT License.

## 👨‍💻 Author

Developed with ❤️ by Dev Krishan
