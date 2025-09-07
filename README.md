# QuickyCart 📦

QuickyCart is a **Smart Shipment Tracker iOS app** built in Swift. It integrates with the **Ship24 API** to fetch real-time shipment tracking information for multiple packages.  

**Note:** This project hides all API keys and secret files (`Service.plist`, `Info.plist`, `GoogleService-Info.plist`) for security.  

---

## Features 🚀
- Add multiple shipments to track
- Real-time tracking updates from Ship24 API
- Clean, Apple-friendly UI
- Local notifications for shipment status changes

---

## Project Structure 🗂️
QuickyCart/
├─ QuickyCart.xcodeproj
├─ QuickyCart/
│  ├─ AppDelegate.swift
│  ├─ ViewControllers/
│  ├─ Models/
│  ├─ Service.plist         # Hidden, contains API keys
│  ├─ Info.plist            # Hidden
│  ├─ GoogleService-Info.plist # Hidden
│  └─ … other Swift files
├─ .gitignore
└─ README.md
> **Secrets & sensitive files are excluded via `.gitignore`.**

---

## Getting Started ⚡

### 1. Clone the repository
```bash
git clone https://github.com/Mannagurung121/QuickyCart.git
cd QuickyCart

Open project in Xcode
	•	Open QuickyCart.xcodeproj in Xcode
	•	Make sure your iOS deployment target matches your device/simulator

3. Add your own API keys

Since secret files are hidden, you need to add:
	1.	Service.plist (your Ship24 API key)
	2.	Info.plist (app info)
	3.	GoogleService-Info.plist (Firebase / Google related info)

Place them in the QuickyCart folder.

⸻

4. Build & Run
	•	Select a simulator or your real device
	•	Press Run in Xcode (Cmd + R)
	•	The app will fetch shipments and display real-time tracking info

⸻

Notes 📝
	•	Ensure your device or simulator is connected to the internet
	•	The app currently only works with the Ship24 API
	•	Hidden files should never be pushed to GitHub

⸻

Contact

Manan Gurung
GitHub: Mannagurung121
