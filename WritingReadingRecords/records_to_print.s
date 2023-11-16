record1:
.ascii "Alexandre \0"
.rept 29
.byte 0
.endr
.ascii "OSSELIN \0"
.rept 32
.byte 0
.endr
.ascii "Avenue De France, Kremlin-Bîcetre, 94000, France\n"
.rept 191
.byte 0
.endr
.long 28

record2:
.ascii "Pierre \0"
.rept 32
.byte 0
.endr
.ascii "FRANCOIS \0"
.rept 31
.byte 0
.endr
.ascii "Avenue De Montorgeuil, Paris, 75017, France\n"
.rept 196
.byte 0
.endr
.long 23

record3:
.ascii "Esther \0"
.rept 32
.byte 0
.endr
.ascii "ST.ESPRIT \0"
.rept 29
.byte 0
.endr
.ascii "4th avenue, Blaine, Minnessota, USA\n"
.rept 204
.byte 0
.endr
.long 20
