/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ecommerceapp;

import javax.swing.*;
import javax.swing.table.*;
import java.awt.*;
import java.sql.*;


/**
 *
 * @author desktop
 */
public class ProductPanel extends JPanel {
       private JTable productTable;
    private DefaultTableModel tableModel;
    private JTextField searchField;
    
    public ProductPanel() {
        setLayout(new BorderLayout());
        setBorder(BorderFactory.createTitledBorder("📦 Products"));
        
        // Search panel
        JPanel searchPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        searchPanel.add(new JLabel("Search:"));
        searchField = new JTextField(20);
        searchPanel.add(searchField);
        JButton searchBtn = new JButton("🔍 Search");
        searchBtn.addActionListener(e -> loadProducts(searchField.getText()));
        searchPanel.add(searchBtn);
        JButton refreshBtn = new JButton("🔄 Refresh");
        refreshBtn.addActionListener(e -> loadProducts(""));
        searchPanel.add(refreshBtn);
        
        add(searchPanel, BorderLayout.NORTH);
        
        // Table
        String[] columns = {"ID", "Product Name", "Category", "Price (RON)", "Stock"};
        tableModel = new DefaultTableModel(columns, 0) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };
        productTable = new JTable(tableModel);
        productTable.setRowHeight(25);
        productTable.getTableHeader().setFont(new Font("Arial", Font.BOLD, 12));
        
        JScrollPane scrollPane = new JScrollPane(productTable);
        add(scrollPane, BorderLayout.CENTER);
        
        // Load products
        loadProducts("");
    }
    
    private void loadProducts(String search) {
        tableModel.setRowCount(0);
        
        String sql = "SELECT p.id_produs, p.nume, c.nume as categorie, p.pret, s.cantitate " +
                     "FROM produse p " +
                     "JOIN categorii c ON p.id_categorie = c.id_categorie " +
                     "JOIN stocuri s ON p.id_produs = s.id_produs " +
                     "WHERE p.activ = 1 " +
                     (search.isEmpty() ? "" : "AND p.nume LIKE ?") +
                     " ORDER BY p.nume LIMIT 50";
        
        try (PreparedStatement stmt = DatabaseConnection.getConnection().prepareStatement(sql)) {
            if (!search.isEmpty()) {
                stmt.setString(1, "%" + search + "%");
            }
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Object[] row = {
                    rs.getInt("id_produs"),
                    rs.getString("nume"),
                    rs.getString("categorie"),
                    rs.getDouble("pret"),
                    rs.getInt("cantitate")
                };
                tableModel.addRow(row);
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error loading products: " + e.getMessage());
            e.printStackTrace();
        }
    } 
}
