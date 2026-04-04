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
import java.awt.*;
import java.sql.*;

public class OrderPanel extends JPanel {
    private JComboBox<String> customerCombo;
    private JComboBox<String> paymentCombo;
    private JList<String> productList;
    private DefaultListModel<String> cartModel;
    private JLabel totalLabel;
    private double currentTotal = 0;
    
    // Store product details separately
    private java.util.Map<String, ProductInfo> productMap = new java.util.HashMap<>();
    
    class ProductInfo {
        int id;
        String name;
        double price;
        int stock;
        
        ProductInfo(int id, String name, double price, int stock) {
            this.id = id;
            this.name = name;
            this.price = price;
            this.stock = stock;
        }
    }
    
    public OrderPanel() {
        setLayout(new BorderLayout());
        setBorder(BorderFactory.createTitledBorder("🛒 Place Order"));
        
        // Top panel - customer info
        JPanel topPanel = new JPanel(new GridLayout(2, 2, 10, 10));
        topPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        
        topPanel.add(new JLabel("Customer:"));
        customerCombo = new JComboBox<>();
        loadCustomers();
        topPanel.add(customerCombo);
        
        topPanel.add(new JLabel("Payment Method:"));
        paymentCombo = new JComboBox<>();
        loadPaymentMethods();
        topPanel.add(paymentCombo);
        
        add(topPanel, BorderLayout.NORTH);
        
        // Center - products and cart
        JPanel centerPanel = new JPanel(new GridLayout(1, 2, 10, 10));
        
        // Products list
        JPanel productsPanel = new JPanel(new BorderLayout());
        productsPanel.setBorder(BorderFactory.createTitledBorder("Available Products"));
        productList = new JList<>();
        productList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        loadProducts();
        JScrollPane productScroll = new JScrollPane(productList);
        productsPanel.add(productScroll, BorderLayout.CENTER);
        
        JButton addBtn = new JButton("➡ Add to Cart");
        addBtn.addActionListener(e -> addToCart());
        productsPanel.add(addBtn, BorderLayout.SOUTH);
        
        // Cart panel
        JPanel cartPanel = new JPanel(new BorderLayout());
        cartPanel.setBorder(BorderFactory.createTitledBorder("Shopping Cart"));
        cartModel = new DefaultListModel<>();
        JList<String> cartList = new JList<>(cartModel);
        JScrollPane cartScroll = new JScrollPane(cartList);
        cartPanel.add(cartScroll, BorderLayout.CENTER);
        
        JPanel cartButtons = new JPanel(new FlowLayout());
        JButton removeBtn = new JButton("❌ Remove");
        removeBtn.addActionListener(e -> {
            int index = cartList.getSelectedIndex();
            if (index >= 0) {
                String item = cartModel.get(index);
                // Extract price from the stored format
                String[] parts = item.split(" \\| ");
                if (parts.length >= 2) {
                    double price = Double.parseDouble(parts[1].replace(" RON", ""));
                    currentTotal -= price;
                    totalLabel.setText(String.format("Total: %.2f RON", currentTotal));
                }
                cartModel.remove(index);
            }
        });
        cartButtons.add(removeBtn);
        
        totalLabel = new JLabel("Total: 0.00 RON");
        totalLabel.setFont(new Font("Arial", Font.BOLD, 14));
        cartButtons.add(totalLabel);
        cartPanel.add(cartButtons, BorderLayout.SOUTH);
        
        centerPanel.add(productsPanel);
        centerPanel.add(cartPanel);
        add(centerPanel, BorderLayout.CENTER);
        
        // Bottom - place order button
        JButton placeOrderBtn = new JButton("✅ PLACE ORDER");
        placeOrderBtn.setFont(new Font("Arial", Font.BOLD, 14));
        placeOrderBtn.setBackground(new Color(50, 205, 50));
        placeOrderBtn.addActionListener(e -> placeOrder());
        
        JPanel bottomPanel = new JPanel();
        bottomPanel.add(placeOrderBtn);
        add(bottomPanel, BorderLayout.SOUTH);
    }
    
