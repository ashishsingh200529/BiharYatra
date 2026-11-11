/**
 * Expense Tracker - Storage & Data Persistence Layer
 * Handles LocalStorage CRUD, initial demo seeding, category schemas, and CSV/JSON export/import.
 */

const STORAGE_KEYS = {
  TRANSACTIONS: 'et_transactions',
  CATEGORIES: 'et_categories',
  SETTINGS: 'et_settings',
  INITIALIZED: 'et_initialized_v1'
};

// Default Categories with pre-assigned color schemes and SVG icon names
const DEFAULT_CATEGORIES = {
  income: [
    { id: 'cat-salary', name: 'Salary', icon: 'briefcase', color: '#10b981', isCustom: false },
    { id: 'cat-freelance', name: 'Freelance & Projects', icon: 'laptop', color: '#06b6d4', isCustom: false },
    { id: 'cat-investments', name: 'Investments & Returns', icon: 'trending-up', color: '#8b5cf6', isCustom: false },
    { id: 'cat-business', name: 'Business Profits', icon: 'building', color: '#3b82f6', isCustom: false },
    { id: 'cat-gifts', name: 'Gifts & Rewards', icon: 'gift', color: '#f59e0b', isCustom: false },
    { id: 'cat-other-income', name: 'Other Income', icon: 'wallet', color: '#64748b', isCustom: false }
  ],
  expense: [
    { id: 'cat-food', name: 'Food & Dining', icon: 'utensils', color: '#ef4444', isCustom: false },
    { id: 'cat-housing', name: 'Rent & Housing', icon: 'home', color: '#f97316', isCustom: false },
    { id: 'cat-utilities', name: 'Utilities & Bills', icon: 'zap', color: '#eab308', isCustom: false },
    { id: 'cat-transport', name: 'Transportation', icon: 'car', color: '#3b82f6', isCustom: false },
    { id: 'cat-shopping', name: 'Shopping & Groceries', icon: 'shopping-bag', color: '#ec4899', isCustom: false },
    { id: 'cat-entertainment', name: 'Entertainment & Fun', icon: 'tv', color: '#a855f7', isCustom: false },
    { id: 'cat-healthcare', name: 'Healthcare & Medical', icon: 'heart-pulse', color: '#14b8a6', isCustom: false },
    { id: 'cat-education', name: 'Education & Books', icon: 'book-open', color: '#6366f1', isCustom: false },
    { id: 'cat-personal', name: 'Personal Care & Fitness', icon: 'smile', color: '#d946ef', isCustom: false },
    { id: 'cat-travel', name: 'Travel & Vacation', icon: 'plane', color: '#0284c7', isCustom: false },
    { id: 'cat-misc', name: 'Miscellaneous', icon: 'tag', color: '#64748b', isCustom: false }
  ]
};

// Default User Settings
const DEFAULT_SETTINGS = {
  currency: 'INR',
  currencySymbol: '₹',
  theme: 'dark' // 'dark' | 'light'
};

// Generates dynamic dates relative to today for realistic sample data
function getRelativeDateStr(daysAgo) {
  const d = new Date();
  d.setDate(d.getDate() - daysAgo);
  return d.toISOString().split('T')[0];
}

