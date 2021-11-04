#ifndef GFX_SDL_H
#define GFX_SDL_H

#include "gfx_window_manager_api.h"
#include <UIKit/UIKit.h>

extern struct GfxWindowManagerAPI gfx_sdl;
UIViewController *get_sdl_viewcontroller();
static SDL_Window *wnd;

#endif
