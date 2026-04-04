/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ecommerceapp;

/**
 *
 * @author desktop
 */
import javax.swing.*;
import javax.swing.table.*;
import java.awt.*;
import java.sql.*;
import java.awt.event.*;

public class AdminPanel extends JFrame {
    private JTabbedPane tabbedPane;
    private JTable ordersTable;
    private DefaultTableModel ordersModel;
    private JTable productsTable;
    private DefaultTableModel productsModel;
    private JComboBox<String> categoryCombo;
    private JTextField nameField, priceField, stockField, descField;
    
    public AdminPanel() {
        setTitle("👑 Admin Dashboard - E-Commerce Management");
        setSize(1200, 700);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        
        tabbedPane = new JTabbedPane();
        
        // Add tabs
        tabbedPane.addTab("📋 View Orders", createOrdersPanel());
        tabbedPane.addTab("➕ Add Product", createAddProductPanel());
        tabbedPane.addTab("✏️ Manage Products", createManageProductsPanel());
        tabbedPane.addTab("📊 Dashboard", createDashboardPanel());
        
        add(tabbedPane);
        
        // Refresh data when tab changes
        tabbedPane.addChangeListener(e -> {
            if (tabbedPane.getSelectedIndex() == 0) {
                loadOrders();
            } else if (tabbedPane.getSelectedIndex() == 1) {
                loadCategories();
            } else if (tabbedPane.getSelectedIndex() == 2) {
                loadProductsForManagement();
            } else if (tabbedPane.getSelectedIndex() == 3) {
                loadDashboardStats();
            }
        });
        
        // Load initial data
        loadOrders();
    }
    
    private JPanel createOrdersPanel() {
        JPanel panel = new JPanel(new BorderLayout());
        panel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        
        // Orders table
        String[] columns = {"Order ID", "Customer", "Date", "Status", "Total (RON)", "Payment Method", "Items"};
        ordersModel = new DefaultTableModel(columns, 0) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };
        ordersTable = new JTable(ordersModel);
        ordersTable.setRowHeight(25);
        ordersTable.getTableHeader().setFont(new Font("Arial", Font.BOLD, 12));
        
        // Add double-click to view order details
        ordersTable.addMouseListener(new MouseAdapter() {
            public void mouseClicked(MouseEvent e) {
                if (e.getClickCount() == 2) {
                    int row = ordersTable.getSelectedRow();
                    if (row >= 0) {
                        int orderId = (int) ordersModel.getValueAt(row, 0);
                        showOrderDetails(orderId);
                    }
                }
            }
        });
        
        JScrollPane scrollPane = new JScrollPane(ordersTable);
        panel.add(scrollPane, BorderLayout.CENTER);
        
        // Button panel
        JPanel buttonPanel = new JPanel();
        JButton refreshBtn = new JButton("🔄 Refresh");
        refreshBtn.addActionListener(e -> loadOrders());
        buttonPanel.add(refreshBtn);
        
        JButton updateStatusBtn = new JButton("📝 Update Status");
        updateStatusBtn.addActionListener(e -> updateOrderStatus());
        buttonPanel.add(updateStatusBtn);
        
        panel.add(buttonPanel, BorderLayout.SOUTH);
        