// Sample initial data so the dashboard is immediately rich and interactive
const SAMPLE_TRANSACTIONS = [
  {
    id: 'tx-1',
    title: 'Monthly Software Engineering Salary',
    amount: 85000,
    type: 'income',
    categoryId: 'cat-salary',
    date: getRelativeDateStr(2),
    notes: 'Direct deposit from TechCorp Solutions',
    createdAt: new Date().toISOString()
  },
  {
    id: 'tx-2',
    title: 'Apartment Rent Payment',
    amount: 22000,
    type: 'expense',
    categoryId: 'cat-housing',
    date: getRelativeDateStr(3),
    notes: 'Paid via UPI with maintenance fee included',
    createdAt: new Date().toISOString()
  },
  {
    id: 'tx-3',
    title: 'Freelance Web Design Project',
    amount: 18500,
    type: 'income',
    categoryId: 'cat-freelance',
    date: getRelativeDateStr(5),
    notes: 'Landing page redesign milestone payout',
    createdAt: new Date().toISOString()
  },
  {
    id: 'tx-4',
    title: 'Supermarket Groceries & Essentials',
    amount: 4350,
    type: 'expense',
    categoryId: 'cat-shopping',
    date: getRelativeDateStr(6),
    notes: 'Organic produce, weekly pantry refill',
    createdAt: new Date().toISOString()
  },
  {
    id: 'tx-5',
    title: 'Electricity & High-Speed Fiber Internet',
    amount: 2800,
    type: 'expense',
    categoryId: 'cat-utilities',
    date: getRelativeDateStr(8),
    notes: 'Electricity bill + 300 Mbps broadband',
    createdAt: new Date().toISOString()
  },
  {
    id: 'tx-6',
    title: 'Weekend Dinner with Friends',
    amount: 3200,
    type: 'expense',
    categoryId: 'cat-food',
    date: getRelativeDateStr(10),
    notes: 'Bistro dining and beverages',
    createdAt: new Date().toISOString()
  },
  {
    id: 'tx-7',
    title: 'Mutual Fund Dividend & Stock Yield',
    amount: 6200,
    type: 'income',
    categoryId: 'cat-investments',
    date: getRelativeDateStr(12),
    notes: 'Q3 Dividend distribution',
    createdAt: new Date().toISOString()
  },
  {
    id: 'tx-8',
    title: 'Fuel & Metro Transit Card Recharge',
    amount: 2100,
    type: 'expense',
    categoryId: 'cat-transport',
    date: getRelativeDateStr(14),
    notes: 'Petrol fill up and monthly metro pass',
    createdAt: new Date().toISOString()
  },
  {
    id: 'tx-9',
    title: 'Streaming Subscriptions (Netflix, Spotify)',
    amount: 1199,
    type: 'expense',
    categoryId: 'cat-entertainment',
    date: getRelativeDateStr(16),
    notes: 'Monthly recurring entertainment subscriptions',
    createdAt: new Date().toISOString()
  },
  {
    id: 'tx-10',
    title: 'Annual Dental Checkup & Prescriptions',
    amount: 1850,
    type: 'expense',
    categoryId: 'cat-healthcare',
    date: getRelativeDateStr(20),
    notes: 'Routine dental hygiene consultation',
    createdAt: new Date().toISOString()
  }
];

class StorageManager {
  constructor() {
    this.init();
  }

  init() {
    if (!localStorage.getItem(STORAGE_KEYS.INITIALIZED)) {
      this.resetToDefaults();
      localStorage.setItem(STORAGE_KEYS.INITIALIZED, 'true');
    }
  }

  resetToDefaults() {
    localStorage.setItem(STORAGE_KEYS.CATEGORIES, JSON.stringify(DEFAULT_CATEGORIES));
    localStorage.setItem(STORAGE_KEYS.TRANSACTIONS, JSON.stringify(SAMPLE_TRANSACTIONS));
    if (!localStorage.getItem(STORAGE_KEYS.SETTINGS)) {
      localStorage.setItem(STORAGE_KEYS.SETTINGS, JSON.stringify(DEFAULT_SETTINGS));
    }
  }

  // --- Transactions API ---
  getTransactions() {
    try {
      const data = localStorage.getItem(STORAGE_KEYS.TRANSACTIONS);
      return data ? JSON.parse(data) : [];
    } catch (e) {
      console.error('Error reading transactions from storage:', e);
      return [];
    }
  }

  saveTransactions(transactions) {
    try {
      localStorage.setItem(STORAGE_KEYS.TRANSACTIONS, JSON.stringify(transactions));
      return true;
    } catch (e) {
      console.error('Error saving transactions to storage:', e);
      return false;
    }
  }

  addTransaction(txData) {
    const transactions = this.getTransactions();
    const newTx = {
      id: 'tx-' + Date.now() + '-' + Math.random().toString(36).substr(2, 6),
      title: txData.title.trim(),
      amount: parseFloat(txData.amount),
      type: txData.type, // 'income' | 'expense'
      categoryId: txData.categoryId,
      date: txData.date || new Date().toISOString().split('T')[0],
      notes: txData.notes ? txData.notes.trim() : '',
      createdAt: new Date().toISOString()
    };
    transactions.unshift(newTx);
    this.saveTransactions(transactions);
    return newTx;
  }

  updateTransaction(id, updatedFields) {
    const transactions = this.getTransactions();
    const index = transactions.findIndex(t => t.id === id);
    if (index === -1) return null;

    transactions[index] = {
      ...transactions[index],
      title: updatedFields.title.trim(),
      amount: parseFloat(updatedFields.amount),
      type: updatedFields.type,
      categoryId: updatedFields.categoryId,
      date: updatedFields.date,
      notes: updatedFields.notes ? updatedFields.notes.trim() : '',
      updatedAt: new Date().toISOString()
    };

    this.saveTransactions(transactions);
    return transactions[index];
  }

  deleteTransaction(id) {
    const transactions = this.getTransactions();
    const filtered = transactions.filter(t => t.id !== id);
    this.saveTransactions(filtered);
    return filtered.length !== transactions.length;
  }

  clearAllTransactions() {
    this.saveTransactions([]);
  }

