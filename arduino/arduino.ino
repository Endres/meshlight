#include <painlessMesh.h>

#define LED_PIN_RED   0
#define LED_PIN_GREEN 1
#define LED_PIN_BLUE  2

#define   MESH_SSID       "MeshLight"
#define   MESH_PASSWORD   "this_is_no_internet"
#define   MESH_PORT       9876

// Prototypes
void sendMessage();
void receivedCallback(uint32_t from, String & msg);
void newConnectionCallback(uint32_t nodeId);
void changedConnectionCallback();
void nodeTimeAdjustedCallback(int32_t offset);
void delayReceivedCallback(uint32_t from, int32_t delay);

Scheduler     userScheduler; // to control your personal task
painlessMesh  mesh;

SimpleList<uint32_t> nodes;

size_t node_offset = 0;

void setup() {
  // alternate functions of UART pins
  pinMode(LED_PIN_GREEN, FUNCTION_3);

  mesh.setDebugMsgTypes(ERROR | DEBUG);  // set before init() so that you can see error messages

  mesh.init(MESH_SSID, MESH_PASSWORD, &userScheduler, MESH_PORT);
  mesh.onReceive(&receivedCallback);
  mesh.onChangedConnections(&changedConnectionCallback);
}

void loop() {
  mesh.update();
}

void receivedCallback(uint32_t from, String & msg) {
  uint8_t red, green, blue;
  // TODO: check whether first received or previously configured MAC does match
  // parse package here
  uint8_t *data = ((uint8_t *) msg.c_str()) + node_offset * 3;
  red = *data;
  green = *++data;
  blue = *++data;

  // shifting converts a 8-bit integer value to a 10-bit wide integer, uniformly
  // spread over the interval, such that e.g. 0xFF -> 0x3FF, 0xAA -> 0x2AA,
  // 0x00 -> 0x000
  analogWrite(LED_PIN_RED, 0x3FF - ((red << 2) | (red >> 6)));
  analogWrite(LED_PIN_GREEN, 0x3FF - ((green << 2) | (green >> 6)));
  analogWrite(LED_PIN_BLUE, 0x3FF - ((blue << 2) | (blue >> 6)));
}

// TODO: maybe work with delays of the mesh network, means to also buffer-delay
// received packets until everyone got it. But lets see how it performs without
// this first.

void changedConnectionCallback() {
  // Changed Connections

  nodes = mesh.getNodeList(true);
  //Serial.printf("Num nodes: %d\n", nodes.size());

  nodes.sort();
  size_t i = 0;
  for (auto &&id : nodes) {
    if (id == mesh.getNodeId()) {
      node_offset = i;
      return;
    }
    ++i;
  }
  node_offset = 0;
}
