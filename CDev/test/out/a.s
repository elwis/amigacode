
out/a.elf:     file format elf32-m68k


Disassembly of section .text:

00000000 <_start>:
extern void (*__init_array_start[])() __attribute__((weak));
extern void (*__init_array_end[])() __attribute__((weak));
extern void (*__fini_array_start[])() __attribute__((weak));
extern void (*__fini_array_end[])() __attribute__((weak));

__attribute__((used)) __attribute__((section(".text.unlikely"))) void _start() {
       0:	       movem.l d2-d3/a2,-(sp)
	// initialize globals, ctors etc.
	unsigned long count;
	unsigned long i;

	count = __preinit_array_end - __preinit_array_start;
       4:	       move.l #20780,d3
       a:	       subi.l #20780,d3
      10:	       asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	       move.l #20780,d0
      18:	       cmpi.l #20780,d0
      1e:	,----- beq.s 32 <_start+0x32>
      20:	|      lea 512c <incbin_image_start>,a2
      26:	|      moveq #0,d2
		__preinit_array_start[i]();
      28:	|  ,-> movea.l (a2)+,a0
      2a:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
      2c:	|  |   addq.l #1,d2
      2e:	|  |   cmp.l d3,d2
      30:	|  '-- bcs.s 28 <_start+0x28>

	count = __init_array_end - __init_array_start;
      32:	'----> move.l #20780,d3
      38:	       subi.l #20780,d3
      3e:	       asr.l #2,d3
	for (i = 0; i < count; i++)
      40:	       move.l #20780,d0
      46:	       cmpi.l #20780,d0
      4c:	,----- beq.s 60 <_start+0x60>
      4e:	|      lea 512c <incbin_image_start>,a2
      54:	|      moveq #0,d2
		__init_array_start[i]();
      56:	|  ,-> movea.l (a2)+,a0
      58:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
      5a:	|  |   addq.l #1,d2
      5c:	|  |   cmp.l d3,d2
      5e:	|  '-- bcs.s 56 <_start+0x56>

	main();
      60:	'----> jsr 8c <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
      66:	       move.l #20780,d2
      6c:	       subi.l #20780,d2
      72:	       asr.l #2,d2
	for (i = count; i > 0; i--)
      74:	,----- beq.s 86 <_start+0x86>
      76:	|      lea 512c <incbin_image_start>,a2
		__fini_array_start[i - 1]();
      7c:	|  ,-> subq.l #1,d2
      7e:	|  |   movea.l -(a2),a0
      80:	|  |   jsr (a0)
	for (i = count; i > 0; i--)
      82:	|  |   tst.l d2
      84:	|  '-- bne.s 7c <_start+0x7c>
}
      86:	'----> movem.l (sp)+,d2-d3/a2
      8a:	       rts

0000008c <main>:
static void Wait10() { WaitLine(0x10); }
static void Wait11() { WaitLine(0x11); }
static void Wait12() { WaitLine(0x12); }
static void Wait13() { WaitLine(0x13); }

int main() {
      8c:	                                                          link.w a5,#-52
      90:	                                                          movem.l d2-d7/a2-a4/a6,-(sp)
	SysBase = *((struct ExecBase**)4UL);
      94:	                                                          movea.l 4 <_start+0x4>,a6
      98:	                                                          move.l a6,13cc4 <SysBase>
	custom = (struct Custom*)0xdff000;
      9e:	                                                          move.l #14675968,13cce <custom>

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR)"graphics.library",0);
      a8:	                                                          lea 2f5e <incbin_player_end+0xd4>,a1
      ae:	                                                          moveq #0,d0
      b0:	                                                          jsr -552(a6)
      b4:	                                                          move.l d0,13cc0 <GfxBase>
	if (!GfxBase)
      ba:	      ,-------------------------------------------------- beq.w c4e <main+0xbc2>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
      be:	      |                                                   movea.l 13cc4 <SysBase>,a6
      c4:	      |                                                   lea 2f6f <incbin_player_end+0xe5>,a1
      ca:	      |                                                   moveq #0,d0
      cc:	      |                                                   jsr -552(a6)
      d0:	      |                                                   move.l d0,13cbc <DOSBase>
	if (!DOSBase)
      d6:	,-----|-------------------------------------------------- beq.w bde <main+0xb52>
		Exit(0);

#ifdef __cplusplus
	KPrintF("Hello debugger from Amiga: %ld!\n", staticClass.i);
#else
	KPrintF("Hello debugger from Amiga!\n");
      da:	|  ,--|-------------------------------------------------> pea 2f7b <incbin_player_end+0xf1>
      e0:	|  |  |                                                   jsr f80 <KPrintF>
