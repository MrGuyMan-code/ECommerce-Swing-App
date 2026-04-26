# 🛒 E-Commerce Management System

A desktop application for managing an e-commerce database, built with Java Swing and MariaDB/MySQL. This application provides both customer-facing product browsing and an administrative dashboard for managing orders, products, and inventory.

## 📋 Table of Contents

- [Features](#-features)
- [Technologies Used](#-technologies-used)
- [Database Schema](#-database-schema)
- [Database Triggers](#-database-triggers)
- [Installation](#-installation)
- [Database Setup](#-database-setup)
- [Configuration](#-configuration)
- [How to Use](#-how-to-use)
- [Default Credentials](#-default-credentials)
- [Project Structure](#-project-structure)
- [Screenshots](#-screenshots)
- [Troubleshooting](#-troubleshooting)
- [Future Improvements](#-future-improvements)
- [Contributing](#-contributing)
- [License](#-license)
- [Author](#-author)

## ✨ Features

### 👤 Customer Features
- 🔍 **Browse Products** - View all available products with search functionality
- 📄 **Pagination** - Navigate through 200+ products with Previous/Next buttons
- 🔽 **Sortable Columns** - Click column headers to sort (▲ ascending, ▼ descending)
- 🛒 **Shopping Cart** - Add/remove items before placing order
- 💳 **Payment Methods** - Multiple payment method options
- 📝 **Order Confirmation** - Receive order ID and total after purchase

### 👑 Admin Features
- 📊 **Dashboard** - Real-time statistics (total orders, revenue, products, low stock)
- 📋 **Order Management** - View all orders with customer details
- ✅ **Order Status Updates** - Change status: pending → processing → shipped → delivered → cancelled
- ➕ **Add Products** - Add new products with category, price, and stock
- ✏️ **Manage Products** - View all products, update stock levels
- ❌ **Delete Products** - Remove products from catalog (with foreign key handling)
- 🔍 **Order Details** - Double-click orders to view items ordered

### 🗄️ Database Features
- 🔄 **Automatic Stock Updates** - Stock decreases when orders are placed
- 📝 **Audit Logging** - Track all cancelled orders in audit table
- ✅ **Stock Validation** - Prevents orders when stock is insufficient
- 💰 **Auto Total Calculation** - Order totals computed automatically
- 🔁 **Return Handling** - Stock restored when returns are approved

## 🛠️ Technologies Used

| Technology | Version | Purpose |
|------------|---------|---------|
| Java | 8+ | Core application logic |
| Swing | - | GUI framework |
| MariaDB | 10.5+ | Database (MySQL compatible) |
| JDBC | - | Database connectivity |
| Git | - | Version control |
| NetBeans | 12+ | IDE (recommended) |

## 📊 Database Schema

The database `ecommerce_db` contains the following tables:

| Table | Description |
|-------|-------------|
| `clienti` | Customer information (name, email, phone, address) |
| `produse` | Product catalog (name, description, price, category) |
| `categorii` | Product categories (supports parent-child hierarchy) |
| `comenzi` | Orders (customer, date, status, total, payment method) |
| `detalii_comanda` | Order details (products, quantities, unit prices) |
| `stocuri` | Stock/inventory levels per product |
| `metode_plata` | Payment methods (card, cash, PayPal, etc.) |
| `recenzii` | Product reviews and ratings |
| `retururi` | Return requests (reason, status) |
| `audit_comenzi_anulate` | Audit log for cancelled orders |

### Sample Data Counts
- Products: 332
- Categories: 59
- Orders: 42
- Stock entries: 400
- Customers: 120

## ⚡ Database Triggers

The system includes 5 automated triggers for business logic:

### 1. `verifica_stoc_inainte_comanda` (BEFORE INSERT on `detalii_comanda`)
```sql
-- Validates stock before allowing order
-- Throws error if insufficient stock
