/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package ecommerceapp;

/**
 *
 * @author desktop
 */
import javax.swing.*;
import java.awt.*;

public class MainFrame extends JFrame {
    private JTabbedPane tabbedPane;
    
    public MainFrame() {
        setTitle("🛒 E-Commerce Management System");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(1000, 700);
        setLocationRelativeTo(null);
        
        // Create tabbed pane
        tabbedPane = new JTabbedPane();
        
        // Add customer tabs
        tabbedPane.addTab("📦 Products", new ProductPanel());
        tabbedPane.addTab("🛒 Place Order", new OrderPanel());
        
        // Add Admin button
        JButton adminButton = new JButton("👑 Admin Access");
        adminButton.setFont(new Font("Arial", Font.BOLD, 12));
        adminButton.setBackground(new Color(255, 165, 0));
        adminButton.addActionListener(e -> openAdminPanel());
        
        // Create top panel with admin button
        JPanel topPanel = new JPanel(new BorderLayout());
        topPanel.add(adminButton, BorderLayout.EAST);
        
        // Status bar
        JPanel statusBar = new JPanel(new FlowLayout(FlowLayout.LEFT));
        statusBar.setBorder(BorderFactory.createLoweredBevelBorder());
        statusBar.add(new JLabel("✅ Connected to: ecommerce_db | Mode: Customer"));
        
        add(topPanel, BorderLayout.NORTH);
        add(tabbedPane, BorderLayout.CENTER);
        add(statusBar, BorderLayout.SOUTH);
        
        // Shutdown hook
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            DatabaseConnection.closeConnection();
        }));
    }
    
    private void openAdminPanel() {
        AdminLoginDialog loginDialog = new AdminLoginDialog(this);
        loginDialog.setVisible(true);
        
        if (loginDialog.isAuthenticated()) {
            AdminPanel adminPanel = new AdminPanel();
            adminPanel.setVisible(true);
            
            // Update status bar
            JPanel statusBar = (JPanel) getContentPane().getComponent(2);
            statusBar.removeAll();
            statusBar.add(new JLabel("✅ Connected to: ecommerce_db | Mode: Admin (Admin panel open)"));
            statusBar.revalidate();
            statusBar.repaint();
        }
    }
    
    public static void main(String[] args) {
        // Set Look and Feel
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        SwingUtilities.invokeLater(() -> {
            // Test database connection first
            if (DatabaseConnection.getConnection() != null) {
                new MainFrame().setVisible(true);
            } else {
                JOptionPane.showMessageDialog(null, 
                    "Cannot connect to database!\nCheck if MariaDB is running.", 
                    "Connection Error", 
                    JOptionPane.ERROR_MESSAGE);
            }
        });
    }
}