#endif
	Write(Output(), (APTR)"Hello console!\n", 15);
      e6:	|  |  |                                                   movea.l 13cbc <DOSBase>,a6
      ec:	|  |  |                                                   jsr -60(a6)
      f0:	|  |  |                                                   movea.l 13cbc <DOSBase>,a6
      f6:	|  |  |                                                   move.l d0,d1
      f8:	|  |  |                                                   move.l #12183,d2
      fe:	|  |  |                                                   moveq #15,d3
     100:	|  |  |                                                   jsr -48(a6)
	Delay(50);
     104:	|  |  |                                                   movea.l 13cbc <DOSBase>,a6
     10a:	|  |  |                                                   moveq #50,d1
     10c:	|  |  |                                                   jsr -198(a6)

	warpmode(1);
     110:	|  |  |                                                   pea 1 <_start+0x1>
     114:	|  |  |                                                   lea ff2 <warpmode>,a4
     11a:	|  |  |                                                   jsr (a4)
		register volatile const void* _a0 ASM("a0") = module;
     11c:	|  |  |                                                   lea 12830 <incbin_module_start>,a0
		register volatile const void* _a1 ASM("a1") = NULL;
     122:	|  |  |                                                   suba.l a1,a1
		register volatile const void* _a2 ASM("a2") = NULL;
     124:	|  |  |                                                   suba.l a2,a2
		register volatile const void* _a3 ASM("a3") = player;
     126:	|  |  |                                                   lea 1524 <incbin_player_start>,a3
		__asm volatile (
     12c:	|  |  |                                                   movem.l d1-d7/a4-a6,-(sp)
     130:	|  |  |                                                   jsr (a3)
     132:	|  |  |                                                   movem.l (sp)+,d1-d7/a4-a6
	// TODO: precalc stuff here
#ifdef MUSIC
	if(p61Init(module) != 0)
     136:	|  |  |                                                   addq.l #8,sp
     138:	|  |  |                                                   tst.l d0
     13a:	|  |  |  ,----------------------------------------------- bne.w b2e <main+0xaa2>
		KPrintF("p61Init failed!\n");
#endif
	warpmode(0);
     13e:	|  |  |  |  ,-------------------------------------------> clr.l -(sp)
     140:	|  |  |  |  |                                             jsr (a4)
	Forbid();
     142:	|  |  |  |  |                                             movea.l 13cc4 <SysBase>,a6
     148:	|  |  |  |  |                                             jsr -132(a6)
	SystemADKCON=custom->adkconr;
     14c:	|  |  |  |  |                                             movea.l 13cce <custom>,a0
     152:	|  |  |  |  |                                             move.w 16(a0),d0
     156:	|  |  |  |  |                                             move.w d0,13cae <SystemADKCON>
	SystemInts=custom->intenar;
     15c:	|  |  |  |  |                                             move.w 28(a0),d0
     160:	|  |  |  |  |                                             move.w d0,13cb2 <SystemInts>
	SystemDMA=custom->dmaconr;
     166:	|  |  |  |  |                                             move.w 2(a0),d0
     16a:	|  |  |  |  |                                             move.w d0,13cb0 <SystemDMA>
	ActiView=GfxBase->ActiView; //store current view
     170:	|  |  |  |  |                                             movea.l 13cc0 <GfxBase>,a6
     176:	|  |  |  |  |                                             move.l 34(a6),13caa <ActiView>
	LoadView(0);
     17e:	|  |  |  |  |                                             suba.l a1,a1
     180:	|  |  |  |  |                                             jsr -222(a6)
	WaitTOF();
     184:	|  |  |  |  |                                             movea.l 13cc0 <GfxBase>,a6
     18a:	|  |  |  |  |                                             jsr -270(a6)
	WaitTOF();
     18e:	|  |  |  |  |                                             movea.l 13cc0 <GfxBase>,a6
     194:	|  |  |  |  |                                             jsr -270(a6)
	WaitVbl();
     198:	|  |  |  |  |                                             lea ec6 <WaitVbl>,a2
     19e:	|  |  |  |  |                                             jsr (a2)
	WaitVbl();
     1a0:	|  |  |  |  |                                             jsr (a2)
	OwnBlitter();
     1a2:	|  |  |  |  |                                             movea.l 13cc0 <GfxBase>,a6
     1a8:	|  |  |  |  |                                             jsr -456(a6)
	WaitBlit();	
     1ac:	|  |  |  |  |                                             movea.l 13cc0 <GfxBase>,a6
     1b2:	|  |  |  |  |                                             jsr -228(a6)
	Disable();
     1b6:	|  |  |  |  |                                             movea.l 13cc4 <SysBase>,a6
     1bc:	|  |  |  |  |                                             jsr -120(a6)
	custom->intena=0x7fff;//disable all interrupts
     1c0:	|  |  |  |  |                                             movea.l 13cce <custom>,a0
     1c6:	|  |  |  |  |                                             move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
     1cc:	|  |  |  |  |                                             move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
     1d2:	|  |  |  |  |                                             move.w #32767,150(a0)
     1d8:	|  |  |  |  |                                             addq.l #4,sp
	for(int a=0;a<32;a++)
     1da:	|  |  |  |  |                                             moveq #0,d1
		custom->color[a]=0;
     1dc:	|  |  |  |  |        ,----------------------------------> move.l d1,d0
     1de:	|  |  |  |  |        |                                    addi.l #192,d0
     1e4:	|  |  |  |  |        |                                    add.l d0,d0
     1e6:	|  |  |  |  |        |                                    move.w #0,(0,a0,d0.l)
	for(int a=0;a<32;a++)
     1ec:	|  |  |  |  |        |                                    addq.l #1,d1
     1ee:	|  |  |  |  |        |                                    moveq #32,d0
     1f0:	|  |  |  |  |        |                                    cmp.l d1,d0
     1f2:	|  |  |  |  |        +----------------------------------- bne.s 1dc <main+0x150>
	WaitVbl();
     1f4:	|  |  |  |  |        |                                    jsr (a2)
	WaitVbl();
     1f6:	|  |  |  |  |        |                                    jsr (a2)
	UWORD getvbr[] = { 0x4e7a, 0x0801, 0x4e73 }; // MOVEC.L VBR,D0 RTE
     1f8:	|  |  |  |  |        |                                    move.w #20090,-50(a5)
     1fe:	|  |  |  |  |        |                                    move.w #2049,-48(a5)
     204:	|  |  |  |  |        |                                    move.w #20083,-46(a5)
	if (SysBase->AttnFlags & AFF_68010) 
     20a:	|  |  |  |  |        |                                    movea.l 13cc4 <SysBase>,a6
     210:	|  |  |  |  |        |                                    btst #0,297(a6)
     216:	|  |  |  |  |  ,-----|----------------------------------- beq.w c7a <main+0xbee>
		vbr = (APTR)Supervisor((ULONG (*)())getvbr);
     21a:	|  |  |  |  |  |     |                                    moveq #-50,d7
     21c:	|  |  |  |  |  |     |                                    add.l a5,d7
     21e:	|  |  |  |  |  |     |                                    exg d7,a5
     220:	|  |  |  |  |  |     |                                    jsr -30(a6)
     224:	|  |  |  |  |  |     |                                    exg d7,a5
	VBR=GetVBR();
     226:	|  |  |  |  |  |     |                                    move.l d0,13cb8 <VBR>
	return *(volatile APTR*)(((UBYTE*)VBR)+0x6c);
     22c:	|  |  |  |  |  |     |                                    movea.l 13cb8 <VBR>,a0
     232:	|  |  |  |  |  |     |                                    move.l 108(a0),d0
	SystemIrq=GetInterruptHandler(); //store interrupt register
     236:	|  |  |  |  |  |     |                                    move.l d0,13cb4 <SystemIrq>

	TakeSystem();
	WaitVbl();
     23c:	|  |  |  |  |  |     |                                    jsr (a2)

	char* test = (char*)AllocMem(2502, MEMF_ANY);
     23e:	|  |  |  |  |  |     |                                    movea.l 13cc4 <SysBase>,a6
     244:	|  |  |  |  |  |     |                                    move.l #2502,d0
     24a:	|  |  |  |  |  |     |                                    moveq #0,d1
     24c:	|  |  |  |  |  |     |                                    jsr -198(a6)
     250:	|  |  |  |  |  |     |                                    move.l d0,d4
	memset(test, 0xcd, 2502);
     252:	|  |  |  |  |  |     |                                    pea 9c6 <main+0x93a>
     256:	|  |  |  |  |  |     |                                    pea cd <main+0x41>
     25a:	|  |  |  |  |  |     |                                    move.l d0,-(sp)
     25c:	|  |  |  |  |  |     |                                    jsr 12b8 <memset>
	memclr(test + 2, 2502 - 4);
     262:	|  |  |  |  |  |     |                                    movea.l d4,a0
     264:	|  |  |  |  |  |     |                                    addq.l #2,a0
	__asm volatile (
     266:	|  |  |  |  |  |     |                                    move.l #2498,d5
     26c:	|  |  |  |  |  |     |                                    adda.l d5,a0
     26e:	|  |  |  |  |  |     |                                    moveq #0,d0
     270:	|  |  |  |  |  |     |                                    moveq #0,d1
     272:	|  |  |  |  |  |     |                                    moveq #0,d2
     274:	|  |  |  |  |  |     |                                    moveq #0,d3
     276:	|  |  |  |  |  |     |                                    cmpi.l #256,d5
     27c:	|  |  |  |  |  |     |                             ,----- blt.w 2d0 <main+0x244>
     280:	|  |  |  |  |  |     |                             |  ,-> movem.l d0-d3,-(a0)
     284:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     288:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     28c:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     290:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     294:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     298:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     29c:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2a0:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2a4:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2a8:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2ac:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2b0:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2b4:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2b8:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2bc:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2c0:	|  |  |  |  |  |     |                             |  |   subi.l #256,d5
     2c6:	|  |  |  |  |  |     |                             |  |   cmpi.l #256,d5
     2cc:	|  |  |  |  |  |     |                             |  '-- bge.w 280 <main+0x1f4>
     2d0:	|  |  |  |  |  |     |                             >----> cmpi.w #64,d5
     2d4:	|  |  |  |  |  |     |                             |  ,-- blt.w 2f0 <main+0x264>
     2d8:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2dc:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2e0:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2e4:	|  |  |  |  |  |     |                             |  |   movem.l d0-d3,-(a0)
     2e8:	|  |  |  |  |  |     |                             |  |   subi.w #64,d5
     2ec:	|  |  |  |  |  |     |                             '--|-- bra.w 2d0 <main+0x244>
     2f0:	|  |  |  |  |  |     |                                '-> lsr.w #2,d5
     2f2:	|  |  |  |  |  |     |                                ,-- bcc.w 2f8 <main+0x26c>
     2f6:	|  |  |  |  |  |     |                                |   move.w d0,-(a0)
     2f8:	|  |  |  |  |  |     |                                '-> moveq #16,d1
     2fa:	|  |  |  |  |  |     |                                    sub.w d5,d1
     2fc:	|  |  |  |  |  |     |                                    add.w d1,d1
     2fe:	|  |  |  |  |  |     |                                    jmp (302 <main+0x276>,pc,d1.w)
     302:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     304:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     306:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     308:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     30a:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     30c:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     30e:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     310:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     312:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     314:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     316:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     318:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     31a:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     31c:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     31e:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
     320:	|  |  |  |  |  |     |                                    move.l d0,-(a0)
	FreeMem(test, 2502);
     322:	|  |  |  |  |  |     |                                    movea.l 13cc4 <SysBase>,a6
     328:	|  |  |  |  |  |     |                                    movea.l d4,a1
     32a:	|  |  |  |  |  |     |                                    move.l #2502,d0
     330:	|  |  |  |  |  |     |                                    jsr -210(a6)

	USHORT* copper1 = (USHORT*)AllocMem(1024, MEMF_CHIP);
     334:	|  |  |  |  |  |     |                                    movea.l 13cc4 <SysBase>,a6
     33a:	|  |  |  |  |  |     |                                    move.l #1024,d0
     340:	|  |  |  |  |  |     |                                    moveq #2,d1
     342:	|  |  |  |  |  |     |                                    jsr -198(a6)
     346:	|  |  |  |  |  |     |                                    movea.l d0,a3
	USHORT* copPtr = copper1;

	// register graphics resources with WinUAE for nicer gfx debugger experience
	debug_register_bitmap(image, "image.bpl", 320, 256, 5, debug_resource_bitmap_interleaved);
     348:	|  |  |  |  |  |     |                                    pea 1 <_start+0x1>
     34c:	|  |  |  |  |  |     |                                    pea 100 <main+0x74>
     350:	|  |  |  |  |  |     |                                    pea 140 <main+0xb4>
     354:	|  |  |  |  |  |     |                                    pea 2fb8 <incbin_player_end+0x12e>
     35a:	|  |  |  |  |  |     |                                    pea 512c <incbin_image_start>
     360:	|  |  |  |  |  |     |                                    lea 114e <debug_register_bitmap.constprop.0>,a4
     366:	|  |  |  |  |  |     |                                    jsr (a4)
	debug_register_bitmap(bob, "bob.bpl", 32, 96, 5, debug_resource_bitmap_interleaved | debug_resource_bitmap_masked);
     368:	|  |  |  |  |  |     |                                    lea 32(sp),sp
     36c:	|  |  |  |  |  |     |                                    pea 3 <_start+0x3>
     370:	|  |  |  |  |  |     |                                    pea 60 <_start+0x60>
     374:	|  |  |  |  |  |     |                                    pea 20 <_start+0x20>
     378:	|  |  |  |  |  |     |                                    pea 2fc2 <incbin_player_end+0x138>
     37e:	|  |  |  |  |  |     |                                    pea 1192e <incbin_bob_start>
     384:	|  |  |  |  |  |     |                                    jsr (a4)
	my_strncpy(resource.name, name, sizeof(resource.name));
	debug_cmd(barto_cmd_register_resource, (unsigned int)&resource, 0, 0);
}

void debug_register_palette(const void* addr, const char* name, short numEntries, unsigned short flags) {
	struct debug_resource resource = {
     386:	|  |  |  |  |  |     |                                    clr.l -42(a5)
     38a:	|  |  |  |  |  |     |                                    clr.l -38(a5)
     38e:	|  |  |  |  |  |     |                                    clr.l -34(a5)
     392:	|  |  |  |  |  |     |                                    clr.l -30(a5)
     396:	|  |  |  |  |  |     |                                    clr.l -26(a5)
     39a:	|  |  |  |  |  |     |                                    clr.l -22(a5)
     39e:	|  |  |  |  |  |     |                                    clr.l -18(a5)
     3a2:	|  |  |  |  |  |     |                                    clr.l -14(a5)
     3a6:	|  |  |  |  |  |     |                                    clr.l -10(a5)
     3aa:	|  |  |  |  |  |     |                                    clr.l -6(a5)
     3ae:	|  |  |  |  |  |     |                                    clr.w -2(a5)
		.address = (unsigned int)addr,
     3b2:	|  |  |  |  |  |     |                                    move.l #5346,d3
	struct debug_resource resource = {
     3b8:	|  |  |  |  |  |     |                                    move.l d3,-50(a5)
     3bc:	|  |  |  |  |  |     |                                    moveq #64,d1
     3be:	|  |  |  |  |  |     |                                    move.l d1,-46(a5)
     3c2:	|  |  |  |  |  |     |                                    move.w #1,-10(a5)
     3c8:	|  |  |  |  |  |     |                                    move.w #32,-6(a5)
     3ce:	|  |  |  |  |  |     |                                    lea 20(sp),sp
	while(*source && --num > 0)
     3d2:	|  |  |  |  |  |     |                                    moveq #105,d0
	struct debug_resource resource = {
     3d4:	|  |  |  |  |  |     |                                    lea -42(a5),a1
     3d8:	|  |  |  |  |  |     |                                    lea 2f54 <incbin_player_end+0xca>,a0
		*destination++ = *source++;
     3de:	|  |  |  |  |  |  ,--|----------------------------------> addq.l #1,a0
     3e0:	|  |  |  |  |  |  |  |                                    move.b d0,(a1)+
	while(*source && --num > 0)
     3e2:	|  |  |  |  |  |  |  |                                    move.b (a0),d0
     3e4:	|  |  |  |  |  |  |  |                                ,-- beq.s 3ee <main+0x362>
     3e6:	|  |  |  |  |  |  |  |                                |   cmpa.l #12147,a0
     3ec:	|  |  |  |  |  |  +--|--------------------------------|-- bne.s 3de <main+0x352>
	*destination = '\0';
     3ee:	|  |  |  |  |  |  |  |                                '-> clr.b (a1)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     3f0:	|  |  |  |  |  |  |  |                                    move.w f0ff60 <_end+0xefc28c>,d0
     3f6:	|  |  |  |  |  |  |  |                                    cmpi.w #20153,d0
     3fa:	|  |  |  |  |  |  |  |     ,----------------------------- beq.w 9c2 <main+0x936>
     3fe:	|  |  |  |  |  |  |  |     |                              cmpi.w #-24562,d0
     402:	|  |  |  |  |  |  |  |     +----------------------------- beq.w 9c2 <main+0x936>
	debug_register_palette(colors, "image.pal", 32, 0);
	debug_register_copperlist(copper1, "copper1", 1024, 0);
     406:	|  |  |  |  |  |  |  |     |                              pea 400 <main+0x374>
     40a:	|  |  |  |  |  |  |  |     |                              pea 2fca <incbin_player_end+0x140>
     410:	|  |  |  |  |  |  |  |     |                              move.l a3,-(sp)
     412:	|  |  |  |  |  |  |  |     |                              lea 121e <debug_register_copperlist.constprop.0>,a4
     418:	|  |  |  |  |  |  |  |     |                              jsr (a4)
	debug_register_copperlist(copper2, "copper2", sizeof(copper2), 0);
     41a:	|  |  |  |  |  |  |  |     |                              pea 80 <_start+0x80>
     41e:	|  |  |  |  |  |  |  |     |                              pea 2fd2 <incbin_player_end+0x148>
     424:	|  |  |  |  |  |  |  |     |                              pea 30ac <copper2>
     42a:	|  |  |  |  |  |  |  |     |                              jsr (a4)
	*copListEnd++ = offsetof(struct Custom, ddfstrt);
     42c:	|  |  |  |  |  |  |  |     |                              move.w #146,(a3)
	*copListEnd++ = fw;
     430:	|  |  |  |  |  |  |  |     |                              move.w #56,2(a3)
	*copListEnd++ = offsetof(struct Custom, ddfstop);
     436:	|  |  |  |  |  |  |  |     |                              move.w #148,4(a3)
	*copListEnd++ = fw+(((width>>4)-1)<<3);
     43c:	|  |  |  |  |  |  |  |     |                              move.w #208,6(a3)
	*copListEnd++ = offsetof(struct Custom, diwstrt);
     442:	|  |  |  |  |  |  |  |     |                              move.w #142,8(a3)
	*copListEnd++ = x+(y<<8);
     448:	|  |  |  |  |  |  |  |     |                              move.w #11393,10(a3)
	*copListEnd++ = offsetof(struct Custom, diwstop);
     44e:	|  |  |  |  |  |  |  |     |                              move.w #144,12(a3)
	*copListEnd++ = (xstop-256)+((ystop-256)<<8);
     454:	|  |  |  |  |  |  |  |     |                              move.w #11457,14(a3)

	copPtr = screenScanDefault(copPtr);
	//enable bitplanes	
	*copPtr++ = offsetof(struct Custom, bplcon0);
     45a:	|  |  |  |  |  |  |  |     |                              move.w #256,16(a3)
	*copPtr++ = (0<<10)/*dual pf*/|(1<<9)/*color*/|((5)<<12)/*num bitplanes*/;
     460:	|  |  |  |  |  |  |  |     |                              move.w #20992,18(a3)
	*copPtr++ = offsetof(struct Custom, bplcon1);	//scrolling
     466:	|  |  |  |  |  |  |  |     |                              move.w #258,20(a3)
     46c:	|  |  |  |  |  |  |  |     |                              lea 22(a3),a0
     470:	|  |  |  |  |  |  |  |     |                              move.l a0,13cca <scroll>
	scroll = copPtr;
	*copPtr++ = 0;
     476:	|  |  |  |  |  |  |  |     |                              clr.w 22(a3)
	*copPtr++ = offsetof(struct Custom, bplcon2);	//playfied priority
     47a:	|  |  |  |  |  |  |  |     |                              move.w #260,24(a3)
	*copPtr++ = 1<<6;//0x24;			//Sprites have priority over playfields
     480:	|  |  |  |  |  |  |  |     |                              move.w #64,26(a3)

	const USHORT lineSize=320/8;

	//set bitplane modulo
	*copPtr++=offsetof(struct Custom, bpl1mod); //odd planes   1,3,5
     486:	|  |  |  |  |  |  |  |     |                              move.w #264,28(a3)
	*copPtr++=4*lineSize;
     48c:	|  |  |  |  |  |  |  |     |                              move.w #160,30(a3)
	*copPtr++=offsetof(struct Custom, bpl2mod); //even  planes 2,4
     492:	|  |  |  |  |  |  |  |     |                              move.w #266,32(a3)
	*copPtr++=4*lineSize;
     498:	|  |  |  |  |  |  |  |     |                              move.w #160,34(a3)
		ULONG addr=(ULONG)planes[i];
     49e:	|  |  |  |  |  |  |  |     |                              move.l #20780,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     4a4:	|  |  |  |  |  |  |  |     |                              move.w #224,36(a3)
		*copListEnd++=(UWORD)(addr>>16);
     4aa:	|  |  |  |  |  |  |  |     |                              move.l d0,d1
     4ac:	|  |  |  |  |  |  |  |     |                              clr.w d1
     4ae:	|  |  |  |  |  |  |  |     |                              swap d1
     4b0:	|  |  |  |  |  |  |  |     |                              move.w d1,38(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     4b4:	|  |  |  |  |  |  |  |     |                              move.w #226,40(a3)
		*copListEnd++=(UWORD)addr;
     4ba:	|  |  |  |  |  |  |  |     |                              move.w d0,42(a3)
		ULONG addr=(ULONG)planes[i];
     4be:	|  |  |  |  |  |  |  |     |                              move.l #20820,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     4c4:	|  |  |  |  |  |  |  |     |                              move.w #228,44(a3)
		*copListEnd++=(UWORD)(addr>>16);
     4ca:	|  |  |  |  |  |  |  |     |                              move.l d0,d1
     4cc:	|  |  |  |  |  |  |  |     |                              clr.w d1
     4ce:	|  |  |  |  |  |  |  |     |                              swap d1
     4d0:	|  |  |  |  |  |  |  |     |                              move.w d1,46(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     4d4:	|  |  |  |  |  |  |  |     |                              move.w #230,48(a3)
		*copListEnd++=(UWORD)addr;
     4da:	|  |  |  |  |  |  |  |     |                              move.w d0,50(a3)
		ULONG addr=(ULONG)planes[i];
     4de:	|  |  |  |  |  |  |  |     |                              move.l #20860,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     4e4:	|  |  |  |  |  |  |  |     |                              move.w #232,52(a3)
		*copListEnd++=(UWORD)(addr>>16);
     4ea:	|  |  |  |  |  |  |  |     |                              move.l d0,d1
     4ec:	|  |  |  |  |  |  |  |     |                              clr.w d1
     4ee:	|  |  |  |  |  |  |  |     |                              swap d1
     4f0:	|  |  |  |  |  |  |  |     |                              move.w d1,54(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     4f4:	|  |  |  |  |  |  |  |     |                              move.w #234,56(a3)
		*copListEnd++=(UWORD)addr;
     4fa:	|  |  |  |  |  |  |  |     |                              move.w d0,58(a3)
		ULONG addr=(ULONG)planes[i];
     4fe:	|  |  |  |  |  |  |  |     |                              move.l #20900,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     504:	|  |  |  |  |  |  |  |     |                              move.w #236,60(a3)
		*copListEnd++=(UWORD)(addr>>16);
     50a:	|  |  |  |  |  |  |  |     |                              move.l d0,d1
     50c:	|  |  |  |  |  |  |  |     |                              clr.w d1
     50e:	|  |  |  |  |  |  |  |     |                              swap d1
     510:	|  |  |  |  |  |  |  |     |                              move.w d1,62(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     514:	|  |  |  |  |  |  |  |     |                              move.w #238,64(a3)
		*copListEnd++=(UWORD)addr;
     51a:	|  |  |  |  |  |  |  |     |                              move.w d0,66(a3)
		ULONG addr=(ULONG)planes[i];
     51e:	|  |  |  |  |  |  |  |     |                              move.l #20940,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     524:	|  |  |  |  |  |  |  |     |                              move.w #240,68(a3)
		*copListEnd++=(UWORD)(addr>>16);
     52a:	|  |  |  |  |  |  |  |     |                              move.l d0,d1
     52c:	|  |  |  |  |  |  |  |     |                              clr.w d1
     52e:	|  |  |  |  |  |  |  |     |                              swap d1
     530:	|  |  |  |  |  |  |  |     |                              move.w d1,70(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     534:	|  |  |  |  |  |  |  |     |                              move.w #242,72(a3)
		*copListEnd++=(UWORD)addr;
     53a:	|  |  |  |  |  |  |  |     |                              move.w d0,74(a3)
	for (USHORT i=0;i<numPlanes;i++) {
     53e:	|  |  |  |  |  |  |  |     |                              lea 76(a3),a1
     542:	|  |  |  |  |  |  |  |     |                              move.l #5410,d2
     548:	|  |  |  |  |  |  |  |     |                              lea 24(sp),sp
		*copListEnd++=(UWORD)addr;
     54c:	|  |  |  |  |  |  |  |     |                              lea 14e2 <incbin_colors_start>,a0
     552:	|  |  |  |  |  |  |  |     |                              move.w #382,d0
     556:	|  |  |  |  |  |  |  |     |                              sub.w d3,d0
		planes[a]=(UBYTE*)image + lineSize * a;
	copPtr = copSetPlanes(0, copPtr, planes, 5);

	// set colors
	for(int a=0; a < 32; a++)
		copPtr = copSetColor(copPtr, a, ((USHORT*)colors)[a]);
     558:	|  |  |  |  |  |  |  |  ,--|----------------------------> move.w (a0)+,d1
	*copListCurrent++=offsetof(struct Custom, color) + sizeof(UWORD) * index;
     55a:	|  |  |  |  |  |  |  |  |  |                              movea.w d0,a6
     55c:	|  |  |  |  |  |  |  |  |  |                              adda.w a0,a6
     55e:	|  |  |  |  |  |  |  |  |  |                              move.w a6,(a1)
	*copListCurrent++=color;
     560:	|  |  |  |  |  |  |  |  |  |                              addq.l #4,a1
     562:	|  |  |  |  |  |  |  |  |  |                              move.w d1,-2(a1)
	for(int a=0; a < 32; a++)
     566:	|  |  |  |  |  |  |  |  |  |                              cmpa.l d2,a0
     568:	|  |  |  |  |  |  |  |  +--|----------------------------- bne.s 558 <main+0x4cc>

	// jump to copper2
	*copPtr++ = offsetof(struct Custom, copjmp2);
     56a:	|  |  |  |  |  |  |  |  |  |                              move.w #138,204(a3)
	*copPtr++ = 0x7fff;
     570:	|  |  |  |  |  |  |  |  |  |                              move.w #32767,206(a3)

	custom->cop1lc = (ULONG)copper1;
     576:	|  |  |  |  |  |  |  |  |  |                              movea.l 13cce <custom>,a0
     57c:	|  |  |  |  |  |  |  |  |  |                              move.l a3,128(a0)
	custom->cop2lc = (ULONG)copper2;
     580:	|  |  |  |  |  |  |  |  |  |                              move.l #12460,132(a0)
	custom->dmacon = DMAF_BLITTER;//disable blitter dma for copjmp bug
     588:	|  |  |  |  |  |  |  |  |  |                              move.w #64,150(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     58e:	|  |  |  |  |  |  |  |  |  |                              move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER;
     594:	|  |  |  |  |  |  |  |  |  |                              move.w #-31808,150(a0)
	*(volatile APTR*)(((UBYTE*)VBR)+0x6c) = interrupt;
     59a:	|  |  |  |  |  |  |  |  |  |                              movea.l 13cb8 <VBR>,a1
     5a0:	|  |  |  |  |  |  |  |  |  |                              move.l #3640,108(a1)

	// DEMO
	SetInterruptHandler((APTR)interruptHandler);
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
     5a8:	|  |  |  |  |  |  |  |  |  |                              move.w #-16352,154(a0)
#ifdef MUSIC
	custom->intena = INTF_SETCLR | INTF_EXTER; // ThePlayer needs INTF_EXTER
     5ae:	|  |  |  |  |  |  |  |  |  |                              move.w #-24576,154(a0)
#endif

	custom->intreq=(1<<INTB_VERTB);//reset vbl req
     5b4:	|  |  |  |  |  |  |  |  |  |                              move.w #32,156(a0)
__attribute__((always_inline)) inline short MouseLeft(){return !((*(volatile UBYTE*)0xbfe001)&64);}	
     5ba:	|  |  |  |  |  |  |  |  |  |                              move.b bfe001 <_end+0xbea32d>,d0

	while(!MouseLeft()) {
     5c0:	|  |  |  |  |  |  |  |  |  |                              btst #6,d0
     5c4:	|  |  |  |  |  |  |  |  |  |  ,-------------------------- beq.w 744 <main+0x6b8>
     5c8:	|  |  |  |  |  |  |  |  |  |  |                           lea 14a2 <__umodsi3>,a4
     5ce:	|  |  |  |  |  |  |  |  |  |  |                           lea 2ff9 <sinus40>,a3
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
     5d4:	|  |  |  |  |  |  |  |  |  |  |  ,----------------------> move.l dff004 <_end+0xdeb330>,d0
     5da:	|  |  |  |  |  |  |  |  |  |  |  |                        move.l d0,-50(a5)
		if(((vpos >> 8) & 511) == line)
     5de:	|  |  |  |  |  |  |  |  |  |  |  |                        move.l -50(a5),d0
     5e2:	|  |  |  |  |  |  |  |  |  |  |  |                        andi.l #130816,d0
     5e8:	|  |  |  |  |  |  |  |  |  |  |  |                        cmpi.l #4096,d0
     5ee:	|  |  |  |  |  |  |  |  |  |  |  +----------------------- bne.s 5d4 <main+0x548>
		Wait10();
		int f = frameCounter & 255;
     5f0:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w 13cc8 <frameCounter>,d7

		// clear
		WaitBlit();
     5f6:	|  |  |  |  |  |  |  |  |  |  |  |                        movea.l 13cc0 <GfxBase>,a6
     5fc:	|  |  |  |  |  |  |  |  |  |  |  |                        jsr -228(a6)
		custom->bltcon0 = A_TO_D | DEST;
     600:	|  |  |  |  |  |  |  |  |  |  |  |                        movea.l 13cce <custom>,a0
     606:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #496,64(a0)
		custom->bltcon1 = 0;
     60c:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #0,66(a0)
		custom->bltadat = 0;
     612:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #0,116(a0)
		custom->bltdpt = (UBYTE*)image + 320 / 8 * 200 * 5;
     618:	|  |  |  |  |  |  |  |  |  |  |  |                        move.l #60780,84(a0)
		custom->bltdmod = 0;
     620:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #0,102(a0)
		custom->bltafwm = custom->bltalwm = 0xffff;
     626:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #-1,70(a0)
     62c:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #-1,68(a0)
		custom->bltsize = ((56 * 5) << HSIZEBITS) | (320/16);
     632:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w #17940,88(a0)
     638:	|  |  |  |  |  |  |  |  |  |  |  |                        moveq #0,d6
     63a:	|  |  |  |  |  |  |  |  |  |  |  |                        moveq #0,d5

		// blit
		for(short i = 0; i < 16; i++) {
			const short x = i * 16 + sinus32[(frameCounter + i) % sizeof(sinus32)] * 2;
     63c:	|  |  |  |  |  |  |  |  |  |  |  |                    ,-> movea.w 13cc8 <frameCounter>,a0
     642:	|  |  |  |  |  |  |  |  |  |  |  |                    |   pea 33 <_start+0x33>
     646:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.w a0,a6
     648:	|  |  |  |  |  |  |  |  |  |  |  |                    |   pea (0,a6,d5.l)
     64c:	|  |  |  |  |  |  |  |  |  |  |  |                    |   jsr (a4)
     64e:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addq.l #8,sp
     650:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lea 3039 <sinus32>,a0
     656:	|  |  |  |  |  |  |  |  |  |  |  |                    |   moveq #0,d3
     658:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.b (0,a0,d0.l),d3
     65c:	|  |  |  |  |  |  |  |  |  |  |  |                    |   add.l d6,d3
     65e:	|  |  |  |  |  |  |  |  |  |  |  |                    |   add.w d3,d3
			const short y = sinus40[((frameCounter + i) * 2) & 63] / 2;
     660:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.w 13cc8 <frameCounter>,a0
     666:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.w a0,a6
     668:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lea (0,a6,d5.l),a0
     66c:	|  |  |  |  |  |  |  |  |  |  |  |                    |   adda.l a0,a0
     66e:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l a0,d0
     670:	|  |  |  |  |  |  |  |  |  |  |  |                    |   moveq #62,d1
     672:	|  |  |  |  |  |  |  |  |  |  |  |                    |   and.l d1,d0
     674:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.b (0,a3,d0.l),d2
     678:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lsr.b #1,d2
			UBYTE* src = (UBYTE*)bob + 32 / 8 * 10 * 16 * (i % 6);
     67a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w d5,d0
     67c:	|  |  |  |  |  |  |  |  |  |  |  |                    |   moveq #6,d1
     67e:	|  |  |  |  |  |  |  |  |  |  |  |                    |   ext.l d0
     680:	|  |  |  |  |  |  |  |  |  |  |  |                    |   divs.w d1,d0
     682:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l d0,d4
     684:	|  |  |  |  |  |  |  |  |  |  |  |                    |   swap d4
     686:	|  |  |  |  |  |  |  |  |  |  |  |                    |   muls.w #640,d4
     68a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addi.l #71982,d4

			WaitBlit();
     690:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.l 13cc0 <GfxBase>,a6
     696:	|  |  |  |  |  |  |  |  |  |  |  |                    |   jsr -228(a6)
			custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | ((x & 15) << ASHIFTSHIFT); // A = source, B = mask, C = background, D = destination
     69a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.l 13cce <custom>,a0
     6a0:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w d3,d0
     6a2:	|  |  |  |  |  |  |  |  |  |  |  |                    |   moveq #12,d1
     6a4:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lsl.w d1,d0
     6a6:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w d0,d1
     6a8:	|  |  |  |  |  |  |  |  |  |  |  |                    |   ori.w #4042,d1
     6ac:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w d1,64(a0)
			custom->bltcon1 = ((x & 15) << BSHIFTSHIFT);
     6b0:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w d0,66(a0)
			custom->bltapt = src;
     6b4:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l d4,80(a0)
			custom->bltamod = 32 / 8;
     6b8:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #4,100(a0)
			custom->bltbpt = src + 32 / 8 * 1;
     6be:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addq.l #4,d4
     6c0:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l d4,76(a0)
			custom->bltbmod = 32 / 8;
     6c4:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #4,98(a0)
			custom->bltcpt = custom->bltdpt = (UBYTE*)image + 320 / 8 * 5 * (200 + y) + x / 8;
     6ca:	|  |  |  |  |  |  |  |  |  |  |  |                    |   andi.l #255,d2
     6d0:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addi.l #200,d2
     6d6:	|  |  |  |  |  |  |  |  |  |  |  |                    |   muls.w #200,d2
     6da:	|  |  |  |  |  |  |  |  |  |  |  |                    |   asr.w #3,d3
     6dc:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w d3,d0
     6de:	|  |  |  |  |  |  |  |  |  |  |  |                    |   ext.l d0
     6e0:	|  |  |  |  |  |  |  |  |  |  |  |                    |   movea.l d2,a6
     6e2:	|  |  |  |  |  |  |  |  |  |  |  |                    |   lea (0,a6,d0.l),a1
     6e6:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l a1,d0
     6e8:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addi.l #20780,d0
     6ee:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l d0,84(a0)
     6f2:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.l d0,72(a0)
			custom->bltcmod = custom->bltdmod = (320 - 32) / 8;
     6f6:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #36,102(a0)
     6fc:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #36,96(a0)
			custom->bltafwm = custom->bltalwm = 0xffff;
     702:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #-1,70(a0)
     708:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #-1,68(a0)
			custom->bltsize = ((16 * 5) << HSIZEBITS) | (32/16);
     70e:	|  |  |  |  |  |  |  |  |  |  |  |                    |   move.w #5122,88(a0)
		for(short i = 0; i < 16; i++) {
     714:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addq.l #1,d5
     716:	|  |  |  |  |  |  |  |  |  |  |  |                    |   addq.l #8,d6
     718:	|  |  |  |  |  |  |  |  |  |  |  |                    |   moveq #16,d1
     71a:	|  |  |  |  |  |  |  |  |  |  |  |                    |   cmp.l d5,d1
     71c:	|  |  |  |  |  |  |  |  |  |  |  |                    '-- bne.w 63c <main+0x5b0>
     720:	|  |  |  |  |  |  |  |  |  |  |  |                        move.w f0ff60 <_end+0xefc28c>,d0
     726:	|  |  |  |  |  |  |  |  |  |  |  |                        cmpi.w #20153,d0
     72a:	|  |  |  |  |  |  |  |  |  |  |  |                    ,-- beq.w 842 <main+0x7b6>
     72e:	|  |  |  |  |  |  |  |  |  |  |  |                    |   cmpi.w #-24562,d0
     732:	|  |  |  |  |  |  |  |  |  |  |  |                    +-- beq.w 842 <main+0x7b6>
__attribute__((always_inline)) inline short MouseLeft(){return !((*(volatile UBYTE*)0xbfe001)&64);}	
     736:	|  |  |  |  |  |  |  |  |  |  |  |  ,-----------------|-> move.b bfe001 <_end+0xbea32d>,d0
	while(!MouseLeft()) {
     73c:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   btst #6,d0
     740:	|  |  |  |  |  |  |  |  |  |  |  +--|-----------------|-- bne.w 5d4 <main+0x548>
		register volatile const void* _a3 ASM("a3") = player;
     744:	|  |  |  |  |  |  |  |  |  |  >--|--|-----------------|-> lea 1524 <incbin_player_start>,a3
		register volatile const void* _a6 ASM("a6") = (void*)0xdff000;
     74a:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l #14675968,a6
		__asm volatile (
     750:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movem.l d0-d1/a0-a1,-(sp)
     754:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr 8(a3)
     758:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movem.l (sp)+,d0-d1/a0-a1
	WaitVbl();
     75c:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr (a2)
	WaitBlit();
     75e:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc0 <GfxBase>,a6
     764:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -228(a6)
	custom->intena=0x7fff;//disable all interrupts
     768:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cce <custom>,a0
     76e:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
     774:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
     77a:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w #32767,150(a0)
	*(volatile APTR*)(((UBYTE*)VBR)+0x6c) = interrupt;
     780:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cb8 <VBR>,a1
     786:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.l 13cb4 <SystemIrq>,108(a1)
	custom->cop1lc=(ULONG)GfxBase->copinit;
     78e:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc0 <GfxBase>,a6
     794:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.l 38(a6),128(a0)
	custom->cop2lc=(ULONG)GfxBase->LOFlist;
     79a:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.l 50(a6),132(a0)
	custom->copjmp1=0x7fff; //start coppper
     7a0:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w #32767,136(a0)
	custom->intena=SystemInts|0x8000;
     7a6:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w 13cb2 <SystemInts>,d0
     7ac:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   ori.w #-32768,d0
     7b0:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w d0,154(a0)
	custom->dmacon=SystemDMA|0x8000;
     7b4:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w 13cb0 <SystemDMA>,d0
     7ba:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   ori.w #-32768,d0
     7be:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w d0,150(a0)
	custom->adkcon=SystemADKCON|0x8000;
     7c2:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w 13cae <SystemADKCON>,d0
     7c8:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   ori.w #-32768,d0
     7cc:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   move.w d0,158(a0)
	WaitBlit();	
     7d0:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -228(a6)
	DisownBlitter();
     7d4:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc0 <GfxBase>,a6
     7da:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -462(a6)
	Enable();
     7de:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc4 <SysBase>,a6
     7e4:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -126(a6)
	LoadView(ActiView);
     7e8:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc0 <GfxBase>,a6
     7ee:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13caa <ActiView>,a1
     7f4:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -222(a6)
	WaitTOF();
     7f8:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc0 <GfxBase>,a6
     7fe:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -270(a6)
	WaitTOF();
     802:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc0 <GfxBase>,a6
     808:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -270(a6)
	Permit();
     80c:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc4 <SysBase>,a6
     812:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -138(a6)
#endif

	// END
	FreeSystem();

	CloseLibrary((struct Library*)DOSBase);
     816:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc4 <SysBase>,a6
     81c:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cbc <DOSBase>,a1
     822:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -414(a6)
	CloseLibrary((struct Library*)GfxBase);
     826:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc4 <SysBase>,a6
     82c:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movea.l 13cc0 <GfxBase>,a1
     832:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   jsr -414(a6)
}
     836:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   moveq #0,d0
     838:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   movem.l -92(a5),d2-d7/a2-a4/a6
     83e:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   unlk a5
     840:	|  |  |  |  |  |  |  |  |  |  |  |  |                 |   rts
		UaeLib(88, arg1, arg2, arg3, arg4);
     842:	|  |  |  |  |  |  |  |  |  |  |  |  |                 '-> clr.l -(sp)
     844:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.l -(sp)
     846:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.l -(sp)
     848:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.l -(sp)
     84a:	|  |  |  |  |  |  |  |  |  |  |  |  |                     pea 58 <_start+0x58>
     84e:	|  |  |  |  |  |  |  |  |  |  |  |  |                     movea.l #15794016,a6
     854:	|  |  |  |  |  |  |  |  |  |  |  |  |                     jsr (a6)
		debug_filled_rect(f + 100, 200*2, f + 400, 220*2, 0x0000ff00); // 0x00RRGGBB
     856:	|  |  |  |  |  |  |  |  |  |  |  |  |                     andi.w #255,d7
     85a:	|  |  |  |  |  |  |  |  |  |  |  |  |                     move.w d7,d2
     85c:	|  |  |  |  |  |  |  |  |  |  |  |  |                     addi.w #400,d2
	debug_cmd(barto_cmd_filled_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
     860:	|  |  |  |  |  |  |  |  |  |  |  |  |                     swap d2
     862:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.w d2
     864:	|  |  |  |  |  |  |  |  |  |  |  |  |                     ori.w #440,d2
     868:	|  |  |  |  |  |  |  |  |  |  |  |  |                     move.w d7,d0
     86a:	|  |  |  |  |  |  |  |  |  |  |  |  |                     addi.w #100,d0
     86e:	|  |  |  |  |  |  |  |  |  |  |  |  |                     swap d0
     870:	|  |  |  |  |  |  |  |  |  |  |  |  |                     clr.w d0
     872:	|  |  |  |  |  |  |  |  |  |  |  |  |                     ori.w #400,d0
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     876:	|  |  |  |  |  |  |  |  |  |  |  |  |                     move.w (a6),d1
     878:	|  |  |  |  |  |  |  |  |  |  |  |  |                     lea 20(sp),sp
     87c:	|  |  |  |  |  |  |  |  |  |  |  |  |                     cmpi.w #20153,d1
     880:	|  |  |  |  |  |  |  |  |  |  |  |  |              ,----- bne.w 946 <main+0x8ba>
		UaeLib(88, arg1, arg2, arg3, arg4);
     884:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.l #65280,-(sp)
     88a:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.l d2,-(sp)
     88c:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.l d0,-(sp)
     88e:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      pea 2 <_start+0x2>
     892:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      pea 58 <_start+0x58>
     896:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      movea.l #15794016,a6
     89c:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      jsr (a6)
		debug_rect(f + 90, 190*2, f + 400, 220*2, 0x000000ff); // 0x00RRGGBB
     89e:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.w d7,d0
     8a0:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      addi.w #90,d0
	debug_cmd(barto_cmd_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
     8a4:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      swap d0
     8a6:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      clr.w d0
     8a8:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      ori.w #380,d0
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     8ac:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      move.w (a6),d1
     8ae:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      lea 20(sp),sp
     8b2:	|  |  |  |  |  |  |  |  |  |  |  |  |              |      cmpi.w #20153,d1
     8b6:	|  |  |  |  |  |  |  |  |  |  |  |  |        ,-----|----- bne.w 984 <main+0x8f8>
		UaeLib(88, arg1, arg2, arg3, arg4);
     8ba:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  ,--|----> pea ff <main+0x73>
     8be:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      move.l d2,-(sp)
     8c0:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      move.l d0,-(sp)
     8c2:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      pea 1 <_start+0x1>
     8c6:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      pea 58 <_start+0x58>
     8ca:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      movea.l #15794016,a6
     8d0:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      jsr (a6)
		debug_text(f+ 130, 209*2, "This is a WinUAE debug overlay", 0x00ff00ff);
     8d2:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      addi.w #130,d7
	debug_cmd(barto_cmd_text, (((unsigned int)left) << 16) | ((unsigned int)top), (unsigned int)text, color);
     8d6:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      swap d7
     8d8:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      clr.w d7
     8da:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      ori.w #418,d7
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     8de:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      move.w (a6),d0
     8e0:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      lea 20(sp),sp
     8e4:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |      cmpi.w #20153,d0
     8e8:	|  |  |  |  |  |  |  |  |  |  |  |  |  ,-----|--|--|----- bne.s 91c <main+0x890>
		UaeLib(88, arg1, arg2, arg3, arg4);
     8ea:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  ,--|--|--|----> move.l #16711935,-(sp)
     8f0:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      pea 2fda <incbin_player_end+0x150>
     8f6:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      move.l d7,-(sp)
     8f8:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      pea 3 <_start+0x3>
     8fc:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      pea 58 <_start+0x58>
     900:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      jsr f0ff60 <_end+0xefc28c>
}
     906:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      lea 20(sp),sp
__attribute__((always_inline)) inline short MouseLeft(){return !((*(volatile UBYTE*)0xbfe001)&64);}	
     90a:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ,-> move.b bfe001 <_end+0xbea32d>,d0
	while(!MouseLeft()) {
     910:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   btst #6,d0
     914:	|  |  |  |  |  |  |  |  |  |  |  '--|--|--|--|--|--|--|-- bne.w 5d4 <main+0x548>
     918:	|  |  |  |  |  |  |  |  |  |  '-----|--|--|--|--|--|--|-- bra.w 744 <main+0x6b8>
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     91c:	|  |  |  |  |  |  |  |  |  |        |  >--|--|--|--|--|-> cmpi.w #-24562,d0
     920:	|  |  |  |  |  |  |  |  |  |        +--|--|--|--|--|--|-- bne.w 736 <main+0x6aa>
		UaeLib(88, arg1, arg2, arg3, arg4);
     924:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   move.l #16711935,-(sp)
     92a:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   pea 2fda <incbin_player_end+0x150>
     930:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   move.l d7,-(sp)
     932:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   pea 3 <_start+0x3>
     936:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   pea 58 <_start+0x58>
     93a:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   jsr f0ff60 <_end+0xefc28c>
}
     940:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  |   lea 20(sp),sp
     944:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  |  '-- bra.s 90a <main+0x87e>
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     946:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |  '----> cmpi.w #-24562,d1
     94a:	|  |  |  |  |  |  |  |  |  |        +--|--|--|--|-------- bne.w 736 <main+0x6aa>
		UaeLib(88, arg1, arg2, arg3, arg4);
     94e:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.l #65280,-(sp)
     954:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.l d2,-(sp)
     956:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.l d0,-(sp)
     958:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         pea 2 <_start+0x2>
     95c:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         pea 58 <_start+0x58>
     960:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         movea.l #15794016,a6
     966:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         jsr (a6)
		debug_rect(f + 90, 190*2, f + 400, 220*2, 0x000000ff); // 0x00RRGGBB
     968:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.w d7,d0
     96a:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         addi.w #90,d0
	debug_cmd(barto_cmd_rect, (((unsigned int)left) << 16) | ((unsigned int)top), (((unsigned int)right) << 16) | ((unsigned int)bottom), color);
     96e:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         swap d0
     970:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         clr.w d0
     972:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         ori.w #380,d0
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     976:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         move.w (a6),d1
     978:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         lea 20(sp),sp
     97c:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |         cmpi.w #20153,d1
     980:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  '-------- beq.w 8ba <main+0x82e>
     984:	|  |  |  |  |  |  |  |  |  |        |  |  |  '----------> cmpi.w #-24562,d1
     988:	|  |  |  |  |  |  |  |  |  |        '--|--|-------------- bne.w 736 <main+0x6aa>
		UaeLib(88, arg1, arg2, arg3, arg4);
     98c:	|  |  |  |  |  |  |  |  |  |           |  |               pea ff <main+0x73>
     990:	|  |  |  |  |  |  |  |  |  |           |  |               move.l d2,-(sp)
     992:	|  |  |  |  |  |  |  |  |  |           |  |               move.l d0,-(sp)
     994:	|  |  |  |  |  |  |  |  |  |           |  |               pea 1 <_start+0x1>
     998:	|  |  |  |  |  |  |  |  |  |           |  |               pea 58 <_start+0x58>
     99c:	|  |  |  |  |  |  |  |  |  |           |  |               movea.l #15794016,a6
     9a2:	|  |  |  |  |  |  |  |  |  |           |  |               jsr (a6)
		debug_text(f+ 130, 209*2, "This is a WinUAE debug overlay", 0x00ff00ff);
     9a4:	|  |  |  |  |  |  |  |  |  |           |  |               addi.w #130,d7
	debug_cmd(barto_cmd_text, (((unsigned int)left) << 16) | ((unsigned int)top), (unsigned int)text, color);
     9a8:	|  |  |  |  |  |  |  |  |  |           |  |               swap d7
     9aa:	|  |  |  |  |  |  |  |  |  |           |  |               clr.w d7
     9ac:	|  |  |  |  |  |  |  |  |  |           |  |               ori.w #418,d7
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     9b0:	|  |  |  |  |  |  |  |  |  |           |  |               move.w (a6),d0
     9b2:	|  |  |  |  |  |  |  |  |  |           |  |               lea 20(sp),sp
     9b6:	|  |  |  |  |  |  |  |  |  |           |  |               cmpi.w #20153,d0
     9ba:	|  |  |  |  |  |  |  |  |  |           |  '-------------- beq.w 8ea <main+0x85e>
     9be:	|  |  |  |  |  |  |  |  |  |           '----------------- bra.w 91c <main+0x890>
     9c2:	|  |  |  |  |  |  |  |  |  '----------------------------> clr.l -(sp)
     9c4:	|  |  |  |  |  |  |  |  |                                 clr.l -(sp)
     9c6:	|  |  |  |  |  |  |  |  |                                 pea -50(a5)
     9ca:	|  |  |  |  |  |  |  |  |                                 pea 4 <_start+0x4>
     9ce:	|  |  |  |  |  |  |  |  |                                 jsr ea6 <debug_cmd.part.0>
     9d4:	|  |  |  |  |  |  |  |  |                                 lea 16(sp),sp
	debug_register_copperlist(copper1, "copper1", 1024, 0);
     9d8:	|  |  |  |  |  |  |  |  |                                 pea 400 <main+0x374>
     9dc:	|  |  |  |  |  |  |  |  |                                 pea 2fca <incbin_player_end+0x140>
     9e2:	|  |  |  |  |  |  |  |  |                                 move.l a3,-(sp)
     9e4:	|  |  |  |  |  |  |  |  |                                 lea 121e <debug_register_copperlist.constprop.0>,a4
     9ea:	|  |  |  |  |  |  |  |  |                                 jsr (a4)
	debug_register_copperlist(copper2, "copper2", sizeof(copper2), 0);
     9ec:	|  |  |  |  |  |  |  |  |                                 pea 80 <_start+0x80>
     9f0:	|  |  |  |  |  |  |  |  |                                 pea 2fd2 <incbin_player_end+0x148>
     9f6:	|  |  |  |  |  |  |  |  |                                 pea 30ac <copper2>
     9fc:	|  |  |  |  |  |  |  |  |                                 jsr (a4)
	*copListEnd++ = offsetof(struct Custom, ddfstrt);
     9fe:	|  |  |  |  |  |  |  |  |                                 move.w #146,(a3)
	*copListEnd++ = fw;
     a02:	|  |  |  |  |  |  |  |  |                                 move.w #56,2(a3)
	*copListEnd++ = offsetof(struct Custom, ddfstop);
     a08:	|  |  |  |  |  |  |  |  |                                 move.w #148,4(a3)
	*copListEnd++ = fw+(((width>>4)-1)<<3);
     a0e:	|  |  |  |  |  |  |  |  |                                 move.w #208,6(a3)
	*copListEnd++ = offsetof(struct Custom, diwstrt);
     a14:	|  |  |  |  |  |  |  |  |                                 move.w #142,8(a3)
	*copListEnd++ = x+(y<<8);
     a1a:	|  |  |  |  |  |  |  |  |                                 move.w #11393,10(a3)
	*copListEnd++ = offsetof(struct Custom, diwstop);
     a20:	|  |  |  |  |  |  |  |  |                                 move.w #144,12(a3)
	*copListEnd++ = (xstop-256)+((ystop-256)<<8);
     a26:	|  |  |  |  |  |  |  |  |                                 move.w #11457,14(a3)
	*copPtr++ = offsetof(struct Custom, bplcon0);
     a2c:	|  |  |  |  |  |  |  |  |                                 move.w #256,16(a3)
	*copPtr++ = (0<<10)/*dual pf*/|(1<<9)/*color*/|((5)<<12)/*num bitplanes*/;
     a32:	|  |  |  |  |  |  |  |  |                                 move.w #20992,18(a3)
	*copPtr++ = offsetof(struct Custom, bplcon1);	//scrolling
     a38:	|  |  |  |  |  |  |  |  |                                 move.w #258,20(a3)
     a3e:	|  |  |  |  |  |  |  |  |                                 lea 22(a3),a0
     a42:	|  |  |  |  |  |  |  |  |                                 move.l a0,13cca <scroll>
	*copPtr++ = 0;
     a48:	|  |  |  |  |  |  |  |  |                                 clr.w 22(a3)
	*copPtr++ = offsetof(struct Custom, bplcon2);	//playfied priority
     a4c:	|  |  |  |  |  |  |  |  |                                 move.w #260,24(a3)
	*copPtr++ = 1<<6;//0x24;			//Sprites have priority over playfields
     a52:	|  |  |  |  |  |  |  |  |                                 move.w #64,26(a3)
	*copPtr++=offsetof(struct Custom, bpl1mod); //odd planes   1,3,5
     a58:	|  |  |  |  |  |  |  |  |                                 move.w #264,28(a3)
	*copPtr++=4*lineSize;
     a5e:	|  |  |  |  |  |  |  |  |                                 move.w #160,30(a3)
	*copPtr++=offsetof(struct Custom, bpl2mod); //even  planes 2,4
     a64:	|  |  |  |  |  |  |  |  |                                 move.w #266,32(a3)
	*copPtr++=4*lineSize;
     a6a:	|  |  |  |  |  |  |  |  |                                 move.w #160,34(a3)
		ULONG addr=(ULONG)planes[i];
     a70:	|  |  |  |  |  |  |  |  |                                 move.l #20780,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     a76:	|  |  |  |  |  |  |  |  |                                 move.w #224,36(a3)
		*copListEnd++=(UWORD)(addr>>16);
     a7c:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     a7e:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     a80:	|  |  |  |  |  |  |  |  |                                 swap d1
     a82:	|  |  |  |  |  |  |  |  |                                 move.w d1,38(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     a86:	|  |  |  |  |  |  |  |  |                                 move.w #226,40(a3)
		*copListEnd++=(UWORD)addr;
     a8c:	|  |  |  |  |  |  |  |  |                                 move.w d0,42(a3)
		ULONG addr=(ULONG)planes[i];
     a90:	|  |  |  |  |  |  |  |  |                                 move.l #20820,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     a96:	|  |  |  |  |  |  |  |  |                                 move.w #228,44(a3)
		*copListEnd++=(UWORD)(addr>>16);
     a9c:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     a9e:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     aa0:	|  |  |  |  |  |  |  |  |                                 swap d1
     aa2:	|  |  |  |  |  |  |  |  |                                 move.w d1,46(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     aa6:	|  |  |  |  |  |  |  |  |                                 move.w #230,48(a3)
		*copListEnd++=(UWORD)addr;
     aac:	|  |  |  |  |  |  |  |  |                                 move.w d0,50(a3)
		ULONG addr=(ULONG)planes[i];
     ab0:	|  |  |  |  |  |  |  |  |                                 move.l #20860,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     ab6:	|  |  |  |  |  |  |  |  |                                 move.w #232,52(a3)
		*copListEnd++=(UWORD)(addr>>16);
     abc:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     abe:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     ac0:	|  |  |  |  |  |  |  |  |                                 swap d1
     ac2:	|  |  |  |  |  |  |  |  |                                 move.w d1,54(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     ac6:	|  |  |  |  |  |  |  |  |                                 move.w #234,56(a3)
		*copListEnd++=(UWORD)addr;
     acc:	|  |  |  |  |  |  |  |  |                                 move.w d0,58(a3)
		ULONG addr=(ULONG)planes[i];
     ad0:	|  |  |  |  |  |  |  |  |                                 move.l #20900,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     ad6:	|  |  |  |  |  |  |  |  |                                 move.w #236,60(a3)
		*copListEnd++=(UWORD)(addr>>16);
     adc:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     ade:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     ae0:	|  |  |  |  |  |  |  |  |                                 swap d1
     ae2:	|  |  |  |  |  |  |  |  |                                 move.w d1,62(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     ae6:	|  |  |  |  |  |  |  |  |                                 move.w #238,64(a3)
		*copListEnd++=(UWORD)addr;
     aec:	|  |  |  |  |  |  |  |  |                                 move.w d0,66(a3)
		ULONG addr=(ULONG)planes[i];
     af0:	|  |  |  |  |  |  |  |  |                                 move.l #20940,d0
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR);
     af6:	|  |  |  |  |  |  |  |  |                                 move.w #240,68(a3)
		*copListEnd++=(UWORD)(addr>>16);
     afc:	|  |  |  |  |  |  |  |  |                                 move.l d0,d1
     afe:	|  |  |  |  |  |  |  |  |                                 clr.w d1
     b00:	|  |  |  |  |  |  |  |  |                                 swap d1
     b02:	|  |  |  |  |  |  |  |  |                                 move.w d1,70(a3)
		*copListEnd++=offsetof(struct Custom, bplpt[0]) + (i + bplPtrStart) * sizeof(APTR) + 2;
     b06:	|  |  |  |  |  |  |  |  |                                 move.w #242,72(a3)
		*copListEnd++=(UWORD)addr;
     b0c:	|  |  |  |  |  |  |  |  |                                 move.w d0,74(a3)
	for (USHORT i=0;i<numPlanes;i++) {
     b10:	|  |  |  |  |  |  |  |  |                                 lea 76(a3),a1
     b14:	|  |  |  |  |  |  |  |  |                                 move.l #5410,d2
     b1a:	|  |  |  |  |  |  |  |  |                                 lea 24(sp),sp
		*copListEnd++=(UWORD)addr;
     b1e:	|  |  |  |  |  |  |  |  |                                 lea 14e2 <incbin_colors_start>,a0
     b24:	|  |  |  |  |  |  |  |  |                                 move.w #382,d0
     b28:	|  |  |  |  |  |  |  |  |                                 sub.w d3,d0
     b2a:	|  |  |  |  |  |  |  |  '-------------------------------- bra.w 558 <main+0x4cc>
		KPrintF("p61Init failed!\n");
     b2e:	|  |  |  >--|--|--|--|----------------------------------> pea 2fa7 <incbin_player_end+0x11d>
     b34:	|  |  |  |  |  |  |  |                                    jsr f80 <KPrintF>
     b3a:	|  |  |  |  |  |  |  |                                    addq.l #4,sp
	warpmode(0);
     b3c:	|  |  |  |  |  |  |  |                                    clr.l -(sp)
     b3e:	|  |  |  |  |  |  |  |                                    jsr (a4)
	Forbid();
     b40:	|  |  |  |  |  |  |  |                                    movea.l 13cc4 <SysBase>,a6
     b46:	|  |  |  |  |  |  |  |                                    jsr -132(a6)
	SystemADKCON=custom->adkconr;
     b4a:	|  |  |  |  |  |  |  |                                    movea.l 13cce <custom>,a0
     b50:	|  |  |  |  |  |  |  |                                    move.w 16(a0),d0
     b54:	|  |  |  |  |  |  |  |                                    move.w d0,13cae <SystemADKCON>
	SystemInts=custom->intenar;
     b5a:	|  |  |  |  |  |  |  |                                    move.w 28(a0),d0
     b5e:	|  |  |  |  |  |  |  |                                    move.w d0,13cb2 <SystemInts>
	SystemDMA=custom->dmaconr;
     b64:	|  |  |  |  |  |  |  |                                    move.w 2(a0),d0
     b68:	|  |  |  |  |  |  |  |                                    move.w d0,13cb0 <SystemDMA>
	ActiView=GfxBase->ActiView; //store current view
     b6e:	|  |  |  |  |  |  |  |                                    movea.l 13cc0 <GfxBase>,a6
     b74:	|  |  |  |  |  |  |  |                                    move.l 34(a6),13caa <ActiView>
	LoadView(0);
     b7c:	|  |  |  |  |  |  |  |                                    suba.l a1,a1
     b7e:	|  |  |  |  |  |  |  |                                    jsr -222(a6)
	WaitTOF();
     b82:	|  |  |  |  |  |  |  |                                    movea.l 13cc0 <GfxBase>,a6
     b88:	|  |  |  |  |  |  |  |                                    jsr -270(a6)
	WaitTOF();
     b8c:	|  |  |  |  |  |  |  |                                    movea.l 13cc0 <GfxBase>,a6
     b92:	|  |  |  |  |  |  |  |                                    jsr -270(a6)
	WaitVbl();
     b96:	|  |  |  |  |  |  |  |                                    lea ec6 <WaitVbl>,a2
     b9c:	|  |  |  |  |  |  |  |                                    jsr (a2)
	WaitVbl();
     b9e:	|  |  |  |  |  |  |  |                                    jsr (a2)
	OwnBlitter();
     ba0:	|  |  |  |  |  |  |  |                                    movea.l 13cc0 <GfxBase>,a6
     ba6:	|  |  |  |  |  |  |  |                                    jsr -456(a6)
	WaitBlit();	
     baa:	|  |  |  |  |  |  |  |                                    movea.l 13cc0 <GfxBase>,a6
     bb0:	|  |  |  |  |  |  |  |                                    jsr -228(a6)
	Disable();
     bb4:	|  |  |  |  |  |  |  |                                    movea.l 13cc4 <SysBase>,a6
     bba:	|  |  |  |  |  |  |  |                                    jsr -120(a6)
	custom->intena=0x7fff;//disable all interrupts
     bbe:	|  |  |  |  |  |  |  |                                    movea.l 13cce <custom>,a0
     bc4:	|  |  |  |  |  |  |  |                                    move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
     bca:	|  |  |  |  |  |  |  |                                    move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
     bd0:	|  |  |  |  |  |  |  |                                    move.w #32767,150(a0)
     bd6:	|  |  |  |  |  |  |  |                                    addq.l #4,sp
	for(int a=0;a<32;a++)
     bd8:	|  |  |  |  |  |  |  |                                    moveq #0,d1
     bda:	|  |  |  |  |  |  |  '----------------------------------- bra.w 1dc <main+0x150>
		Exit(0);
     bde:	>--|--|--|--|--|--|-------------------------------------> suba.l a6,a6
     be0:	|  |  |  |  |  |  |                                       moveq #0,d1
     be2:	|  |  |  |  |  |  |                                       jsr -144(a6)
	KPrintF("Hello debugger from Amiga!\n");
     be6:	|  |  |  |  |  |  |                                       pea 2f7b <incbin_player_end+0xf1>
     bec:	|  |  |  |  |  |  |                                       jsr f80 <KPrintF>
	Write(Output(), (APTR)"Hello console!\n", 15);
     bf2:	|  |  |  |  |  |  |                                       movea.l 13cbc <DOSBase>,a6
     bf8:	|  |  |  |  |  |  |                                       jsr -60(a6)
     bfc:	|  |  |  |  |  |  |                                       movea.l 13cbc <DOSBase>,a6
     c02:	|  |  |  |  |  |  |                                       move.l d0,d1
     c04:	|  |  |  |  |  |  |                                       move.l #12183,d2
     c0a:	|  |  |  |  |  |  |                                       moveq #15,d3
     c0c:	|  |  |  |  |  |  |                                       jsr -48(a6)
	Delay(50);
     c10:	|  |  |  |  |  |  |                                       movea.l 13cbc <DOSBase>,a6
     c16:	|  |  |  |  |  |  |                                       moveq #50,d1
     c18:	|  |  |  |  |  |  |                                       jsr -198(a6)
	warpmode(1);
     c1c:	|  |  |  |  |  |  |                                       pea 1 <_start+0x1>
     c20:	|  |  |  |  |  |  |                                       lea ff2 <warpmode>,a4
     c26:	|  |  |  |  |  |  |                                       jsr (a4)
		register volatile const void* _a0 ASM("a0") = module;
     c28:	|  |  |  |  |  |  |                                       lea 12830 <incbin_module_start>,a0
		register volatile const void* _a1 ASM("a1") = NULL;
     c2e:	|  |  |  |  |  |  |                                       suba.l a1,a1
		register volatile const void* _a2 ASM("a2") = NULL;
     c30:	|  |  |  |  |  |  |                                       suba.l a2,a2
		register volatile const void* _a3 ASM("a3") = player;
     c32:	|  |  |  |  |  |  |                                       lea 1524 <incbin_player_start>,a3
		__asm volatile (
     c38:	|  |  |  |  |  |  |                                       movem.l d1-d7/a4-a6,-(sp)
     c3c:	|  |  |  |  |  |  |                                       jsr (a3)
     c3e:	|  |  |  |  |  |  |                                       movem.l (sp)+,d1-d7/a4-a6
	if(p61Init(module) != 0)
     c42:	|  |  |  |  |  |  |                                       addq.l #8,sp
     c44:	|  |  |  |  |  |  |                                       tst.l d0
     c46:	|  |  |  |  '--|--|-------------------------------------- beq.w 13e <main+0xb2>
     c4a:	|  |  |  '-----|--|-------------------------------------- bra.w b2e <main+0xaa2>
		Exit(0);
     c4e:	|  |  '--------|--|-------------------------------------> movea.l 13cbc <DOSBase>,a6
     c54:	|  |           |  |                                       moveq #0,d1
     c56:	|  |           |  |                                       jsr -144(a6)
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
     c5a:	|  |           |  |                                       movea.l 13cc4 <SysBase>,a6
     c60:	|  |           |  |                                       lea 2f6f <incbin_player_end+0xe5>,a1
     c66:	|  |           |  |                                       moveq #0,d0
     c68:	|  |           |  |                                       jsr -552(a6)
     c6c:	|  |           |  |                                       move.l d0,13cbc <DOSBase>
	if (!DOSBase)
     c72:	|  '-----------|--|-------------------------------------- bne.w da <main+0x4e>
     c76:	'--------------|--|-------------------------------------- bra.w bde <main+0xb52>
	APTR vbr = 0;
     c7a:	               '--|-------------------------------------> moveq #0,d0
	VBR=GetVBR();
     c7c:	                  |                                       move.l d0,13cb8 <VBR>
	return *(volatile APTR*)(((UBYTE*)VBR)+0x6c);
     c82:	                  |                                       movea.l 13cb8 <VBR>,a0
     c88:	                  |                                       move.l 108(a0),d0
	SystemIrq=GetInterruptHandler(); //store interrupt register
     c8c:	                  |                                       move.l d0,13cb4 <SystemIrq>
	WaitVbl();
     c92:	                  |                                       jsr (a2)
	char* test = (char*)AllocMem(2502, MEMF_ANY);
     c94:	                  |                                       movea.l 13cc4 <SysBase>,a6
     c9a:	                  |                                       move.l #2502,d0
     ca0:	                  |                                       moveq #0,d1
     ca2:	                  |                                       jsr -198(a6)
     ca6:	                  |                                       move.l d0,d4
	memset(test, 0xcd, 2502);
     ca8:	                  |                                       pea 9c6 <main+0x93a>
     cac:	                  |                                       pea cd <main+0x41>
     cb0:	                  |                                       move.l d0,-(sp)
     cb2:	                  |                                       jsr 12b8 <memset>
	memclr(test + 2, 2502 - 4);
     cb8:	                  |                                       movea.l d4,a0
     cba:	                  |                                       addq.l #2,a0
	__asm volatile (
     cbc:	                  |                                       move.l #2498,d5
     cc2:	                  |                                       adda.l d5,a0
     cc4:	                  |                                       moveq #0,d0
     cc6:	                  |                                       moveq #0,d1
     cc8:	                  |                                       moveq #0,d2
     cca:	                  |                                       moveq #0,d3
     ccc:	                  |                                       cmpi.l #256,d5
     cd2:	                  |                                ,----- blt.w d26 <main+0xc9a>
     cd6:	                  |                                |  ,-> movem.l d0-d3,-(a0)
     cda:	                  |                                |  |   movem.l d0-d3,-(a0)
     cde:	                  |                                |  |   movem.l d0-d3,-(a0)
     ce2:	                  |                                |  |   movem.l d0-d3,-(a0)
     ce6:	                  |                                |  |   movem.l d0-d3,-(a0)
     cea:	                  |                                |  |   movem.l d0-d3,-(a0)
     cee:	                  |                                |  |   movem.l d0-d3,-(a0)
     cf2:	                  |                                |  |   movem.l d0-d3,-(a0)
     cf6:	                  |                                |  |   movem.l d0-d3,-(a0)
     cfa:	                  |                                |  |   movem.l d0-d3,-(a0)
     cfe:	                  |                                |  |   movem.l d0-d3,-(a0)
     d02:	                  |                                |  |   movem.l d0-d3,-(a0)
     d06:	                  |                                |  |   movem.l d0-d3,-(a0)
     d0a:	                  |                                |  |   movem.l d0-d3,-(a0)
     d0e:	                  |                                |  |   movem.l d0-d3,-(a0)
     d12:	                  |                                |  |   movem.l d0-d3,-(a0)
     d16:	                  |                                |  |   subi.l #256,d5
     d1c:	                  |                                |  |   cmpi.l #256,d5
     d22:	                  |                                |  '-- bge.w cd6 <main+0xc4a>
     d26:	                  |                                >----> cmpi.w #64,d5
     d2a:	                  |                                |  ,-- blt.w d46 <main+0xcba>
     d2e:	                  |                                |  |   movem.l d0-d3,-(a0)
     d32:	                  |                                |  |   movem.l d0-d3,-(a0)
     d36:	                  |                                |  |   movem.l d0-d3,-(a0)
     d3a:	                  |                                |  |   movem.l d0-d3,-(a0)
     d3e:	                  |                                |  |   subi.w #64,d5
     d42:	                  |                                '--|-- bra.w d26 <main+0xc9a>
     d46:	                  |                                   '-> lsr.w #2,d5
     d48:	                  |                                   ,-- bcc.w d4e <main+0xcc2>
     d4c:	                  |                                   |   move.w d0,-(a0)
     d4e:	                  |                                   '-> moveq #16,d1
     d50:	                  |                                       sub.w d5,d1
     d52:	                  |                                       add.w d1,d1
     d54:	                  |                                       jmp (d58 <main+0xccc>,pc,d1.w)
     d58:	                  |                                       move.l d0,-(a0)
     d5a:	                  |                                       move.l d0,-(a0)
     d5c:	                  |                                       move.l d0,-(a0)
     d5e:	                  |                                       move.l d0,-(a0)
     d60:	                  |                                       move.l d0,-(a0)
     d62:	                  |                                       move.l d0,-(a0)
     d64:	                  |                                       move.l d0,-(a0)
     d66:	                  |                                       move.l d0,-(a0)
     d68:	                  |                                       move.l d0,-(a0)
     d6a:	                  |                                       move.l d0,-(a0)
     d6c:	                  |                                       move.l d0,-(a0)
     d6e:	                  |                                       move.l d0,-(a0)
     d70:	                  |                                       move.l d0,-(a0)
     d72:	                  |                                       move.l d0,-(a0)
     d74:	                  |                                       move.l d0,-(a0)
     d76:	                  |                                       move.l d0,-(a0)
	FreeMem(test, 2502);
     d78:	                  |                                       movea.l 13cc4 <SysBase>,a6
     d7e:	                  |                                       movea.l d4,a1
     d80:	                  |                                       move.l #2502,d0
     d86:	                  |                                       jsr -210(a6)
	USHORT* copper1 = (USHORT*)AllocMem(1024, MEMF_CHIP);
     d8a:	                  |                                       movea.l 13cc4 <SysBase>,a6
     d90:	                  |                                       move.l #1024,d0
     d96:	                  |                                       moveq #2,d1
     d98:	                  |                                       jsr -198(a6)
     d9c:	                  |                                       movea.l d0,a3
	debug_register_bitmap(image, "image.bpl", 320, 256, 5, debug_resource_bitmap_interleaved);
     d9e:	                  |                                       pea 1 <_start+0x1>
     da2:	                  |                                       pea 100 <main+0x74>
     da6:	                  |                                       pea 140 <main+0xb4>
     daa:	                  |                                       pea 2fb8 <incbin_player_end+0x12e>
     db0:	                  |                                       pea 512c <incbin_image_start>
     db6:	                  |                                       lea 114e <debug_register_bitmap.constprop.0>,a4
     dbc:	                  |                                       jsr (a4)
	debug_register_bitmap(bob, "bob.bpl", 32, 96, 5, debug_resource_bitmap_interleaved | debug_resource_bitmap_masked);
     dbe:	                  |                                       lea 32(sp),sp
     dc2:	                  |                                       pea 3 <_start+0x3>
     dc6:	                  |                                       pea 60 <_start+0x60>
     dca:	                  |                                       pea 20 <_start+0x20>
     dce:	                  |                                       pea 2fc2 <incbin_player_end+0x138>
     dd4:	                  |                                       pea 1192e <incbin_bob_start>
     dda:	                  |                                       jsr (a4)
	struct debug_resource resource = {
     ddc:	                  |                                       clr.l -42(a5)
     de0:	                  |                                       clr.l -38(a5)
     de4:	                  |                                       clr.l -34(a5)
     de8:	                  |                                       clr.l -30(a5)
     dec:	                  |                                       clr.l -26(a5)
     df0:	                  |                                       clr.l -22(a5)
     df4:	                  |                                       clr.l -18(a5)
     df8:	                  |                                       clr.l -14(a5)
     dfc:	                  |                                       clr.l -10(a5)
     e00:	                  |                                       clr.l -6(a5)
     e04:	                  |                                       clr.w -2(a5)
		.address = (unsigned int)addr,
     e08:	                  |                                       move.l #5346,d3
	struct debug_resource resource = {
     e0e:	                  |                                       move.l d3,-50(a5)
     e12:	                  |                                       moveq #64,d1
     e14:	                  |                                       move.l d1,-46(a5)
     e18:	                  |                                       move.w #1,-10(a5)
     e1e:	                  |                                       move.w #32,-6(a5)
     e24:	                  |                                       lea 20(sp),sp
	while(*source && --num > 0)
     e28:	                  |                                       moveq #105,d0
	struct debug_resource resource = {
     e2a:	                  |                                       lea -42(a5),a1
     e2e:	                  |                                       lea 2f54 <incbin_player_end+0xca>,a0
     e34:	                  '-------------------------------------- bra.w 3de <main+0x352>

00000e38 <interruptHandler>:
static __attribute__((interrupt)) void interruptHandler() {
     e38:	    movem.l d0-d1/a0-a1/a3/a6,-(sp)
	custom->intreq=(1<<INTB_VERTB); custom->intreq=(1<<INTB_VERTB); //reset vbl req. twice for a4000 bug.
     e3c:	    movea.l 13cce <custom>,a0
     e42:	    move.w #32,156(a0)
     e48:	    move.w #32,156(a0)
	if(scroll) {
     e4e:	    movea.l 13cca <scroll>,a0
     e54:	    cmpa.w #0,a0
     e58:	,-- beq.s e7a <interruptHandler+0x42>
		int sin = sinus15[frameCounter & 63];
     e5a:	|   move.w 13cc8 <frameCounter>,d0
     e60:	|   moveq #63,d1
     e62:	|   and.l d1,d0
		*scroll = sin | (sin << 4);
     e64:	|   lea 306c <sinus15>,a1
     e6a:	|   move.b (0,a1,d0.l),d0
     e6e:	|   andi.w #255,d0
     e72:	|   move.w d0,d1
     e74:	|   lsl.w #4,d1
     e76:	|   or.w d0,d1
     e78:	|   move.w d1,(a0)
		register volatile const void* _a3 ASM("a3") = player;
     e7a:	'-> lea 1524 <incbin_player_start>,a3
		register volatile const void* _a6 ASM("a6") = (void*)0xdff000;
     e80:	    movea.l #14675968,a6
		__asm volatile (
     e86:	    movem.l d0-a2/a4-a5,-(sp)
     e8a:	    jsr 4(a3)
     e8e:	    movem.l (sp)+,d0-a2/a4-a5
	frameCounter++;
     e92:	    move.w 13cc8 <frameCounter>,d0
     e98:	    addq.w #1,d0
     e9a:	    move.w d0,13cc8 <frameCounter>
}
     ea0:	    movem.l (sp)+,d0-d1/a0-a1/a3/a6
     ea4:	    rte

00000ea6 <debug_cmd.part.0>:
		UaeLib(88, arg1, arg2, arg3, arg4);
     ea6:	move.l 16(sp),-(sp)
     eaa:	move.l 16(sp),-(sp)
     eae:	move.l 16(sp),-(sp)
     eb2:	move.l 16(sp),-(sp)
     eb6:	pea 58 <_start+0x58>
     eba:	jsr f0ff60 <_end+0xefc28c>
}
     ec0:	lea 20(sp),sp
     ec4:	rts

00000ec6 <WaitVbl>:
void WaitVbl() {
     ec6:	             subq.l #8,sp
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
     ec8:	             move.w f0ff60 <_end+0xefc28c>,d0
     ece:	             cmpi.w #20153,d0
     ed2:	      ,----- beq.s f48 <WaitVbl+0x82>
     ed4:	      |      cmpi.w #-24562,d0
     ed8:	      +----- beq.s f48 <WaitVbl+0x82>
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
     eda:	,-----|----> move.l dff004 <_end+0xdeb330>,d0
     ee0:	|     |      move.l d0,(sp)
		vpos&=0x1ff00;
     ee2:	|     |      move.l (sp),d0
     ee4:	|     |      andi.l #130816,d0
     eea:	|     |      move.l d0,(sp)
		if (vpos!=(311<<8))
     eec:	|     |      move.l (sp),d0
     eee:	|     |      cmpi.l #79616,d0
     ef4:	+-----|----- beq.s eda <WaitVbl+0x14>
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
     ef6:	|  ,--|----> move.l dff004 <_end+0xdeb330>,d0
     efc:	|  |  |      move.l d0,4(sp)
		vpos&=0x1ff00;
     f00:	|  |  |      move.l 4(sp),d0
     f04:	|  |  |      andi.l #130816,d0
     f0a:	|  |  |      move.l d0,4(sp)
		if (vpos==(311<<8))
     f0e:	|  |  |      move.l 4(sp),d0
     f12:	|  |  |      cmpi.l #79616,d0
     f18:	|  +--|----- bne.s ef6 <WaitVbl+0x30>
     f1a:	|  |  |      move.w f0ff60 <_end+0xefc28c>,d0
     f20:	|  |  |      cmpi.w #20153,d0
     f24:	|  |  |  ,-- beq.s f30 <WaitVbl+0x6a>
     f26:	|  |  |  |   cmpi.w #-24562,d0
     f2a:	|  |  |  +-- beq.s f30 <WaitVbl+0x6a>
}
     f2c:	|  |  |  |   addq.l #8,sp
     f2e:	|  |  |  |   rts
     f30:	|  |  |  '-> clr.l -(sp)
     f32:	|  |  |      clr.l -(sp)
     f34:	|  |  |      clr.l -(sp)
     f36:	|  |  |      pea 5 <_start+0x5>
     f3a:	|  |  |      jsr ea6 <debug_cmd.part.0>
}
     f40:	|  |  |      lea 16(sp),sp
     f44:	|  |  |      addq.l #8,sp
     f46:	|  |  |      rts
     f48:	|  |  '----> clr.l -(sp)
     f4a:	|  |         clr.l -(sp)
     f4c:	|  |         pea 1 <_start+0x1>
     f50:	|  |         pea 5 <_start+0x5>
     f54:	|  |         jsr ea6 <debug_cmd.part.0>
}
     f5a:	|  |         lea 16(sp),sp
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
     f5e:	|  |         move.l dff004 <_end+0xdeb330>,d0
     f64:	|  |         move.l d0,(sp)
		vpos&=0x1ff00;
     f66:	|  |         move.l (sp),d0
     f68:	|  |         andi.l #130816,d0
     f6e:	|  |         move.l d0,(sp)
		if (vpos!=(311<<8))
     f70:	|  |         move.l (sp),d0
     f72:	|  |         cmpi.l #79616,d0
     f78:	'--|-------- beq.w eda <WaitVbl+0x14>
     f7c:	   '-------- bra.w ef6 <WaitVbl+0x30>

00000f80 <KPrintF>:
void KPrintF(const char* fmt, ...) {
     f80:	    lea -128(sp),sp
     f84:	    movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
     f88:	    move.w f0ff60 <_end+0xefc28c>,d0
     f8e:	    cmpi.w #20153,d0
     f92:	,-- beq.s fbe <KPrintF+0x3e>
     f94:	|   cmpi.w #-24562,d0
     f98:	+-- beq.s fbe <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
     f9a:	|   movea.l 13cc4 <SysBase>,a6
     fa0:	|   movea.l 144(sp),a0
     fa4:	|   lea 148(sp),a1
     fa8:	|   lea 14d0 <KPutCharX>,a2
     fae:	|   suba.l a3,a3
     fb0:	|   jsr -522(a6)
}
     fb4:	|   movem.l (sp)+,a2-a3/a6
     fb8:	|   lea 128(sp),sp
     fbc:	|   rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
     fbe:	'-> movea.l 13cc4 <SysBase>,a6
     fc4:	    movea.l 144(sp),a0
     fc8:	    lea 148(sp),a1
     fcc:	    lea 14de <PutChar>,a2
     fd2:	    lea 12(sp),a3
     fd6:	    jsr -522(a6)
		UaeDbgLog(86, temp);
     fda:	    move.l a3,-(sp)
     fdc:	    pea 56 <_start+0x56>
     fe0:	    jsr f0ff60 <_end+0xefc28c>
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
     fe6:	    addq.l #8,sp
}
     fe8:	    movem.l (sp)+,a2-a3/a6
     fec:	    lea 128(sp),sp
     ff0:	    rts

00000ff2 <warpmode>:
void warpmode(int on) { // bool
     ff2:	       subq.l #4,sp
     ff4:	       move.l a2,-(sp)
     ff6:	       move.l d2,-(sp)
	if(*((UWORD *)UaeConf) == 0x4eb9 || *((UWORD *)UaeConf) == 0xa00e) {
     ff8:	       move.w f0ff60 <_end+0xefc28c>,d0
     ffe:	       cmpi.w #20153,d0
    1002:	   ,-- beq.s 1012 <warpmode+0x20>
    1004:	   |   cmpi.w #-24562,d0
    1008:	   +-- beq.s 1012 <warpmode+0x20>
}
    100a:	   |   move.l (sp)+,d2
    100c:	   |   movea.l (sp)+,a2
    100e:	   |   addq.l #4,sp
    1010:	   |   rts
		UaeConf(82, -1, on ? "cpu_speed max" : "cpu_speed real", 0, &outbuf, 1);
    1012:	   '-> tst.l 16(sp)
    1016:	,----- beq.w 10b6 <warpmode+0xc4>
    101a:	|      pea 1 <_start+0x1>
    101e:	|      moveq #15,d2
    1020:	|      add.l sp,d2
    1022:	|      move.l d2,-(sp)
    1024:	|      clr.l -(sp)
    1026:	|      pea 2ef9 <incbin_player_end+0x6f>
    102c:	|      pea ffffffff <_end+0xfffec32b>
    1030:	|      pea 52 <_start+0x52>
    1034:	|      movea.l #15794016,a2
    103a:	|      jsr (a2)
		UaeConf(82, -1, on ? "cpu_cycle_exact false" : "cpu_cycle_exact true", 0, &outbuf, 1);
    103c:	|      pea 1 <_start+0x1>
    1040:	|      move.l d2,-(sp)
    1042:	|      clr.l -(sp)
    1044:	|      pea 2f07 <incbin_player_end+0x7d>
    104a:	|      pea ffffffff <_end+0xfffec32b>
    104e:	|      pea 52 <_start+0x52>
    1052:	|      jsr (a2)
		UaeConf(82, -1, on ? "cpu_memory_cycle_exact false" : "cpu_memory_cycle_exact true", 0, &outbuf, 1);
    1054:	|      lea 48(sp),sp
    1058:	|      pea 1 <_start+0x1>
    105c:	|      move.l d2,-(sp)
    105e:	|      clr.l -(sp)
    1060:	|      pea 2f1d <incbin_player_end+0x93>
    1066:	|      pea ffffffff <_end+0xfffec32b>
    106a:	|      pea 52 <_start+0x52>
    106e:	|      jsr (a2)
		UaeConf(82, -1, on ? "blitter_cycle_exact false" : "blitter_cycle_exact true", 0, &outbuf, 1);
    1070:	|      pea 1 <_start+0x1>
    1074:	|      move.l d2,-(sp)
    1076:	|      clr.l -(sp)
    1078:	|      pea 2f3a <incbin_player_end+0xb0>
    107e:	|      pea ffffffff <_end+0xfffec32b>
    1082:	|      pea 52 <_start+0x52>
    1086:	|      jsr (a2)
    1088:	|      lea 48(sp),sp
		UaeConf(82, -1, on ? "warp true" : "warp false", 0, &outbuf, 1);
    108c:	|      move.l #11915,d0
    1092:	|      pea 1 <_start+0x1>
    1096:	|      move.l d2,-(sp)
    1098:	|      clr.l -(sp)
    109a:	|      move.l d0,-(sp)
    109c:	|      pea ffffffff <_end+0xfffec32b>
    10a0:	|      pea 52 <_start+0x52>
    10a4:	|      jsr f0ff60 <_end+0xefc28c>
}
    10aa:	|      lea 24(sp),sp
    10ae:	|  ,-> move.l (sp)+,d2
    10b0:	|  |   movea.l (sp)+,a2
    10b2:	|  |   addq.l #4,sp
    10b4:	|  |   rts
		UaeConf(82, -1, on ? "cpu_speed max" : "cpu_speed real", 0, &outbuf, 1);
    10b6:	'--|-> pea 1 <_start+0x1>
    10ba:	   |   moveq #15,d2
    10bc:	   |   add.l sp,d2
    10be:	   |   move.l d2,-(sp)
    10c0:	   |   clr.l -(sp)
    10c2:	   |   pea 2ea0 <incbin_player_end+0x16>
    10c8:	   |   pea ffffffff <_end+0xfffec32b>
    10cc:	   |   pea 52 <_start+0x52>
    10d0:	   |   movea.l #15794016,a2
    10d6:	   |   jsr (a2)
		UaeConf(82, -1, on ? "cpu_cycle_exact false" : "cpu_cycle_exact true", 0, &outbuf, 1);
    10d8:	   |   pea 1 <_start+0x1>
    10dc:	   |   move.l d2,-(sp)
    10de:	   |   clr.l -(sp)
    10e0:	   |   pea 2eaf <incbin_player_end+0x25>
    10e6:	   |   pea ffffffff <_end+0xfffec32b>
    10ea:	   |   pea 52 <_start+0x52>
    10ee:	   |   jsr (a2)
		UaeConf(82, -1, on ? "cpu_memory_cycle_exact false" : "cpu_memory_cycle_exact true", 0, &outbuf, 1);
    10f0:	   |   lea 48(sp),sp
    10f4:	   |   pea 1 <_start+0x1>
    10f8:	   |   move.l d2,-(sp)
    10fa:	   |   clr.l -(sp)
    10fc:	   |   pea 2ec4 <incbin_player_end+0x3a>
    1102:	   |   pea ffffffff <_end+0xfffec32b>
    1106:	   |   pea 52 <_start+0x52>
    110a:	   |   jsr (a2)
		UaeConf(82, -1, on ? "blitter_cycle_exact false" : "blitter_cycle_exact true", 0, &outbuf, 1);
    110c:	   |   pea 1 <_start+0x1>
    1110:	   |   move.l d2,-(sp)
    1112:	   |   clr.l -(sp)
    1114:	   |   pea 2ee0 <incbin_player_end+0x56>
    111a:	   |   pea ffffffff <_end+0xfffec32b>
    111e:	   |   pea 52 <_start+0x52>
    1122:	   |   jsr (a2)
    1124:	   |   lea 48(sp),sp
		UaeConf(82, -1, on ? "warp true" : "warp false", 0, &outbuf, 1);
    1128:	   |   move.l #11925,d0
    112e:	   |   pea 1 <_start+0x1>
    1132:	   |   move.l d2,-(sp)
    1134:	   |   clr.l -(sp)
    1136:	   |   move.l d0,-(sp)
    1138:	   |   pea ffffffff <_end+0xfffec32b>
    113c:	   |   pea 52 <_start+0x52>
    1140:	   |   jsr f0ff60 <_end+0xefc28c>
}
    1146:	   |   lea 24(sp),sp
    114a:	   '-- bra.w 10ae <warpmode+0xbc>

0000114e <debug_register_bitmap.constprop.0>:
void debug_register_bitmap(const void* addr, const char* name, short width, short height, short numPlanes, unsigned short flags) {
    114e:	       link.w a5,#-52
    1152:	       movem.l d2-d3/a2,-(sp)
    1156:	       movea.l 12(a5),a1
    115a:	       move.l 16(a5),d3
    115e:	       move.l 20(a5),d2
    1162:	       move.l 24(a5),d1
	struct debug_resource resource = {
    1166:	       clr.l -42(a5)
    116a:	       clr.l -38(a5)
    116e:	       clr.l -34(a5)
    1172:	       clr.l -30(a5)
    1176:	       clr.l -26(a5)
    117a:	       clr.l -22(a5)
    117e:	       clr.l -18(a5)
    1182:	       clr.l -14(a5)
    1186:	       clr.w -10(a5)
    118a:	       move.l 8(a5),-50(a5)
		.size = width / 8 * height * numPlanes,
    1190:	       move.w d3,d0
    1192:	       asr.w #3,d0
    1194:	       muls.w d2,d0
    1196:	       movea.w d0,a0
    1198:	       move.l a0,d0
    119a:	       add.l a0,d0
    119c:	       add.l d0,d0
    119e:	       adda.l d0,a0
	struct debug_resource resource = {
    11a0:	       move.l a0,-46(a5)
    11a4:	       move.w d1,-8(a5)
    11a8:	       move.w d3,-6(a5)
    11ac:	       move.w d2,-4(a5)
    11b0:	       move.w #5,-2(a5)
	if (flags & debug_resource_bitmap_masked)
    11b6:	       cmpi.w #1,d1
    11ba:	   ,-- beq.s 11c8 <debug_register_bitmap.constprop.0+0x7a>
		resource.size *= 2;
    11bc:	   |   moveq #0,d0
    11be:	   |   move.w a0,d0
    11c0:	   |   movea.l d0,a0
    11c2:	   |   adda.l a0,a0
    11c4:	   |   move.l a0,-46(a5)
	while(*source && --num > 0)
    11c8:	   '-> move.b (a1),d0
    11ca:	       lea -42(a5),a0
    11ce:	,----- beq.s 11e0 <debug_register_bitmap.constprop.0+0x92>
    11d0:	|      lea -11(a5),a2
		*destination++ = *source++;
    11d4:	|  ,-> addq.l #1,a1
    11d6:	|  |   move.b d0,(a0)+
	while(*source && --num > 0)
    11d8:	|  |   move.b (a1),d0
    11da:	+--|-- beq.s 11e0 <debug_register_bitmap.constprop.0+0x92>
    11dc:	|  |   cmpa.l a0,a2
    11de:	|  '-- bne.s 11d4 <debug_register_bitmap.constprop.0+0x86>
	*destination = '\0';
    11e0:	'----> clr.b (a0)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
    11e2:	       move.w f0ff60 <_end+0xefc28c>,d0
    11e8:	       cmpi.w #20153,d0
    11ec:	   ,-- beq.s 11fe <debug_register_bitmap.constprop.0+0xb0>
    11ee:	   |   cmpi.w #-24562,d0
    11f2:	   +-- beq.s 11fe <debug_register_bitmap.constprop.0+0xb0>
}
    11f4:	   |   movem.l -64(a5),d2-d3/a2
    11fa:	   |   unlk a5
    11fc:	   |   rts
    11fe:	   '-> clr.l -(sp)
    1200:	       clr.l -(sp)
    1202:	       pea -50(a5)
    1206:	       pea 4 <_start+0x4>
    120a:	       jsr ea6 <debug_cmd.part.0>
    1210:	       lea 16(sp),sp
    1214:	       movem.l -64(a5),d2-d3/a2
    121a:	       unlk a5
    121c:	       rts

0000121e <debug_register_copperlist.constprop.0>:
	};
	my_strncpy(resource.name, name, sizeof(resource.name));
	debug_cmd(barto_cmd_register_resource, (unsigned int)&resource, 0, 0);
}

void debug_register_copperlist(const void* addr, const char* name, unsigned int size, unsigned short flags) {
    121e:	       link.w a5,#-52
    1222:	       move.l a2,-(sp)
    1224:	       movea.l 12(a5),a1
	struct debug_resource resource = {
    1228:	       clr.l -42(a5)
    122c:	       clr.l -38(a5)
    1230:	       clr.l -34(a5)
    1234:	       clr.l -30(a5)
    1238:	       clr.l -26(a5)
    123c:	       clr.l -22(a5)
    1240:	       clr.l -18(a5)
    1244:	       clr.l -14(a5)
    1248:	       clr.l -10(a5)
    124c:	       clr.l -6(a5)
    1250:	       clr.w -2(a5)
    1254:	       move.l 8(a5),-50(a5)
    125a:	       move.l 16(a5),-46(a5)
    1260:	       move.w #2,-10(a5)
	while(*source && --num > 0)
    1266:	       move.b (a1),d0
    1268:	       lea -42(a5),a0
    126c:	,----- beq.s 127e <debug_register_copperlist.constprop.0+0x60>
    126e:	|      lea -11(a5),a2
		*destination++ = *source++;
    1272:	|  ,-> addq.l #1,a1
    1274:	|  |   move.b d0,(a0)+
	while(*source && --num > 0)
    1276:	|  |   move.b (a1),d0
    1278:	+--|-- beq.s 127e <debug_register_copperlist.constprop.0+0x60>
    127a:	|  |   cmpa.l a0,a2
    127c:	|  '-- bne.s 1272 <debug_register_copperlist.constprop.0+0x54>
	*destination = '\0';
    127e:	'----> clr.b (a0)
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
    1280:	       move.w f0ff60 <_end+0xefc28c>,d0
    1286:	       cmpi.w #20153,d0
    128a:	   ,-- beq.s 129a <debug_register_copperlist.constprop.0+0x7c>
    128c:	   |   cmpi.w #-24562,d0
    1290:	   +-- beq.s 129a <debug_register_copperlist.constprop.0+0x7c>
		.type = debug_resource_type_copperlist,
		.flags = flags,
	};
	my_strncpy(resource.name, name, sizeof(resource.name));
	debug_cmd(barto_cmd_register_resource, (unsigned int)&resource, 0, 0);
}
    1292:	   |   movea.l -56(a5),a2
    1296:	   |   unlk a5
    1298:	   |   rts
    129a:	   '-> clr.l -(sp)
    129c:	       clr.l -(sp)
    129e:	       pea -50(a5)
    12a2:	       pea 4 <_start+0x4>
    12a6:	       jsr ea6 <debug_cmd.part.0>
    12ac:	       lea 16(sp),sp
    12b0:	       movea.l -56(a5),a2
    12b4:	       unlk a5
    12b6:	       rts

000012b8 <memset>:
void* memset(void *dest, int val, unsigned long len) {
    12b8:	                      movem.l d2-d7/a2,-(sp)
    12bc:	                      move.l 32(sp),d0
    12c0:	                      move.l 36(sp),d3
    12c4:	                      movea.l 40(sp),a0
	while(len-- > 0)
    12c8:	                      lea -1(a0),a1
    12cc:	                      cmpa.w #0,a0
    12d0:	               ,----- beq.w 137e <memset+0xc6>
		*ptr++ = val;
    12d4:	               |      move.b d3,d7
    12d6:	               |      move.l d0,d2
    12d8:	               |      neg.l d2
    12da:	               |      moveq #3,d1
    12dc:	               |      and.l d2,d1
    12de:	               |      moveq #5,d4
    12e0:	               |      cmp.l a1,d4
    12e2:	,--------------|----- bcc.w 141e <memset+0x166>
    12e6:	|              |      tst.l d1
    12e8:	|           ,--|----- beq.w 13b8 <memset+0x100>
    12ec:	|           |  |      movea.l d0,a1
    12ee:	|           |  |      move.b d3,(a1)
	while(len-- > 0)
    12f0:	|           |  |      btst #1,d2
    12f4:	|           |  |  ,-- beq.w 1384 <memset+0xcc>
		*ptr++ = val;
    12f8:	|           |  |  |   move.b d3,1(a1)
	while(len-- > 0)
    12fc:	|           |  |  |   moveq #3,d2
    12fe:	|           |  |  |   cmp.l d1,d2
    1300:	|  ,--------|--|--|-- bne.w 13e8 <memset+0x130>
		*ptr++ = val;
    1304:	|  |        |  |  |   lea 3(a1),a2
    1308:	|  |        |  |  |   move.b d3,2(a1)
	while(len-- > 0)
    130c:	|  |        |  |  |   lea -4(a0),a1
    1310:	|  |        |  |  |   move.l a0,d5
    1312:	|  |        |  |  |   sub.l d1,d5
    1314:	|  |        |  |  |   moveq #0,d4
    1316:	|  |        |  |  |   move.b d3,d4
    1318:	|  |        |  |  |   move.l d4,d6
    131a:	|  |        |  |  |   swap d6
    131c:	|  |        |  |  |   clr.w d6
    131e:	|  |        |  |  |   move.l d3,d2
    1320:	|  |        |  |  |   lsl.w #8,d2
    1322:	|  |        |  |  |   swap d2
    1324:	|  |        |  |  |   clr.w d2
    1326:	|  |        |  |  |   lsl.l #8,d4
    1328:	|  |        |  |  |   or.l d6,d2
    132a:	|  |        |  |  |   or.l d4,d2
    132c:	|  |        |  |  |   move.b d7,d2
    132e:	|  |        |  |  |   movea.l d0,a0
    1330:	|  |        |  |  |   adda.l d1,a0
    1332:	|  |        |  |  |   moveq #-4,d4
    1334:	|  |        |  |  |   and.l d5,d4
    1336:	|  |        |  |  |   move.l d4,d1
    1338:	|  |        |  |  |   add.l a0,d1
		*ptr++ = val;
    133a:	|  |  ,-----|--|--|-> move.l d2,(a0)+
	while(len-- > 0)
    133c:	|  |  |     |  |  |   cmp.l a0,d1
    133e:	|  |  +-----|--|--|-- bne.s 133a <memset+0x82>
    1340:	|  |  |     |  |  |   cmp.l d4,d5
    1342:	|  |  |     |  +--|-- beq.s 137e <memset+0xc6>
    1344:	|  |  |     |  |  |   suba.l d4,a1
    1346:	|  |  |     |  |  |   lea (0,a2,d4.l),a0
		*ptr++ = val;
    134a:	|  |  |  ,--|--|--|-> move.b d3,(a0)
	while(len-- > 0)
    134c:	|  |  |  |  |  |  |   cmpa.w #0,a1
    1350:	|  |  |  |  |  +--|-- beq.s 137e <memset+0xc6>
		*ptr++ = val;
    1352:	|  |  |  |  |  |  |   move.b d3,1(a0)
	while(len-- > 0)
    1356:	|  |  |  |  |  |  |   moveq #1,d1
    1358:	|  |  |  |  |  |  |   cmp.l a1,d1
    135a:	|  |  |  |  |  +--|-- beq.s 137e <memset+0xc6>
		*ptr++ = val;
    135c:	|  |  |  |  |  |  |   move.b d3,2(a0)
	while(len-- > 0)
    1360:	|  |  |  |  |  |  |   moveq #2,d2
    1362:	|  |  |  |  |  |  |   cmp.l a1,d2
    1364:	|  |  |  |  |  +--|-- beq.s 137e <memset+0xc6>
		*ptr++ = val;
    1366:	|  |  |  |  |  |  |   move.b d3,3(a0)
	while(len-- > 0)
    136a:	|  |  |  |  |  |  |   moveq #3,d4
    136c:	|  |  |  |  |  |  |   cmp.l a1,d4
    136e:	|  |  |  |  |  +--|-- beq.s 137e <memset+0xc6>
		*ptr++ = val;
    1370:	|  |  |  |  |  |  |   move.b d3,4(a0)
	while(len-- > 0)
    1374:	|  |  |  |  |  |  |   moveq #4,d1
    1376:	|  |  |  |  |  |  |   cmp.l a1,d1
    1378:	|  |  |  |  |  +--|-- beq.s 137e <memset+0xc6>
		*ptr++ = val;
    137a:	|  |  |  |  |  |  |   move.b d3,5(a0)
}
    137e:	|  |  |  |  |  '--|-> movem.l (sp)+,d2-d7/a2
    1382:	|  |  |  |  |     |   rts
		*ptr++ = val;
    1384:	|  |  |  |  |     '-> lea 1(a1),a2
	while(len-- > 0)
    1388:	|  |  |  |  |         lea -2(a0),a1
    138c:	|  |  |  |  |         move.l a0,d5
    138e:	|  |  |  |  |         sub.l d1,d5
    1390:	|  |  |  |  |         moveq #0,d4
    1392:	|  |  |  |  |         move.b d3,d4
    1394:	|  |  |  |  |         move.l d4,d6
    1396:	|  |  |  |  |         swap d6
    1398:	|  |  |  |  |         clr.w d6
    139a:	|  |  |  |  |         move.l d3,d2
    139c:	|  |  |  |  |         lsl.w #8,d2
    139e:	|  |  |  |  |         swap d2
    13a0:	|  |  |  |  |         clr.w d2
    13a2:	|  |  |  |  |         lsl.l #8,d4
    13a4:	|  |  |  |  |         or.l d6,d2
    13a6:	|  |  |  |  |         or.l d4,d2
    13a8:	|  |  |  |  |         move.b d7,d2
    13aa:	|  |  |  |  |         movea.l d0,a0
    13ac:	|  |  |  |  |         adda.l d1,a0
    13ae:	|  |  |  |  |         moveq #-4,d4
    13b0:	|  |  |  |  |         and.l d5,d4
    13b2:	|  |  |  |  |         move.l d4,d1
    13b4:	|  |  |  |  |         add.l a0,d1
    13b6:	|  |  +--|--|-------- bra.s 133a <memset+0x82>
	unsigned char *ptr = (unsigned char *)dest;
    13b8:	|  |  |  |  '-------> movea.l d0,a2
    13ba:	|  |  |  |            move.l a0,d5
    13bc:	|  |  |  |            sub.l d1,d5
    13be:	|  |  |  |            moveq #0,d4
    13c0:	|  |  |  |            move.b d3,d4
    13c2:	|  |  |  |            move.l d4,d6
    13c4:	|  |  |  |            swap d6
    13c6:	|  |  |  |            clr.w d6
    13c8:	|  |  |  |            move.l d3,d2
    13ca:	|  |  |  |            lsl.w #8,d2
    13cc:	|  |  |  |            swap d2
    13ce:	|  |  |  |            clr.w d2
    13d0:	|  |  |  |            lsl.l #8,d4
    13d2:	|  |  |  |            or.l d6,d2
    13d4:	|  |  |  |            or.l d4,d2
    13d6:	|  |  |  |            move.b d7,d2
    13d8:	|  |  |  |            movea.l d0,a0
    13da:	|  |  |  |            adda.l d1,a0
    13dc:	|  |  |  |            moveq #-4,d4
    13de:	|  |  |  |            and.l d5,d4
    13e0:	|  |  |  |            move.l d4,d1
    13e2:	|  |  |  |            add.l a0,d1
    13e4:	|  |  +--|----------- bra.w 133a <memset+0x82>
		*ptr++ = val;
    13e8:	|  '--|--|----------> lea 2(a1),a2
	while(len-- > 0)
    13ec:	|     |  |            lea -3(a0),a1
    13f0:	|     |  |            move.l a0,d5
    13f2:	|     |  |            sub.l d1,d5
    13f4:	|     |  |            moveq #0,d4
    13f6:	|     |  |            move.b d3,d4
    13f8:	|     |  |            move.l d4,d6
    13fa:	|     |  |            swap d6
    13fc:	|     |  |            clr.w d6
    13fe:	|     |  |            move.l d3,d2
    1400:	|     |  |            lsl.w #8,d2
    1402:	|     |  |            swap d2
    1404:	|     |  |            clr.w d2
    1406:	|     |  |            lsl.l #8,d4
    1408:	|     |  |            or.l d6,d2
    140a:	|     |  |            or.l d4,d2
    140c:	|     |  |            move.b d7,d2
    140e:	|     |  |            movea.l d0,a0
    1410:	|     |  |            adda.l d1,a0
    1412:	|     |  |            moveq #-4,d4
    1414:	|     |  |            and.l d5,d4
    1416:	|     |  |            move.l d4,d1
    1418:	|     |  |            add.l a0,d1
    141a:	|     '--|----------- bra.w 133a <memset+0x82>
	unsigned char *ptr = (unsigned char *)dest;
    141e:	'--------|----------> movea.l d0,a0
    1420:	         '----------- bra.w 134a <memset+0x92>

00001424 <__mulsi3>:
	.section .text.__mulsi3,"ax",@progbits
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    1424:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    1428:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    142c:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    1430:	mulu.w 8(sp),d1
	addw	d1, d0
    1434:	add.w d1,d0
	swap	d0
    1436:	swap d0
	clrw	d0
    1438:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    143a:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    143e:	mulu.w 10(sp),d1
	addl	d1, d0
    1442:	add.l d1,d0
	rts
    1444:	rts

00001446 <__udivsi3>:
	.section .text.__udivsi3,"ax",@progbits
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    1446:	       move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    1448:	       move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    144c:	       move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    1450:	       cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    1456:	   ,-- bcc.s 146e <__udivsi3+0x28>
	movel	d0, d2
    1458:	   |   move.l d0,d2
	clrw	d2
    145a:	   |   clr.w d2
	swap	d2
    145c:	   |   swap d2
	divu	d1, d2          /* high quotient in lower word */
    145e:	   |   divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    1460:	   |   move.w d2,d0
	swap	d0
    1462:	   |   swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    1464:	   |   move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    1468:	   |   divu.w d1,d2
	movew	d2, d0
    146a:	   |   move.w d2,d0
	jra	6f
    146c:	,--|-- bra.s 149e <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    146e:	|  '-> move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    1470:	|  ,-> lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    1472:	|  |   lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    1474:	|  |   cmpi.l #65536,d1
	jcc	4b
    147a:	|  '-- bcc.s 1470 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    147c:	|      divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    147e:	|      andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    1484:	|      move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    1486:	|      mulu.w d0,d1
	swap	d2
    1488:	|      swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    148a:	|      mulu.w d0,d2
	swap	d2		/* align high part with low part */
    148c:	|      swap d2
	tstw	d2		/* high part 17 bits? */
    148e:	|      tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    1490:	|  ,-- bne.s 149c <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    1492:	|  |   add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    1494:	|  +-- bcs.s 149c <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    1496:	|  |   cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    149a:	+--|-- bls.s 149e <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    149c:	|  '-> subq.l #1,d0

6:	movel	sp@+, d2
    149e:	'----> move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    14a0:	       rts

000014a2 <__umodsi3>:
	.section .text.__umodsi3,"ax",@progbits
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    14a2:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    14a6:	move.l 4(sp),d0
	movel	d1, sp@-
    14aa:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    14ac:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    14ae:	jsr 1446 <__udivsi3>
	addql	#8, sp
    14b4:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    14b6:	move.l 8(sp),d1
	movel	d1, sp@-
    14ba:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    14bc:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    14be:	jsr 1424 <__mulsi3>
	addql	#8, sp
    14c4:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    14c6:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    14ca:	sub.l d0,d1
	movel	d1, d0
    14cc:	move.l d1,d0
	rts
    14ce:	rts

000014d0 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    14d0:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    14d2:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    14d6:	jsr -516(a6)
    move.l (sp)+, a6
    14da:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    14dc:	rts

000014de <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    14de:	move.b d0,(a3)+
	rts
    14e0:	rts
