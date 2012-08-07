/*
 * ChangePinPage.java
 *
 * Created on August 6, 2012, 9:40 PM
 */

package etracs2.rpt.utils;

/**
 *
 * @author  PRMF
 */
public class ModifyPinPage extends javax.swing.JPanel {
    
    /** Creates new form ChangePinPage */
    public ModifyPinPage() {
        initComponents();
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc=" Generated Code ">//GEN-BEGIN:initComponents
    private void initComponents() {
        formPanel1 = new com.rameses.rcp.util.FormPanel();
        xLookupField1 = new com.rameses.rcp.control.XLookupField();
        xLabel1 = new com.rameses.rcp.control.XLabel();
        xLabel2 = new com.rameses.rcp.control.XLabel();
        xLabel3 = new com.rameses.rcp.control.XLabel();
        formPanel2 = new com.rameses.rcp.util.FormPanel();
        xComboBox3 = new com.rameses.rcp.control.XComboBox();
        xComboBox1 = new com.rameses.rcp.control.XComboBox();
        xComboBox2 = new com.rameses.rcp.control.XComboBox();
        xNumberField1 = new com.rameses.rcp.control.XNumberField();
        xNumberField2 = new com.rameses.rcp.control.XNumberField();
        xNumberField3 = new com.rameses.rcp.control.XNumberField();
        xLabel4 = new com.rameses.rcp.control.XLabel();
        xButton1 = new com.rameses.rcp.control.XButton();
        xButton2 = new com.rameses.rcp.control.XButton();

        com.rameses.rcp.control.border.XTitledBorder xTitledBorder1 = new com.rameses.rcp.control.border.XTitledBorder();
        xTitledBorder1.setTitle("Existing PIN Information");
        formPanel1.setBorder(xTitledBorder1);
        xLookupField1.setCaption("TD No.");
        xLookupField1.setCaptionWidth(105);
        xLookupField1.setExpression("#{tdno}");
        xLookupField1.setHandler("lookupFaas");
        xLookupField1.setIndex(-100);
        xLookupField1.setName("faas");
        xLookupField1.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel1.add(xLookupField1);

        xLabel1.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(153, 153, 153)));
        xLabel1.setCaption("Taxpayer Name");
        xLabel1.setCaptionWidth(105);
        xLabel1.setDepends(new String[] {"faas"});
        xLabel1.setFont(new java.awt.Font("Arial", 1, 11));
        xLabel1.setName("faas.taxpayername");
        xLabel1.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel1.add(xLabel1);

