/**
 * Expense Tracker - Application Controller
 * Handles UI interactions, calculations, filtering, modals, and event bindings.
 */

(function () {
  'use strict';

  // Supported Currencies
  const CURRENCIES = {
    INR: { symbol: '₹', name: 'INR (₹)' },
    USD: { symbol: '$', name: 'USD ($)' },
    EUR: { symbol: '€', name: 'EUR (€)' },
    GBP: { symbol: '£', name: 'GBP (£)' },
    JPY: { symbol: '¥', name: 'JPY (¥)' },
    CAD: { symbol: 'C$', name: 'CAD (C$)' },
    AUD: { symbol: 'A$', name: 'AUD (A$)' }
  };

  // State
  let appState = {
    transactions: [],
    categories: {},
    settings: {
      currency: 'INR',
      currencySymbol: '₹',
      theme: 'dark'
    },
    filters: {
      type: 'all',
      categoryId: 'all',
      datePreset: 'all',
      search: '',
      startDate: '',
      endDate: '',
      sort: 'date-desc'
    },
    editingTxId: null,
    deletingTxId: null,
    categoryModalType: 'expense'
  };

  // --- SVG Icon Provider ---
  function getIconSvg(iconName, size = 16) {
    const icons = {
      'briefcase': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path></svg>`,
      'laptop': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 16V7a2 2 0 0 0-2-2H6a2 2 0 0 0-2 2v9m16 0H4m16 0 1.28 2.55a1 1 0 0 1-.9 1.45H3.62a1 1 0 0 1-.9-1.45L4 16"></path></svg>`,
      'trending-up': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18"></polyline><polyline points="17 6 23 6 23 12"></polyline></svg>`,
      'building': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="2" width="16" height="20" rx="2" ry="2"></rect><path d="M9 22v-4h6v4"></path><path d="M8 6h.01"></path><path d="M16 6h.01"></path><path d="M12 6h.01"></path><path d="M12 10h.01"></path><path d="M12 14h.01"></path><path d="M16 10h.01"></path><path d="M16 14h.01"></path><path d="M8 10h.01"></path><path d="M8 14h.01"></path></svg>`,
      'gift': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 12 20 22 4 22 4 12"></polyline><rect x="2" y="7" width="20" height="5"></rect><line x1="12" y1="22" x2="12" y2="7"></line><path d="M12 7H7.5a2.5 2.5 0 0 1 0-5C11 2 12 7 12 7z"></path><path d="M12 7h4.5a2.5 2.5 0 0 0 0-5C13 2 12 7 12 7z"></path></svg>`,
      'wallet': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12V7H5a2 2 0 0 1 0-4h14v4"></path><path d="M3 5v14a2 2 0 0 0 2 2h16v-5"></path><path d="M18 12a2 2 0 0 0 0 4h4v-4Z"></path></svg>`,
      'utensils': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 2v6a3 3 0 0 1-3 3 3 3 0 0 1-3-3V2"></path><path d="M15 2v19"></path><path d="M8 18v3"></path><path d="M4 2v6a4 4 0 0 0 4 4 4 4 0 0 0 4-4V2"></path></svg>`,
      'home': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>`,
      'zap': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>`,
      'car': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 .6.4 1 1 1h2"></path><circle cx="7" cy="17" r="2"></circle><path d="M9 17h6"></path><circle cx="17" cy="17" r="2"></circle></svg>`,
      'shopping-bag': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"></path><path d="M3 6h18"></path><path d="M16 10a4 4 0 0 1-8 0"></path></svg>`,
      'tv': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="20" height="15" x="2" y="7" rx="2" ry="2"></rect><polyline points="17 2 12 7 7 2"></polyline></svg>`,
      'heart-pulse': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"></path><path d="M3.22 12H9.5l.5-1 2 4.5 2-7 1.5 3.5h5.27"></path></svg>`,
      'book-open': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path></svg>`,
      'smile': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><path d="M8 14s1.5 2 4 2 4-2 4-2"></path><line x1="9" y1="9" x2="9.01" y2="9"></line><line x1="15" y1="9" x2="15.01" y2="9"></line></svg>`,
      'plane': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.8 19.2 16 11l3.5-3.5C21 6 21.5 4 21 3c-1-.5-3 0-4.5 1.5L13 8 4.8 6.2c-.5-.1-.9.1-1.1.5l-.3.5c-.2.5-.1 1 .3 1.3L9 12l-2 3H4l-1 1 3 2 2 3 1-1v-3l3-2 3.5 5.3c.3.4.8.5 1.3.3l.5-.2c.4-.3.6-.7.5-1.2z"></path></svg>`,
      'tag': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2H2v10l9.29 9.29c.94.94 2.48.94 3.42 0l6.58-6.58c.94-.94.94-2.48 0-3.42L12 2Z"></path><path d="M7 7h.01"></path></svg>`,
      'trash': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"></path><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"></path><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path></svg>`,
      'edit': `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"></path></svg>`
    };
    return icons[iconName] || icons['tag'];
  }

  // --- Formatting Helpers ---
  function formatMoney(amount) {
    const sym = appState.settings.currencySymbol || '₹';
    const num = Math.abs(Number(amount) || 0);
    return `${sym}${num.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
  }

  function formatDate(dateStr) {
    if (!dateStr) return '';
    const parts = dateStr.split('-');
    if (parts.length !== 3) return dateStr;
    const d = new Date(parseInt(parts[0], 10), parseInt(parts[1], 10) - 1, parseInt(parts[2], 10));
    return d.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
  }

  // --- Initialization ---
  function initApp() {
    loadSettings();
    loadCategories();
    loadTransactions();
    applyTheme(appState.settings.theme);
    setupEventListeners();
    updateUI();
  }

  function loadSettings() {
    appState.settings = window.storageManager.getSettings();
    const currencySelect = document.getElementById('currencySelector');
    if (currencySelect) {
      currencySelect.value = appState.settings.currency;
    }
  }

  function loadCategories() {
    appState.categories = window.storageManager.getCategories();
    populateCategoryFilterDropdown();
  }

  function loadTransactions() {
    appState.transactions = window.storageManager.getTransactions();
  }

  // --- Theme Management ---
  function applyTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    appState.settings.theme = theme;
    window.storageManager.saveSettings({ theme: theme });

    const themeToggleBtn = document.getElementById('themeToggleBtn');
    if (themeToggleBtn) {
      themeToggleBtn.setAttribute('title', theme === 'dark' ? 'Switch to Light Mode' : 'Switch to Dark Mode');
      themeToggleBtn.innerHTML = theme === 'dark' 
        ? `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>`
        : `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg>`;
    }

    if (window.chartManager) {
      window.chartManager.updateCharts(
        getFilteredTransactions(),
        appState.categories,
        appState.settings.currencySymbol,
        theme === 'dark'
      );
    }
  }

  // --- Filter and Search Logic ---
  function getFilteredTransactions() {
    return appState.transactions.filter(tx => {
      // Type Filter
      if (appState.filters.type !== 'all' && tx.type !== appState.filters.type) {
        return false;
      }

      // Category Filter
      if (appState.filters.categoryId !== 'all' && tx.categoryId !== appState.filters.categoryId) {
        return false;
      }

      // Search Filter (Title or Notes)
      if (appState.filters.search) {
        const query = appState.filters.search.toLowerCase();
        const matchTitle = (tx.title || '').toLowerCase().includes(query);
        const matchNotes = (tx.notes || '').toLowerCase().includes(query);
        if (!matchTitle && !matchNotes) return false;
      }

      // Date Presets
      if (appState.filters.datePreset !== 'all') {
        const txDate = new Date(tx.date);
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        if (appState.filters.datePreset === 'today') {
          const todayStr = today.toISOString().split('T')[0];
          if (tx.date !== todayStr) return false;
        } else if (appState.filters.datePreset === 'this-week') {
          const sevenDaysAgo = new Date();
          sevenDaysAgo.setDate(today.getDate() - 7);
          sevenDaysAgo.setHours(0, 0, 0, 0);
          if (txDate < sevenDaysAgo) return false;
        } else if (appState.filters.datePreset === 'this-month') {
          const isSameMonth = txDate.getMonth() === today.getMonth() && txDate.getFullYear() === today.getFullYear();
          if (!isSameMonth) return false;
        } else if (appState.filters.datePreset === 'this-year') {
          if (txDate.getFullYear() !== today.getFullYear()) return false;
        } else if (appState.filters.datePreset === 'custom') {
          if (appState.filters.startDate && tx.date < appState.filters.startDate) return false;
          if (appState.filters.endDate && tx.date > appState.filters.endDate) return false;
        }
      }

      return true;
    }).sort((a, b) => {
      const sort = appState.filters.sort;
      if (sort === 'date-desc') return new Date(b.date) - new Date(a.date);
      if (sort === 'date-asc') return new Date(a.date) - new Date(b.date);
      if (sort === 'amount-desc') return b.amount - a.amount;
      if (sort === 'amount-asc') return a.amount - b.amount;
      if (sort === 'title-asc') return a.title.localeCompare(b.title);
      return 0;
    });
  }

  // --- Summary Calculations ---
  function updateSummaryMetrics() {
    let totalIncome = 0;
    let totalExpense = 0;

    appState.transactions.forEach(tx => {
      if (tx.type === 'income') totalIncome += tx.amount;
      else if (tx.type === 'expense') totalExpense += tx.amount;
    });

    const netBalance = totalIncome - totalExpense;
    const savingsRate = totalIncome > 0 ? Math.max(0, Math.round((netBalance / totalIncome) * 100)) : 0;

    // Balance
    const balanceElem = document.getElementById('metricBalance');
    if (balanceElem) {
      balanceElem.textContent = `${netBalance < 0 ? '-' : ''}${formatMoney(netBalance)}`;
      balanceElem.style.color = netBalance >= 0 ? 'var(--income-color)' : 'var(--expense-color)';
    }

    // Income
    const incomeElem = document.getElementById('metricIncome');
    if (incomeElem) {
      incomeElem.textContent = `+${formatMoney(totalIncome)}`;
    }

    // Expense
    const expenseElem = document.getElementById('metricExpense');
    if (expenseElem) {
      expenseElem.textContent = `-${formatMoney(totalExpense)}`;
    }

    // Savings Rate
    const savingsElem = document.getElementById('metricSavingsRate');
    const savingsFill = document.getElementById('savingsBarFill');
    if (savingsElem) {
      savingsElem.textContent = `${savingsRate}%`;
    }
    if (savingsFill) {
      savingsFill.style.width = `${Math.min(100, Math.max(0, savingsRate))}%`;
    }
  }

  // --- Render Transactions Table ---
  function renderTransactions() {
    const listBody = document.getElementById('transactionsTableBody');
    const emptyState = document.getElementById('transactionsEmptyState');
    const countBadge = document.getElementById('transactionCountBadge');

    const filtered = getFilteredTransactions();

    if (countBadge) {
      countBadge.textContent = `${filtered.length} ${filtered.length === 1 ? 'transaction' : 'transactions'}`;
    }

    if (filtered.length === 0) {
      if (listBody) listBody.innerHTML = '';
      if (emptyState) emptyState.style.display = 'flex';
      return;
    }

    if (emptyState) emptyState.style.display = 'none';

    let html = '';
    filtered.forEach(tx => {
      const cat = window.storageManager.getCategoryById(tx.categoryId);
      const isIncome = tx.type === 'income';
      const amountPrefix = isIncome ? '+' : '-';
      const amountClass = isIncome ? 'amount-income' : 'amount-expense';

      html += `
        <tr data-id="${tx.id}">
          <td style="white-space: nowrap; color: var(--text-secondary); font-size: 0.82rem;">
            ${formatDate(tx.date)}
          </td>
          <td>
            <div class="tx-title-cell">
              <span class="tx-title">${escapeHtml(tx.title)}</span>
              ${tx.notes ? `<span class="tx-notes">${escapeHtml(tx.notes)}</span>` : ''}
            </div>
          </td>
          <td>
            <span class="category-tag">
              <span class="category-dot" style="background-color: ${cat.color};"></span>
              ${escapeHtml(cat.name)}
            </span>
          </td>
          <td style="text-align: right;">
            <span class="tx-amount ${amountClass}">
              ${amountPrefix}${formatMoney(tx.amount)}
            </span>
          </td>
          <td>
            <div class="tx-actions">
              <button class="btn-table-action edit-btn" data-id="${tx.id}" title="Edit transaction">
                ${getIconSvg('edit', 15)}
              </button>
              <button class="btn-table-action delete delete-btn" data-id="${tx.id}" title="Delete transaction">
                ${getIconSvg('trash', 15)}
              </button>
            </div>
          </td>
        </tr>
      `;
    });

    if (listBody) {
      listBody.innerHTML = html;
    }

    renderActiveFilterBadges();
  }

  // --- Active Filters Tag Bar ---
  function renderActiveFilterBadges() {
    const bar = document.getElementById('activeFiltersBar');
    const tagsWrapper = document.getElementById('activeFiltersList');
    if (!bar || !tagsWrapper) return;

    const tags = [];

    if (appState.filters.type !== 'all') {
      tags.push({ key: 'type', label: `Type: ${appState.filters.type.toUpperCase()}` });
    }

    if (appState.filters.categoryId !== 'all') {
      const cat = window.storageManager.getCategoryById(appState.filters.categoryId);
      tags.push({ key: 'categoryId', label: `Category: ${cat.name}` });
    }

    if (appState.filters.search) {
      tags.push({ key: 'search', label: `Search: "${appState.filters.search}"` });
    }

    if (appState.filters.datePreset !== 'all') {
      let label = `Date: ${appState.filters.datePreset.replace('-', ' ').toUpperCase()}`;
      if (appState.filters.datePreset === 'custom') {
        label = `Date: ${appState.filters.startDate || '*'} to ${appState.filters.endDate || '*'}`;
      }
      tags.push({ key: 'datePreset', label: label });
    }

    if (tags.length === 0) {
      bar.style.display = 'none';
      tagsWrapper.innerHTML = '';
      return;
    }

    bar.style.display = 'flex';
    tagsWrapper.innerHTML = tags.map(t => `
      <span class="filter-tag">
        ${escapeHtml(t.label)}
        <button class="filter-tag-clear" data-filter-key="${t.key}" title="Remove filter">&times;</button>
      </span>
    `).join('');
  }

  function clearSpecificFilter(key) {
    if (key === 'type') {
      appState.filters.type = 'all';
      document.querySelectorAll('.type-pill').forEach(p => {
        p.classList.toggle('active', p.getAttribute('data-type') === 'all');
      });
    } else if (key === 'categoryId') {
      appState.filters.categoryId = 'all';
      const catSelect = document.getElementById('categoryFilterSelect');
      if (catSelect) catSelect.value = 'all';
    } else if (key === 'search') {
      appState.filters.search = '';
      const searchInput = document.getElementById('searchInput');
      const clearBtn = document.getElementById('clearSearchBtn');
      if (searchInput) searchInput.value = '';
      if (clearBtn) clearBtn.style.display = 'none';
    } else if (key === 'datePreset') {
      appState.filters.datePreset = 'all';
      appState.filters.startDate = '';
      appState.filters.endDate = '';
      const dateSelect = document.getElementById('datePresetSelect');
      const customDates = document.getElementById('customDateInputs');
      if (dateSelect) dateSelect.value = 'all';
      if (customDates) customDates.style.display = 'none';
    }
    updateUI();
  }

  function clearAllFilters() {
    appState.filters.type = 'all';
    appState.filters.categoryId = 'all';
    appState.filters.datePreset = 'all';
    appState.filters.search = '';
    appState.filters.startDate = '';
    appState.filters.endDate = '';

    // Reset controls
    document.querySelectorAll('.type-pill').forEach(p => {
      p.classList.toggle('active', p.getAttribute('data-type') === 'all');
    });
    const catSelect = document.getElementById('categoryFilterSelect');
    if (catSelect) catSelect.value = 'all';

    const searchInput = document.getElementById('searchInput');
    const clearBtn = document.getElementById('clearSearchBtn');
    if (searchInput) searchInput.value = '';
    if (clearBtn) clearBtn.style.display = 'none';

    const dateSelect = document.getElementById('datePresetSelect');
    const customDates = document.getElementById('customDateInputs');
    if (dateSelect) dateSelect.value = 'all';
    if (customDates) customDates.style.display = 'none';

    updateUI();
  }

  // --- Category Dropdowns Population ---
  function populateCategoryFilterDropdown() {
    const filterSelect = document.getElementById('categoryFilterSelect');
    if (!filterSelect) return;

    const currentVal = filterSelect.value;
    const expenseCats = appState.categories.expense || [];
    const incomeCats = appState.categories.income || [];

    let options = '<option value="all">All Categories</option>';

    if (expenseCats.length > 0) {
      options += '<optgroup label="Expense Categories">';
      expenseCats.forEach(c => {
        options += `<option value="${c.id}">${escapeHtml(c.name)}</option>`;
      });
      options += '</optgroup>';
    }

    if (incomeCats.length > 0) {
      options += '<optgroup label="Income Categories">';
      incomeCats.forEach(c => {
        options += `<option value="${c.id}">${escapeHtml(c.name)}</option>`;
      });
      options += '</optgroup>';
    }

    filterSelect.innerHTML = options;
    filterSelect.value = currentVal || 'all';
  }

  function populateTxModalCategoryDropdown(type, selectedCatId = null) {
    const select = document.getElementById('txModalCategory');
    if (!select) return;

    const cats = appState.categories[type] || [];
    let options = '';
    cats.forEach(c => {
      const isSel = selectedCatId === c.id ? 'selected' : '';
      options += `<option value="${c.id}" ${isSel}>${escapeHtml(c.name)}</option>`;
    });

    select.innerHTML = options;
  }

  // --- Combined UI Refresh ---
  function updateUI() {
    updateSummaryMetrics();
    renderTransactions();
    if (window.chartManager) {
      window.chartManager.updateCharts(
        getFilteredTransactions(),
        appState.categories,
        appState.settings.currencySymbol,
        appState.settings.theme === 'dark'
      );
    }
  }

  // --- Modal Controllers ---
  function openTxModal(txId = null) {
    const modal = document.getElementById('transactionModal');
    const titleElem = document.getElementById('txModalTitle');
    const form = document.getElementById('transactionForm');
    if (!modal || !form) return;

    form.reset();
    appState.editingTxId = txId;

    if (txId) {
      // Edit Mode
      const tx = appState.transactions.find(t => t.id === txId);
      if (!tx) return;

      if (titleElem) titleElem.textContent = 'Edit Transaction';
      document.getElementById('txModalId').value = tx.id;
      document.getElementById('txModalTitleInput').value = tx.title;
      document.getElementById('txModalAmount').value = tx.amount;
      document.getElementById('txModalDate').value = tx.date;
      document.getElementById('txModalNotes').value = tx.notes || '';

      // Type segment
      setTxModalType(tx.type);
      populateTxModalCategoryDropdown(tx.type, tx.categoryId);
    } else {
      // Add Mode
      if (titleElem) titleElem.textContent = 'Add Transaction';
      document.getElementById('txModalId').value = '';
      document.getElementById('txModalDate').value = new Date().toISOString().split('T')[0];
      setTxModalType('expense');
      populateTxModalCategoryDropdown('expense');
    }

    modal.classList.add('open');
    setTimeout(() => {
      const titleInput = document.getElementById('txModalTitleInput');
      if (titleInput) titleInput.focus();
    }, 100);
  }

  function closeTxModal() {
    const modal = document.getElementById('transactionModal');
    if (modal) modal.classList.remove('open');
    appState.editingTxId = null;
  }

  function setTxModalType(type) {
    const expenseBtn = document.getElementById('segmentExpense');
    const incomeBtn = document.getElementById('segmentIncome');
    const currentCat = document.getElementById('txModalCategory')?.value;

    if (type === 'expense') {
      expenseBtn?.classList.add('active');
      incomeBtn?.classList.remove('active');
    } else {
      incomeBtn?.classList.add('active');
      expenseBtn?.classList.remove('active');
    }

    populateTxModalCategoryDropdown(type, currentCat);
  }

  function handleTxFormSubmit(e) {
    e.preventDefault();
    const title = document.getElementById('txModalTitleInput').value.trim();
    const amount = parseFloat(document.getElementById('txModalAmount').value);
    const date = document.getElementById('txModalDate').value;
    const categoryId = document.getElementById('txModalCategory').value;
    const notes = document.getElementById('txModalNotes').value.trim();
    const isExpense = document.getElementById('segmentExpense')?.classList.contains('active');
    const type = isExpense ? 'expense' : 'income';

    if (!title) {
      showToast('Please enter a description or title.', 'error');
      return;
    }
    if (isNaN(amount) || amount <= 0) {
      showToast('Please enter a valid amount greater than zero.', 'error');
      return;
    }
    if (!categoryId) {
      showToast('Please select a category.', 'error');
      return;
    }
    if (!date) {
      showToast('Please choose a valid date.', 'error');
      return;
    }

    if (appState.editingTxId) {
      const updated = window.storageManager.updateTransaction(appState.editingTxId, {
        title, amount, type, categoryId, date, notes
      });
      if (updated) {
        showToast('Transaction updated successfully!', 'success');
      }
    } else {
      window.storageManager.addTransaction({
        title, amount, type, categoryId, date, notes
      });
      showToast('Transaction added successfully!', 'success');
    }

    loadTransactions();
    closeTxModal();
    updateUI();
  }

  // --- Category Manager Modal ---
  function openCategoryModal() {
    const modal = document.getElementById('categoryModal');
    if (!modal) return;
    renderCategoryManagerList();
    modal.classList.add('open');
  }

  function closeCategoryModal() {
    const modal = document.getElementById('categoryModal');
    if (modal) modal.classList.remove('open');
  }

  function renderCategoryManagerList() {
    const list = document.getElementById('categoryManagerList');
    if (!list) return;

    const type = appState.categoryModalType || 'expense';
    const cats = appState.categories[type] || [];

    if (cats.length === 0) {
      list.innerHTML = `<div style="text-align: center; color: var(--text-muted); padding: 1rem;">No categories found.</div>`;
      return;
    }

    let html = '';
    cats.forEach(c => {
      // Count transactions using this category
      const count = appState.transactions.filter(t => t.categoryId === c.id).length;
      html += `
        <div class="category-manager-item">
          <div class="cat-item-left">
            <span class="cat-item-badge" style="background-color: ${c.color};"></span>
            <span style="font-weight: 500; font-size: 0.875rem;">${escapeHtml(c.name)}</span>
            <span style="font-size: 0.75rem; color: var(--text-muted);">(${count} ${count === 1 ? 'tx' : 'txs'})</span>
          </div>
          <div>
            ${c.isCustom ? `
              <button class="btn-table-action delete delete-cat-btn" data-type="${type}" data-id="${c.id}" title="Delete category">
                ${getIconSvg('trash', 14)}
              </button>
            ` : `<span style="font-size: 0.7rem; color: var(--text-muted); padding: 0.2rem 0.5rem; background: var(--border-color); border-radius: var(--radius-sm);">Default</span>`}
          </div>
        </div>
      `;
    });

    list.innerHTML = html;
  }

  function handleAddCategorySubmit(e) {
    e.preventDefault();
    const nameInput = document.getElementById('newCatNameInput');
    const colorInput = document.querySelector('input[name="catColor"]:checked');
    const type = appState.categoryModalType;

    const name = nameInput ? nameInput.value.trim() : '';
    const color = colorInput ? colorInput.value : '#6366f1';

    if (!name) {
      showToast('Please enter a category name.', 'error');
      return;
    }

    // Check duplicate
    const exists = (appState.categories[type] || []).some(c => c.name.toLowerCase() === name.toLowerCase());
    if (exists) {
      showToast('A category with this name already exists.', 'error');
      return;
    }

    window.storageManager.addCategory(type, name, color);
    loadCategories();
    renderCategoryManagerList();
    if (nameInput) nameInput.value = '';
    populateCategoryFilterDropdown();
    populateTxModalCategoryDropdown(type);
    showToast(`Category "${name}" added!`, 'success');
  }

  // --- Delete Transaction Confirmation ---
  function promptDeleteTransaction(txId) {
    const tx = appState.transactions.find(t => t.id === txId);
    if (!tx) return;

    appState.deletingTxId = txId;
    const confirmModal = document.getElementById('deleteConfirmModal');
    const textElem = document.getElementById('deleteConfirmText');

    if (textElem) {
      textElem.innerHTML = `Are you sure you want to delete <strong>"${escapeHtml(tx.title)}"</strong> (${formatMoney(tx.amount)})? This action cannot be undone.`;
    }

    if (confirmModal) confirmModal.classList.add('open');
  }

  function confirmDeleteTransaction() {
    if (!appState.deletingTxId) return;

    window.storageManager.deleteTransaction(appState.deletingTxId);
    loadTransactions();
    updateUI();
    closeDeleteModal();
    showToast('Transaction deleted.', 'info');
  }

  function closeDeleteModal() {
    const confirmModal = document.getElementById('deleteConfirmModal');
    if (confirmModal) confirmModal.classList.remove('open');
    appState.deletingTxId = null;
  }

  // --- Backup & Restore Modal ---
  function openBackupModal() {
    const modal = document.getElementById('backupModal');
    if (modal) modal.classList.add('open');
  }

  function closeBackupModal() {
    const modal = document.getElementById('backupModal');
    if (modal) modal.classList.remove('open');
  }

  // --- Toast System ---
  function showToast(message, type = 'info') {
    const container = document.getElementById('toastContainer');
    if (!container) return;

    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;
    toast.innerHTML = `
      <span>${escapeHtml(message)}</span>
    `;

    container.appendChild(toast);

    setTimeout(() => {
      toast.style.opacity = '0';
      toast.style.transform = 'translateY(10px)';
      toast.style.transition = 'all 0.25s ease';
      setTimeout(() => {
        if (toast.parentNode) toast.parentNode.removeChild(toast);
      }, 250);
    }, 3200);
  }

  // --- Utility: Escape HTML ---
  function escapeHtml(str) {
    if (!str) return '';
    return str
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#039;');
  }

  // --- Event Listeners Setup ---
  function setupEventListeners() {
    // Theme toggle
    document.getElementById('themeToggleBtn')?.addEventListener('click', () => {
      const nextTheme = appState.settings.theme === 'dark' ? 'light' : 'dark';
      applyTheme(nextTheme);
    });

    // Currency selector
    document.getElementById('currencySelector')?.addEventListener('change', (e) => {
      const code = e.target.value;
      const currency = CURRENCIES[code] || { symbol: '₹' };
      appState.settings.currency = code;
      appState.settings.currencySymbol = currency.symbol;
      window.storageManager.saveSettings({
        currency: code,
        currencySymbol: currency.symbol
      });
      showToast(`Currency changed to ${currency.name}`, 'info');
      updateUI();
    });

    // Type pills filter
    document.querySelectorAll('.type-pill').forEach(pill => {
      pill.addEventListener('click', () => {
        document.querySelectorAll('.type-pill').forEach(p => p.classList.remove('active'));
        pill.classList.add('active');
        appState.filters.type = pill.getAttribute('data-type');
        updateUI();
      });
    });

    // Category filter
    document.getElementById('categoryFilterSelect')?.addEventListener('change', (e) => {
      appState.filters.categoryId = e.target.value;
      updateUI();
    });

    // Date preset filter
    document.getElementById('datePresetSelect')?.addEventListener('change', (e) => {
      appState.filters.datePreset = e.target.value;
      const customInputs = document.getElementById('customDateInputs');
      if (customInputs) {
        customInputs.style.display = e.target.value === 'custom' ? 'flex' : 'none';
      }
      updateUI();
    });

    // Custom date inputs
    document.getElementById('customStartDate')?.addEventListener('change', (e) => {
      appState.filters.startDate = e.target.value;
      updateUI();
    });
    document.getElementById('customEndDate')?.addEventListener('change', (e) => {
      appState.filters.endDate = e.target.value;
      updateUI();
    });

    // Sort selector
    document.getElementById('sortSelect')?.addEventListener('change', (e) => {
      appState.filters.sort = e.target.value;
      updateUI();
    });

    // Search input
    const searchInput = document.getElementById('searchInput');
    const clearSearchBtn = document.getElementById('clearSearchBtn');
    searchInput?.addEventListener('input', (e) => {
      appState.filters.search = e.target.value;
      if (clearSearchBtn) {
        clearSearchBtn.style.display = e.target.value ? 'flex' : 'none';
      }
      updateUI();
    });

    clearSearchBtn?.addEventListener('click', () => {
      if (searchInput) searchInput.value = '';
      clearSearchBtn.style.display = 'none';
      appState.filters.search = '';
      updateUI();
    });

    // Active filters bar clear events
    document.getElementById('activeFiltersBar')?.addEventListener('click', (e) => {
      const clearBtn = e.target.closest('.filter-tag-clear');
      if (clearBtn) {
        const key = clearBtn.getAttribute('data-filter-key');
        clearSpecificFilter(key);
      }
    });

    document.getElementById('clearAllFiltersBtn')?.addEventListener('click', clearAllFilters);
    document.getElementById('emptyStateResetFiltersBtn')?.addEventListener('click', clearAllFilters);

    // Open Add Transaction Modal
    document.getElementById('addTransactionBtn')?.addEventListener('click', () => openTxModal());
    document.getElementById('mobileFabAddBtn')?.addEventListener('click', () => openTxModal());
    document.getElementById('emptyStateAddBtn')?.addEventListener('click', () => openTxModal());

    // Transaction form modal segment controls
    document.getElementById('segmentExpense')?.addEventListener('click', () => setTxModalType('expense'));
    document.getElementById('segmentIncome')?.addEventListener('click', () => setTxModalType('income'));

    // Transaction form submit
    document.getElementById('transactionForm')?.addEventListener('submit', handleTxFormSubmit);
    document.getElementById('txModalCloseBtn')?.addEventListener('click', closeTxModal);
    document.getElementById('txModalCancelBtn')?.addEventListener('click', closeTxModal);

    // Edit and Delete table button delegation
    document.getElementById('transactionsTableBody')?.addEventListener('click', (e) => {
      const editBtn = e.target.closest('.edit-btn');
      if (editBtn) {
        const id = editBtn.getAttribute('data-id');
        openTxModal(id);
        return;
      }

      const deleteBtn = e.target.closest('.delete-btn');
      if (deleteBtn) {
        const id = deleteBtn.getAttribute('data-id');
        promptDeleteTransaction(id);
      }
    });

    // Delete confirmation modal actions
    document.getElementById('deleteConfirmBtn')?.addEventListener('click', confirmDeleteTransaction);
    document.getElementById('deleteCancelBtn')?.addEventListener('click', closeDeleteModal);
    document.getElementById('deleteModalCloseBtn')?.addEventListener('click', closeDeleteModal);

    // Category Manager Modal
    document.getElementById('manageCategoriesBtn')?.addEventListener('click', openCategoryModal);
    document.getElementById('categoryModalCloseBtn')?.addEventListener('click', closeCategoryModal);
    document.getElementById('addCategoryForm')?.addEventListener('submit', handleAddCategorySubmit);

    // Category type tabs in Category Modal
    document.getElementById('catTabExpense')?.addEventListener('click', () => {
      document.getElementById('catTabExpense').classList.add('active');
      document.getElementById('catTabIncome').classList.remove('active');
      appState.categoryModalType = 'expense';
      renderCategoryManagerList();
    });

    document.getElementById('catTabIncome')?.addEventListener('click', () => {
      document.getElementById('catTabIncome').classList.add('active');
      document.getElementById('catTabExpense').classList.remove('active');
      appState.categoryModalType = 'income';
      renderCategoryManagerList();
    });

    // Delete custom category delegation
    document.getElementById('categoryManagerList')?.addEventListener('click', (e) => {
      const deleteCatBtn = e.target.closest('.delete-cat-btn');
      if (deleteCatBtn) {
        const type = deleteCatBtn.getAttribute('data-type');
        const id = deleteCatBtn.getAttribute('data-id');
        if (confirm('Delete this custom category? Existing transactions with this category will be reassigned to Miscellaneous/Other.')) {
          window.storageManager.deleteCategory(type, id);
          loadCategories();
          loadTransactions();
          renderCategoryManagerList();
          populateCategoryFilterDropdown();
          showToast('Category deleted.', 'info');
          updateUI();
        }
      }
    });

    // Backup & Restore Modal
    document.getElementById('backupRestoreBtn')?.addEventListener('click', openBackupModal);
    document.getElementById('backupModalCloseBtn')?.addEventListener('click', closeBackupModal);

    // Export CSV
    document.getElementById('exportCsvBtn')?.addEventListener('click', () => {
      window.storageManager.exportToCSV();
      showToast('Exported transactions to CSV!', 'success');
    });

    // Export JSON
    document.getElementById('exportJsonBtn')?.addEventListener('click', () => {
      window.storageManager.exportToJSON();
      showToast('Backup JSON downloaded!', 'success');
    });

    // Import JSON
    const importFileInput = document.getElementById('importFileInput');
    document.getElementById('importJsonBtn')?.addEventListener('click', () => {
      importFileInput?.click();
    });

    importFileInput?.addEventListener('change', (e) => {
      const file = e.target.files[0];
      if (!file) return;

      const reader = new FileReader();
      reader.onload = (event) => {
        const result = window.storageManager.importFromJSON(event.target.result);
        if (result.success) {
          loadCategories();
          loadTransactions();
          loadSettings();
          populateCategoryFilterDropdown();
          applyTheme(appState.settings.theme);
          updateUI();
          closeBackupModal();
          showToast(`Successfully imported ${result.count} transactions!`, 'success');
        } else {
          showToast(`Import error: ${result.error}`, 'error');
        }
      };
      reader.readAsText(file);
      importFileInput.value = '';
    });

    // Reset to Sample Demo Data
    document.getElementById('resetSampleDataBtn')?.addEventListener('click', () => {
      if (confirm('Reset to initial sample demo data? Any unsaved changes will be replaced.')) {
        window.storageManager.resetToDefaults();
        loadCategories();
        loadTransactions();
        loadSettings();
        populateCategoryFilterDropdown();
        applyTheme(appState.settings.theme);
        updateUI();
        closeBackupModal();
        showToast('Reset to demo sample transactions!', 'success');
      }
    });

    // Clear All Transactions
    document.getElementById('clearAllDataBtn')?.addEventListener('click', () => {
      if (confirm('WARNING: Are you sure you want to clear ALL transactions? This cannot be undone.')) {
        window.storageManager.clearAllTransactions();
        loadTransactions();
        updateUI();
        closeBackupModal();
        showToast('All transaction records cleared.', 'info');
      }
    });

    // Close Modals on Backdrop Click & ESC Key
    document.querySelectorAll('.modal-overlay').forEach(modal => {
      modal.addEventListener('click', (e) => {
        if (e.target === modal) {
          modal.classList.remove('open');
        }
      });
    });

    window.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') {
        document.querySelectorAll('.modal-overlay.open').forEach(modal => {
          modal.classList.remove('open');
        });
      }
    });
  }

  // Run on DOM ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initApp);
  } else {
    initApp();
  }

})();
