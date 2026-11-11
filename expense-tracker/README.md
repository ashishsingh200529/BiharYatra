# 💰 Expense Tracker | Personal Finance & Budget Management

A responsive, feature-rich web application designed to track personal income and expenses efficiently. Built using vanilla **HTML5**, **CSS3**, and modern **JavaScript (ES6+)**, featuring dynamic financial calculations, category management, interactive visual charts, and local storage data persistence.

---

## 🚀 Key Features

### 1. **Financial Overview & Automatic Calculations**
- **Real-time Balance Calculation**: Automatically calculates net balance (`Total Income - Total Expenses`).
- **Dynamic Inflow & Outflow Metrics**: Live totals for income and expenses with status indicators.
- **Savings Rate Tracker**: Real-time savings percentage bar indicating financial health.
- **Multi-Currency Support**: Switch between **₹ INR (Default)**, **$ USD**, **€ EUR**, **£ GBP**, **¥ JPY**, **C$ CAD**, and **A$ AUD** with instant ledger re-formatting.

### 2. **Transaction Management (CRUD)**
- **Add Transactions**: Input title, amount, type (*Income* or *Expense*), category, transaction date, and optional notes.
- **Edit Transactions**: Populates existing details into an interactive modal for seamless updates.
- **Delete Transactions**: Confirmation dialog preventing accidental loss, accompanied by toast feedback.

### 3. **Smart Search & Advanced Filtering**
- **Live Search**: Instant keyword filtering across transaction titles and notes.
- **Type Filter**: Quickly isolate *All*, *Income*, or *Expense* records.
- **Category Filter**: Filter transactions by specific spending or income streams.
- **Date Presets & Custom Range**: Presets for *All Time*, *Today*, *Last 7 Days*, *This Month*, *This Year*, or *Custom Date Range*.
- **Multi-criteria Sorting**: Sort by date (newest/oldest), amount (highest/lowest), or alphabetical title.
- **Active Filter Badges**: Visual indicator tags for active filters with 1-click removal and "Clear All".

### 4. **Category Management**
- **Pre-configured Categories**: Includes diverse categories for both income (*Salary*, *Freelance*, *Investments*, *Business*, *Gifts*, etc.) and expenses (*Food & Dining*, *Housing*, *Utilities*, *Transport*, *Shopping*, *Entertainment*, *Healthcare*, etc.).
- **Custom Category Creation**: Add custom categories with custom color badge tags.
- **Category Usage Count & Safe Deletion**: Re-assigns linked transactions to fallback categories when a custom category is removed.

### 5. **Interactive Data Visualization & Analytics**
- **Category Breakdown Chart**: Donut chart visualizing expense distribution by category with percentage tooltips.
- **Cash Flow Bar Chart**: Side-by-side comparison of monthly income vs. expense trends.
- **Theme Responsive**: Charts automatically synchronize their axis, grid, and tooltip colors to light and dark themes.

### 6. **Data Persistence & Portability**
- **LocalStorage Persistence**: Keeps all data saved safely in the user's browser across sessions.
- **Initial Demo Seed Data**: Includes realistic sample transactions on initial launch for immediate demonstration.
- **CSV Export**: Download formatted transaction records for Excel or Google Sheets.
- **JSON Backup & Restore**: Export complete data snapshots and import them back at any time.
- **Reset / Wipe Options**: Easily reset back to sample demo data or clear all transactions.

### 7. **Responsive & Modern UI/UX**
- **Dark Mode & Light Mode**: High-contrast, theme-switchable UI with persistent theme preference.
- **Mobile-First Layout**: Fully responsive card grids, horizontal scrollable tables, and a dedicated mobile Floating Action Button (FAB).
- **Toast Notifications**: Non-intrusive alerts for user actions (add, edit, delete, backup).
- **Keyboard Friendly**: Press `Esc` to close any open modal dialog.

---

## 🛠️ Tech Stack

- **Markup**: Semantic HTML5
- **Styling**: Modern CSS3 (CSS Variables, Flexbox, CSS Grid, Media Queries)
- **Scripting**: Modern Vanilla JavaScript (ES6+, DOM Manipulation, LocalStorage API, Blob API for file download)
- **Data Visualization**: [Chart.js](https://www.chartjs.org/) via CDN

---

## 📂 Project Structure

```text
expense-tracker/
├── index.html          # Main HTML structure with semantic dashboard and modals
├── css/
│   └── style.css       # Complete design system with light/dark variables and responsive styles
├── js/
│   ├── storage.js      # LocalStorage CRUD, seed sample data, CSV/JSON export & import
│   ├── charts.js       # Chart.js donut and cash flow bar visualization controller
│   └── app.js          # Main app logic, state management, search/filter, UI rendering
└── README.md           # Documentation
```

---

## 💻 How to Run

No build tools or server installation required!

1. Clone or download the repository.
2. Navigate to the `expense-tracker` folder.
3. Open `index.html` in any modern web browser (Chrome, Edge, Firefox, Safari, etc.):
   - Double click `index.html`, OR
   - Right click `index.html` -> Open with -> Browser, OR
   - Run a simple local server if preferred:
     ```bash
     # Using Python
     python -m http.server 8000
     # Open http://localhost:8000/expense-tracker
     ```

---

## 📄 Resume Project Highlights

> **Expense Tracker | HTML, CSS, JavaScript**
> - Developed a responsive personal finance web application to track income and expenses with automatic balance and savings rate calculation.
> - Built an interactive interface featuring transaction CRUD, live search, multi-criteria filtering, custom category management, and Chart.js financial analytics.
> - Implemented Local Storage for persistent client-side data management, dark/light theme switching, and CSV/JSON backup/restore capabilities.
