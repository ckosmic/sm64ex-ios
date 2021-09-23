#include "controller_api.h"

int currentInput = Touch;

void set_current_input(int type) {
    currentInput = type;
}

int get_current_input() {
    return currentInput;
}
