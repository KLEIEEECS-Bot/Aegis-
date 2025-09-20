📊 Customer Review Analysis App

A full-stack app to analyze customer reviews, identify common problems, praise points, and generate actionable insights using Supabase as backend and React + Tailwind for frontend.

🚀 Tech Stack

Frontend: React, TailwindCSS

Backend: Supabase (Database + Auth + API)

✅ Prerequisites

Node.js v16+ and npm

Supabase account & project (with API keys)

⚙️ Steps to Run the Project Locally
🔹 Backend Setup (Supabase)

Create a new Supabase
 project.

Configure a Postgres database with tables for:

reviews (stores raw customer reviews)

analysis (stores insights, problems, praise points, categories)

users (optional: for authentication & roles)

Get your API URL and anon/public key from Supabase dashboard.

Add environment variables:

SUPABASE_URL=your-supabase-project-url
SUPABASE_KEY=your-anon-public-key


Supabase automatically serves RESTful APIs for your tables.

🔹 Frontend Setup (React + Tailwind)

Navigate to frontend folder:

cd main


Install dependencies:

npm install


Create .env file and add:

VITE_SUPABASE_URL=your-supabase-project-url
VITE_SUPABASE_KEY=your-anon-public-key


Run development server:

npm run dev


Frontend URL: http://localhost:3000

🏗️ Architecture
🔹 Frontend (React + Tailwind)

Input Form: Users paste or type reviews (or upload multiple).

Analysis View: On submit, calls Supabase API → fetches categorized insights.

Results Display: Shows categorized feedback → ✅ Positive, ❌ Negative, ⚠️ Problems.

Dashboard: Aggregated metrics like most common complaints, top praise points, and sentiment distribution.

🔹 Backend (Supabase)

Data Storage: Stores reviews and categorized analysis results.

APIs: Auto-generated RESTful APIs for reviews and analysis.

Auth (Optional): Secure endpoints with Supabase Auth (for enterprises/admins).

Metrics Endpoint: Track review counts, category distribution, and sentiment scores.

📌 Example Use Cases

Enterprises & Startups: Quickly identify problems & improve services.

App Developers & E-commerce Platforms: Detect frustrations & optimize UX.

Hospitality Industry: Monitor praise & complaints to boost customer satisfaction.

Government Organizations: Analyze citizen feedback for better services.

Society at Large: Improve transparency, faster resolution of issues.