        xLabel2.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(153, 153, 153)));
        xLabel2.setCaption("Cadastral Lot No.");
        xLabel2.setCaptionWidth(105);
        xLabel2.setDepends(new String[] {"faas"});
        xLabel2.setFont(new java.awt.Font("Arial", 1, 11));
        xLabel2.setName("faas.cadastrallotno");
        xLabel2.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel1.add(xLabel2);

        xLabel3.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(153, 153, 153)));
        xLabel3.setCaption("PIN");
        xLabel3.setCaptionWidth(105);
        xLabel3.setDepends(new String[] {"faas"});
        xLabel3.setFont(new java.awt.Font("Arial", 1, 11));
        xLabel3.setName("faas.fullpin");
        xLabel3.setPreferredSize(new java.awt.Dimension(0, 19));
        formPanel1.add(xLabel3);

        com.rameses.rcp.control.border.XTitledBorder xTitledBorder2 = new com.rameses.rcp.control.border.XTitledBorder();
        xTitledBorder2.setTitle("Modified PIN Information");
        formPanel2.setBorder(xTitledBorder2);
        xComboBox3.setAllowNull(false);
        xComboBox3.setCaption("PIN Type");
        xComboBox3.setImmediate(true);
        xComboBox3.setItems("pinTypeList");
        xComboBox3.setName("pintype");
        xComboBox3.setPreferredSize(new java.awt.Dimension(0, 22));
        xComboBox3.setRequired(true);
        formPanel2.add(xComboBox3);

        xComboBox1.setCaption("Municipality");
        xComboBox1.setExpression("#{lguname}");
        xComboBox1.setImmediate(true);
        xComboBox1.setItems("municipalityList");
        xComboBox1.setName("municipality");
        xComboBox1.setPreferredSize(new java.awt.Dimension(0, 22));
        xComboBox1.setRequired(true);
        formPanel2.add(xComboBox1);

        xComboBox2.setCaption("Barangay");
        xComboBox2.setDepends(new String[] {"municipality"});
        xComboBox2.setDynamic(true);
        xComboBox2.setExpression("#{lguname}");
        xComboBox2.setImmediate(true);
        xComboBox2.setItems("barangayList");
        xComboBox2.setName("barangay");
        xComboBox2.setPreferredSize(new java.awt.Dimension(0, 22));
        xComboBox2.setRequired(true);
        formPanel2.add(xComboBox2);

        xNumberField1.setCaption("Section");
        xNumberField1.setFieldType(Integer.class);
        xNumberField1.setName("section");
        xNumberField1.setPreferredSize(new java.awt.Dimension(80, 19));
        xNumberField1.setRequired(true);
        formPanel2.add(xNumberField1);

        xNumberField2.setCaption("Parcel");
        xNumberField2.setFieldType(Integer.class);
        xNumberField2.setName("parcel");
        xNumberField2.setPreferredSize(new java.awt.Dimension(80, 19));
        xNumberField2.setRequired(true);
        formPanel2.add(xNumberField2);

        xNumberField3.setCaption("Suffix");
        xNumberField3.setDepends(new String[] {"faas"});
        xNumberField3.setFieldType(Integer.class);
        xNumberField3.setName("suffix");
        xNumberField3.setPreferredSize(new java.awt.Dimension(80, 19));
        xNumberField3.setRequired(true);
        formPanel2.add(xNumberField3);

        xLabel4.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(153, 153, 153)));
        xLabel4.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        xLabel4.setCaption("New PIN");
        xLabel4.setCellPadding(new java.awt.Insets(10, 0, 0, 0));
        xLabel4.setFont(new java.awt.Font("Arial", 1, 18));
        xLabel4.setName("newpin");
        xLabel4.setPreferredSize(new java.awt.Dimension(0, 26));
        xLabel4.setShowCaption(false);
        formPanel2.add(xLabel4);

        xButton1.setMnemonic('c');
        xButton1.setText("Cancel");
        xButton1.setImmediate(true);
        xButton1.setName("_close");

        xButton2.setMnemonic('u');
        xButton2.setText("Update");
        xButton2.setName("updatePin");

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(org.jdesktop.layout.GroupLayout.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING)
                    .add(org.jdesktop.layout.GroupLayout.LEADING, formPanel2, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 391, Short.MAX_VALUE)
                    .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING)
                        .add(layout.createSequentialGroup()
                            .add(xButton2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                            .add(xButton1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                        .add(org.jdesktop.layout.GroupLayout.LEADING, formPanel1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 391, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                .add(105, 105, 105))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .addContainerGap()
                .add(formPanel1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 124, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(formPanel2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 213, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(xButton2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(xButton1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(26, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents
    
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private com.rameses.rcp.util.FormPanel formPanel1;
    private com.rameses.rcp.util.FormPanel formPanel2;
    private com.rameses.rcp.control.XButton xButton1;
    private com.rameses.rcp.control.XButton xButton2;
    private com.rameses.rcp.control.XComboBox xComboBox1;
    private com.rameses.rcp.control.XComboBox xComboBox2;
    private com.rameses.rcp.control.XComboBox xComboBox3;
    private com.rameses.rcp.control.XLabel xLabel1;
    private com.rameses.rcp.control.XLabel xLabel2;
    private com.rameses.rcp.control.XLabel xLabel3;
    private com.rameses.rcp.control.XLabel xLabel4;
    private com.rameses.rcp.control.XLookupField xLookupField1;
    private com.rameses.rcp.control.XNumberField xNumberField1;
    private com.rameses.rcp.control.XNumberField xNumberField2;
    private com.rameses.rcp.control.XNumberField xNumberField3;
    // End of variables declaration//GEN-END:variables
    
}
