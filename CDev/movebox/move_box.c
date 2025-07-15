#include <exec/types.h>
#include <exec/exec.h>
#include <graphics/gfx.h>
#include <graphics/view.h>
#include <intuition/intuition.h>
#include <hardware/input.h>

#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#include <proto/keymap.h>

#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 256

struct Screen *scr;
struct Window *win;
struct RastPort *rp;

int boxX = 100;
int boxY = 100;
int boxW = 20;
int boxH = 20;

void draw_box(){
	SetAPen(rp,1); //white
	RectFill(rp, boxX, boxY, boxX+boxW, boxY+boxH);
}

void clear_screen() {
	SetRast(rp,0); //black
}

void open_window() {

scr= OpenScreenTags(NULL,
	SA_Width,SCREEN_WIDTH,
	SA_Height, SCREEN_HEIGHT,
	SA_Depth, 2,
	SA_Title, (ULONG)"Mein move box",
	TAG_DONE);
	
win = OpenWindowTags(NULL,
	WA_CustomScreen, (ULONG)scr,
	WA_Width, SCREEN_WIDTH,
	WA_Height, SCREEN_HEIGHT,
	WA_Left, 0,
	WA_Top, 0,
	WA_Flags, WFLG_SIMPLE_REFRESH | WFLG_BORDERLESS,
	WA_IDCMP,IDCMP_RAWKEY | IDCMP_CLOSEWINDOW,
	TAG_DONE);
rp = win ->RPort;	
}

void close_window() {
	if (win) CloseWindow(win);
	if (scr) CloseScreen(scr);
}

void main_loop() {
	BOOL running = TRUE;
	struct IntuiMessage *msg;

	while (running) {
		clear_screen();
		draw_box();
		WaitTOF(); //vsync

		while ((msg = (struct IntuiMessage *)GetMsg(win->UserPort))) {
			if (msg->Class == IDCMP_RAWKEY) {
			UWORD code = msg->Code;

			switch(code) {
				case 0x4F: boxX += 5; break; //R ->
				case 0x4E: boxX -= 5; break; // L <-
				case 0x4C: boxY -= 5; break; //up
				case 0x4D: boxY += 5; break; //down
				case 0x45: running = FALSE; break; //esc
				}
			}
		ReplyMsg((struct Message *)msg);
		}
	}
}

int main() {
	open_window();
	if (scr && win) {
		main_loop();
	}
	close_window();
	return 0;
}
 
