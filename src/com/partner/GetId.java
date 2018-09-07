package com.partner;

import java.io.File;
import java.io.FileReader;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class GetId {

	public static void main(String[] args) {

		try {
			if (args[0].equals("PARTNER"))
			{
			JSONParser parser = new JSONParser();
            Object obj = parser.parse(new FileReader("AddPartner/"+  args[1] + "/" + args[1] + "_response.json"));
            JSONObject jsonObject = (JSONObject) obj;
            JSONObject jsonObj = (JSONObject)jsonObject.get("bean");

            for (Object key : jsonObj.keySet()) 
            {
                    String keyStr = (String)key;
                    Object keyvalue = jsonObj.get(keyStr);
                    //System.out.println(keyStr + " : " + keyvalue);
                    if (keyStr.equals(args[2]))
                    	System.out.println(keyvalue);
            }
			}
			else if (args[0].equals("COMMUNITY"))
			{
			ObjectMapper mapper = new ObjectMapper();
			JsonNode root = mapper.readTree(new File("conf/communityResponse.json"));
			JsonNode contactNode = root.path("results");
			for (JsonNode node : contactNode) {
				if (node.path("partyName").asText().equals(args[1]))
					System.out.println(node.path(args[2]).asText());
			}
			}
			else if (args[0].equals("COMPONENTS"))
			{
			ObjectMapper mapper = new ObjectMapper();
			JsonNode root = mapper.readTree(new File("conf/componentsResponse.json"));
			JsonNode contactNode = root.path("results");
			for (JsonNode node : contactNode) {
				if (node.path("resourceName").asText().equals(args[1]))
					System.out.println(node.path(args[2]).asText());
			}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
}
