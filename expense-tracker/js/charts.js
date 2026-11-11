/**
 * Expense Tracker - Chart Visualizations Layer
 * Uses Chart.js to render modern, responsive donut and cash flow charts.
 */

class ChartManager {
  constructor() {
    this.categoryChart = null;
    this.cashFlowChart = null;
  }

  getThemeColors(isDarkMode) {
    return {
      textColor: isDarkMode ? '#94a3b8' : '#475569',
      gridColor: isDarkMode ? 'rgba(148, 163, 184, 0.12)' : 'rgba(100, 116, 139, 0.12)',
      tooltipBg: isDarkMode ? '#1e293b' : '#ffffff',
      tooltipText: isDarkMode ? '#f8fafc' : '#0f172a',
      tooltipBorder: isDarkMode ? '#334155' : '#e2e8f0'
    };
  }

  updateCharts(transactions, categories, currencySymbol = '₹', isDarkMode = true) {
    if (typeof Chart === 'undefined') {
      console.warn('Chart.js is not loaded. Skipping chart rendering.');
      return;
    }

    const theme = this.getThemeColors(isDarkMode);
    this.renderCategoryChart(transactions, categories, currencySymbol, theme);
    this.renderCashFlowChart(transactions, currencySymbol, theme);
  }

  renderCategoryChart(transactions, categories, currencySymbol, theme) {
    const ctx = document.getElementById('categoryChartCanvas');
    const emptyState = document.getElementById('categoryChartEmpty');
    if (!ctx) return;

    // Filter only expense transactions
    const expenses = transactions.filter(t => t.type === 'expense');

    if (expenses.length === 0) {
      if (this.categoryChart) {
        this.categoryChart.destroy();
        this.categoryChart = null;
      }
      ctx.style.display = 'none';
      if (emptyState) emptyState.style.display = 'flex';
      return;
    }

    ctx.style.display = 'block';
    if (emptyState) emptyState.style.display = 'none';

    // Group expenses by category
    const catMap = {};
    expenses.forEach(tx => {
      catMap[tx.categoryId] = (catMap[tx.categoryId] || 0) + tx.amount;
    });

    // Lookup metadata for each category
    const allCategories = [...(categories.expense || []), ...(categories.income || [])];
    const labels = [];
    const data = [];
    const backgroundColors = [];

    // Sort categories by highest amount
    const sortedCats = Object.entries(catMap).sort((a, b) => b[1] - a[1]);

    sortedCats.forEach(([catId, amount]) => {
      const catObj = allCategories.find(c => c.id === catId) || { name: 'Other', color: '#94a3b8' };
      labels.push(catObj.name);
      data.push(amount);
      backgroundColors.push(catObj.color);
    });

    const totalExpense = data.reduce((a, b) => a + b, 0);

    const config = {
      type: 'doughnut',
      data: {
        labels: labels,
        datasets: [{
          data: data,
          backgroundColor: backgroundColors,
          borderWidth: 2,
          borderColor: theme.tooltipBg,
          hoverOffset: 6
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        cutout: '72%',
        plugins: {
          legend: {
            position: 'bottom',
            labels: {
              color: theme.textColor,
              font: { family: "'Inter', sans-serif", size: 12 },
              padding: 16,
              usePointStyle: true,
              pointStyle: 'circle'
            }
          },
          tooltip: {
            backgroundColor: theme.tooltipBg,
            titleColor: theme.tooltipText,
            bodyColor: theme.tooltipText,
            borderColor: theme.tooltipBorder,
            borderWidth: 1,
            padding: 12,
            boxPadding: 6,
            usePointStyle: true,
            callbacks: {
              label: function(context) {
                const val = context.raw || 0;
                const pct = totalExpense > 0 ? ((val / totalExpense) * 100).toFixed(1) : 0;
                return ` ${currencySymbol}${val.toLocaleString()} (${pct}%)`;
              }
            }
          }
        }
      }
    };

    if (this.categoryChart) {
      this.categoryChart.destroy();
    }
    this.categoryChart = new Chart(ctx, config);
  }

  renderCashFlowChart(transactions, currencySymbol, theme) {
    const ctx = document.getElementById('cashFlowChartCanvas');
    const emptyState = document.getElementById('cashFlowChartEmpty');
    if (!ctx) return;

    if (transactions.length === 0) {
      if (this.cashFlowChart) {
        this.cashFlowChart.destroy();
        this.cashFlowChart = null;
      }
      ctx.style.display = 'none';
      if (emptyState) emptyState.style.display = 'flex';
      return;
    }

    ctx.style.display = 'block';
    if (emptyState) emptyState.style.display = 'none';

    // Group transactions by month (last 6 distinct months or recent months)
    const monthMap = {};
    const monthOrder = [];

    // Helper: format YYYY-MM to Month Name
    const getMonthLabel = (dateStr) => {
      const [year, month] = dateStr.split('-');
      const d = new Date(parseInt(year, 10), parseInt(month, 10) - 1, 1);
      return d.toLocaleDateString('en-US', { month: 'short', year: 'numeric' });
    };

    // Sort transactions chronologically
    const sorted = [...transactions].sort((a, b) => new Date(a.date) - new Date(b.date));

    sorted.forEach(tx => {
      const key = tx.date.substring(0, 7); // YYYY-MM
      if (!monthMap[key]) {
        monthMap[key] = { income: 0, expense: 0, label: getMonthLabel(tx.date) };
        monthOrder.push(key);
      }
      if (tx.type === 'income') {
        monthMap[key].income += tx.amount;
      } else {
        monthMap[key].expense += tx.amount;
      }
    });

    // Take up to last 6 months
    const recentKeys = monthOrder.slice(-6);
    const labels = recentKeys.map(k => monthMap[k].label);
    const incomeData = recentKeys.map(k => monthMap[k].income);
    const expenseData = recentKeys.map(k => monthMap[k].expense);

    const config = {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [
          {
            label: 'Income',
            data: incomeData,
            backgroundColor: '#10b981',
            borderRadius: 6,
            barPercentage: 0.6,
            categoryPercentage: 0.7
          },
          {
            label: 'Expense',
            data: expenseData,
            backgroundColor: '#ef4444',
            borderRadius: 6,
            barPercentage: 0.6,
            categoryPercentage: 0.7
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: 'top',
            labels: {
              color: theme.textColor,
              font: { family: "'Inter', sans-serif", size: 12 },
              usePointStyle: true,
              pointStyle: 'circle'
            }
          },
          tooltip: {
            backgroundColor: theme.tooltipBg,
            titleColor: theme.tooltipText,
            bodyColor: theme.tooltipText,
            borderColor: theme.tooltipBorder,
            borderWidth: 1,
            padding: 12,
            boxPadding: 6,
            usePointStyle: true,
            callbacks: {
              label: function(context) {
                return ` ${context.dataset.label}: ${currencySymbol}${context.raw.toLocaleString()}`;
              }
            }
          }
        },
        scales: {
          x: {
            grid: { display: false },
            ticks: {
              color: theme.textColor,
              font: { family: "'Inter', sans-serif", size: 12 }
            }
          },
          y: {
            grid: { color: theme.gridColor },
            ticks: {
              color: theme.textColor,
              font: { family: "'Inter', sans-serif", size: 11 },
              callback: function(val) {
                if (val >= 1000) {
                  return currencySymbol + (val / 1000).toFixed(0) + 'k';
                }
                return currencySymbol + val;
              }
            }
          }
        }
      }
    };

    if (this.cashFlowChart) {
      this.cashFlowChart.destroy();
    }
    this.cashFlowChart = new Chart(ctx, config);
  }
}

// Global chart singleton instance
window.chartManager = new ChartManager();
