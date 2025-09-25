obj-m += applespi.o
obj-m += apple-ibridge.o
obj-m += apple-ib-tb.o
obj-m += apple-ib-als.o

CFLAGS_applespi.o = -I$(src)	# for tracing
CFLAGS_apple-ibridge.o = -DCONFIG_HID=1
CFLAGS_apple-ib-tb.o = -DCONFIG_HID=1
CFLAGS_apple-ib-als.o = -DCONFIG_HID=1 -DCONFIG_IIO=1

KVERSION := $(KERNELRELEASE)
ifeq ($(origin KERNELRELEASE), undefined)
KVERSION := $(shell uname -r)
endif
KDIR := /lib/modules/$(KVERSION)/build
PWD := $(shell pwd)

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean

install:
	$(MAKE) -C $(KDIR) M=$(PWD) modules_install

test: all
	sync
	-rmmod applespi
	insmod ./applespi.ko
