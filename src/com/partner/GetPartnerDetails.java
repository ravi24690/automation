package com.partner;

import java.io.File;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

/*args[0] used for partner or community
In case of partner args[1] represents partner name
In case of community args[1] represents community name
In case of community args[2] represents node name
*/

public class GetPartnerDetails {

	public static void main(String[] args) {

		try {
			if (args[0].equals("PARTNER"))
			{
				ObjectMapper mapper = new ObjectMapper();
				JsonNode root = mapper.readTree(new File("conf/partnerResponse.json"));
				JsonNode contactNode = root.path("results");
				for (JsonNode node : contactNode) {
					if (node.path("partyName").asText().equals(args[1])) {
						System.out.println(node.path(args[2]).asText());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
}
