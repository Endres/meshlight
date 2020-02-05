#include <ESP8266WiFi.h>
#include <WiFiUdp.h>

#define LED_PIN_RED   0
#define LED_PIN_GREEN 1
#define LED_PIN_BLUE  2

#define MESH_SSID     "MeshLight"
#define MESH_PASSWORD "this_is_no_internet"
#define MESH_PORT     9876

#define MESH_IP_OFFSET 10
#define MESH_MAX_ID    244

const uint16_t pwmtable_16[256] =
{
    0, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3,
    3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 7,
    7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 11, 11, 12, 12, 13, 13, 14, 15,
    15, 16, 17, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
    31, 32, 33, 35, 36, 38, 40, 41, 43, 45, 47, 49, 52, 54, 56, 59,
    61, 64, 67, 70, 73, 76, 79, 83, 87, 91, 95, 99, 103, 108, 112,
    117, 123, 128, 134, 140, 146, 152, 159, 166, 173, 181, 189, 197,
    206, 215, 225, 235, 245, 256, 267, 279, 292, 304, 318, 332, 347,
    362, 378, 395, 412, 431, 450, 470, 490, 512, 535, 558, 583, 609,
    636, 664, 693, 724, 756, 790, 825, 861, 899, 939, 981, 1024, 1069,
    1117, 1166, 1218, 1272, 1328, 1387, 1448, 1512, 1579, 1649, 1722,
    1798, 1878, 1961, 2048, 2139, 2233, 2332, 2435, 2543, 2656, 2773,
    2896, 3025, 3158, 3298, 3444, 3597, 3756, 3922, 4096, 4277, 4467,
    4664, 4871, 5087, 5312, 5547, 5793, 6049, 6317, 6596, 6889, 7194,
    7512, 7845, 8192, 8555, 8933, 9329, 9742, 10173, 10624, 11094,
    11585, 12098, 12634, 13193, 13777, 14387, 15024, 15689, 16384,
    17109, 17867, 18658, 19484, 20346, 21247, 22188, 23170, 24196,
    25267, 26386, 27554, 28774, 30048, 31378, 32768, 34218, 35733,
    37315, 38967, 40693, 42494, 44376, 46340, 48392, 50534, 52772,
    55108, 57548, 60096, 62757, 65535
};

WiFiUDP udp;

unsigned char data[3 * MESH_MAX_ID];
unsigned short data_offset = 0;

void setup() {
  // alternate functions of UART pins
  pinMode(LED_PIN_GREEN, FUNCTION_3);

  WiFi.mode(WIFI_STA);
  WiFi.begin(MESH_SSID, MESH_PASSWORD);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
  }

  IPAddress ip = WiFi.localIP();
  data_offset = 3 * (ip[3] - MESH_IP_OFFSET);

  udp.begin(MESH_PORT);
}

void loop() {
  int size = udp.parsePacket();
  if (size) {
    uint8_t red, green, blue;

    udp.read(data, 3 * MESH_MAX_ID);

    // TODO: check whether first received or previously configured MAC does match
    // parse package here
    red = data[data_offset];
    green = data[data_offset + 1];
    blue = data[data_offset + 2];

    analogWrite(LED_PIN_RED, pwmtable_16[red]);
    analogWrite(LED_PIN_GREEN, pwmtable_16[green]);
    analogWrite(LED_PIN_BLUE, pwmtable_16[blue]);
  }
}
