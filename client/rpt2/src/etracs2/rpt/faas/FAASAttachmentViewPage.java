/*
 * FAASAttachmentPage.java
 *
 * Created on August 1, 2011, 6:28 PM
 */

package etracs2.rpt.faas;

/**
 *
 * @author  jzamora
 */
public class FAASAttachmentViewPage extends javax.swing.JPanel {
    
    /** Creates new form FAASAttachmentPage */
    public FAASAttachmentViewPage() {
        initComponents();
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc=" Generated Code ">//GEN-BEGIN:initComponents
    private void initComponents() {
        xImageViewer1 = new com.rameses.rcp.control.XImageViewer();
        xActionBar1 = new com.rameses.rcp.control.XActionBar();
        xImageViewer2 = new com.rameses.rcp.control.XImageViewer();

        xImageViewer1.setAdvanced(true);
        xImageViewer1.setDepends(new String[] {"selectedItem"});
        xImageViewer1.setDynamic(true);
        xImageViewer1.setName("imageUrl");

        setLayout(new java.awt.BorderLayout());

        xActionBar1.setName("viewActions");
        xActionBar1.setPadding(new java.awt.Insets(2, 2, 2, 2));
        xActionBar1.setUseToolBar(false);
        add(xActionBar1, java.awt.BorderLayout.NORTH);

        xImageViewer2.setAdvanced(true);
        xImageViewer2.setDynamic(true);
        xImageViewer2.setName("imageUrl");
        add(xImageViewer2, java.awt.BorderLayout.CENTER);

    }// </editor-fold>//GEN-END:initComponents
    
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private com.rameses.rcp.control.XActionBar xActionBar1;
    private com.rameses.rcp.control.XImageViewer xImageViewer1;
    private com.rameses.rcp.control.XImageViewer xImageViewer2;
    // End of variables declaration//GEN-END:variables
    
}
