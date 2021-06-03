import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public aspect Logger {
		//crear archivo
	   
	    //Salto linea para txt
	    private static final String newLine = System.getProperty("line.separator"); 
	    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
	    pointcut callTransaccion() : call(* moneyMakeTransaction());
	    pointcut callRetiroDinero() : call(* moneyWithdrawal());
	    
	    after() : callTransaccion() {
	    	escribirArchivo("Transaccion ");           
	    }
	    after() : callRetiroDinero() {
	    	escribirArchivo("Retiro de Dinero ");
           
	    }
	    
	    public void escribirArchivo(String mensaje) {
	    	 File file = new File("log.txt");	        
	    	//fecha y hora actual
	    	Calendar cal = Calendar.getInstance();
	    	//formato para sacar hora
	    	DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
	    	//cadena para la escritura del txt + hora
	    	String contenido=mensaje+dateFormat.format(cal.getTime()).toString();
	    	System.out.println(contenido);
			try {
				// Si el archivo no existe, se crea!
		        if (!file.exists()) {
		            file.createNewFile();
		        }
				//permite crear y escribir datos en un archivo agregando linea txt
		        FileWriter fw = new FileWriter(file.getAbsoluteFile(), true);				
				BufferedWriter bw = new BufferedWriter(fw);            
		        bw.write(contenido+newLine);
		        bw.close();
			} catch (IOException e) {				
				e.printStackTrace();
			}
	    }	 
	    
	   // public aspect Logger {

	        pointcut success() : call(* create*(..) );
	        after() : success() {
	        //Aspecto ejemplo: solo muestra este mensaje después de haber creado un usuario 
	        	System.out.println("**** User created ****");
	        }
	        
	//    }
}

