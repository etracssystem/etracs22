package etracs2.ctc.tc.ui;

import com.rameses.rcp.ui.annotations.StyleSheet;
import com.rameses.rcp.ui.annotations.Template;

/**
 *
 * @author  jaycverg
 */
@Template(ReceiptContentPage.class)
@StyleSheet
public class IndividualPage extends javax.swing.JPanel {
    
    /**
     * Creates new form IndividualPage
     */
    public IndividualPage() {
        initComponents();
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc=" Generated Code ">//GEN-BEGIN:initComponents
    private void initComponents() {
        xContextMenu1 = new com.rameses.rcp.control.XContextMenu();
        jPanel8 = new javax.swing.JPanel();
        formPanel1 = new com.rameses.rcp.util.FormPanel();
        xTextField4 = new com.rameses.rcp.control.XTextField();
        xTextField5 = new com.rameses.rcp.control.XTextField();
        xTextField6 = new com.rameses.rcp.control.XTextField();
        xTextField7 = new com.rameses.rcp.control.XTextField();
        xComboBox1 = new com.rameses.rcp.control.XComboBox();
        xTextField1 = new com.rameses.rcp.control.XTextField();
        xDateField2 = new com.rameses.rcp.control.XDateField();
        xTextField2 = new com.rameses.rcp.control.XTextField();
        xComboBox2 = new com.rameses.rcp.control.XComboBox();
        xTextField3 = new com.rameses.rcp.control.XTextField();
        xComboBox3 = new com.rameses.rcp.control.XComboBox();
        xComboBox4 = new com.rameses.rcp.control.XComboBox();
        xTextField8 = new com.rameses.rcp.control.XTextField();
        xTextField9 = new com.rameses.rcp.control.XTextField();
        xCheckBox1 = new com.rameses.rcp.control.XCheckBox();
        xCheckBox2 = new com.rameses.rcp.control.XCheckBox();
        xTextField11 = new com.rameses.rcp.control.XTextField();
        jPanel9 = new javax.swing.JPanel();
        formPanel3 = new com.rameses.rcp.util.FormPanel();
        xCheckBox3 = new com.rameses.rcp.control.XCheckBox();
        xNumberField5 = new com.rameses.rcp.control.XNumberField();
        xNumberField4 = new com.rameses.rcp.control.XNumberField();
        xNumberField6 = new com.rameses.rcp.control.XNumberField();
        xButton1 = new com.rameses.rcp.control.XButton();
        jPanel10 = new javax.swing.JPanel();
        formPanel4 = new com.rameses.rcp.util.FormPanel();
        xNumberField7 = new com.rameses.rcp.control.XNumberField();
        xNumberField8 = new com.rameses.rcp.control.XNumberField();
        xNumberField9 = new com.rameses.rcp.control.XNumberField();
        xNumberField10 = new com.rameses.rcp.control.XNumberField();
        xNumberField11 = new com.rameses.rcp.control.XNumberField();
        xButton2 = new com.rameses.rcp.control.XButton();
        xPanel1 = new com.rameses.rcp.control.XPanel();
        formPanel2 = new com.rameses.rcp.util.FormPanel();
        xDateField1 = new com.rameses.rcp.control.XDateField();
        xLookupField1 = new com.rameses.rcp.control.XLookupField();

        org.jdesktop.layout.GroupLayout xContextMenu1Layout = new org.jdesktop.layout.GroupLayout(xContextMenu1);
        xContextMenu1.setLayout(xContextMenu1Layout);
        xContextMenu1Layout.setHorizontalGroup(
            xContextMenu1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(0, 100, Short.MAX_VALUE)
        );
        xContextMenu1Layout.setVerticalGroup(
            xContextMenu1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(0, 100, Short.MAX_VALUE)
        );

        com.rameses.rcp.control.border.XTitledBorder xTitledBorder1 = new com.rameses.rcp.control.border.XTitledBorder();
        xTitledBorder1.setTitle("Taxpayer Information");
        jPanel8.setBorder(xTitledBorder1);

        formPanel1.setCaptionWidth(90);
        xTextField4.setCaption("Last Name");
        xTextField4.setIndex(-10);
        xTextField4.setName("entity.info.payer.info.lastname");
        xTextField4.setPreferredSize(new java.awt.Dimension(0, 19));
        xTextField4.setRequired(true);
        formPanel1.add(xTextField4);

        xTextField5.setCaption("First Name");
        xTextField5.setName("entity.info.payer.info.firstname");
        xTextField5.setPreferredSize(new java.awt.Dimension(0, 19));
        xTextField5.setRequired(true);
        formPanel1.add(xTextField5);

        xTextField6.setCaption("Middle Name");
        xTextField6.setName("entity.info.payer.info.middlename");
        xTextField6.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel1.add(xTextField6);

        xTextField7.setCaption("Address");
        xTextField7.setName("entity.info.payer.entityaddress");
        xTextField7.setPreferredSize(new java.awt.Dimension(0, 19));
        xTextField7.setRequired(true);
        formPanel1.add(xTextField7);

        xComboBox1.setCaption("Profession");
        xComboBox1.setItems("entitySvc.professionList");
        xComboBox1.setName("entity.info.payer.info.profession");
        xComboBox1.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel1.add(xComboBox1);

        xTextField1.setCaption("TIN");
        xTextField1.setName("entity.info.payer.info.tin");
        xTextField1.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel1.add(xTextField1);

        xDateField2.setCaption("Birth Date");
        xDateField2.setName("entity.info.payer.info.birthdate");
        xDateField2.setPreferredSize(new java.awt.Dimension(100, 19));
        formPanel1.add(xDateField2);

        xTextField2.setCaption("Place of Birth");
        xTextField2.setName("entity.info.payer.info.birthplace");
        xTextField2.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel1.add(xTextField2);

        xComboBox2.setCaption("Citizenship");
        xComboBox2.setItems("entitySvc.citizenshipList");
        xComboBox2.setName("entity.info.payer.info.citizenship");
        xComboBox2.setPreferredSize(new java.awt.Dimension(165, 19));
        formPanel1.add(xComboBox2);

        xTextField3.setCaption("ICR (If Alien)");
        xTextField3.setName("entity.info.payer.info.acr");
        xTextField3.setPreferredSize(new java.awt.Dimension(165, 19));
        formPanel1.add(xTextField3);

        xComboBox3.setCaption("Gender");
        xComboBox3.setItems("genderList");
        xComboBox3.setName("entity.info.payer.info.gender");
        xComboBox3.setPreferredSize(new java.awt.Dimension(165, 19));
        formPanel1.add(xComboBox3);

        xComboBox4.setCaption("Civil Status");
        xComboBox4.setItems("entitySvc.civilStatusList");
        xComboBox4.setName("entity.info.payer.info.civilstatus");
        xComboBox4.setPreferredSize(new java.awt.Dimension(165, 19));
        formPanel1.add(xComboBox4);

        xTextField8.setCaption("Height");
        xTextField8.setName("entity.info.payer.info.height");
        xTextField8.setPreferredSize(new java.awt.Dimension(165, 19));
        formPanel1.add(xTextField8);

        xTextField9.setCaption("Weight");
        xTextField9.setName("entity.info.payer.info.weight");
        xTextField9.setPreferredSize(new java.awt.Dimension(165, 19));
        formPanel1.add(xTextField9);

        xCheckBox1.setBorder(javax.swing.BorderFactory.createEmptyBorder(0, 0, 0, 0));
        xCheckBox1.setCaption("Is Senior?");
        xCheckBox1.setMargin(new java.awt.Insets(0, 0, 0, 0));
        xCheckBox1.setName("entity.info.payer.info.seniorcitizen");
        formPanel1.add(xCheckBox1);

        xCheckBox2.setBorder(javax.swing.BorderFactory.createEmptyBorder(0, 0, 0, 0));
        xCheckBox2.setCaption("Is Additional?");
        xCheckBox2.setMargin(new java.awt.Insets(0, 0, 0, 0));
        xCheckBox2.setName("entity.additional");
        formPanel1.add(xCheckBox2);

        xTextField11.setCaption("Remarks");
        xTextField11.setDepends(new String[] {"entity.additional"});
        xTextField11.setName("entity.additional_remarks");
        xTextField11.setPreferredSize(new java.awt.Dimension(165, 19));
        formPanel1.add(xTextField11);

        org.jdesktop.layout.GroupLayout jPanel8Layout = new org.jdesktop.layout.GroupLayout(jPanel8);
        jPanel8.setLayout(jPanel8Layout);
        jPanel8Layout.setHorizontalGroup(
            jPanel8Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel8Layout.createSequentialGroup()
                .addContainerGap()
                .add(formPanel1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 350, Short.MAX_VALUE)
                .addContainerGap())
        );
        jPanel8Layout.setVerticalGroup(
            jPanel8Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel8Layout.createSequentialGroup()
                .add(formPanel1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 371, Short.MAX_VALUE)
                .addContainerGap())
        );