    private void loadCustomers() {
        try (Statement stmt = DatabaseConnection.getConnection().createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id_client, nume FROM clienti ORDER BY nume")) {
            while (rs.next()) {
                customerCombo.addItem(rs.getInt("id_client") + " - " + rs.getString("nume"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private void loadPaymentMethods() {
        try (Statement stmt = DatabaseConnection.getConnection().createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id_metoda, nume FROM metode_plata WHERE activ = 1")) {
            while (rs.next()) {
                paymentCombo.addItem(rs.getInt("id_metoda") + " - " + rs.getString("nume"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private void loadProducts() {
        productMap.clear();
        DefaultListModel<String> model = new DefaultListModel<>();
        
        String sql = "SELECT p.id_produs, p.nume, p.pret, s.cantitate " +
                     "FROM produse p JOIN stocuri s ON p.id_produs = s.id_produs " +
                     "WHERE s.cantitate > 0 AND p.activ = 1 " +
                     "ORDER BY p.nume LIMIT 50";
        
        try (Statement stmt = DatabaseConnection.getConnection().createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                int id = rs.getInt("id_produs");
                String name = rs.getString("nume");
                double price = rs.getDouble("pret");
                int stock = rs.getInt("cantitate");
                
                // Store product info
                productMap.put(id + "|" + name, new ProductInfo(id, name, price, stock));
                
                // Display in list
                model.addElement(id + "|" + name + " - " + String.format("%.2f", price) + " RON (" + stock + " in stock)");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        productList.setModel(model);
    }
    
    private void addToCart() {
        String selected = productList.getSelectedValue();
        if (selected != null) {
            try {
                // Parse the selected string correctly
                String[] parts = selected.split(" - ");
                if (parts.length >= 2) {
                    String productKey = parts[0];
                    String priceStockPart = parts[1];
                    
                    // Extract price (remove " RON (X in stock)")
                    String priceStr = priceStockPart.split(" RON")[0];
                    double price = Double.parseDouble(priceStr);
                    
                    cartModel.addElement(productKey + " | " + String.format("%.2f", price) + " RON");
                    currentTotal += price;
                    totalLabel.setText(String.format("Total: %.2f RON", currentTotal));
                }
            } catch (Exception e) {
                JOptionPane.showMessageDialog(this, "Error adding to cart: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
    
    private void placeOrder() {
        if (cartModel.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Cart is empty!");
            return;
        }
        
        String customer = (String) customerCombo.getSelectedItem();
        String payment = (String) paymentCombo.getSelectedItem();
        
        if (customer == null || payment == null) {
            JOptionPane.showMessageDialog(this, "Please select customer and payment method!");
            return;
        }
        
        int customerId = Integer.parseInt(customer.split(" - ")[0]);
        int paymentId = Integer.parseInt(payment.split(" - ")[0]);
        
        try {
            // Start transaction
            Connection conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Insert order
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO comenzi (id_client, status, total, id_metoda_plata) VALUES (?, 'pending', ?, ?)",
                Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, customerId);
            stmt.setDouble(2, currentTotal);
            stmt.setInt(3, paymentId);
            stmt.executeUpdate();
            
            ResultSet keys = stmt.getGeneratedKeys();
            keys.next();
            int orderId = keys.getInt(1);
            
            // Insert order details
            for (int i = 0; i < cartModel.size(); i++) {
                String item = cartModel.get(i);
                String[] parts = item.split(" \\| ");
                if (parts.length >= 2) {
                    String productKey = parts[0];
                    int productId = Integer.parseInt(productKey.split("\\|")[0]);
                    double price = Double.parseDouble(parts[1].replace(" RON", ""));
                    
                    stmt = conn.prepareStatement(
                        "INSERT INTO detalii_comanda (id_comanda, id_produs, cantitate, pret_unitar) VALUES (?, ?, 1, ?)");
                    stmt.setInt(1, orderId);
                    stmt.setInt(2, productId);
                    stmt.setDouble(3, price);
                    stmt.executeUpdate();
                }
            }
            
            conn.commit();
            conn.setAutoCommit(true);
            
            JOptionPane.showMessageDialog(this, 
                "✅ Order placed successfully!\nOrder ID: " + orderId + "\nTotal: " + String.format("%.2f", currentTotal) + " RON");
            
            // Clear cart
            cartModel.clear();
            currentTotal = 0;
            totalLabel.setText("Total: 0.00 RON");
            loadProducts(); // Refresh product list
            
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error placing order: " + e.getMessage());
            try {
                DatabaseConnection.getConnection().rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
