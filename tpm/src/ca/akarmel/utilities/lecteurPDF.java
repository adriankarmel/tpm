package ca.akarmel.utilities;

import java.awt.BorderLayout;
import java.io.FileInputStream;
import javax.swing.JFrame;
import javax.swing.JPanel;
import com.adobe.acrobat.Viewer;

public class lecteurPDF extends JPanel{
    private static final long serialVersionUID = 1L;
private Viewer viewer;

public lecteurPDF(String nomfichier) throws Exception{
    this.setLayout(new BorderLayout());

    viewer = new Viewer();
    this.add(viewer, BorderLayout.CENTER);
    FileInputStream fis = new FileInputStream(nomfichier);
    viewer.setDocumentInputStream(fis);
    viewer.activate();
}
}
