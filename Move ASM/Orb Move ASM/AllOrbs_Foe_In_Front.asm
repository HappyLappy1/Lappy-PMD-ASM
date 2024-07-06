; 
; ------------------------------------------------------------------------------
; By happylappy & Gelius
; This move effect should be set to targeting: Enemy in Front
; This move effect can be applied to the following 1-tile range orbs!
;			  Transfer_Orb, Sizebust_Orb (!!!), Itemizer_Orb (!!!), Hurl_Orb,
;			  Decoy_Orb, OneShot_Orb (!!!), Lob_Orb (!!!), Rocky Orb (!!!)
;
; Notes:	- Move Animations may be impacted by this ASM! Please test these!
;					(Tested as many as I could, but some things may break)
;			- Itemizer typically cuts corners! Will NOT here!
;					(Resolve by not applying to Itemize Orb!)
;			- Sizebust Orb & Rocky Orb will have the same type & base power!
;					(Resolve by making Rocky Orb call Rock Tomb!)
;			- One-Shot has perfect accuracy here, unlike in base game!
;					(Resolve by making One-Shot Orb call One-Shot!)
;			- Lob Orb has a 2 tile range! Instead made it have 30% Cringe!
;					(Resolve by making Lob Orb call Bloop Slash!)
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x2598
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC
.definelabel DoMoveTransfer, 0x232C84C 
.definelabel DoMoveEcho, 0x232CEAC
.definelabel DoMoveItemize, 0x232D148
.definelabel DoMoveHurl, 0x232D1DC
.definelabel DoMoveDamageCringe30, 0x2326670
.definelabel DoMoveOneShot, 0x232CDA4
.definelabel DoMoveDamageLowerSpeed100, 0x2327368
.definelabel DoMoveDecoy, 0x232B800 
.definelabel PlayEffectAnimationEntity, 0x22E35E4



; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel DoMoveTransfer, 0x232D2BC
;.definelabel DoMoveItemize, 0x232DBB8
;.definelabel DoMoveHurl, 0x232DC4C
;.definelabel DoMoveDecoy, 0x232C26C
;.definelabel DoMoveDamageCringe30, 0x23270D8
;.definelabel DoMoveOneShot, 0x232D814
;.definelabel DoMoveDamageLowerSpeed100, 0x2327DD0
;.definelabel DoMoveDecoy, 0x232C26C  
;.definelabel PlayEffectAnimationEntity, 0x22E3F94

; File creation
.create "./code_out.bin", 0x02330134 ; Change to the actual offset as this directive doesn't accept labels
    .org MoveStartAddress
    .area MaxSize ; Define the size of the area
    sub sp,sp,#0x8
	; Usable Variables: 
	; r6 = Move ID
	; r9 = User Monster Structure Pointer
	; r4 = Target Monster Structure Pointer
	; r8 = Move Data Structure Pointer (8 bytes: flags [4 bytes], move_id [2 bytes], pp_left [1 byte], boosts [1 byte])
	; r7 = ID of the item that called this move (0 if the move effect isn't from an item)
	; Returns: 
	; r10 (bool) = ???
	; Registers r4 to r9, r11 and r13 must remain unchanged after the execution of that code


	; Check which orb is being used
	ldr r12,=#315
	cmp r7, r12;
		beq Transfer_Orb;
	ldr r12,=#341
	cmp r7, r12;
		beq Sizebust_Orb;
	ldr r12,=#346
	cmp r7, r12;
		beq Itemizer_Orb;
	ldr r12,=#347
	cmp r7, r12;
		beq Hurl_Orb;
	ldr r12,=#325
	cmp r7, r12;
		beq Decoy_Orb;
	ldr r12,=#337
	cmp r7, r12;
		beq OneShot_Orb;
	ldr r12,=#311
	cmp r7, r12;
		beq Lob_Orb;
	ldr r12,=#306
	cmp r7, r12;
		beq Rocky_Orb;
	b return;

	Transfer_Orb: ; Works and animates correctly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r4
		mov r1, #4
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveTransfer;
		b return;
	Decoy_Orb: ; Works and animates correctly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r4
		mov r1, #4
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveDecoy;
		b return;
	Sizebust_Orb: ; Will work, but will deal the damage and base power of whatever type the move slot is!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveEcho; This is sizebust!
		b return;
	Itemizer_Orb: ; Seems to work! Foe not animating correctly, though...
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r4
		mov r1, #4
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveItemize;
		b return;
	Hurl_Orb: ; Works and animates correctly!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveHurl;
		b return;
	OneShot_Orb: ; Works and animates perfectly!
		mov r0, r9
		mov r1, #80
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveOneShot;
		b return;
	Lob_Orb: ; Edited to have a cringe chance instead of a 2 tile range! Will work, but will deal the damage of whatever type the move slot is!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveDamageCringe30;
		b return;
	Rocky_Orb: ; Will work, but will deal the damage of whatever type the move slot is!
		mov r0, r9
		mov r1, #22
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0, r4
		mov r1, #115
		mov r2, #1
		bl PlayEffectAnimationEntity
		mov r0,r9; User	
		mov r1,r4; Target
		mov r2,r8; Move
		mov r3,r7; Item
		bl DoMoveDamageLowerSpeed100;
		b return;
    return:
        add sp,sp,#0x8
        b MoveJumpAddress
        .pool
    .endarea
.close