        com.rameses.rcp.control.border.XTitledBorder xTitledBorder2 = new com.rameses.rcp.control.border.XTitledBorder();
        xTitledBorder2.setTitle("Salary / Business Gross / RPT Income");
        jPanel9.setBorder(xTitledBorder2);

        formPanel3.setCaptionWidth(120);
        formPanel3.setPadding(new java.awt.Insets(5, 5, 10, 0));
        xCheckBox3.setBorder(javax.swing.BorderFactory.createEmptyBorder(0, 0, 0, 0));
        xCheckBox3.setCaption("Is New Business?");
        xCheckBox3.setMargin(new java.awt.Insets(0, 0, 0, 0));
        xCheckBox3.setName("entity.newbusiness");
        formPanel3.add(xCheckBox3);

        xNumberField5.setCaption("Business Gross");
        xNumberField5.setFieldType(java.math.BigDecimal.class);
        xNumberField5.setFont(new java.awt.Font("Arial", 1, 11));
        xNumberField5.setName("entity.businessgross");
        xNumberField5.setPattern("#,##0.00");
        xNumberField5.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel3.add(xNumberField5);

        xNumberField4.setCaption("Annual Salary");
        xNumberField4.setFieldType(java.math.BigDecimal.class);
        xNumberField4.setFont(new java.awt.Font("Arial", 1, 11));
        xNumberField4.setName("entity.annualsalary");
        xNumberField4.setPattern("#,##0.00");
        xNumberField4.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel3.add(xNumberField4);