        return panel;
    }
    
    private JPanel createAddProductPanel() {
        JPanel panel = new JPanel(new GridBagLayout());
        panel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(10, 10, 10, 10);
        gbc.fill = GridBagConstraints.HORIZONTAL;
        
        // Category
        gbc.gridx = 0;
        gbc.gridy = 0;
        panel.add(new JLabel("Category:"), gbc);
        gbc.gridx = 1;
        categoryCombo = new JComboBox<>();
        categoryCombo.setPreferredSize(new Dimension(200, 25));
        panel.add(categoryCombo, gbc);
        
        // Product Name
        gbc.gridx = 0;
        gbc.gridy = 1;
        panel.add(new JLabel("Product Name:"), gbc);
        gbc.gridx = 1;
        nameField = new JTextField(20);
        panel.add(nameField, gbc);
        
        // Description
        gbc.gridx = 0;
        gbc.gridy = 2;
        panel.add(new JLabel("Description:"), gbc);
        gbc.gridx = 1;
        descField = new JTextField(20);
        panel.add(descField, gbc);
        
        // Price
        gbc.gridx = 0;
        gbc.gridy = 3;
        panel.add(new JLabel("Price (RON):"), gbc);
        gbc.gridx = 1;
        priceField = new JTextField(20);
        panel.add(priceField, gbc);
        
        // Stock
        gbc.gridx = 0;
        gbc.gridy = 4;
        panel.add(new JLabel("Initial Stock:"), gbc);
        gbc.gridx = 1;
        stockField = new JTextField(20);
        panel.add(stockField, gbc);
        
        // Buttons
        gbc.gridx = 0;
        gbc.gridy = 5;
        gbc.gridwidth = 2;
        JPanel buttonPanel = new JPanel();
        JButton addBtn = new JButton("✅ Add Product");
        addBtn.setFont(new Font("Arial", Font.BOLD, 14));
        addBtn.setBackground(new Color(50, 205, 50));
        addBtn.addActionListener(e -> addProduct());
        buttonPanel.add(addBtn);
        
        JButton clearBtn = new JButton("🗑️ Clear");
        clearBtn.addActionListener(e -> clearProductForm());
        buttonPanel.add(clearBtn);
        
        panel.add(buttonPanel, gbc);
        
        loadCategories();
        
        return panel;
    }
    
    private JPanel createManageProductsPanel() {
        JPanel panel = new JPanel(new BorderLayout());
        panel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        
        // Products table
        String[] columns = {"ID", "Product Name", "Category", "Price (RON)", "Stock", "Status"};
        productsModel = new DefaultTableModel(columns, 0) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };
        productsTable = new JTable(productsModel);
        productsTable.setRowHeight(25);
        productsTable.getTableHeader().setFont(new Font("Arial", Font.BOLD, 12));
        
        JScrollPane scrollPane = new JScrollPane(productsTable);
        panel.add(scrollPane, BorderLayout.CENTER);
        
        // Button panel
        JPanel buttonPanel = new JPanel();
        JButton refreshBtn = new JButton("🔄 Refresh");
        refreshBtn.addActionListener(e -> loadProductsForManagement());
        buttonPanel.add(refreshBtn);
        
        JButton deleteBtn = new JButton("❌ Delete Selected");
        deleteBtn.setBackground(new Color(255, 69, 58));
        deleteBtn.addActionListener(e -> deleteProduct());
        buttonPanel.add(deleteBtn);
        
        JButton updateStockBtn = new JButton("📦 Update Stock");
        updateStockBtn.addActionListener(e -> updateStock());
        buttonPanel.add(updateStockBtn);
        
        panel.add(buttonPanel, BorderLayout.SOUTH);
        
        return panel;
    }
    
    private JPanel createDashboardPanel() {
        JPanel panel = new JPanel(new GridLayout(2, 2, 20, 20));
        panel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        
        // Stats cards
        JPanel statsPanel = new JPanel(new GridLayout(2, 2, 15, 15));
        
        JPanel totalOrdersCard = createStatCard("Total Orders", "0", "📦");
        JPanel totalRevenueCard = createStatCard("Total Revenue", "0 RON", "💰");
        JPanel totalProductsCard = createStatCard("Total Products", "0", "📊");
        JPanel lowStockCard = createStatCard("Low Stock Items", "0", "⚠️");
        
        statsPanel.add(totalOrdersCard);
        statsPanel.add(totalRevenueCard);
        statsPanel.add(totalProductsCard);
        statsPanel.add(lowStockCard);
        
        panel.add(statsPanel);
        
        // Store references for updating
        panel.putClientProperty("totalOrdersCard", totalOrdersCard);
        panel.putClientProperty("totalRevenueCard", totalRevenueCard);
        panel.putClientProperty("totalProductsCard", totalProductsCard);
        panel.putClientProperty("lowStockCard", lowStockCard);
        
        return panel;
    }
    
    private JPanel createStatCard(String title, String value, String icon) {
        JPanel card = new JPanel(new BorderLayout());
        card.setBorder(BorderFactory.createCompoundBorder(
            BorderFactory.createLineBorder(new Color(200, 200, 200), 1),
            BorderFactory.createEmptyBorder(15, 15, 15, 15)
        ));
        card.setBackground(Color.WHITE);
        
        JLabel iconLabel = new JLabel(icon, SwingConstants.CENTER);
        iconLabel.setFont(new Font("Segoe UI", Font.PLAIN, 40));
        
        JLabel titleLabel = new JLabel(title, SwingConstants.CENTER);
        titleLabel.setFont(new Font("Arial", Font.PLAIN, 14));
        
        JLabel valueLabel = new JLabel(value, SwingConstants.CENTER);
        valueLabel.setFont(new Font("Arial", Font.BOLD, 24));
        valueLabel.setName(title + "_value");
        
        card.add(iconLabel, BorderLayout.NORTH);
        card.add(titleLabel, BorderLayout.CENTER);
        card.add(valueLabel, BorderLayout.SOUTH);
        
        return card;
    }
    
    private void loadOrders() {
        ordersModel.setRowCount(0);
        
        String sql = "SELECT o.id_comanda, c.nume, DATE(o.data_comanda), o.status, o.total, mp.nume, " +
                     "(SELECT COUNT(*) FROM detalii_comanda WHERE id_comanda = o.id_comanda) as items " +
                     "FROM comenzi o " +
                     "JOIN clienti c ON o.id_client = c.id_client " +
                     "JOIN metode_plata mp ON o.id_metoda_plata = mp.id_metoda " +
                     "ORDER BY o.id_comanda DESC";
        
        try (Statement stmt = DatabaseConnection.getConnection().createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Object[] row = {
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getDouble(5),
                    rs.getString(6),
                    rs.getInt(7)
                };
                ordersModel.addRow(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private void loadProductsForManagement() {
        productsModel.setRowCount(0);
        
        String sql = "SELECT p.id_produs, p.nume, c.nume as categorie, p.pret, s.cantitate, " +
                     "CASE WHEN p.activ = 1 THEN 'Active' ELSE 'Inactive' END as status " +
                     "FROM produse p " +
                     "JOIN categorii c ON p.id_categorie = c.id_categorie " +
                     "JOIN stocuri s ON p.id_produs = s.id_produs " +
                     "ORDER BY p.id_produs";
        
        try (Statement stmt = DatabaseConnection.getConnection().createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Object[] row = {
                    rs.getInt("id_produs"),
                    rs.getString("nume"),
                    rs.getString("categorie"),
                    rs.getDouble("pret"),
                    rs.getInt("cantitate"),
                    rs.getString("status")
                };
                productsModel.addRow(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private void loadCategories() {
        categoryCombo.removeAllItems();
        
        try (Statement stmt = DatabaseConnection.getConnection().createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id_categorie, nume FROM categorii ORDER BY nume")) {
            
            while (rs.next()) {
                categoryCombo.addItem(rs.getInt("id_categorie") + " - " + rs.getString("nume"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private void addProduct() {
        if (categoryCombo.getSelectedItem() == null || nameField.getText().trim().isEmpty()) {
            JOptionPane.showMessageDialog(this, "Please fill in category and product name!");
            return;
        }
        
        int categoryId = Integer.parseInt(categoryCombo.getSelectedItem().toString().split(" - ")[0]);
        String name = nameField.getText().trim();
        String desc = descField.getText().trim();
        
        double price;
        int stock;
        
        try {
            price = Double.parseDouble(priceField.getText().trim());
            stock = Integer.parseInt(stockField.getText().trim());
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(this, "Invalid price or stock value!");
            return;
        }
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Insert product
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO produse (nume, descriere, pret, id_categorie, activ) VALUES (?, ?, ?, ?, 1)",
                Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, name);
            stmt.setString(2, desc);
            stmt.setDouble(3, price);
            stmt.setInt(4, categoryId);
            stmt.executeUpdate();
            
            ResultSet keys = stmt.getGeneratedKeys();
            keys.next();
            int productId = keys.getInt(1);
            
            // Insert stock
            stmt = conn.prepareStatement("INSERT INTO stocuri (id_produs, cantitate) VALUES (?, ?)");
            stmt.setInt(1, productId);
            stmt.setInt(2, stock);
            stmt.executeUpdate();
            
            conn.commit();
            conn.setAutoCommit(true);
            
            JOptionPane.showMessageDialog(this, "✅ Product added successfully!\nProduct ID: " + productId);
            clearProductForm();
            loadProductsForManagement();
            
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error adding product: " + e.getMessage());
            try {
                DatabaseConnection.getConnection().rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
    
    private void deleteProduct() {
        int row = productsTable.getSelectedRow();
        if (row < 0) {
            JOptionPane.showMessageDialog(this, "Please select a product to delete!");
            return;
        }
        
        int productId = (int) productsModel.getValueAt(row, 0);
        String productName = (String) productsModel.getValueAt(row, 1);
        
        int confirm = JOptionPane.showConfirmDialog(this,
            "Are you sure you want to delete:\n" + productName + " (ID: " + productId + ")",
            "Confirm Delete",
            JOptionPane.YES_NO_OPTION);
        
        if (confirm == JOptionPane.YES_OPTION) {
            try {
                Connection conn = DatabaseConnection.getConnection();
                conn.setAutoCommit(false);
                
                // Delete from stocuri first (due to foreign key)
                PreparedStatement stmt = conn.prepareStatement("DELETE FROM stocuri WHERE id_produs = ?");
                stmt.setInt(1, productId);
                stmt.executeUpdate();
                
                // Delete from produse
                stmt = conn.prepareStatement("DELETE FROM produse WHERE id_produs = ?");
                stmt.setInt(1, productId);
                stmt.executeUpdate();
                
                conn.commit();
                conn.setAutoCommit(true);
                
                JOptionPane.showMessageDialog(this, "✅ Product deleted successfully!");
                loadProductsForManagement();
                loadDashboardStats();
                
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(this, "Error deleting product: " + e.getMessage());
                try {
                    DatabaseConnection.getConnection().rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
    
    private void updateStock() {
        int row = productsTable.getSelectedRow();
        if (row < 0) {
            JOptionPane.showMessageDialog(this, "Please select a product to update!");
            return;
        }
        
        int productId = (int) productsModel.getValueAt(row, 0);
        String productName = (String) productsModel.getValueAt(row, 1);
        int currentStock = (int) productsModel.getValueAt(row, 4);
        
        String newStockStr = JOptionPane.showInputDialog(this,
            "Product: " + productName + "\nCurrent stock: " + currentStock + "\n\nEnter new stock quantity:",
            "Update Stock",
            JOptionPane.QUESTION_MESSAGE);
        
        if (newStockStr != null && !newStockStr.trim().isEmpty()) {
            try {
                int newStock = Integer.parseInt(newStockStr);
                
                PreparedStatement stmt = DatabaseConnection.getConnection().prepareStatement(
                    "UPDATE stocuri SET cantitate = ?, ultima_actualizare = NOW() WHERE id_produs = ?");
                stmt.setInt(1, newStock);
                stmt.setInt(2, productId);
                stmt.executeUpdate();
                
                JOptionPane.showMessageDialog(this, "✅ Stock updated successfully!");
                loadProductsForManagement();
                loadDashboardStats();
                
            } catch (NumberFormatException e) {
                JOptionPane.showMessageDialog(this, "Invalid number!");
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(this, "Error updating stock: " + e.getMessage());
            }
        }
    }
    
    private void updateOrderStatus() {
        int row = ordersTable.getSelectedRow();
        if (row < 0) {
            JOptionPane.showMessageDialog(this, "Please select an order!");
            return;
        }
        
        int orderId = (int) ordersModel.getValueAt(row, 0);
        String currentStatus = (String) ordersModel.getValueAt(row, 3);
        
        String[] statuses = {"pending", "processing", "shipped", "delivered", "cancelled"};
        String newStatus = (String) JOptionPane.showInputDialog(this,
            "Order ID: " + orderId + "\nCurrent status: " + currentStatus + "\n\nSelect new status:",
            "Update Order Status",
            JOptionPane.QUESTION_MESSAGE,
            null,
            statuses,
            currentStatus);
        
        if (newStatus != null && !newStatus.equals(currentStatus)) {
            try {
                PreparedStatement stmt = DatabaseConnection.getConnection().prepareStatement(
                    "UPDATE comenzi SET status = ? WHERE id_comanda = ?");
                stmt.setString(1, newStatus);
                stmt.setInt(2, orderId);
                stmt.executeUpdate();
                
                JOptionPane.showMessageDialog(this, "✅ Order status updated!");
                loadOrders();
                loadDashboardStats();
                
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(this, "Error updating status: " + e.getMessage());
            }
        }
    }
    
    private void showOrderDetails(int orderId) {
        StringBuilder details = new StringBuilder();
        details.append("Order ID: ").append(orderId).append("\n");
        details.append("================================\n\n");
        details.append("Products:\n");
        
        try {
            PreparedStatement stmt = DatabaseConnection.getConnection().prepareStatement(
                "SELECT p.nume, dc.cantitate, dc.pret_unitar " +
                "FROM detalii_comanda dc " +
                "JOIN produse p ON dc.id_produs = p.id_produs " +
                "WHERE dc.id_comanda = ?");
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            double total = 0;
            while (rs.next()) {
                String name = rs.getString("nume");
                int qty = rs.getInt("cantitate");
                double price = rs.getDouble("pret_unitar");
                double subtotal = qty * price;
                total += subtotal;
                details.append("  • ").append(name)
                       .append(" x").append(qty)
                       .append(" = ").append(String.format("%.2f", subtotal)).append(" RON\n");
            }
            details.append("\n--------------------------------\n");
            details.append("TOTAL: ").append(String.format("%.2f", total)).append(" RON");
            
            JTextArea textArea = new JTextArea(details.toString());
            textArea.setEditable(false);
            textArea.setFont(new Font("Monospaced", Font.PLAIN, 12));
            JScrollPane scrollPane = new JScrollPane(textArea);
            scrollPane.setPreferredSize(new Dimension(400, 300));
            
            JOptionPane.showMessageDialog(this, scrollPane, "Order Details", JOptionPane.INFORMATION_MESSAGE);
            
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error loading details: " + e.getMessage());
        }
    }
    
    private void loadDashboardStats() {
        try {
            // Total Orders
            Statement stmt = DatabaseConnection.getConnection().createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM comenzi");
            rs.next();
            int totalOrders = rs.getInt(1);
            
            // Total Revenue
            rs = stmt.executeQuery("SELECT SUM(total) FROM comenzi WHERE status = 'delivered'");
            rs.next();
            double totalRevenue = rs.getDouble(1);
            
            // Total Products
            rs = stmt.executeQuery("SELECT COUNT(*) FROM produse WHERE activ = 1");
            rs.next();
            int totalProducts = rs.getInt(1);
            
            // Low Stock
            rs = stmt.executeQuery("SELECT COUNT(*) FROM stocuri WHERE cantitate < 10");
            rs.next();
            int lowStock = rs.getInt(1);
            
            // Update the dashboard panel
            Component dashboardPanel = tabbedPane.getComponentAt(3);
            if (dashboardPanel instanceof JPanel) {
                Component[] cards = ((JPanel) dashboardPanel).getComponents();
                if (cards.length > 0 && cards[0] instanceof JPanel) {
                    JPanel statsPanel = (JPanel) cards[0];
                    Component[] stats = statsPanel.getComponents();
                    if (stats.length >= 4) {
                        updateStatCard(stats[0], totalOrders + "");
                        updateStatCard(stats[1], totalRevenue + " RON");
                        updateStatCard(stats[2], totalProducts + "");
                        updateStatCard(stats[3], lowStock + "");
                    }
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private void updateStatCard(Component card, String value) {
        if (card instanceof JPanel) {
            JPanel cardPanel = (JPanel) card;
            Component[] components = cardPanel.getComponents();
            for (Component comp : components) {
                if (comp instanceof JLabel) {
                    JLabel label = (JLabel) comp;
                    if (label.getFont().getSize() == 24) { // Value label
                        label.setText(value);
                        break;
                    }
                }
            }
        }
    }
    
    private void clearProductForm() {
        nameField.setText("");
        descField.setText("");
        priceField.setText("");
        stockField.setText("");
        if (categoryCombo.getItemCount() > 0) {
            categoryCombo.setSelectedIndex(0);
        }
    }
}
