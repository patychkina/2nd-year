#include "Keypad.h"
#include <LiquidCrystal_I2C.h>
#define RED_PIN 11
#define SENSOR_PIN 12
#define DETECTOR_PIN 13
#define BUZZER 9

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
byte rPins[Rows]= {8,7,6,5}; // строки с 0 по 3
byte cPins[Cols]= {4,3,2}; // столбцы с 0 по 2
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
}

void loop() {
  Serial.println(password_input);
  int sensorValue = digitalRead(SENSOR_PIN);
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