        xNumberField6.setCaption("Property Income");
        xNumberField6.setFieldType(java.math.BigDecimal.class);
        xNumberField6.setFont(new java.awt.Font("Arial", 1, 11));
        xNumberField6.setName("entity.propertyincome");
        xNumberField6.setPattern("#,##0.00");
        xNumberField6.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel3.add(xNumberField6);

        xButton1.setMnemonic('t');
        xButton1.setText("Calculate Tax");
        xButton1.setImmediate(true);
        xButton1.setName("calculate");

        org.jdesktop.layout.GroupLayout jPanel9Layout = new org.jdesktop.layout.GroupLayout(jPanel9);
        jPanel9.setLayout(jPanel9Layout);
        jPanel9Layout.setHorizontalGroup(
            jPanel9Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel9Layout.createSequentialGroup()
                .addContainerGap()
                .add(jPanel9Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(formPanel3, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 285, Short.MAX_VALUE)
                    .add(org.jdesktop.layout.GroupLayout.TRAILING, xButton1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 128, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );
        jPanel9Layout.setVerticalGroup(
            jPanel9Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel9Layout.createSequentialGroup()
                .add(formPanel3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(xButton1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 31, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        com.rameses.rcp.control.border.XTitledBorder xTitledBorder3 = new com.rameses.rcp.control.border.XTitledBorder();
        xTitledBorder3.setTitle("Community Tax Breakdown");
        jPanel10.setBorder(xTitledBorder3);

        formPanel4.setCaptionWidth(120);
        formPanel4.setPadding(new java.awt.Insets(5, 5, 10, 5));
        xNumberField7.setCaption("Basic Tax");
        xNumberField7.setFieldType(java.math.BigDecimal.class);
        xNumberField7.setFont(new java.awt.Font("Arial", 1, 11));
        xNumberField7.setName("entity.tax.basic");
        xNumberField7.setPattern("#,##0.00");
        xNumberField7.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel4.add(xNumberField7);

        xNumberField8.setCaption("Annual Salary Tax");
        xNumberField8.setFieldType(java.math.BigDecimal.class);
        xNumberField8.setFont(new java.awt.Font("Arial", 1, 11));
        xNumberField8.setName("entity.tax.salary");
        xNumberField8.setPattern("#,##0.00");
        xNumberField8.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel4.add(xNumberField8);

        xNumberField9.setCaption("Business Gross Tax");
        xNumberField9.setFieldType(java.math.BigDecimal.class);
        xNumberField9.setFont(new java.awt.Font("Arial", 1, 11));
        xNumberField9.setName("entity.tax.business");
        xNumberField9.setPattern("#,##0.00");
        xNumberField9.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel4.add(xNumberField9);

        xNumberField10.setCaption("Property Income Tax");
        xNumberField10.setFieldType(java.math.BigDecimal.class);
        xNumberField10.setFont(new java.awt.Font("Arial", 1, 11));
        xNumberField10.setName("entity.tax.property");
        xNumberField10.setPattern("#,##0.00");
        xNumberField10.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel4.add(xNumberField10);

        xNumberField11.setCaption("Interest");
        xNumberField11.setFieldType(java.math.BigDecimal.class);
        xNumberField11.setFont(new java.awt.Font("Arial", 1, 11));
        xNumberField11.setName("entity.tax.interest");
        xNumberField11.setPattern("#,##0.00");
        xNumberField11.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel4.add(xNumberField11);

        xButton2.setMnemonic('d');
        xButton2.setText("Accept Tax Due");
        xButton2.setImmediate(true);
        xButton2.setName("acceptTaxDue");

        org.jdesktop.layout.GroupLayout jPanel10Layout = new org.jdesktop.layout.GroupLayout(jPanel10);
        jPanel10.setLayout(jPanel10Layout);
        jPanel10Layout.setHorizontalGroup(
            jPanel10Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel10Layout.createSequentialGroup()
                .addContainerGap()
                .add(jPanel10Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(formPanel4, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 285, Short.MAX_VALUE)
                    .add(org.jdesktop.layout.GroupLayout.TRAILING, xButton2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 128, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );
        jPanel10Layout.setVerticalGroup(
            jPanel10Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel10Layout.createSequentialGroup()
                .add(formPanel4, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(xButton2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 31, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        com.rameses.rcp.control.border.XTitledBorder xTitledBorder4 = new com.rameses.rcp.control.border.XTitledBorder();
        xTitledBorder4.setTitle("Transaction Info");
        xPanel1.setBorder(xTitledBorder4);
        xPanel1.setName("txninfo");

        formPanel2.setBorder(javax.swing.BorderFactory.createCompoundBorder(null, javax.swing.BorderFactory.createEmptyBorder(5, 5, 5, 5)));
        formPanel2.setCaptionWidth(120);
        formPanel2.setPadding(new java.awt.Insets(0, 5, 0, 0));
        xDateField1.setCaption("Transaction Date");
        xDateField1.setEnabled(false);
        xDateField1.setFont(new java.awt.Font("Arial", 1, 11));
        xDateField1.setName("entity.info.txndate");
        xDateField1.setPreferredSize(new java.awt.Dimension(100, 19));
        formPanel2.add(xDateField1);

        xLookupField1.setCaption("Barangay");
        xLookupField1.setExpression("#{name}");
        xLookupField1.setHandler("brgyLookup");
        xLookupField1.setName("barangay");
        xLookupField1.setPreferredSize(new java.awt.Dimension(0, 20));
        formPanel2.add(xLookupField1);

        org.jdesktop.layout.GroupLayout xPanel1Layout = new org.jdesktop.layout.GroupLayout(xPanel1);
        xPanel1.setLayout(xPanel1Layout);
        xPanel1Layout.setHorizontalGroup(
            xPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(xPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .add(formPanel2, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 285, Short.MAX_VALUE)
                .addContainerGap())
        );
        xPanel1Layout.setVerticalGroup(
            xPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(xPanel1Layout.createSequentialGroup()
                .add(formPanel2, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
        );

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .addContainerGap()
                .add(jPanel8, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING, false)
                    .add(jPanel10, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .add(jPanel9, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .add(xPanel1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap(106, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jPanel8, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(layout.createSequentialGroup()
                        .add(xPanel1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jPanel9, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jPanel10, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(66, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents
    
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private com.rameses.rcp.util.FormPanel formPanel1;
    private com.rameses.rcp.util.FormPanel formPanel2;
    private com.rameses.rcp.util.FormPanel formPanel3;
    private com.rameses.rcp.util.FormPanel formPanel4;
    private javax.swing.JPanel jPanel10;
    private javax.swing.JPanel jPanel8;
    private javax.swing.JPanel jPanel9;
    private com.rameses.rcp.control.XButton xButton1;
    private com.rameses.rcp.control.XButton xButton2;
    private com.rameses.rcp.control.XCheckBox xCheckBox1;
    private com.rameses.rcp.control.XCheckBox xCheckBox2;
    private com.rameses.rcp.control.XCheckBox xCheckBox3;
    private com.rameses.rcp.control.XComboBox xComboBox1;
    private com.rameses.rcp.control.XComboBox xComboBox2;
    private com.rameses.rcp.control.XComboBox xComboBox3;
    private com.rameses.rcp.control.XComboBox xComboBox4;
    private com.rameses.rcp.control.XContextMenu xContextMenu1;
    private com.rameses.rcp.control.XDateField xDateField1;
    private com.rameses.rcp.control.XDateField xDateField2;
    private com.rameses.rcp.control.XLookupField xLookupField1;
    private com.rameses.rcp.control.XNumberField xNumberField10;
    private com.rameses.rcp.control.XNumberField xNumberField11;
    private com.rameses.rcp.control.XNumberField xNumberField4;
    private com.rameses.rcp.control.XNumberField xNumberField5;
    private com.rameses.rcp.control.XNumberField xNumberField6;
    private com.rameses.rcp.control.XNumberField xNumberField7;
    private com.rameses.rcp.control.XNumberField xNumberField8;
    private com.rameses.rcp.control.XNumberField xNumberField9;
    private com.rameses.rcp.control.XPanel xPanel1;
    private com.rameses.rcp.control.XTextField xTextField1;
    private com.rameses.rcp.control.XTextField xTextField11;
    private com.rameses.rcp.control.XTextField xTextField2;
    private com.rameses.rcp.control.XTextField xTextField3;
    private com.rameses.rcp.control.XTextField xTextField4;
    private com.rameses.rcp.control.XTextField xTextField5;
    private com.rameses.rcp.control.XTextField xTextField6;
    private com.rameses.rcp.control.XTextField xTextField7;
    private com.rameses.rcp.control.XTextField xTextField8;
    private com.rameses.rcp.control.XTextField xTextField9;
    // End of variables declaration//GEN-END:variables
    
}
