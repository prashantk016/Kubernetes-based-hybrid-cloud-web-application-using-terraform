package hello;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class HomeController {

	@RequestMapping(value = "/answer", method = RequestMethod.GET)
	@CrossOrigin(origins="*", allowedHeaders="*")
	public ResponseEntity<String> answer() {
	
		return new ResponseEntity<>(getAnswer(), HttpStatus.OK);
	}

	private static String getAnswer() {
		final String uri = "https://yesno.wtf/api/";
		JSONObject rJSON = new JSONObject();
		try {
			rJSON.put("Error", "API failed!");
			
			RestTemplate restTemplate = new RestTemplate();
			String result = restTemplate.getForObject(uri, String.class);

			//rJSON = new JSONObject(result);
			System.out.println(result);
			return result;
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rJSON.toString();
	}
}
