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


import javax.swing.*;
import java.awt.*;

public class AdminLoginDialog extends JDialog {
    private JPasswordField passwordField;
    private boolean authenticated = false;
    private static final String ADMIN_PASSWORD = "admin123";
    
    public AdminLoginDialog(JFrame parent) {
        super(parent, "Admin Access", true);
        
        // Create components
        JPanel panel = new JPanel(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(15, 15, 15, 15);
        
        // Password label
        gbc.gridx = 0;
        gbc.gridy = 0;
        panel.add(new JLabel("Admin Password:"), gbc);
        
        // Password field - explicitly set size
        gbc.gridx = 1;
        gbc.gridy = 0;
        passwordField = new JPasswordField();
        passwordField.setColumns(15);  // Set columns instead of preferred size
        passwordField.setEchoChar('*');
        panel.add(passwordField, gbc);
        
        // Buttons
        gbc.gridx = 0;
        gbc.gridy = 1;
        gbc.gridwidth = 2;
        gbc.anchor = GridBagConstraints.CENTER;
        
        JPanel buttonPanel = new JPanel(new FlowLayout());
        JButton loginBtn = new JButton("Login");
        JButton cancelBtn = new JButton("Cancel");
        
        loginBtn.addActionListener(e -> {
            String pwd = new String(passwordField.getPassword());
            if (ADMIN_PASSWORD.equals(pwd)) {
                authenticated = true;
                dispose();
            } else {
                JOptionPane.showMessageDialog(this, "Wrong password!");
                passwordField.setText("");
            }
        });
        
        cancelBtn.addActionListener(e -> dispose());
        
        buttonPanel.add(loginBtn);
        buttonPanel.add(cancelBtn);
        panel.add(buttonPanel, gbc);
        
        add(panel);
        
        setSize(450, 180);
        setLocationRelativeTo(parent);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
    }
    
    public boolean isAuthenticated() {
        return authenticated;
    }
}
