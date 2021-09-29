//Not gonna name it .inc.c because of makefile.
//This file will have more layouts for dynamic controls later.

//DEFAULT
struct Position GetDefaultJoystickPos() {
    struct Position ret = { .x = GFX_DIMENSIONS_RECT_FROM_LEFT_EDGE(60) << 2, .y = 720 };
    return ret;
}

struct Position GetDefaultStartPos() {
    struct Position ret = { .x = SCREEN_WIDTH_API / 2 - 68, .y = 880 };
    return ret;
}

struct Position GetDefaultMenuPos() {
    struct Position ret = { .x = SCREEN_WIDTH_API / 2 + 68, .y = 880 };
    return ret;
}

struct Position GetDefaultAPos() {
    struct Position ret = { .x = GFX_DIMENSIONS_RECT_FROM_RIGHT_EDGE(40) << 2, .y = 600 };
    return ret;
}

struct Position GetDefaultBPos() {
    struct Position ret = { .x = GFX_DIMENSIONS_RECT_FROM_RIGHT_EDGE(75) << 2, .y = 600 };
    return ret;
}

struct Position GetDefaultZPos() {
    struct Position ret = { .x = GFX_DIMENSIONS_RECT_FROM_RIGHT_EDGE(40) << 2, .y = 740 };
    return ret;
}

struct Position GetDefaultRPos() {
    struct Position ret = { .x = GFX_DIMENSIONS_RECT_FROM_LEFT_EDGE(40) << 2, .y = 170 };
    return ret;
}

struct Position GetDefaultUpPos() {
    struct Position ret = { .x = GFX_DIMENSIONS_RECT_FROM_RIGHT_EDGE(70) << 2, .y = 170 };
    return ret;
}

struct Position GetDefaultDownPos() {
    struct Position ret = { .x = GFX_DIMENSIONS_RECT_FROM_RIGHT_EDGE(70) << 2, .y = 410 };
    return ret;
}

struct Position GetDefaultLeftPos() {
    struct Position ret = { .x = GFX_DIMENSIONS_RECT_FROM_RIGHT_EDGE(100) << 2, .y = 290 };
    return ret;
}

struct Position GetDefaultRightPos() {
    struct Position ret = { .x = GFX_DIMENSIONS_RECT_FROM_RIGHT_EDGE(40) << 2, .y = 290 };
    return ret;
}

static struct ControlElement ControlElementsDefault[] = {
{.type = Joystick, .GetPos = GetDefaultJoystickPos},
{.type = Button, .GetPos = GetDefaultStartPos, .label = @"S", .buttonID = START_BUTTON},
{.type = Button, .GetPos = GetDefaultMenuPos, .label = @"M", .menuButton = 1},
{.type = Button, .GetPos = GetDefaultAPos, .label = @"A", .buttonID = A_BUTTON},
{.type = Button, .GetPos = GetDefaultBPos, .label = @"B", .buttonID = B_BUTTON},
{.type = Button, .GetPos = GetDefaultZPos, .label = @"Z", .buttonID = Z_TRIG}, //There's no z character, so let's just call it t for trigger
{.type = Button, .GetPos = GetDefaultRPos, .label = @"R", .buttonID = R_TRIG},
{.type = Button, .GetPos = GetDefaultUpPos, .label = @"U", .buttonID = U_CBUTTONS},
{.type = Button, .GetPos = GetDefaultDownPos, .label = @"D", .buttonID = D_CBUTTONS},
{.type = Button, .GetPos = GetDefaultLeftPos, .label = @"L", .buttonID = L_CBUTTONS},
{.type = Button, .GetPos = GetDefaultRightPos, .label = @"R", .buttonID = R_CBUTTONS}
};
