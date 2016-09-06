import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

/*
 * Creates a document which assigns new IDs to facebook members
 */

public class mapping{

// --- Global Variables ---------------------------------------------------------------------------
	
	private static File fFile; //Graph file
	
	private static OutputStreamWriter writer;
	
	private static List<String> idList = new ArrayList<String>(); //new IDs
	private static int id; //ID counter
	
	private static String[] scannedLine;
	
// --- Mapping ------------------------------------------------------------------------------------
	
	public final static void processLineByLine(String fileName, String output) throws IOException {

		fFile = new File(fileName);
		Scanner scanner = new Scanner(new FileReader(fFile));
		writer = new OutputStreamWriter(new FileOutputStream(output));

		id = 1;

		System.out.println("Mapping File. This may take a few minutes...");

		try {
			while (scanner.hasNextLine()) {
				createMappingFile(scanner.nextLine());
			}
		} finally {
			writer.close();
			scanner.close();
		}
	}
	
	protected static void createMappingFile(String line) throws IOException {
		Scanner scanner = new Scanner(line);

		if (scanner.hasNext()) {
			
			scannedLine = scanner.nextLine().split(" ");

			//set new IDs starting with 1
			if(!idList.contains(scannedLine[0])){
				idList.add(scannedLine[0]);
				writer.write(scannedLine[0] + "\t" + id + "\n");
				id++;
			}
			for (int i = 2; i<scannedLine.length; i++){
				if (!idList.contains(scannedLine[i])){
					idList.add(scannedLine[i]);
					writer.write(scannedLine[i] + "\t" + id + "\n");
					id++;
				}
			}
		}
	}

// --- Main Programm ------------------------------------------------------------------------------	

	public static void main (String[] args)throws IOException{
		
		String graph = "uni-socialgraph-anonymized.txt";
		
		processLineByLine(graph, "mapping.txt");
		
		System.out.println("Done.");
	}
}
