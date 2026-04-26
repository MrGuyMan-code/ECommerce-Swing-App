/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ecommerceapp;

import javax.swing.*;
import javax.swing.table.*;
import java.awt.*;
import java.sql.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

/**
 *
 * @author desktop
 */
public class ProductPanel extends JPanel {
    private JTable productTable;
    private DefaultTableModel tableModel;
    private JTextField searchField;
    
    // Pagination variables
    private int currentPage = 0;
    private int pageSize = 200;
    private int totalProducts = 0;
    private int totalPages = 0;
    
    // Sorting variables
    private String currentSortColumn = "p.id_produs";  // Default sort column
    private String currentSortOrder = "ASC";           // Default sort order
    private String currentSearch = "";                 // Store current search term
    
    // Column to database field mapping
    private final String[] columnFields = {
        "p.id_produs",    // ID
        "p.nume",         // Product Name
        "c.nume",         // Category
        "p.pret",         // Price
        "s.cantitate"     // Stock
    };
    
    // UI components for pagination
    private JLabel pageInfoLabel;
    private JButton prevButton;
    private JButton nextButton;
    private JComboBox<Integer> pageSizeCombo;
    
    public ProductPanel() {
        setLayout(new BorderLayout());
        setBorder(BorderFactory.createTitledBorder("📦 Products"));
        
        // Search panel (top)
        JPanel searchPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        searchPanel.add(new JLabel("Search:"));
        searchField = new JTextField(20);
        searchPanel.add(searchField);
        JButton searchBtn = new JButton("🔍 Search");
        searchBtn.addActionListener(e -> {
            currentPage = 0;
            currentSearch = searchField.getText();
            loadProducts();
        });
        searchPanel.add(searchBtn);
        JButton refreshBtn = new JButton("🔄 Refresh");
        refreshBtn.addActionListener(e -> {
            currentPage = 0;
            currentSearch = "";
            currentSortColumn = "p.id_produs";
            currentSortOrder = "ASC";
            searchField.setText("");
            loadProducts();
        });
        searchPanel.add(refreshBtn);
        
        add(searchPanel, BorderLayout.NORTH);
        
        // Table with sortable headers
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
        
        // Add sorting indicator renderer
        productTable.getTableHeader().setDefaultRenderer(new SortableHeaderRenderer());
        
        // Add click listener to column headers
        productTable.getTableHeader().addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                int column = productTable.columnAtPoint(e.getPoint());
                if (column >= 0 && column < columnFields.length) {
                    handleSort(column);
                }
            }
        });
        
        JScrollPane scrollPane = new JScrollPane(productTable);
        add(scrollPane, BorderLayout.CENTER);
        
        // Pagination panel (bottom)
        JPanel paginationPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 10, 10));
        paginationPanel.setBorder(BorderFactory.createEmptyBorder(10, 0, 10, 0));
        
        prevButton = new JButton("◀ Previous");
        prevButton.addActionListener(e -> {
            if (currentPage > 0) {
                currentPage--;
                loadProducts();
            }
        });
        paginationPanel.add(prevButton);
        
        pageInfoLabel = new JLabel("Page 0 of 0");
        pageInfoLabel.setFont(new Font("Arial", Font.BOLD, 12));
        paginationPanel.add(pageInfoLabel);
        
        nextButton = new JButton("Next ▶");
        nextButton.addActionListener(e -> {
            if (currentPage + 1 < totalPages) {
                currentPage++;
                loadProducts();
            }
        });
        paginationPanel.add(nextButton);
        
        paginationPanel.add(new JLabel("  |  Items per page:"));
        pageSizeCombo = new JComboBox<>(new Integer[]{50, 100, 200, 300, 500});
        pageSizeCombo.setSelectedItem(pageSize);
        pageSizeCombo.addActionListener(e -> {
            pageSize = (Integer) pageSizeCombo.getSelectedItem();
            currentPage = 0;
            loadProducts();
        });
        paginationPanel.add(pageSizeCombo);
        
        add(paginationPanel, BorderLayout.SOUTH);
        
        // Load initial products
        loadProducts();
    }
    
    private void handleSort(int columnIndex) {
        String newSortColumn = columnFields[columnIndex];
        
        // If clicking the same column, toggle order
        if (currentSortColumn.equals(newSortColumn)) {
            currentSortOrder = currentSortOrder.equals("ASC") ? "DESC" : "ASC";
        } else {
            // New column, default to ascending
            currentSortColumn = newSortColumn;
            currentSortOrder = "ASC";
        }
        
        // Reset to first page when sorting
        currentPage = 0;
        
        // Reload products with new sorting
        loadProducts();
        
        // Visual feedback - repaint header to show arrow
        productTable.getTableHeader().repaint();
    }
    
    private void loadProducts() {
        // Clear table
        tableModel.setRowCount(0);
        
        // Build the WHERE clause
        String whereClause = "WHERE p.activ = 1";
        if (!currentSearch.isEmpty()) {
            whereClause += " AND p.nume LIKE ?";
        }
        
        // Count query for pagination
        String countSql = "SELECT COUNT(*) as total FROM produse p " +
                          "JOIN stocuri s ON p.id_produs = s.id_produs " +
                          whereClause;
        
        try (PreparedStatement countStmt = DatabaseConnection.getConnection().prepareStatement(countSql)) {
            if (!currentSearch.isEmpty()) {
                countStmt.setString(1, "%" + currentSearch + "%");
            }
            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalProducts = countRs.getInt("total");
                totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error counting products: " + e.getMessage());
            e.printStackTrace();
            return;
        }
        
        // Update pagination UI
        int offset = currentPage * pageSize;
        pageInfoLabel.setText(String.format("Page %d of %d (Total: %d products)", 
                             currentPage + 1, Math.max(1, totalPages), totalProducts));
        
        prevButton.setEnabled(currentPage > 0);
        nextButton.setEnabled(currentPage + 1 < totalPages);
        
        // Handle empty result set
        if (totalProducts == 0) {
            tableModel.addRow(new Object[]{"", "No products found", "", "", ""});
            return;
        }
        
        // Data query with dynamic sorting
        String dataSql = "SELECT p.id_produs, p.nume, c.nume as categorie, p.pret, s.cantitate " +
                         "FROM produse p " +
                         "JOIN categorii c ON p.id_categorie = c.id_categorie " +
                         "JOIN stocuri s ON p.id_produs = s.id_produs " +
                         whereClause +
                         " ORDER BY " + currentSortColumn + " " + currentSortOrder + ", p.id_produs " + currentSortOrder +
                         " LIMIT ? OFFSET ?";
        
        try (PreparedStatement stmt = DatabaseConnection.getConnection().prepareStatement(dataSql)) {
            int paramIndex = 1;
            
            if (!currentSearch.isEmpty()) {
                stmt.setString(paramIndex++, "%" + currentSearch + "%");
            }
            stmt.setInt(paramIndex++, pageSize);
            stmt.setInt(paramIndex, offset);
            
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
    
    // Custom header renderer to show sorting arrows
    class SortableHeaderRenderer extends JLabel implements javax.swing.table.TableCellRenderer {
        
        public SortableHeaderRenderer() {
            setFont(new Font("Arial", Font.BOLD, 12));
            setOpaque(true);
            setBackground(UIManager.getColor("TableHeader.background"));
            setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(Color.LIGHT_GRAY, 1),
                BorderFactory.createEmptyBorder(5, 10, 5, 10)
            ));
        }
        
        @Override
        public Component getTableCellRendererComponent(JTable table, Object value,
                                                       boolean isSelected, boolean hasFocus,
                                                       int row, int column) {
            setText(value != null ? value.toString() : "");
            
            // Get the column name to check if this column is sorted
            String columnName = table.getColumnName(column);
            String sortedColumnName = "";
            
            // Map column index to display name for comparison
            switch(column) {
                case 0: sortedColumnName = "ID"; break;
                case 1: sortedColumnName = "Product Name"; break;
                case 2: sortedColumnName = "Category"; break;
                case 3: sortedColumnName = "Price (RON)"; break;
                case 4: sortedColumnName = "Stock"; break;
            }
            
            // Check if this column is currently sorted
            boolean isThisColumnSorted = false;
            String displayText = getText();
            
            if (column == 0 && currentSortColumn.equals("p.id_produs")) isThisColumnSorted = true;
            if (column == 1 && currentSortColumn.equals("p.nume")) isThisColumnSorted = true;
            if (column == 2 && currentSortColumn.equals("c.nume")) isThisColumnSorted = true;
            if (column == 3 && currentSortColumn.equals("p.pret")) isThisColumnSorted = true;
            if (column == 4 && currentSortColumn.equals("s.cantitate")) isThisColumnSorted = true;
            
            if (isThisColumnSorted) {
                // Add arrow indicator
                String arrow = currentSortOrder.equals("ASC") ? " ▲" : " ▼";
                setText(getText() + arrow);
                setForeground(new Color(0, 102, 204)); // Blue color for sorted column
                setFont(new Font("Arial", Font.BOLD, 12));
            } else {
                setForeground(Color.BLACK);
            }
            
            // Center align the text
            setHorizontalAlignment(SwingConstants.CENTER);
            
            return this;
        }
    }
}