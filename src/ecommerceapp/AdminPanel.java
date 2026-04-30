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
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;

public class AdminPanel extends JFrame {
    private JTabbedPane tabbedPane;
    private JTable ordersTable;
    private DefaultTableModel ordersModel;
    private JTable productsTable;
    private DefaultTableModel productsModel;
    private JComboBox<String> categoryCombo;
    private JTextField nameField, priceField, stockField, descField;
    
    // Sorting variables for orders
    private String currentOrdersSortColumn = "o.id_comanda";
    private String currentOrdersSortOrder = "DESC";
    
    // Sorting variables for products
    private String currentProductsSortColumn = "p.id_produs";
    private String currentProductsSortOrder = "ASC";
    
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
        tabbedPane.addTab("📁 Manage Categories", createCategoryPanel());  // ← NEW TAB
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
                // Refresh category data when tab is selected
                Component comp = tabbedPane.getComponentAt(3);
                if (comp instanceof JPanel) {
                    // Refresh the category tree and table
                    refreshCategoryData();
                }
            } else if (tabbedPane.getSelectedIndex() == 4) {
                loadDashboardStats();
            }
        });
        
        // Load initial data
        loadOrders();
    }
    
    private JPanel createOrdersPanel() {
        JPanel panel = new JPanel(new BorderLayout());
        panel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        
        // Orders table with sortable columns
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
        
        // Add sorting to orders table header
        installOrderTableSorting();
        
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
    
    private void installOrderTableSorting() {
        JTableHeader header = ordersTable.getTableHeader();
        header.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                int column = ordersTable.columnAtPoint(e.getPoint());
                if (column >= 0) {
                    handleOrderSort(column);
                }
            }
        });
        
        // Custom renderer for header with sort indicators
        header.setDefaultRenderer(new SortableOrdersHeaderRenderer());
    }
    
    private void handleOrderSort(int columnIndex) {
        // Map column index to database field
        String[] columnFields = {
            "o.id_comanda",      // Order ID
            "c.nume",            // Customer
            "o.data_comanda",    // Date
            "o.status",          // Status
            "o.total",           // Total
            "mp.nume",           // Payment Method
            "items_count"        // Items (subquery)
        };
        
        String newSortColumn = columnFields[columnIndex];
        
        // If clicking the same column, toggle order
        if (currentOrdersSortColumn.equals(newSortColumn)) {
            currentOrdersSortOrder = currentOrdersSortOrder.equals("ASC") ? "DESC" : "ASC";
        } else {
            // New column, default to ascending
            currentOrdersSortColumn = newSortColumn;
            currentOrdersSortOrder = "ASC";
        }
        
        // Reload orders with new sorting
        loadOrders();
        
        // Repaint header to show arrow
        ordersTable.getTableHeader().repaint();
    }
    
    // Custom header renderer for orders table
    class SortableOrdersHeaderRenderer extends JLabel implements javax.swing.table.TableCellRenderer {
        private final String[] columnNames = {"Order ID", "Customer", "Date", "Status", "Total (RON)", "Payment Method", "Items"};
        private final String[] columnFields = {"o.id_comanda", "c.nume", "o.data_comanda", "o.status", "o.total", "mp.nume", "items_count"};
        
        public SortableOrdersHeaderRenderer() {
            setFont(new Font("Arial", Font.BOLD, 12));
            setOpaque(true);
            setBackground(UIManager.getColor("TableHeader.background"));
            setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(Color.LIGHT_GRAY, 1),
                BorderFactory.createEmptyBorder(5, 10, 5, 10)
            ));
            setHorizontalAlignment(SwingConstants.CENTER);
        }
        
        @Override
        public Component getTableCellRendererComponent(JTable table, Object value,
                                                       boolean isSelected, boolean hasFocus,
                                                       int row, int column) {
            setText(columnNames[column]);
            
            // Check if this column is currently sorted
            boolean isSorted = currentOrdersSortColumn.equals(columnFields[column]);
            
            if (isSorted) {
                String arrow = currentOrdersSortOrder.equals("ASC") ? " ▲" : " ▼";
                setText(getText() + arrow);
                setForeground(new Color(0, 102, 204));
            } else {
                setForeground(Color.BLACK);
            }
            
            return this;
        }
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
        
        // Products table with sortable columns
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
        
        // Add sorting to products table header
        installProductTableSorting();
        
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
    
    private void installProductTableSorting() {
        JTableHeader header = productsTable.getTableHeader();
        header.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                int column = productsTable.columnAtPoint(e.getPoint());
                if (column >= 0) {
                    handleProductSort(column);
                }
            }
        });
        
        // Custom renderer for header with sort indicators
        header.setDefaultRenderer(new SortableProductsHeaderRenderer());
    }
    
    private void handleProductSort(int columnIndex) {
        // Map column index to database field
        String[] columnFields = {
            "p.id_produs",    // ID
            "p.nume",         // Product Name
            "c.nume",         // Category
            "p.pret",         // Price
            "s.cantitate",    // Stock
            "p.activ"         // Status
        };
        
        String newSortColumn = columnFields[columnIndex];
        
        // If clicking the same column, toggle order
        if (currentProductsSortColumn.equals(newSortColumn)) {
            currentProductsSortOrder = currentProductsSortOrder.equals("ASC") ? "DESC" : "ASC";
        } else {
            // New column, default to ascending
            currentProductsSortColumn = newSortColumn;
            currentProductsSortOrder = "ASC";
        }
        
        // Reload products with new sorting
        loadProductsForManagement();
        
        // Repaint header to show arrow
        productsTable.getTableHeader().repaint();
    }
    
    // Custom header renderer for products table
    class SortableProductsHeaderRenderer extends JLabel implements javax.swing.table.TableCellRenderer {
        private final String[] columnNames = {"ID", "Product Name", "Category", "Price (RON)", "Stock", "Status"};
        private final String[] columnFields = {"p.id_produs", "p.nume", "c.nume", "p.pret", "s.cantitate", "p.activ"};
        
        public SortableProductsHeaderRenderer() {
            setFont(new Font("Arial", Font.BOLD, 12));
            setOpaque(true);
            setBackground(UIManager.getColor("TableHeader.background"));
            setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(Color.LIGHT_GRAY, 1),
                BorderFactory.createEmptyBorder(5, 10, 5, 10)
            ));
            setHorizontalAlignment(SwingConstants.CENTER);
        }
        
        @Override
        public Component getTableCellRendererComponent(JTable table, Object value,
                                                       boolean isSelected, boolean hasFocus,
                                                       int row, int column) {
            setText(columnNames[column]);
            
            // Check if this column is currently sorted
            boolean isSorted = currentProductsSortColumn.equals(columnFields[column]);
            
            if (isSorted) {
                String arrow = currentProductsSortOrder.equals("ASC") ? " ▲" : " ▼";
                setText(getText() + arrow);
                setForeground(new Color(0, 102, 204));
            } else {
                setForeground(Color.BLACK);
            }
            
            return this;
        }
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
    
    private JPanel createCategoryPanel() {
        JPanel panel = new JPanel(new BorderLayout());
        panel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        // Create split pane (left: tree view, right: form)
        JSplitPane splitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT);
        splitPane.setDividerLocation(350);

        // LEFT SIDE - Category Tree
        JPanel treePanel = new JPanel(new BorderLayout());
        treePanel.setBorder(BorderFactory.createTitledBorder("Category Hierarchy"));

        JTree categoryTree = new JTree();
        categoryTree.setRootVisible(true);
        categoryTree.setShowsRootHandles(true);
        JScrollPane treeScroll = new JScrollPane(categoryTree);
        treePanel.add(treeScroll, BorderLayout.CENTER);

        JButton refreshTreeBtn = new JButton("🔄 Refresh Tree");
        refreshTreeBtn.addActionListener(e -> loadCategoryTree(categoryTree));
        treePanel.add(refreshTreeBtn, BorderLayout.SOUTH);

        // RIGHT SIDE - Category Form
        JPanel formPanel = new JPanel(new GridBagLayout());
        formPanel.setBorder(BorderFactory.createTitledBorder("Category Details"));
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(10, 10, 10, 10);
        gbc.fill = GridBagConstraints.HORIZONTAL;

        // Category ID (read-only)
        gbc.gridx = 0;
        gbc.gridy = 0;
        formPanel.add(new JLabel("Category ID:"), gbc);
        gbc.gridx = 1;
        JTextField idField = new JTextField(20);
        idField.setEditable(false);
        idField.setBackground(Color.LIGHT_GRAY);
        formPanel.add(idField, gbc);

        // Category Name
        gbc.gridx = 0;
        gbc.gridy = 1;
        formPanel.add(new JLabel("Category Name:*"), gbc);
        gbc.gridx = 1;
        JTextField catNameField = new JTextField(20);
        formPanel.add(catNameField, gbc);

        // Parent Category
        gbc.gridx = 0;
        gbc.gridy = 2;
        formPanel.add(new JLabel("Parent Category:"), gbc);
        gbc.gridx = 1;
        JComboBox<String> parentCombo = new JComboBox<>();
        parentCombo.addItem("None (Top Level)");
        formPanel.add(parentCombo, gbc);

        // Description
        gbc.gridx = 0;
        gbc.gridy = 3;
        formPanel.add(new JLabel("Description:"), gbc);
        gbc.gridx = 1;
        JTextArea descArea = new JTextArea(5, 20);
        descArea.setLineWrap(true);
        descArea.setWrapStyleWord(true);
        JScrollPane descScroll = new JScrollPane(descArea);
        formPanel.add(descScroll, gbc);

        // Buttons
        gbc.gridx = 0;
        gbc.gridy = 4;
        gbc.gridwidth = 2;
        JPanel buttonPanel = new JPanel(new FlowLayout());

        JButton addBtn = new JButton("➕ Add New");
        addBtn.setBackground(new Color(50, 205, 50));
        addBtn.addActionListener(e -> {
            clearCategoryForm(idField, catNameField, parentCombo, descArea);
            idField.setText("New Category");
        });

        JButton saveBtn = new JButton("💾 Save");
        saveBtn.setBackground(new Color(70, 130, 200));
        saveBtn.addActionListener(e -> saveCategory(idField, catNameField, parentCombo, descArea, categoryTree));

        JButton updateBtn = new JButton("✏️ Update");
        updateBtn.setBackground(new Color(255, 165, 0));
        updateBtn.addActionListener(e -> updateCategory(idField, catNameField, parentCombo, descArea, categoryTree));

        JButton deleteBtn = new JButton("🗑️ Delete");
        deleteBtn.setBackground(new Color(255, 69, 58));
        deleteBtn.addActionListener(e -> deleteCategory(idField, catNameField, parentCombo, descArea, categoryTree));

        JButton clearBtn = new JButton("🗑️ Clear Form");
        clearBtn.addActionListener(e -> clearCategoryForm(idField, catNameField, parentCombo, descArea));

        buttonPanel.add(addBtn);
        buttonPanel.add(saveBtn);
        buttonPanel.add(updateBtn);
        buttonPanel.add(deleteBtn);
        buttonPanel.add(clearBtn);
        formPanel.add(buttonPanel, gbc);

        // Category table view (alternative to tree)
        JPanel bottomPanel = new JPanel(new BorderLayout());
        bottomPanel.setBorder(BorderFactory.createTitledBorder("All Categories (Table View)"));

        String[] columns = {"ID", "Category Name", "Parent", "Description", "Subcategories"};
        DefaultTableModel tableModel = new DefaultTableModel(columns, 0) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };
        JTable categoryTable = new JTable(tableModel);
        categoryTable.setRowHeight(25);
        categoryTable.getTableHeader().setFont(new Font("Arial", Font.BOLD, 12));

        // Load categories into table
        loadCategoryTable(tableModel);

        // Double-click to edit
        categoryTable.addMouseListener(new MouseAdapter() {
            public void mouseClicked(MouseEvent e) {
                if (e.getClickCount() == 2) {
                    int row = categoryTable.getSelectedRow();
                    if (row >= 0) {
                        int catId = (int) tableModel.getValueAt(row, 0);
                        loadCategoryToForm(catId, idField, catNameField, parentCombo, descArea);
                        loadCategoryTree(categoryTree);
                    }
                }
            }
        });

        JScrollPane tableScroll = new JScrollPane(categoryTable);
        bottomPanel.add(tableScroll, BorderLayout.CENTER);

        JButton refreshTableBtn = new JButton("🔄 Refresh Table");
        refreshTableBtn.addActionListener(e -> loadCategoryTable(tableModel));
        bottomPanel.add(refreshTableBtn, BorderLayout.SOUTH);

        // Combine split pane and bottom panel
        JPanel rightPanel = new JPanel(new BorderLayout());
        rightPanel.add(formPanel, BorderLayout.NORTH);
        rightPanel.add(bottomPanel, BorderLayout.CENTER);

        splitPane.setLeftComponent(treePanel);
        splitPane.setRightComponent(rightPanel);

        panel.add(splitPane, BorderLayout.CENTER);
        
        // Store references for refresh
        panel.putClientProperty("categoryTree", categoryTree);
        panel.putClientProperty("parentCombo", parentCombo);
        panel.putClientProperty("tableModel", tableModel);
        panel.putClientProperty("idField", idField);
        panel.putClientProperty("catNameField", catNameField);
        panel.putClientProperty("descArea", descArea);

        // Load initial data
        loadCategoryTree(categoryTree);
        loadParentCategories(parentCombo);
        loadCategoryTable(tableModel);

        // Add selection listener to tree
        categoryTree.addTreeSelectionListener(e -> {
            DefaultMutableTreeNode node = (DefaultMutableTreeNode) categoryTree.getLastSelectedPathComponent();
            if (node != null && node.getUserObject() instanceof CategoryNode) {
                CategoryNode catNode = (CategoryNode) node.getUserObject();
                loadCategoryToForm(catNode.id, idField, catNameField, parentCombo, descArea);
            }
        });

        return panel;
    }
    
    private void refreshCategoryData() {
        // This method will be called when the category tab is selected
        // Find the category panel and refresh its components
        Component categoryPanel = tabbedPane.getComponentAt(3);
        if (categoryPanel instanceof JPanel) {
            JPanel panel = (JPanel) categoryPanel;
            JTree tree = (JTree) panel.getClientProperty("categoryTree");
            JComboBox<String> parentCombo = (JComboBox<String>) panel.getClientProperty("parentCombo");
            DefaultTableModel tableModel = (DefaultTableModel) panel.getClientProperty("tableModel");
            
            if (tree != null) loadCategoryTree(tree);
            if (parentCombo != null) loadParentCategories(parentCombo);
            if (tableModel != null) loadCategoryTable(tableModel);
        }
    }
    
    private void loadCategoryTree(JTree tree) {
        DefaultMutableTreeNode root = new DefaultMutableTreeNode("All Categories");

        String sql = "SELECT id_categorie, nume, id_categorie_parinte FROM categorii ORDER BY id_categorie_parinte, nume";

        try (Statement stmt = DatabaseConnection.getConnection().createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            java.util.Map<Integer, DefaultMutableTreeNode> nodeMap = new java.util.HashMap<>();

            while (rs.next()) {
                int id = rs.getInt("id_categorie");
                String name = rs.getString("nume");
                int parentId = rs.getInt("id_categorie_parinte");

                CategoryNode catNode = new CategoryNode(id, name);
                DefaultMutableTreeNode treeNode = new DefaultMutableTreeNode(catNode);
                nodeMap.put(id, treeNode);

                if (parentId == 0 || rs.wasNull()) {
                    root.add(treeNode);
                } else {
                    DefaultMutableTreeNode parentNode = nodeMap.get(parentId);
                    if (parentNode != null) {
                        parentNode.add(treeNode);
                    } else {
                        root.add(treeNode);
                    }
                }
            }

            DefaultTreeModel model = new DefaultTreeModel(root);
            tree.setModel(model);

            // Expand all nodes
            for (int i = 0; i < tree.getRowCount(); i++) {
                tree.expandRow(i);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading category tree: " + e.getMessage());
        }
    }

    private void loadParentCategories(JComboBox<String> parentCombo) {
        parentCombo.removeAllItems();
        parentCombo.addItem("None (Top Level)");

        String sql = "SELECT id_categorie, nume FROM categorii ORDER BY nume";

        try (Statement stmt = DatabaseConnection.getConnection().createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                parentCombo.addItem(rs.getInt("id_categorie") + " - " + rs.getString("nume"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void loadCategoryTable(DefaultTableModel model) {
        model.setRowCount(0);

        String sql = "SELECT c1.id_categorie, c1.nume, c2.nume as parent, c1.descriere, " +
                     "(SELECT COUNT(*) FROM categorii WHERE id_categorie_parinte = c1.id_categorie) as subcount " +
                     "FROM categorii c1 " +
                     "LEFT JOIN categorii c2 ON c1.id_categorie_parinte = c2.id_categorie " +
                     "ORDER BY c1.id_categorie";

        try (Statement stmt = DatabaseConnection.getConnection().createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Object[] row = {
                    rs.getInt("id_categorie"),
                    rs.getString("nume"),
                    rs.getString("parent") == null ? "(Top Level)" : rs.getString("parent"),
                    rs.getString("descriere") == null ? "" : rs.getString("descriere"),
                    rs.getInt("subcount")
                };
                model.addRow(row);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void saveCategory(JTextField idField, JTextField nameField, JComboBox<String> parentCombo, 
                              JTextArea descArea, JTree tree) {
        String name = nameField.getText().trim();

        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Category name is required!");
            return;
        }

        int parentId = 0;
        String parentSelected = (String) parentCombo.getSelectedItem();
        if (parentSelected != null && !parentSelected.equals("None (Top Level)")) {
            parentId = Integer.parseInt(parentSelected.split(" - ")[0]);
        }

        String description = descArea.getText().trim();

        try {
            PreparedStatement stmt = DatabaseConnection.getConnection().prepareStatement(
                "INSERT INTO categorii (nume, id_categorie_parinte, descriere) VALUES (?, ?, ?)");
            stmt.setString(1, name);
            if (parentId == 0) {
                stmt.setNull(2, java.sql.Types.INTEGER);
            } else {
                stmt.setInt(2, parentId);
            }
            stmt.setString(3, description);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                JOptionPane.showMessageDialog(this, "✅ Category added successfully!");
                clearCategoryForm(idField, nameField, parentCombo, descArea);
                loadCategoryTree(tree);
                loadParentCategories(parentCombo);
                // Refresh the table view
                refreshCategoryData();
            }

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error saving category: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void updateCategory(JTextField idField, JTextField nameField, JComboBox<String> parentCombo,
                               JTextArea descArea, JTree tree) {
        String idText = idField.getText().trim();

        if (idText.isEmpty() || idText.equals("New Category")) {
            JOptionPane.showMessageDialog(this, "Please select a category to update!");
            return;
        }

        int categoryId = Integer.parseInt(idText);
        String name = nameField.getText().trim();

        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Category name is required!");
            return;
        }

        int parentId = 0;
        String parentSelected = (String) parentCombo.getSelectedItem();
        if (parentSelected != null && !parentSelected.equals("None (Top Level)")) {
            parentId = Integer.parseInt(parentSelected.split(" - ")[0]);
        }

        // Prevent circular reference (cannot set parent to itself)
        if (parentId == categoryId) {
            JOptionPane.showMessageDialog(this, "Cannot set a category as its own parent!");
            return;
        }

        String description = descArea.getText().trim();

        try {
            PreparedStatement stmt = DatabaseConnection.getConnection().prepareStatement(
                "UPDATE categorii SET nume = ?, id_categorie_parinte = ?, descriere = ? WHERE id_categorie = ?");
            stmt.setString(1, name);
            if (parentId == 0) {
                stmt.setNull(2, java.sql.Types.INTEGER);
            } else {
                stmt.setInt(2, parentId);
            }
            stmt.setString(3, description);
            stmt.setInt(4, categoryId);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                JOptionPane.showMessageDialog(this, "✅ Category updated successfully!");
                loadCategoryTree(tree);
                loadParentCategories(parentCombo);
                refreshCategoryData();
            }

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error updating category: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void deleteCategory(JTextField idField, JTextField nameField, JComboBox<String> parentCombo,
                               JTextArea descArea, JTree tree) {
        String idText = idField.getText().trim();

        if (idText.isEmpty() || idText.equals("New Category")) {
            JOptionPane.showMessageDialog(this, "Please select a category to delete!");
            return;
        }

        int categoryId = Integer.parseInt(idText);
        String categoryName = nameField.getText().trim();

        // Check if category has products
        try {
            PreparedStatement checkStmt = DatabaseConnection.getConnection().prepareStatement(
                "SELECT COUNT(*) FROM produse WHERE id_categorie = ?");
            checkStmt.setInt(1, categoryId);
            ResultSet rs = checkStmt.executeQuery();
            rs.next();
            int productCount = rs.getInt(1);

            if (productCount > 0) {
                JOptionPane.showMessageDialog(this, 
                    "Cannot delete category with " + productCount + " products!\nMove or delete products first.",
                    "Category Has Products",
                    JOptionPane.WARNING_MESSAGE);
                return;
            }

            // Check if category has subcategories
            checkStmt = DatabaseConnection.getConnection().prepareStatement(
                "SELECT COUNT(*) FROM categorii WHERE id_categorie_parinte = ?");
            checkStmt.setInt(1, categoryId);
            rs = checkStmt.executeQuery();
            rs.next();
            int subCount = rs.getInt(1);

            if (subCount > 0) {
                JOptionPane.showMessageDialog(this,
                    "Cannot delete category with " + subCount + " subcategories!\nDelete or reassign subcategories first.",
                    "Category Has Subcategories",
                    JOptionPane.WARNING_MESSAGE);
                return;
            }

            int confirm = JOptionPane.showConfirmDialog(this,
                "Delete category: " + categoryName + " (ID: " + categoryId + ")?\nThis action cannot be undone.",
                "Confirm Delete",
                JOptionPane.YES_NO_OPTION,
                JOptionPane.WARNING_MESSAGE);

            if (confirm == JOptionPane.YES_OPTION) {
                PreparedStatement deleteStmt = DatabaseConnection.getConnection().prepareStatement(
                    "DELETE FROM categorii WHERE id_categorie = ?");
                deleteStmt.setInt(1, categoryId);
                deleteStmt.executeUpdate();

                JOptionPane.showMessageDialog(this, "✅ Category deleted successfully!");
                clearCategoryForm(idField, nameField, parentCombo, descArea);
                loadCategoryTree(tree);
                loadParentCategories(parentCombo);
                refreshCategoryData();
            }

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error deleting category: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void loadCategoryToForm(int categoryId, JTextField idField, JTextField nameField,
                                    JComboBox<String> parentCombo, JTextArea descArea) {
        String sql = "SELECT nume, id_categorie_parinte, descriere FROM categorii WHERE id_categorie = ?";

        try (PreparedStatement stmt = DatabaseConnection.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                idField.setText(String.valueOf(categoryId));
                nameField.setText(rs.getString("nume"));
                descArea.setText(rs.getString("descriere") == null ? "" : rs.getString("descriere"));

                int parentId = rs.getInt("id_categorie_parinte");
                if (rs.wasNull() || parentId == 0) {
                    parentCombo.setSelectedItem("None (Top Level)");
                } else {
                    // Find and select parent in combo box
                    for (int i = 0; i < parentCombo.getItemCount(); i++) {
                        String item = parentCombo.getItemAt(i);
                        if (item.startsWith(parentId + " - ")) {
                            parentCombo.setSelectedIndex(i);
                            break;
                        }
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void clearCategoryForm(JTextField idField, JTextField nameField, JComboBox<String> parentCombo,
                                   JTextArea descArea) {
        idField.setText("");
        nameField.setText("");
        descArea.setText("");
        parentCombo.setSelectedIndex(0);
    }

    // Helper class for tree nodes
    class CategoryNode {
        int id;
        String name;

        CategoryNode(int id, String name) {
            this.id = id;
            this.name = name;
        }

        public String toString() {
            return name;
        }
    }
    
    private void loadOrders() {
        ordersModel.setRowCount(0);
        
        String sql = "SELECT o.id_comanda, c.nume, DATE(o.data_comanda) as order_date, o.status, o.total, mp.nume as payment_method, " +
                     "(SELECT COUNT(*) FROM detalii_comanda WHERE id_comanda = o.id_comanda) as items_count " +
                     "FROM comenzi o " +
                     "JOIN clienti c ON o.id_client = c.id_client " +
                     "JOIN metode_plata mp ON o.id_metoda_plata = mp.id_metoda " +
                     "ORDER BY " + currentOrdersSortColumn + " " + currentOrdersSortOrder;
        
        try (Statement stmt = DatabaseConnection.getConnection().createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Object[] row = {
                    rs.getInt("id_comanda"),
                    rs.getString("nume"),
                    rs.getString("order_date"),
                    rs.getString("status"),
                    rs.getDouble("total"),
                    rs.getString("payment_method"),
                    rs.getInt("items_count")
                };
                ordersModel.addRow(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading orders: " + e.getMessage());
        }
    }
    
    private void loadProductsForManagement() {
        productsModel.setRowCount(0);
        
        String sql = "SELECT p.id_produs, p.nume, c.nume as categorie, p.pret, s.cantitate, " +
                     "CASE WHEN p.activ = 1 THEN 'Active' ELSE 'Inactive' END as status " +
                     "FROM produse p " +
                     "JOIN categorii c ON p.id_categorie = c.id_categorie " +
                     "JOIN stocuri s ON p.id_produs = s.id_produs " +
                     "ORDER BY " + currentProductsSortColumn + " " + currentProductsSortOrder;
        
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
            JOptionPane.showMessageDialog(this, "Error loading products: " + e.getMessage());
        }
    }
    
    private void loadCategories() {
        categoryCombo.removeAllItems();

        try (Statement stmt = DatabaseConnection.getConnection().createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id_categorie, nume FROM categorii ORDER BY nume")) {

            while (rs.next()) {
                categoryCombo.addItem(rs.getInt("id_categorie") + " - " + rs.getString("nume"));
            }

            // Add a refresh method call
            if (categoryCombo.getItemCount() == 0) {
                categoryCombo.addItem("No categories - add some in Admin");
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
            loadDashboardStats();
            
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
            Component dashboardPanel = tabbedPane.getComponentAt(4);
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