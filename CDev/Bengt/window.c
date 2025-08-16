#include <exec/types.h>
#include <exec/exec.h>
#include <intuition/intuition.h>
#include <proto/exec.h>
#include <proto/intuition.h>

struct Window *win;

int main() {
	IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR)"intuition.library", 0);
	if (!IntuitionBase) return 20;
	
	win = OpenWindowTags(NULL,
		WA_Title, (ULONG)"Hello Amiga",
		WA_Width, 300,
		WA_Height, 100,
		WA_Flags, WFLG_CLOSEGADGET | WFLG_DRAGBAR | WFLG_DEPTHGADGET | WFLG_ACTIVATE,
		WA_IDCMP, IDCMP_CLOSEWINDOW,
		TAG_END);
		
	if(win) {
		BOOL done = FALSE;
		struct IntuiMessage *msg;
		
		while(!done) {
			WaitPort(win->UserPort);
			while((msg = (struct IntuiMessage *)GetMsg(win->UserPort))) {
				if(msg->Class == IDCMP_CLOSEWINDOW) {
					done = TRUE;
				}
				ReplyMsg((struct Message *)msg);
			}
		}
		CloseWindow(win);
	}
	CloseLibrary((struct Library *)IntuitionBase);
	return 0;
}
