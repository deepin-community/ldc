include ../common.mak

TESTS := attributes sentinel printf memstomp invariant logging \
		 precise precisegc \
		 recoverfree nocollect
# LDC: disable POSIX-specific tests on Windows
ifeq (,$(findstring win,$(OS)))
TESTS += sentinel1 sentinel2 \
		 forkgc forkgc2 \
		 sigmaskgc startbackgc concurrent precise_concurrent hospital
endif

SRC_GC = ../../src/core/internal/gc/impl/conservative/gc.d
SRC = $(SRC_GC) ../../src/rt/lifetime.d
# ../../src/object.d causes duplicate symbols
UDFLAGS = $(DFLAGS) -unittest -version=CoreUnittest

.PHONY: all clean
all: $(addprefix $(ROOT)/,$(addsuffix .done,$(TESTS)))

$(ROOT)/%.done: $(ROOT)/%
	@echo Testing $*
	$(QUIET)$(TIMELIMIT)$(ROOT)/$* $(RUN_ARGS)
	@touch $@

$(ROOT)/sentinel: $(SRC)
	$(DMD) -debug=SENTINEL $(UDFLAGS) -main -of$@ $(SRC)

$(ROOT)/sentinel1: $(SRC) sentinel1.d
	$(DMD) -debug=SENTINEL -debug=GC_RECURSIVE_LOCK $(DFLAGS) sentinel1.d -of$@ $(SRC)

$(ROOT)/sentinel2: $(SRC) sentinel2.d
	$(DMD) -debug=SENTINEL -debug=GC_RECURSIVE_LOCK $(DFLAGS) sentinel2.d -gx -of$@ $(SRC)

$(ROOT)/printf: $(SRC)
	$(DMD) -debug=PRINTF -debug=PRINTF_TO_FILE -debug=COLLECT_PRINTF $(UDFLAGS) -main -of$@ $(SRC_GC)

$(ROOT)/memstomp: $(SRC)
	$(DMD) -debug=MEMSTOMP $(UDFLAGS) -main -of$@ $(SRC)

$(ROOT)/invariant: $(SRC)
	$(DMD) -debug -debug=INVARIANT -debug=PTRCHECK -debug=PTRCHECK2 $(UDFLAGS) -main -of$@ $(SRC)

$(ROOT)/logging: $(SRC)
	$(DMD) -debug=LOGGING $(UDFLAGS) -main -of$@ $(SRC)

$(ROOT)/precise: $(SRC)
	$(DMD) -debug -debug=INVARIANT -debug=MEMSTOMP $(UDFLAGS) -main -of$@ $(SRC)
$(ROOT)/precise.done: RUN_ARGS += --DRT-gcopt=gc:precise

$(ROOT)/precisegc: $(SRC) precisegc.d
	$(DMD) $(UDFLAGS) -gx -of$@ $(SRC) precisegc.d

$(ROOT)/concurrent: $(SRC)
	$(DMD) $(UDFLAGS) -main -of$@ $(SRC)
$(ROOT)/concurrent.done: RUN_ARGS += --DRT-gcopt=fork:1

$(ROOT)/precise_concurrent: $(SRC)
	$(DMD) $(UDFLAGS) -main -of$@ $(SRC)
$(ROOT)/precise_concurrent.done: RUN_ARGS += "--DRT-gcopt=gc:precise fork:1"

$(ROOT)/attributes: attributes.d
	$(DMD) $(UDFLAGS) -of$@ attributes.d

$(ROOT)/forkgc: forkgc.d
	$(DMD) $(UDFLAGS) -of$@ forkgc.d

$(ROOT)/forkgc2: forkgc2.d
	$(DMD) $(UDFLAGS) -of$@ forkgc2.d

$(ROOT)/sigmaskgc: sigmaskgc.d
	$(DMD) $(UDFLAGS) -of$@ sigmaskgc.d

$(ROOT)/startbackgc: startbackgc.d
	$(DMD) $(UDFLAGS) -of$@ sigmaskgc.d

$(ROOT)/recoverfree: recoverfree.d
	$(DMD) $(DFLAGS) -of$@ recoverfree.d

$(ROOT)/nocollect: nocollect.d
	$(DMD) $(DFLAGS) -of$@ nocollect.d

$(ROOT)/hospital: hospital.d
	$(DMD) $(DFLAGS) -d -of$@ hospital.d
$(ROOT)/hospital.done: RUN_ARGS += --DRT-gcopt=fork:1

clean:
	rm -rf $(ROOT)
