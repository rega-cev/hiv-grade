import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * 
 * @author ewout
 * 
 * Sequence
 * 	=> SequenceName
 *  => gene
 *  => InputSequence
 *  => DrugClass
 *    => NNRTI
 *      => mutations
 *      => algorithm
 *        => ANRS
 *        => GRADE
 *        => HIVDB
 *        => Rega
 *    => PI
 *      => mutations
 *      => algorithm
 *        => ANRS
 *        => GRADE
 *        => HIVDB
 *        => Rega
 *    => NRTI
 *    	=> mutations
 *      => algorithm
 *        => ANRS
 *        => GRADE
 *        => HIVDB
 *        => Rega
 *          => version
 *          => drug
 *          => ...
 *  => Warnings
 *
 */

public class JSONParser {

	static char delimitor = ';';
	
	public static void main(String[] args) {
//		String inputfile = "/Users/ewout/Documents/Kristof/script/output/file_All_JSON";
		
		File dir = new File("/Users/ewout/Documents/Kristof/script/output");
		File [] files = dir.listFiles(new FilenameFilter() {
		    @Override
		    public boolean accept(File dir, String name) {
		        return name.endsWith(".json");
		    }
		});
		
		JSONParser jsonParser = new JSONParser();
		// TODO: Make this dynamic
		
		// Loop over all the sequences
		String basePath = "/Users/ewout/Documents/Kristof/script/output/";

		for(File file:files) {
			try {
				System.out.println(file.toPath());
				JSONObject rootObject = new JSONObject(new String(Files.readAllBytes(file.toPath())));
				
				// Find out which drugClasses are supported
				// Normally this is NNRTI, NRTI and PI
				List<String> drugClasses = null;
				// Find out which algorithms are supported
				// Normally this is ANRS, HIVDB, Rega and GRADE
				List<String> algorithms = null;
				
				JSONArray root = (JSONArray)rootObject.get("Sequence");
				
				Iterator<Object> iterator = root.iterator();
				JSONObject jsonObject = null;
				
				while(drugClasses == null) {
					if(iterator.hasNext()) {
						jsonObject = (JSONObject)iterator.next();
						try {
							drugClasses = jsonParser.getDrugs(jsonObject);
							algorithms = jsonParser.getAlgorithms(jsonObject, drugClasses.iterator().next());
						} catch(JSONException e) {
						}
					}
				}
				
				for(String algorithm:algorithms) {
					for(String drugClass:drugClasses) {
						iterator = root.iterator();
						jsonObject = (JSONObject)iterator.next();
						String fileName = basePath + "output_" + drugClass + "_" + algorithm + ".csv";
						File outputFile = new File(fileName);
						boolean fileExists = outputFile.exists();
						FileWriter fileWriter = new FileWriter(outputFile, true);
						
						if(!fileExists) { 
							fileWriter.write(jsonParser.getHeader(jsonObject, drugClass, algorithm));
						}

						while(true) {
//							System.out.println(jsonObject.get("SequenceName").toString());
							fileWriter.write(jsonObject.get("SequenceName").toString() + delimitor);
							fileWriter.write(jsonParser.getData(jsonObject, drugClass, algorithm));
							fileWriter.write("\n");
							if(iterator.hasNext())
								jsonObject = (JSONObject)iterator.next();
							else
								break;
						}
						fileWriter.close();
					}
				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (JSONException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	private List<String> getAlgorithms(JSONObject root, String drugClass) throws JSONException {
		JSONObject JSON = root.getJSONObject("DrugClass").getJSONObject(drugClass).getJSONObject("algorithm");
		List<String> algorithms = new ArrayList<String>();
		for(String algorithm:JSON.keySet()) {
			algorithms.add(algorithm);
		}
		return algorithms;
	}

	private List<String> getDrugs(JSONObject root) throws JSONException {
		JSONObject drugsJSON = root.getJSONObject("DrugClass");
		List<String> drugClasses = new ArrayList<String>();
		for(String drugClass:drugsJSON.keySet()) {
			drugClasses.add(drugClass);
		}
		return drugClasses;
	}
	
	public String getHeader(JSONObject root, String drugClass, String algorithm) {
		JSONObject drugsJSON = null;
		try {
			drugsJSON = root.getJSONObject("DrugClass").getJSONObject(drugClass).getJSONObject("algorithm").getJSONObject(algorithm).getJSONObject("drug");
		} catch(JSONException e) {
			System.err.println("Header could not be created because root doesn't contain root.getJSONObject(\"DrugClass\")");
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("id" + delimitor);
		for(String drugs:drugsJSON.keySet()) {
			stringBuilder.append(drugs + "_SIR" + delimitor + drugs + "_GSS" + delimitor + drugs + "_mutations" + delimitor);
		}
		stringBuilder.append("\n");
		return stringBuilder.toString();
	}
	
	private String getData(JSONObject root, String drugClass, String algorithm) {
		JSONObject drugsJSON = null;
		try {
			drugsJSON = root.getJSONObject("DrugClass").getJSONObject(drugClass).getJSONObject("algorithm").getJSONObject(algorithm).getJSONObject("drug");
		} catch(JSONException e) {
			System.err.println(root + " doesn't contain DrugClass.");
		}
		StringBuilder stringBuilder = new StringBuilder();
		if(drugsJSON != null) {
			for(String drug:drugsJSON.keySet()) {
				stringBuilder.append(drugsJSON.getJSONObject(drug).get("SIR").toString() + delimitor + drugsJSON.getJSONObject(drug).get("original") + delimitor + drugsJSON.getJSONObject(drug).get("mutations").toString() + delimitor);
			}
		} else {
			stringBuilder.append("" + delimitor + "" + delimitor + "" + delimitor);
		}
		return stringBuilder.toString();
	}
	
}
