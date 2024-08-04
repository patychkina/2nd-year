#include "Keypad.h"
#include <LiquidCrystal_I2C.h>
#include "AsyncTCP.h"
#include "ESPAsyncWebServer.h"
#include "WiFi.h"
#define RED_PIN 23
#define SENSOR_PIN 12
#define DETECTOR_PIN 13
#define BUZZER 15

const char* ssid = "Pixel4";
const char* pass = "123456780";

int S = 0;
String pas_input = "";

// Create AsyncWebServer object on port 80
AsyncWebServer server(80);
unsigned long previousMillis = 0;
// Updates readings every 10 seconds
const long interval = 10000;
const char css[] PROGMEM = R"rawliteral(
html {
font-family: Arial;
display: inline-block;
margin: 0px auto;
text-align: center;
}
h2 { font-size: 3.0rem; }
p { font-size: 3.0rem; }
.units { font-size: 1.2rem; }
.dht-labels{
font-size: 1.5rem;
vertical-align:middle;
padding-bottom: 15px;
}
)rawliteral";
const char index_html[] PROGMEM = R"rawliteral(
<!DOCTYPE HTML><html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" />
<link rel="stylesheet" href="/style.css" />
</head>
<body>
<h2>ESP32 DISPLAY Server</h2>
<p>
<span class="dht-labels">State</span>
<span id="State">%STATE%</span>
</p>
<p>
<span class="dht-labels">Input</span>
<span id="State">%INPUT%</span>
</p>
</body>
<script src='/script.js'></script>
</html>)rawliteral";
const char js[] PROGMEM = R"rawliteral(
setInterval(async function ( ) {
const response = await fetch("/State");
const string = await response.text();
document.getElementById("State").innerHTML = string;
}, 5000);
const char js[] PROGMEM = R"rawliteral(
setInterval(async function ( ) {
const response = await fetch("/Input");
const string = await response.text();
document.getElementById("Input").innerHTML = string;
}, 5000);

)rawliteral";
// Replaces placeholder with DHT values
String processor(const String& var) {
//Serial.println(var);
if(var == "STATE"){
return String(S);
}
else if (var == "INPUT")
{
  return pas_input;
}
return String();
}
//Матричная клавиатура
const byte Rows= 4; // количество строк на клавиатуре, 4
const byte Cols= 3; // количество столбцов на клавиатуре, 3
// Массив, соответствующий распределению кнопок на клавиатуре:
char keymap[Rows][Cols]=
{
{'1', '2', '3'},
{'4', '5', '6'},
{'7', '8', '9'},
{'*', '0', '#'}
};
// соединения клавиатуры с выводами Arduino задаются так:
byte rPins[Rows]= {19,18,5,17}; // строки с 0 по 3
byte cPins[Cols]= {16,25,26}; // столбцы с 0 по 2
// создаем объект
Keypad kpd= Keypad(makeKeymap(keymap), rPins, cPins, Rows, Cols);
//Дисплей
LiquidCrystal_I2C lcd(0x27,20,2);
bool flag_switch = false;
bool flag_display = false;
bool flag_move = false;
int minute = 0;
String password_input = "";
String password = "123";
void setup() {
  pinMode(BUZZER , OUTPUT);
  // put your setup code here, to run once:
  //Настройка диода
  pinMode(RED_PIN, OUTPUT);
  Serial.begin(9600);
  //Настройка сенсора
  pinMode(SENSOR_PIN, INPUT);
  lcd.init();
  lcd.backlight();
  lcd.setCursor(3,0);
  lcd.print("Switched off");

  WiFi.begin(ssid, pass);

  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request){
request->send_P(200, "text/html", index_html, processor);
});
server.on("/style.css", HTTP_GET, [](AsyncWebServerRequest
*request){
request->send_P(200, "text/css", css);
});
server.on("/script.js", HTTP_GET, [](AsyncWebServerRequest
*request){
request->send_P(200, "text/javascript", js);
});
server.on("/temperature", HTTP_GET, [](AsyncWebServerRequest
*request){
request->send_P(200, "text/plain", String(S).c_str());
});
server.on("/temperature", HTTP_GET, [](AsyncWebServerRequest
*request){
request->send_P(200, "text/plain", pas_input.c_str());
});

server.begin();
}

void loop() {
unsigned long currentMillis = millis();
if (currentMillis - previousMillis >= interval) {
previousMillis = currentMillis;
int sensorValue = digitalRead(SENSOR_PIN);
if (sensorValue == HIGH)
{
  S = sensorValue;
Serial.println("touched");
}
else
{
  S = 0;
Serial.println("not touched");
}
char keypressed = kpd.getKey();
if (keypressed != NO_KEY) {
pas_input += keypressed;
}
}

  Serial.println(password_input);
  int sensorValue = digitalRead(SENSOR_PIN);
  if (WiFi.status() == WL_CONNECTED) {
    lcd.setCursor(0,1);
    lcd.print("wifi");
  }
  if (sensorValue == HIGH)
  {
    flag_switch = true;
    Serial.println("touched");
  }
  if (flag_switch)
  {
    if (!flag_display)
    {
      lcd.clear();
      lcd.setCursor(3,0);
      lcd.print("Switched on");
      flag_display = true;
      digitalWrite(RED_PIN, HIGH);
    }
    if(digitalRead(DETECTOR_PIN))
    {
      flag_move = true;
    }
    if (flag_move)
    {
      Serial.println("Move");
      lcd.setCursor(10,1);
      lcd.print(password_input);
      lcd.setCursor(5,1);
      lcd.print("Move");
      minute++;
      Serial.println(minute);
      if (minute==1000)
      {

          if (password_input == password)
          {
            Serial.println("I am here");
            digitalWrite(RED_PIN, LOW);
            lcd.clear();
            lcd.setCursor(3,0);
            lcd.print("Switched off");
            //flag_display = false;
          }
          else
          {
            tone(BUZZER, 1000);
          }
      }
      else
      {
        char keypressed = kpd.getKey();
        if (keypressed != NO_KEY) {
        password_input+=keypressed;
      }
    }
    }
  }
}
