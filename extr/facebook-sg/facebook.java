import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

/**
 * Creates a document which opposes the ID of a facebook member to the ID of his or her friend
 */

public class facebook{
	
// --- Global Variables ---------------------------------------------------------------------------
	
	private static File fFile; //Graph file
	
	private static OutputStreamWriter writer;
	
	private static HashMap<String,Integer> idList = new HashMap<String,Integer>(); //new IDs
	private static int id; //ID counter
	
	private static int member; //Member's ID
	//private static List<Integer> previousMembers = new ArrayList<Integer>();
	
	private static String[] scannedLine;
	
// --- Parsing ------------------------------------------------------------------------------------
	
	public final static void processLineByLine(String fileName, String output) throws IOException {

		fFile = new File(fileName);
		Scanner scanner = new Scanner(new FileReader(fFile));
		writer = new OutputStreamWriter(new FileOutputStream(output));
		writer.write("% sym unweighted\n");
		id = 1;

		System.out.println("Writing File. This may take a few minutes...");

		try {
			while (scanner.hasNextLine()) {
				createFriendsList(scanner.nextLine());
			}
		} finally {
			writer.close();
			scanner.close();
		}
	}
	
	protected static void createFriendsList(String line) throws IOException {
		Scanner scanner = new Scanner(line);

		if (scanner.hasNext()) {
			
			scannedLine = scanner.nextLine().split(" ");

			//set new IDs starting with 1
			if(!idList.containsKey(scannedLine[0])){
				idList.put(scannedLine[0], id);
				id++;
			}
			for (int i = 2; i<scannedLine.length; i++){
				if (!idList.containsKey(scannedLine[i])){
					idList.put(scannedLine[i], id);
					id++;
				}
			}
			
			member = idList.get(scannedLine[0]);
			//previousMembers.add(member);			
				
			for (int i=2; i<scannedLine.length; i++){
				//no directed graph
				//if(!previousMembers.contains(scannedLine[i])){
					//Output: uid	friend_uid
					writer.write(member + "\t" + idList.get(scannedLine[i]) + "\n");
				//}
			}
		}
	}

// --- Main Programm ------------------------------------------------------------------------------	

	public static void main(String[] args) throws IOException{
		
		String graph = "uni-socialgraph-anonymized.txt";
		
		processLineByLine(graph, "tmp.facebook-sg");
		
		System.out.println("Done.");
	}
}
