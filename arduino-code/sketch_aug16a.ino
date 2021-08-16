#include "WiFiClientSecure.h"
#include "ESP8266WiFi.h"
#include "ESP8266HTTPClient.h"
#include "ArduinoJson.h"

//Wifi SSID
const char* ssid = "TURKSAT-KABLONET-CF4B-2.4G";

//Wifi Passoword
const char* password = "02302add";

//HTTPS Port [Constant]
const int httpsPort = 443;

//Your Firebase Realtime Database Address (add .json end)
const String rest_api_url = "https://flutter-arduino-e9560-default-rtdb.firebaseio.com/.json";

// HTTP client creating
HTTPClient http;

// WiFi Client creating
WiFiClientSecure client;


void setup() {
  Serial.begin(115200);

  //Connect Wifi Address with SSID and Password
  WiFi.begin(ssid, password);

  //Activate Led Pin
  pinMode(LED_BUILTIN, OUTPUT);
  while (WiFi.status() != WL_CONNECTED) 
  {
     delay(200);
     Serial.print("*");
  }
  delay(1000);
  Serial.println("");
  Serial.print("Connected to Wifi ! Network Name: ");
  Serial.println(ssid);
  Serial.print("ESP8266 Modüle's IP Adress: ");
  Serial.print(WiFi.localIP());
  delay(2000);

}

void loop() {

  //Firebase Request Function
  FirebaseRequest();
}

void FirebaseRequest(){

  //To connect HTTPS(secured) connections
  client.setInsecure(); 

  //Start database connection
  client.connect(rest_api_url, httpsPort);
  http.begin(client, rest_api_url);

  //Start request
  int code = http.GET();

  // If connection success.
  if(code == 200){
    String payload = http.getString();
    DynamicJsonDocument jsonBuffer(1100);
    deserializeJson(jsonBuffer, payload);

    //Value in my Firebase should be "true" or "false" as String
    String blinkValue = jsonBuffer["isBlinked"];
    Serial.println(blinkValue);

    //If value is true led on else led off
    if(blinkValue == "true"){
      digitalWrite(LED_BUILTIN, LOW);
    }else{
      digitalWrite(LED_BUILTIN, HIGH);
    }
    delay(500);
  }  
}