  // --- Categories API ---
  getCategories() {
    try {
      const data = localStorage.getItem(STORAGE_KEYS.CATEGORIES);
      return data ? JSON.parse(data) : DEFAULT_CATEGORIES;
    } catch (e) {
      console.error('Error reading categories from storage:', e);
      return DEFAULT_CATEGORIES;
    }
  }

  saveCategories(categories) {
    try {
      localStorage.setItem(STORAGE_KEYS.CATEGORIES, JSON.stringify(categories));
      return true;
    } catch (e) {
      console.error('Error saving categories to storage:', e);
      return false;
    }
  }

  addCategory(type, name, color, icon = 'tag') {
    const categories = this.getCategories();
    if (!categories[type]) categories[type] = [];

    const newCategory = {
      id: 'cat-custom-' + Date.now(),
      name: name.trim(),
      icon: icon || 'tag',
      color: color || '#6366f1',
      isCustom: true
    };

    categories[type].push(newCategory);
    this.saveCategories(categories);
    return newCategory;
  }

  deleteCategory(type, categoryId) {
    const categories = this.getCategories();
    if (!categories[type]) return false;

    // Do not delete default categories
    const target = categories[type].find(c => c.id === categoryId);
    if (!target || !target.isCustom) return false;

    categories[type] = categories[type].filter(c => c.id !== categoryId);
    this.saveCategories(categories);

    // Reassign existing transactions with this category to miscellaneous / other
    const fallbackId = type === 'income' ? 'cat-other-income' : 'cat-misc';
    const txs = this.getTransactions();
    let updated = false;
    txs.forEach(t => {
      if (t.categoryId === categoryId) {
        t.categoryId = fallbackId;
        updated = true;
      }
    });
    if (updated) this.saveTransactions(txs);

    return true;
  }

  getCategoryById(categoryId) {
    const categories = this.getCategories();
    const all = [...(categories.income || []), ...(categories.expense || [])];
    return all.find(c => c.id === categoryId) || {
      id: categoryId,
      name: 'Uncategorized',
      icon: 'tag',
      color: '#94a3b8'
    };
  }

  // --- Settings API ---
  getSettings() {
    try {
      const data = localStorage.getItem(STORAGE_KEYS.SETTINGS);
      return data ? { ...DEFAULT_SETTINGS, ...JSON.parse(data) } : DEFAULT_SETTINGS;
    } catch (e) {
      return DEFAULT_SETTINGS;
    }
  }

  saveSettings(settings) {
    try {
      const current = this.getSettings();
      const updated = { ...current, ...settings };
      localStorage.setItem(STORAGE_KEYS.SETTINGS, JSON.stringify(updated));
      return updated;
    } catch (e) {
      console.error('Error saving settings:', e);
      return DEFAULT_SETTINGS;
    }
  }

  // --- Export & Import Helpers ---
  exportToCSV() {
    const transactions = this.getTransactions();
    const headers = ['ID', 'Date', 'Type', 'Category', 'Title', 'Amount', 'Notes'];

    const rows = transactions.map(t => {
      const cat = this.getCategoryById(t.categoryId);
      const escape = str => `"${(str || '').replace(/"/g, '""')}"`;
      return [
        t.id,
        t.date,
        t.type.toUpperCase(),
        escape(cat.name),
        escape(t.title),
        t.amount.toFixed(2),
        escape(t.notes)
      ].join(',');
    });

    const csvContent = [headers.join(','), ...rows].join('\r\n');
    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.setAttribute('href', url);
    link.setAttribute('download', `Expense_Tracker_Export_${new Date().toISOString().split('T')[0]}.csv`);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(url);
  }

  exportToJSON() {
    const exportData = {
      version: '1.0',
      exportedAt: new Date().toISOString(),
      settings: this.getSettings(),
      categories: this.getCategories(),
      transactions: this.getTransactions()
    };

    const jsonStr = JSON.stringify(exportData, null, 2);
    const blob = new Blob([jsonStr], { type: 'application/json;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.setAttribute('href', url);
    link.setAttribute('download', `Expense_Tracker_Backup_${new Date().toISOString().split('T')[0]}.json`);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(url);
  }

  importFromJSON(jsonString) {
    try {
      const parsed = JSON.parse(jsonString);
      if (!Array.isArray(parsed.transactions)) {
        throw new Error('Invalid JSON format: missing transactions array.');
      }

      if (parsed.categories && typeof parsed.categories === 'object') {
        this.saveCategories(parsed.categories);
      }
      if (parsed.settings && typeof parsed.settings === 'object') {
        this.saveSettings(parsed.settings);
      }
      this.saveTransactions(parsed.transactions);
      return { success: true, count: parsed.transactions.length };
    } catch (err) {
      console.error('Import failed:', err);
      return { success: false, error: err.message };
    }
  }
}

// Global storage singleton instance
window.storageManager = new StorageManager();
