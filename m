From: Masuko Tomoya <tomoya.masuko@gmail.com>
Subject: Re: about attaching rbd volume from instance on KVM
Date: Thu, 16 Feb 2012 12:01:57 +0900
Message-ID: <CAM2zNoNeaNpR4N+WE2X6+eAMiQXJRspvyKNZPYGWfhnPeJOwAw@mail.gmail.com>
References: <CAM2zNoMCEb+8m1SJrS_oXHhQw18L5axNRQY-RB53GfgACNN9Hg@mail.gmail.com>
	<CAJafhzSa=tUJpOyLaQvde__hM+5wwN4wDjRei+HGrm5nf7VX0w@mail.gmail.com>
	<CAM2zNoPg88JM=VOGUz6vE=n=xWzgOZ+Nkz2hM=ip33ojw94-nQ@mail.gmail.com>
	<4F332B19.5090206@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50202 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757034Ab2BPDCA convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 15 Feb 2012 22:02:00 -0500
Received: by lagu2 with SMTP id u2so1838251lag.19
        for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2012 19:01:57 -0800 (PST)
In-Reply-To: <4F332B19.5090206@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: christian@brunner-muc.de, ceph-devel@vger.kernel.org

Hi Josh,

Thank you for your reply !

>libvirt 0.9.9 fixes this (the applied patch is http://www.redhat.com/a=
rchives/libvir-list/2011-December/msg00506.html if you're curious).
=46inally I applied the patch to libvirt 0.9.8 and
I fixed it.

But I have another issue.
When I tried attach rbd volume to VM on KVM, error occured.

--
root@compute04:~# virsh attach-device instance-00000027 testvolume4.xml
error: Failed to attach device from testvolume4.xml
error: operation failed: open disk image file failed
--

Could you advice to me ?

*testvolume4.xml is below.
<disk type=3D'network' device=3D'disk'>
  <driver name=3D'qemu' type=3D'raw'/>
  <source protocol=3D'rbd' name=3D'rbd/testvolume3'>
    <host name=3D'10.2.100.56' port=3D'6789'/>
  </source>
  <target dev=3D'vdm' bus=3D'virtio'/>
</disk>

* I use this qemu-kvm with built rbd option on.
root@compute04:/usr/bin# /usr/bin/qemu-system-x86_64 -version
QEMU emulator version 1.0 (qemu-kvm-1.0), Copyright (c) 2003-2008
=46abrice Bellard

*libvirtd.log is below
2012-02-15 05:30:24.669+0000: 14034: debug :
remoteDispatchDomainAttachDeviceHelper:297 : server=3D0x1dad7f0
client=3D0x1e78fd0 msg=3D0x7fedd0003490 rerr=3D0x7feddeb1fc70 args=3D0x=
1e6f270
ret=3D0x1e6f210
2012-02-15 05:30:24.669+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D9 imeout=3D5000
2012-02-15 05:30:24.669+0000: 14034: debug :
virDomainAttachDevice:8542 : dom=3D0x1e6f230, (VM:
name=3Dinstance-00000027, uuid=3D51846781-0d41-44a4-9da7-902c7c394f53),
xml=3D<disk type=3D'network' device=3D'disk'>
  <driver name=3D'qemu' type=3D'raw'/>
  <source protocol=3D'rbd' name=3D'rbd/testvolume3'>
    <host name=3D'10.2.100.56' port=3D'6789'/>
  </source>
  <target dev=3D'vdm' bus=3D'virtio'/>
</disk>

2012-02-15 05:30:24.669+0000: 14034: debug : virDomainObjRef:1508 :
obj=3D0x1dcd410 refs=3D3
2012-02-15 05:30:24.669+0000: 14034: debug :
qemuDomainObjBeginJobInternal:766 : Starting job: modify (async=3Dnone)
2012-02-15 05:30:24.669+0000: 14034: debug : virCgroupNew:602 : New
group /libvirt/qemu/instance-00000027
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupDetect:261 :
Detected mount/mapping 0:cpu at /sys/fs/cgroup/cpu in
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupDetect:261 :
Detected mount/mapping 1:cpuacct at /sys/fs/cgroup/cpuacct in
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupDetect:261 :
Detected mount/mapping 2:cpuset at /sys/fs/cgroup/cpuset in
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupDetect:261 :
Detected mount/mapping 3:memory at /sys/fs/cgroup/memory in
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupDetect:261 :
Detected mount/mapping 4:devices at /sys/fs/cgroup/devices in
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupDetect:261 :
Detected mount/mapping 5:freezer at /sys/fs/cgroup/freezer in
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupDetect:261 :
Detected mount/mapping 6:blkio at /sys/fs/cgroup/blkio in
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupMakeGroup:523 :
Make group /libvirt/qemu/instance-00000027
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupMakeGroup:545 :
Make controller /sys/fs/cgroup/cpu/libvirt/qemu/instance-00000027/
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupMakeGroup:545 :
Make controller /sys/fs/cgroup/cpuacct/libvirt/qemu/instance-00000027/
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupMakeGroup:545 :
Make controller /sys/fs/cgroup/cpuset/libvirt/qemu/instance-00000027/
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupMakeGroup:545 :
Make controller /sys/fs/cgroup/memory/libvirt/qemu/instance-00000027/
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupMakeGroup:545 :
Make controller /sys/fs/cgroup/devices/libvirt/qemu/instance-00000027/
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupMakeGroup:545 :
Make controller /sys/fs/cgroup/freezer/libvirt/qemu/instance-00000027/
2012-02-15 05:30:24.670+0000: 14034: debug : virCgroupMakeGroup:545 :
Make controller /sys/fs/cgroup/blkio/libvirt/qemu/instance-00000027/
2012-02-15 05:30:24.670+0000: 14034: debug :
virDomainLockManagerNew:123 : plugin=3D0x1dbb650 dom=3D0x1dcd410
withResources=3D0
2012-02-15 05:30:24.670+0000: 14034: debug : virLockManagerNew:291 :
plugin=3D0x1dbb650 type=3D0 nparams=3D4 params=3D0x7feddeb1f8c0 flags=3D=
0
2012-02-15 05:30:24.670+0000: 14034: debug :
virLockManagerLogParams:98 :   key=3Duuid type=3Duuid
value=3D51846781-0d41-44a4-9da7-902c7c394f53
2012-02-15 05:30:24.670+0000: 14034: debug :
virLockManagerLogParams:94 :   key=3Dname type=3Dstring
value=3Dinstance-00000027
2012-02-15 05:30:24.670+0000: 14034: debug :
virLockManagerLogParams:82 :   key=3Did type=3Duint value=3D6
2012-02-15 05:30:24.670+0000: 14034: debug :
virLockManagerLogParams:82 :   key=3Dpid type=3Duint value=3D31613
2012-02-15 05:30:24.670+0000: 14034: debug : virLockManagerAcquire:337
: lock=3D0x1ebec30 state=3D'(null)' flags=3D0 fd=3D(nil)
2012-02-15 05:30:24.670+0000: 14034: debug : virLockManagerFree:374 :
lock=3D0x1ebec30
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressSetNextAddr:1053 : PCI addr 0:0:2.0 already in use
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressSetNextAddr:1053 : PCI addr 0:0:3.0 already in use
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressSetNextAddr:1053 : PCI addr 0:0:4.0 already in use
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressSetNextAddr:1053 : PCI addr 0:0:5.0 already in use
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressSetNextAddr:1053 : PCI addr 0:0:6.0 already in use
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressSetNextAddr:1058 : Allocating PCI addr 0:0:7.0
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressReserveAddr:882 : Reserving PCI addr 0:0:7.0
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressReserveAddr:882 : Reserving PCI addr 0:0:7.1
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressReserveAddr:882 : Reserving PCI addr 0:0:7.2
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressReserveAddr:882 : Reserving PCI addr 0:0:7.3
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressReserveAddr:882 : Reserving PCI addr 0:0:7.4
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressReserveAddr:882 : Reserving PCI addr 0:0:7.5
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressReserveAddr:882 : Reserving PCI addr 0:0:7.6
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuDomainPCIAddressReserveAddr:882 : Reserving PCI addr 0:0:7.7
2012-02-15 05:30:24.670+0000: 14034: debug : qemuMonitorRef:187 :
QEMU_MONITOR_REF: mon=3D0x1dcdf70 refs=3D3
2012-02-15 05:30:24.670+0000: 14034: debug : qemuMonitorAddDrive:2382
: mon=3D0x1dcdf70
drive=3Dfile=3Drbd:rbd/testvolume3:mon_host=3D10.2.100.56\:6789,if=3Dno=
ne,id=3Ddrive-virtio-disk12,format=3Draw
2012-02-15 05:30:24.670+0000: 14034: debug : virJSONValueToString:1037
: object=3D0x1dd5fb0
2012-02-15 05:30:24.670+0000: 14034: debug :
virJSONValueToStringOne:969 : object=3D0x1dd5fb0 type=3D0 gen=3D0x1e6e9=
e0
2012-02-15 05:30:24.670+0000: 14034: debug :
virJSONValueToStringOne:969 : object=3D0x1dc9ed0 type=3D2 gen=3D0x1e6e9=
e0
2012-02-15 05:30:24.670+0000: 14034: debug :
virJSONValueToStringOne:969 : object=3D0x1e4f370 type=3D0 gen=3D0x1e6e9=
e0
2012-02-15 05:30:24.670+0000: 14034: debug :
virJSONValueToStringOne:969 : object=3D0x1ebf6e0 type=3D2 gen=3D0x1e6e9=
e0
2012-02-15 05:30:24.670+0000: 14034: debug :
virJSONValueToStringOne:969 : object=3D0x1e79960 type=3D2 gen=3D0x1e6e9=
e0
2012-02-15 05:30:24.670+0000: 14034: debug :
virJSONValueToStringOne:969 : object=3D0x1ebf4b0 type=3D2 gen=3D0x1e6e9=
e0
2012-02-15 05:30:24.670+0000: 14034: debug : virJSONValueToString:1071
: result=3D{"execute":"drive_add","arguments":{"pci_addr":"dummy","opts=
":"file=3Drbd:rbd/testvolume3:mon_host=3D10.2.100.56\\:6789,if=3Dnone,i=
d=3Ddrive-virtio-disk12,format=3Draw"},"id":"libvirt-7"}
2012-02-15 05:30:24.670+0000: 14034: debug :
qemuMonitorJSONCommandWithFd:228 : Send command
'{"execute":"drive_add","arguments":{"pci_addr":"dummy","opts":"file=3D=
rbd:rbd/testvolume3:mon_host=3D10.2.100.56\\:6789,if=3Dnone,id=3Ddrive-=
virtio-disk12,format=3Draw"},"id":"libvirt-7"}'
for write with FD -1
2012-02-15 05:30:24.670+0000: 14034: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D23
events=3D15
2012-02-15 05:30:24.670+0000: 14034: debug :
virEventPollInterruptLocked:706 : Interrupting
2012-02-15 05:30:24.670+0000: 14034: debug : qemuMonitorSend:788 :
QEMU_MONITOR_SEND_MSG: mon=3D0x1dcdf70
msg=3D{"execute":"drive_add","arguments":{"pci_addr":"dummy","opts":"fi=
le=3Drbd:rbd/testvolume3:mon_host=3D10.2.100.56\\:6789,if=3Dnone,id=3Dd=
rive-virtio-disk12,format=3Draw"},"id":"libvirt-7"}
 fd=3D-1
2012-02-15 05:30:24.670+0000: 14032: debug : virEventPollRunOnce:630 :
Poll got 1 event(s)
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchTimeouts:415 : Dispatch 7
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:460 : Dispatch 9
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D0 w=3D1
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=3D1
events=3D1
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D1 w=3D2
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D2 w=3D3
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D3 w=3D4
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D4 w=3D5
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D5 w=3D6
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D6 w=3D8
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D7 w=3D23
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D8 w=3D24
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventRunDefaultImpl:244 : running default event implementation
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D0 w=3D1, f=3D7 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D1 w=3D2, f=3D9 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D2 w=3D3, f=3D11 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D3 w=3D4, f=3D12 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D4 w=3D5, f=3D6 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D5 w=3D6, f=3D14 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D6 w=3D8, f=3D16 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D7 w=3D23, f=3D19 e=3D29 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D24, f=3D15 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 7 timers
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCalculateTimeout:331 : Got a timeout scheduled for
1329283829669
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCalculateTimeout:351 : Timeout at 1329283829669 due in
4999 ms
2012-02-15 05:30:24.670+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D9 imeout=3D4999
2012-02-15 05:30:24.670+0000: 14032: debug : virEventPollRunOnce:630 :
Poll got 1 event(s)
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchTimeouts:415 : Dispatch 7
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:460 : Dispatch 9
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D0 w=3D1
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D1 w=3D2
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D2 w=3D3
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D3 w=3D4
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D4 w=3D5
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D5 w=3D6
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D6 w=3D8
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D7 w=3D23
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=3D2=
3
events=3D2
2012-02-15 05:30:24.670+0000: 14032: debug : qemuMonitorRef:187 :
QEMU_MONITOR_REF: mon=3D0x1dcdf70 refs=3D4
2012-02-15 05:30:24.670+0000: 14032: debug : qemuMonitorIOWrite:418 :
QEMU_MONITOR_IO_WRITE: mon=3D0x1dcdf70
buf=3D{"execute":"drive_add","arguments":{"pci_addr":"dummy","opts":"fi=
le=3Drbd:rbd/testvolume3:mon_host=3D10.2.100.56\\:6789,if=3Dnone,id=3Dd=
rive-virtio-disk12,format=3Draw"},"id":"libvirt-7"}
 len=3D179 ret=3D179 errno=3D11
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D23
events=3D13
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollInterruptLocked:702 : Skip interrupt, 1 -472389568
2012-02-15 05:30:24.670+0000: 14032: debug : qemuMonitorUnref:196 :
QEMU_MONITOR_UNREF: mon=3D0x1dcdf70 refs=3D3
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D8 w=3D24
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventRunDefaultImpl:244 : running default event implementation
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D0 w=3D1, f=3D7 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D1 w=3D2, f=3D9 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D2 w=3D3, f=3D11 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D3 w=3D4, f=3D12 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D4 w=3D5, f=3D6 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D5 w=3D6, f=3D14 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D6 w=3D8, f=3D16 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D7 w=3D23, f=3D19 e=3D25 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D24, f=3D15 e=3D1 d=3D0
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 7 timers
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCalculateTimeout:331 : Got a timeout scheduled for
1329283829669
2012-02-15 05:30:24.670+0000: 14032: debug :
virEventPollCalculateTimeout:351 : Timeout at 1329283829669 due in
4999 ms
2012-02-15 05:30:24.670+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D9 imeout=3D4999
2012-02-15 05:30:24.671+0000: 14032: debug : virEventPollRunOnce:630 :
Poll got 1 event(s)
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchTimeouts:415 : Dispatch 7
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:460 : Dispatch 9
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D0 w=3D1
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D1 w=3D2
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D2 w=3D3
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D3 w=3D4
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D4 w=3D5
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D5 w=3D6
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D6 w=3D8
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D7 w=3D23
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=3D2=
3
events=3D1
2012-02-15 05:30:24.671+0000: 14032: debug : qemuMonitorRef:187 :
QEMU_MONITOR_REF: mon=3D0x1dcdf70 refs=3D4
2012-02-15 05:30:24.671+0000: 14032: debug : qemuMonitorIOProcess:313
: QEMU_MONITOR_IO_PROCESS: mon=3D0x1dcdf70 buf=3D{"id": "libvirt-7",
"error": {"class": "CommandNotFound", "desc": "The command drive_add
has not been found", "data": {"name": "drive_add"}}}
 len=3D143
2012-02-15 05:30:24.671+0000: 14032: debug :
qemuMonitorJSONIOProcessLine:115 : Line [{"id": "libvirt-7", "error":
{"class": "CommandNotFound", "desc": "The command drive_add has not
been found", "data": {"name": "drive_add"}}}]
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONValueFromString:914 : string=3D{"id": "libvirt-7", "error":
{"class": "CommandNotFound", "desc": "The command drive_add has not
been found", "data": {"name": "drive_add"}}}
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleStartMap:791 : parser=3D0x7fffc5c35aa0
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleMapKey:772 : parser=3D0x7fffc5c35aa0
key=3D0x7fedd0002252
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleString:752 : parser=3D0x7fffc5c35aa0
str=3D0x7fedd0002258
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleMapKey:772 : parser=3D0x7fffc5c35aa0
key=3D0x7fedd0002265
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleStartMap:791 : parser=3D0x7fffc5c35aa0
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleMapKey:772 : parser=3D0x7fffc5c35aa0
key=3D0x7fedd000226f
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleString:752 : parser=3D0x7fffc5c35aa0
str=3D0x7fedd0002278
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleMapKey:772 : parser=3D0x7fffc5c35aa0
key=3D0x7fedd000228b
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleString:752 : parser=3D0x7fffc5c35aa0
str=3D0x7fedd0002293
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleMapKey:772 : parser=3D0x7fffc5c35aa0
key=3D0x7fedd00022bf
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleStartMap:791 : parser=3D0x7fffc5c35aa0
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleMapKey:772 : parser=3D0x7fffc5c35aa0
key=3D0x7fedd00022c8
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleString:752 : parser=3D0x7fffc5c35aa0
str=3D0x7fedd00022d0
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleEndMap:820 : parser=3D0x7fffc5c35aa0
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleEndMap:820 : parser=3D0x7fffc5c35aa0
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONParserHandleEndMap:820 : parser=3D0x7fffc5c35aa0
2012-02-15 05:30:24.671+0000: 14032: debug :
virJSONValueFromString:958 : result=3D0x7fedd0000bc0
2012-02-15 05:30:24.671+0000: 14032: debug :
qemuMonitorJSONIOProcessLine:135 : QEMU_MONITOR_RECV_REPLY:
mon=3D0x1dcdf70 reply=3D{"id": "libvirt-7", "error": {"class":
"CommandNotFound", "desc": "The command drive_add has not been found",
"data": {"name": "drive_add"}}}
2012-02-15 05:30:24.671+0000: 14032: debug :
qemuMonitorJSONIOProcess:186 : Total used 143 bytes out of 143
available in buffer
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D23
events=3D13
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollInterruptLocked:702 : Skip interrupt, 1 -472389568
2012-02-15 05:30:24.671+0000: 14032: debug : qemuMonitorUnref:196 :
QEMU_MONITOR_UNREF: mon=3D0x1dcdf70 refs=3D3
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D8 w=3D24
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventRunDefaultImpl:244 : running default event implementation
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D0 w=3D1, f=3D7 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D1 w=3D2, f=3D9 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D2 w=3D3, f=3D11 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D3 w=3D4, f=3D12 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D4 w=3D5, f=3D6 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D5 w=3D6, f=3D14 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14034: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D23
events=3D13
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D6 w=3D8, f=3D16 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D7 w=3D23, f=3D19 e=3D25 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D24, f=3D15 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 7 timers
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollCalculateTimeout:331 : Got a timeout scheduled for
1329283829669
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollCalculateTimeout:351 : Timeout at 1329283829669 due in
4998 ms
2012-02-15 05:30:24.671+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D9 imeout=3D4998
2012-02-15 05:30:24.671+0000: 14034: debug :
virEventPollInterruptLocked:706 : Interrupting
2012-02-15 05:30:24.671+0000: 14034: debug :
qemuMonitorJSONCommandWithFd:233 : Receive command reply ret=3D0
rxObject=3D0x7fedd0000bc0
2012-02-15 05:30:24.671+0000: 14032: debug : virEventPollRunOnce:630 :
Poll got 1 event(s)
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchTimeouts:415 : Dispatch 7
2012-02-15 05:30:24.671+0000: 14034: debug :
qemuMonitorJSONAddDrive:2818 : drive_add command not found, trying HMP
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:460 : Dispatch 9
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D0 w=3D1
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=3D1
events=3D1
2012-02-15 05:30:24.671+0000: 14034: debug : virJSONValueToString:1037
: object=3D0x1ebd520
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D1 w=3D2
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D2 w=3D3
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D3 w=3D4
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D4 w=3D5
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D5 w=3D6
2012-02-15 05:30:24.671+0000: 14034: debug :
virJSONValueToStringOne:969 : object=3D0x1ebd520 type=3D0 gen=3D0x1ebd6=
f0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D6 w=3D8
2012-02-15 05:30:24.671+0000: 14034: debug :
virJSONValueToStringOne:969 : object=3D0x1e4e7a0 type=3D2 gen=3D0x1ebd6=
f0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D7 w=3D23
2012-02-15 05:30:24.671+0000: 14034: debug :
virJSONValueToStringOne:969 : object=3D0x1ebf600 type=3D0 gen=3D0x1ebd6=
f0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D8 w=3D24
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.671+0000: 14034: debug :
virJSONValueToStringOne:969 : object=3D0x1dd5e50 type=3D2 gen=3D0x1ebd6=
f0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.671+0000: 14034: debug :
virJSONValueToStringOne:969 : object=3D0x1e543f0 type=3D2 gen=3D0x1ebd6=
f0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventRunDefaultImpl:244 : running default event implementation
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.671+0000: 14034: debug : virJSONValueToString:1071
: result=3D{"execute":"human-monitor-command","arguments":{"command-lin=
e":"drive_add
dummy file=3Drbd:rbd/testvolume3:mon_host=3D10.2.100.56\\\\:6789,if=3Dn=
one,id=3Ddrive-virtio-disk12,format=3Draw"},"id":"libvirt-8"}
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.671+0000: 14034: debug :
qemuMonitorJSONCommandWithFd:228 : Send command
'{"execute":"human-monitor-command","arguments":{"command-line":"drive_=
add
dummy file=3Drbd:rbd/testvolume3:mon_host=3D10.2.100.56\\\\:6789,if=3Dn=
one,id=3Ddrive-virtio-disk12,format=3Draw"},"id":"libvirt-8"}'
for write with FD -1
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D0 w=3D1, f=3D7 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D1 w=3D2, f=3D9 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D2 w=3D3, f=3D11 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14034: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D23
events=3D15
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D3 w=3D4, f=3D12 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D4 w=3D5, f=3D6 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D5 w=3D6, f=3D14 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D6 w=3D8, f=3D16 e=3D1 d=3D0
2012-02-15 05:30:24.671+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D7 w=3D23, f=3D19 e=3D25 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D24, f=3D15 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 7 timers
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCalculateTimeout:331 : Got a timeout scheduled for
1329283829669
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCalculateTimeout:351 : Timeout at 1329283829669 due in
4997 ms
2012-02-15 05:30:24.672+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D9 imeout=3D4997
2012-02-15 05:30:24.672+0000: 14034: debug :
virEventPollInterruptLocked:706 : Interrupting
2012-02-15 05:30:24.672+0000: 14034: debug : qemuMonitorSend:788 :
QEMU_MONITOR_SEND_MSG: mon=3D0x1dcdf70
msg=3D{"execute":"human-monitor-command","arguments":{"command-line":"d=
rive_add
dummy file=3Drbd:rbd/testvolume3:mon_host=3D10.2.100.56\\\\:6789,if=3Dn=
one,id=3Ddrive-virtio-disk12,format=3Draw"},"id":"libvirt-8"}
 fd=3D-1
2012-02-15 05:30:24.672+0000: 14032: debug : virEventPollRunOnce:630 :
Poll got 1 event(s)
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchTimeouts:415 : Dispatch 7
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:460 : Dispatch 9
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D0 w=3D1
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=3D1
events=3D1
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D1 w=3D2
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D2 w=3D3
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D3 w=3D4
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D4 w=3D5
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D5 w=3D6
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D6 w=3D8
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D7 w=3D23
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D8 w=3D24
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventRunDefaultImpl:244 : running default event implementation
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D0 w=3D1, f=3D7 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D1 w=3D2, f=3D9 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D2 w=3D3, f=3D11 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D3 w=3D4, f=3D12 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D4 w=3D5, f=3D6 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D5 w=3D6, f=3D14 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D6 w=3D8, f=3D16 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D7 w=3D23, f=3D19 e=3D29 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D24, f=3D15 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 7 timers
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCalculateTimeout:331 : Got a timeout scheduled for
1329283829669
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCalculateTimeout:351 : Timeout at 1329283829669 due in
4997 ms
2012-02-15 05:30:24.672+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D9 imeout=3D4997
2012-02-15 05:30:24.672+0000: 14032: debug : virEventPollRunOnce:630 :
Poll got 1 event(s)
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchTimeouts:415 : Dispatch 7
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:460 : Dispatch 9
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D0 w=3D1
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D1 w=3D2
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D2 w=3D3
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D3 w=3D4
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D4 w=3D5
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D5 w=3D6
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D6 w=3D8
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D7 w=3D23
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=3D2=
3
events=3D2
2012-02-15 05:30:24.672+0000: 14032: debug : qemuMonitorRef:187 :
QEMU_MONITOR_REF: mon=3D0x1dcdf70 refs=3D4
2012-02-15 05:30:24.672+0000: 14032: debug : qemuMonitorIOWrite:418 :
QEMU_MONITOR_IO_WRITE: mon=3D0x1dcdf70
buf=3D{"execute":"human-monitor-command","arguments":{"command-line":"d=
rive_add
dummy file=3Drbd:rbd/testvolume3:mon_host=3D10.2.100.56\\\\:6789,if=3Dn=
one,id=3Ddrive-virtio-disk12,format=3Draw"},"id":"libvirt-8"}
 len=3D198 ret=3D198 errno=3D11
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D23
events=3D13
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollInterruptLocked:702 : Skip interrupt, 1 -472389568
2012-02-15 05:30:24.672+0000: 14032: debug : qemuMonitorUnref:196 :
QEMU_MONITOR_UNREF: mon=3D0x1dcdf70 refs=3D3
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D8 w=3D24
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventRunDefaultImpl:244 : running default event implementation
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D0 w=3D1, f=3D7 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D1 w=3D2, f=3D9 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D2 w=3D3, f=3D11 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D3 w=3D4, f=3D12 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D4 w=3D5, f=3D6 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D5 w=3D6, f=3D14 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D6 w=3D8, f=3D16 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D7 w=3D23, f=3D19 e=3D25 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D24, f=3D15 e=3D1 d=3D0
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 7 timers
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCalculateTimeout:331 : Got a timeout scheduled for
1329283829669
2012-02-15 05:30:24.672+0000: 14032: debug :
virEventPollCalculateTimeout:351 : Timeout at 1329283829669 due in
4997 ms
2012-02-15 05:30:24.672+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D9 imeout=3D4997
2012-02-15 05:30:24.673+0000: 14032: debug : virEventPollRunOnce:630 :
Poll got 1 event(s)
2012-02-15 05:30:24.673+0000: 14032: debug :
virEventPollDispatchTimeouts:415 : Dispatch 7
2012-02-15 05:30:24.673+0000: 14032: debug :
virEventPollDispatchHandles:460 : Dispatch 9
2012-02-15 05:30:24.673+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D0 w=3D1
2012-02-15 05:30:24.673+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D1 w=3D2
2012-02-15 05:30:24.673+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D2 w=3D3
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D3 w=3D4
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D4 w=3D5
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D5 w=3D6
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D6 w=3D8
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D7 w=3D23
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=3D2=
3
events=3D1
2012-02-15 05:30:24.674+0000: 14032: debug : qemuMonitorRef:187 :
QEMU_MONITOR_REF: mon=3D0x1dcdf70 refs=3D4
2012-02-15 05:30:24.674+0000: 14032: debug : qemuMonitorIOProcess:313
: QEMU_MONITOR_IO_PROCESS: mon=3D0x1dcdf70 buf=3D{"return": "conf optio=
n
6789 has no value\r\nerror setting config options\r\ncould not open
disk image rbd:rbd/testvolume3:mon_host=3D10.2.100.56\\\\:6789: Invalid
argument\r\n", "id": "libvirt-8"}
 len=3D197
2012-02-15 05:30:24.674+0000: 14032: debug :
qemuMonitorJSONIOProcessLine:115 : Line [{"return": "conf option 6789
has no value\r\nerror setting config options\r\ncould not open disk
image rbd:rbd/testvolume3:mon_host=3D10.2.100.56\\\\:6789: Invalid
argument\r\n", "id": "libvirt-8"}]
2012-02-15 05:30:24.674+0000: 14032: debug :
virJSONValueFromString:914 : string=3D{"return": "conf option 6789 has
no value\r\nerror setting config options\r\ncould not open disk image
rbd:rbd/testvolume3:mon_host=3D10.2.100.56\\\\:6789: Invalid
argument\r\n", "id": "libvirt-8"}
2012-02-15 05:30:24.674+0000: 14032: debug :
virJSONParserHandleStartMap:791 : parser=3D0x7fffc5c35aa0
2012-02-15 05:30:24.674+0000: 14032: debug :
virJSONParserHandleMapKey:772 : parser=3D0x7fffc5c35aa0
key=3D0x7fedd00026f2
2012-02-15 05:30:24.674+0000: 14032: debug :
virJSONParserHandleString:752 : parser=3D0x7fffc5c35aa0
str=3D0x7fedd0083e80
2012-02-15 05:30:24.674+0000: 14032: debug :
virJSONParserHandleMapKey:772 : parser=3D0x7fffc5c35aa0
key=3D0x7fedd00027a2
2012-02-15 05:30:24.674+0000: 14032: debug :
virJSONParserHandleString:752 : parser=3D0x7fffc5c35aa0
str=3D0x7fedd00027a8
2012-02-15 05:30:24.674+0000: 14032: debug :
virJSONParserHandleEndMap:820 : parser=3D0x7fffc5c35aa0
2012-02-15 05:30:24.674+0000: 14032: debug :
virJSONValueFromString:958 : result=3D0x7fedd0000b10
2012-02-15 05:30:24.674+0000: 14032: debug :
qemuMonitorJSONIOProcessLine:135 : QEMU_MONITOR_RECV_REPLY:
mon=3D0x1dcdf70 reply=3D{"return": "conf option 6789 has no value\r\ner=
ror
setting config options\r\ncould not open disk image
rbd:rbd/testvolume3:mon_host=3D10.2.100.56\\\\:6789: Invalid
argument\r\n", "id": "libvirt-8"}
2012-02-15 05:30:24.674+0000: 14032: debug :
qemuMonitorJSONIOProcess:186 : Total used 197 bytes out of 197
available in buffer
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D23
events=3D13
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollInterruptLocked:702 : Skip interrupt, 1 -472389568
2012-02-15 05:30:24.674+0000: 14032: debug : qemuMonitorUnref:196 :
QEMU_MONITOR_UNREF: mon=3D0x1dcdf70 refs=3D3
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D8 w=3D24
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventRunDefaultImpl:244 : running default event implementation
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D0 w=3D1, f=3D7 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D1 w=3D2, f=3D9 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D2 w=3D3, f=3D11 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D3 w=3D4, f=3D12 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D4 w=3D5, f=3D6 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14034: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D23
events=3D13
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D5 w=3D6, f=3D14 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D6 w=3D8, f=3D16 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D7 w=3D23, f=3D19 e=3D25 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D24, f=3D15 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 7 timers
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCalculateTimeout:331 : Got a timeout scheduled for
1329283829669
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCalculateTimeout:351 : Timeout at 1329283829669 due in
4995 ms
2012-02-15 05:30:24.674+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D9 imeout=3D4995
2012-02-15 05:30:24.674+0000: 14034: debug :
virEventPollInterruptLocked:706 : Interrupting
2012-02-15 05:30:24.674+0000: 14034: debug :
qemuMonitorJSONCommandWithFd:233 : Receive command reply ret=3D0
rxObject=3D0x7fedd0000b10
2012-02-15 05:30:24.674+0000: 14032: debug : virEventPollRunOnce:630 :
Poll got 1 event(s)
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchTimeouts:415 : Dispatch 7
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:460 : Dispatch 9
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D0 w=3D1
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=3D1
events=3D1
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D1 w=3D2
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D2 w=3D3
2012-02-15 05:30:24.674+0000: 14034: error :
qemuMonitorTextAddDrive:2828 : operation failed: open disk image file
failed
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D3 w=3D4
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D4 w=3D5
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D5 w=3D6
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D6 w=3D8
2012-02-15 05:30:24.674+0000: 14034: debug : qemuMonitorUnref:196 :
QEMU_MONITOR_UNREF: mon=3D0x1dcdf70 refs=3D2
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D7 w=3D23
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D8 w=3D24
2012-02-15 05:30:24.674+0000: 14034: debug :
virSecurityDACRestoreSecurityImageLabelInt:219 : Skipping image label
restore on rbd/testvolume3 because FS is of type network
2012-02-15 05:30:24.674+0000: 14034: debug :
virDomainLockManagerNew:123 : plugin=3D0x1dbb650 dom=3D0x1dcd410
withResources=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.674+0000: 14034: debug : virLockManagerNew:291 :
plugin=3D0x1dbb650 type=3D0 nparams=3D4 params=3D0x7feddeb1f8c0 flags=3D=
0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventRunDefaultImpl:244 : running default event implementation
2012-02-15 05:30:24.674+0000: 14034: debug :
virLockManagerLogParams:98 :   key=3Duuid type=3Duuid
value=3D51846781-0d41-44a4-9da7-902c7c394f53
2012-02-15 05:30:24.674+0000: 14034: debug :
virLockManagerLogParams:94 :   key=3Dname type=3Dstring
value=3Dinstance-00000027
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.674+0000: 14034: debug :
virLockManagerLogParams:82 :   key=3Did type=3Duint value=3D6
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.674+0000: 14034: debug :
virLockManagerLogParams:82 :   key=3Dpid type=3Duint value=3D31613
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D0 w=3D1, f=3D7 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14034: debug : virLockManagerRelease:352
: lock=3D0x1ebf210 state=3D(nil) flags=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D1 w=3D2, f=3D9 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14034: debug : virLockManagerFree:374 :
lock=3D0x1ebf210
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D2 w=3D3, f=3D11 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14034: debug : qemuDomainObjEndJob:883 :
Stopping job: modify (async=3Dnone)
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D3 w=3D4, f=3D12 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D4 w=3D5, f=3D6 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D5 w=3D6, f=3D14 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D6 w=3D8, f=3D16 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D7 w=3D23, f=3D19 e=3D25 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D24, f=3D15 e=3D1 d=3D0
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 7 timers
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCalculateTimeout:331 : Got a timeout scheduled for
1329283829669
2012-02-15 05:30:24.674+0000: 14032: debug :
virEventPollCalculateTimeout:351 : Timeout at 1329283829669 due in
4995 ms
2012-02-15 05:30:24.674+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D9 imeout=3D4995
2012-02-15 05:30:24.674+0000: 14034: debug : virDomainObjUnref:1515 :
obj=3D0x1dcd410 refs=3D2
2012-02-15 05:30:24.674+0000: 14034: debug : virDomainFree:2292 :
dom=3D0x1e6f230, (VM: name=3Dinstance-00000027,
uuid=3D51846781-0d41-44a4-9da7-902c7c394f53)
2012-02-15 05:30:24.674+0000: 14034: debug : virUnrefDomain:276 :
unref domain 0x1e6f230 instance-00000027 1
2012-02-15 05:30:24.674+0000: 14034: debug : virReleaseDomain:238 :
release domain 0x1e6f230 instance-00000027
51846781-0d41-44a4-9da7-902c7c394f53
2012-02-15 05:30:24.674+0000: 14034: debug : virReleaseDomain:246 :
unref connection 0x7fedd0043570 2
2012-02-15 05:30:24.674+0000: 14034: debug :
virNetServerProgramSendError:135 : prog=3D536903814 ver=3D1 proc=3D8 ty=
pe=3D1
serial=3D4 msg=3D0x7fedd0003490 rerr=3D0x7feddeb1fc70
2012-02-15 05:30:24.674+0000: 14034: debug :
virNetMessageEncodePayload:351 : Encode length as 180
2012-02-15 05:30:24.674+0000: 14034: debug :
virNetServerClientSendMessage:1106 : msg=3D0x7fedd0003490 proc=3D8 len=3D=
180
offset=3D0
2012-02-15 05:30:24.674+0000: 14034: debug :
virNetServerClientSendMessage:1116 : RPC_SERVER_CLIENT_MSG_TX_QUEUE:
client=3D0x1e78fd0 len=3D180 prog=3D536903814 vers=3D1 proc=3D8 type=3D=
1 status=3D1
serial=3D4
2012-02-15 05:30:24.674+0000: 14034: debug :
virNetServerClientCalculateHandleMode:137 : tls=3D(nil) hs=3D-1,
rx=3D0x7fedd0043e10 tx=3D0x7fedd0003490
2012-02-15 05:30:24.675+0000: 14034: debug :
virNetServerClientCalculateHandleMode:167 : mode=3D3
2012-02-15 05:30:24.675+0000: 14034: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D24
events=3D3
2012-02-15 05:30:24.675+0000: 14034: debug :
virEventPollInterruptLocked:706 : Interrupting
2012-02-15 05:30:24.675+0000: 14034: debug :
virNetServerProgramFree:527 : prog=3D0x1db8300 refs=3D3
2012-02-15 05:30:24.675+0000: 14034: debug :
virNetServerClientFree:591 : RPC_SERVER_CLIENT_FREE: client=3D0x1e78fd0
refs=3D4
2012-02-15 05:30:24.675+0000: 14032: debug : virEventPollRunOnce:630 :
Poll got 1 event(s)
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchTimeouts:415 : Dispatch 7
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:460 : Dispatch 9
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D0 w=3D1
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=3D1
events=3D1
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D1 w=3D2
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D2 w=3D3
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D3 w=3D4
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D4 w=3D5
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D5 w=3D6
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D6 w=3D8
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D7 w=3D23
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D8 w=3D24
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventRunDefaultImpl:244 : running default event implementation
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D0 w=3D1, f=3D7 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D1 w=3D2, f=3D9 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D2 w=3D3, f=3D11 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D3 w=3D4, f=3D12 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D4 w=3D5, f=3D6 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D5 w=3D6, f=3D14 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D6 w=3D8, f=3D16 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D7 w=3D23, f=3D19 e=3D25 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D24, f=3D15 e=3D5 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 7 timers
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCalculateTimeout:331 : Got a timeout scheduled for
1329283829669
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCalculateTimeout:351 : Timeout at 1329283829669 due in
4994 ms
2012-02-15 05:30:24.675+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D9 imeout=3D4994
2012-02-15 05:30:24.675+0000: 14032: debug : virEventPollRunOnce:630 :
Poll got 1 event(s)
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchTimeouts:415 : Dispatch 7
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:460 : Dispatch 9
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D0 w=3D1
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D1 w=3D2
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D2 w=3D3
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D3 w=3D4
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D4 w=3D5
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D5 w=3D6
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D6 w=3D8
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D7 w=3D23
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D8 w=3D24
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=3D2=
4
events=3D2
2012-02-15 05:30:24.675+0000: 14032: debug : virNetMessageFree:75 :
msg=3D0x7fedd0003490 nfds=3D0 cb=3D(nil)
2012-02-15 05:30:24.675+0000: 14032: debug :
virNetServerClientCalculateHandleMode:137 : tls=3D(nil) hs=3D-1,
rx=3D0x7fedd0043e10 tx=3D(nil)
2012-02-15 05:30:24.675+0000: 14032: debug :
virNetServerClientCalculateHandleMode:167 : mode=3D1
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D24
events=3D1
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollInterruptLocked:702 : Skip interrupt, 1 -472389568
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventRunDefaultImpl:244 : running default event implementation
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D0 w=3D1, f=3D7 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D1 w=3D2, f=3D9 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D2 w=3D3, f=3D11 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D3 w=3D4, f=3D12 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D4 w=3D5, f=3D6 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D5 w=3D6, f=3D14 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D6 w=3D8, f=3D16 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D7 w=3D23, f=3D19 e=3D25 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D24, f=3D15 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 7 timers
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCalculateTimeout:331 : Got a timeout scheduled for
1329283829669
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCalculateTimeout:351 : Timeout at 1329283829669 due in
4994 ms
2012-02-15 05:30:24.675+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D9 imeout=3D4994
2012-02-15 05:30:24.675+0000: 14032: debug : virEventPollRunOnce:630 :
Poll got 1 event(s)
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchTimeouts:415 : Dispatch 7
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:460 : Dispatch 9
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D0 w=3D1
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D1 w=3D2
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D2 w=3D3
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D3 w=3D4
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D4 w=3D5
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D5 w=3D6
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D6 w=3D8
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D7 w=3D23
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D8 w=3D24
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=3D2=
4
events=3D1
2012-02-15 05:30:24.675+0000: 14032: debug :
virNetMessageDecodeLength:149 : Got length, now need 28 total (24
more)
2012-02-15 05:30:24.675+0000: 14032: debug :
virNetServerClientCalculateHandleMode:137 : tls=3D(nil) hs=3D-1,
rx=3D0x7fedd0043e10 tx=3D(nil)
2012-02-15 05:30:24.675+0000: 14032: debug :
virNetServerClientCalculateHandleMode:167 : mode=3D1
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D24
events=3D1
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollInterruptLocked:702 : Skip interrupt, 1 -472389568
2012-02-15 05:30:24.675+0000: 14032: debug :
virNetServerClientDispatchRead:886 : RPC_SERVER_CLIENT_MSG_RX:
client=3D0x1e78fd0 len=3D28 prog=3D536903814 vers=3D1 proc=3D2 type=3D0=
 status=3D0
serial=3D5
2012-02-15 05:30:24.675+0000: 14032: debug :
virKeepAliveCheckMessage:408 : ka=3D0x1ebf3e0, client=3D0x1e78fd0,
msg=3D0x7fedd0043e10
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollUpdateTimeout:259 : EVENT_POLL_UPDATE_TIMEOUT: timer=3D59
frequency=3D5000
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollInterruptLocked:702 : Skip interrupt, 1 -472389568
2012-02-15 05:30:24.675+0000: 14032: debug :
virNetServerDispatchNewMessage:199 : server=3D0x1dad7f0 client=3D0x1e78=
fd0
message=3D0x7fedd0043e10
2012-02-15 05:30:24.675+0000: 14032: debug : virNetServerProgramRef:87
: prog=3D0x1db8300 refs=3D3
2012-02-15 05:30:24.675+0000: 14036: debug : virNetServerHandleJob:138
: server=3D0x1dad7f0 client=3D0x1e78fd0 message=3D0x7fedd0043e10
prog=3D0x1db8300
2012-02-15 05:30:24.675+0000: 14036: debug :
virNetServerProgramDispatch:269 : prog=3D536903814 ver=3D1 type=3D0 sta=
tus=3D0
serial=3D5 proc=3D2
2012-02-15 05:30:24.675+0000: 14032: debug : virNetMessageNew:48 :
msg=3D0x7fedd0003490 tracked=3D1
2012-02-15 05:30:24.675+0000: 14032: debug :
virNetServerClientCalculateHandleMode:137 : tls=3D(nil) hs=3D-1,
rx=3D0x7fedd0003490 tx=3D(nil)
2012-02-15 05:30:24.675+0000: 14032: debug :
virNetServerClientCalculateHandleMode:167 : mode=3D1
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D24
events=3D1
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollInterruptLocked:702 : Skip interrupt, 1 -472389568
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventRunDefaultImpl:244 : running default event implementation
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D0 w=3D1, f=3D7 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D1 w=3D2, f=3D9 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D2 w=3D3, f=3D11 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D3 w=3D4, f=3D12 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D4 w=3D5, f=3D6 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D5 w=3D6, f=3D14 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D6 w=3D8, f=3D16 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D7 w=3D23, f=3D19 e=3D25 d=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D24, f=3D15 e=3D1 d=3D0
2012-02-15 05:30:24.675+0000: 14036: debug :
remoteDispatchCloseHelper:124 : server=3D0x1dad7f0 client=3D0x1e78fd0
msg=3D0x7fedd0043e10 rerr=3D0x7fedddb1dc70 args=3D0x1ebe3c0 ret=3D0x1e6=
f210
2012-02-15 05:30:24.675+0000: 14036: debug :
virNetMessageEncodePayload:351 : Encode length as 28
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 7 timers
2012-02-15 05:30:24.675+0000: 14036: debug :
virNetServerClientSendMessage:1106 : msg=3D0x7fedd0043e10 proc=3D2 len=3D=
28
offset=3D0
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCalculateTimeout:331 : Got a timeout scheduled for
1329283829675
2012-02-15 05:30:24.675+0000: 14036: debug :
virNetServerClientSendMessage:1116 : RPC_SERVER_CLIENT_MSG_TX_QUEUE:
client=3D0x1e78fd0 len=3D28 prog=3D536903814 vers=3D1 proc=3D2 type=3D1=
 status=3D0
serial=3D5
2012-02-15 05:30:24.675+0000: 14036: debug :
virNetServerClientCalculateHandleMode:137 : tls=3D(nil) hs=3D-1,
rx=3D0x7fedd0003490 tx=3D0x7fedd0043e10
2012-02-15 05:30:24.675+0000: 14036: debug :
virNetServerClientCalculateHandleMode:167 : mode=3D3
2012-02-15 05:30:24.675+0000: 14036: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D24
events=3D3
2012-02-15 05:30:24.675+0000: 14032: debug :
virEventPollCalculateTimeout:351 : Timeout at 1329283829675 due in
5000 ms
2012-02-15 05:30:24.676+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D9 imeout=3D5000
2012-02-15 05:30:24.676+0000: 14036: debug :
virEventPollInterruptLocked:706 : Interrupting
2012-02-15 05:30:24.676+0000: 14036: debug :
virNetServerProgramFree:527 : prog=3D0x1db8300 refs=3D3
2012-02-15 05:30:24.676+0000: 14036: debug :
virNetServerClientFree:591 : RPC_SERVER_CLIENT_FREE: client=3D0x1e78fd0
refs=3D4
2012-02-15 05:30:24.676+0000: 14032: debug : virEventPollRunOnce:630 :
Poll got 1 event(s)
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchTimeouts:415 : Dispatch 7
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:460 : Dispatch 9
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D0 w=3D1
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=3D1
events=3D1
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D1 w=3D2
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D2 w=3D3
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D3 w=3D4
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D4 w=3D5
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D5 w=3D6
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D6 w=3D8
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D7 w=3D23
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D8 w=3D24
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventRunDefaultImpl:244 : running default event implementation
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D0 w=3D1, f=3D7 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D1 w=3D2, f=3D9 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D2 w=3D3, f=3D11 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D3 w=3D4, f=3D12 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D4 w=3D5, f=3D6 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D5 w=3D6, f=3D14 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D6 w=3D8, f=3D16 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D7 w=3D23, f=3D19 e=3D25 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D8 w=3D24, f=3D15 e=3D5 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 7 timers
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCalculateTimeout:331 : Got a timeout scheduled for
1329283829675
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCalculateTimeout:351 : Timeout at 1329283829675 due in
4999 ms
2012-02-15 05:30:24.676+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D9 imeout=3D4999
2012-02-15 05:30:24.676+0000: 14032: debug : virEventPollRunOnce:630 :
Poll got 1 event(s)
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchTimeouts:415 : Dispatch 7
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:460 : Dispatch 9
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D0 w=3D1
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D1 w=3D2
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D2 w=3D3
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D3 w=3D4
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D4 w=3D5
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D5 w=3D6
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D6 w=3D8
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D7 w=3D23
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:474 : i=3D8 w=3D24
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollDispatchHandles:488 : EVENT_POLL_DISPATCH_HANDLE: watch=3D2=
4
events=3D2
2012-02-15 05:30:24.676+0000: 14032: debug : virNetMessageFree:75 :
msg=3D0x7fedd0043e10 nfds=3D0 cb=3D(nil)
2012-02-15 05:30:24.676+0000: 14032: debug :
virNetServerClientCalculateHandleMode:137 : tls=3D(nil) hs=3D-1,
rx=3D0x7fedd0003490 tx=3D(nil)
2012-02-15 05:30:24.676+0000: 14032: debug :
virNetServerClientCalculateHandleMode:167 : mode=3D1
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollUpdateHandle:151 : EVENT_POLL_UPDATE_HANDLE: watch=3D24
events=3D1
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollInterruptLocked:702 : Skip interrupt, 1 -472389568
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.676+0000: 14032: debug :
virNetServerClientClose:632 : client=3D0x1e78fd0 refs=3D3
2012-02-15 05:30:24.676+0000: 14032: debug : virKeepAliveStop:382 :
RPC_KEEPALIVE_STOP: ka=3D0x1ebf3e0 client=3D0x1e78fd0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollRemoveTimeout:293 : EVENT_POLL_REMOVE_TIMEOUT: timer=3D59
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollInterruptLocked:702 : Skip interrupt, 0 -472389568
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollRemoveTimeout:293 : EVENT_POLL_REMOVE_TIMEOUT: timer=3D58
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollInterruptLocked:702 : Skip interrupt, 0 -472389568
2012-02-15 05:30:24.676+0000: 14032: debug : virKeepAliveFree:304 :
RPC_KEEPALIVE_FREE: ka=3D0x1ebf3e0 client=3D0x1e78fd0 refs=3D3
2012-02-15 05:30:24.676+0000: 14032: debug :
daemonRemoveAllClientStreams:493 : stream=3D(nil)
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollRemoveHandle:180 : EVENT_POLL_REMOVE_HANDLE: watch=3D24
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollRemoveHandle:193 : mark delete 8 15
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollInterruptLocked:702 : Skip interrupt, 0 -472389568
2012-02-15 05:30:24.676+0000: 14032: debug : virNetMessageFree:75 :
msg=3D0x7fedd0003490 nfds=3D0 cb=3D(nil)
2012-02-15 05:30:24.676+0000: 14032: debug : virNetSocketFree:722 :
RPC_SOCKET_FREE: sock=3D0x1e6e3f0 refs=3D2
2012-02-15 05:30:24.676+0000: 14032: debug :
virNetServerClientFree:591 : RPC_SERVER_CLIENT_FREE: client=3D0x1e78fd0
refs=3D3
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventRunDefaultImpl:244 : running default event implementation
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCleanupTimeouts:506 : Cleanup 7
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCleanupTimeouts:519 : EVENT_POLL_PURGE_TIMEOUT: timer=3D58
2012-02-15 05:30:24.676+0000: 14032: debug : virKeepAliveFree:304 :
RPC_KEEPALIVE_FREE: ka=3D0x1ebf3e0 client=3D0x1e78fd0 refs=3D2
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCleanupTimeouts:519 : EVENT_POLL_PURGE_TIMEOUT: timer=3D59
2012-02-15 05:30:24.676+0000: 14032: debug : virKeepAliveFree:304 :
RPC_KEEPALIVE_FREE: ka=3D0x1ebf3e0 client=3D0x1e78fd0 refs=3D1
2012-02-15 05:30:24.676+0000: 14032: debug :
virNetServerClientFree:591 : RPC_SERVER_CLIENT_FREE: client=3D0x1e78fd0
refs=3D2
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCleanupHandles:554 : Cleanup 9
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCleanupHandles:567 : EVENT_POLL_PURGE_HANDLE: watch=3D24
2012-02-15 05:30:24.676+0000: 14032: debug :
virNetServerClientFree:591 : RPC_SERVER_CLIENT_FREE: client=3D0x1e78fd0
refs=3D1
2012-02-15 05:30:24.676+0000: 14032: debug : virConnectClose:1462 :
conn=3D0x7fedd0043570
2012-02-15 05:30:24.676+0000: 14032: debug : virUnrefConnect:145 :
unref connection 0x7fedd0043570 1
2012-02-15 05:30:24.676+0000: 14032: debug : virReleaseConnect:94 :
release connection 0x7fedd0043570
2012-02-15 05:30:24.676+0000: 14032: debug :
qemuProcessAutoDestroyRun:3823 : conn=3D0x7fedd0043570
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollRemoveTimeout:293 : EVENT_POLL_REMOVE_TIMEOUT: timer=3D57
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollInterruptLocked:702 : Skip interrupt, 1 -472389568
2012-02-15 05:30:24.676+0000: 14032: debug : virNetSocketFree:722 :
RPC_SOCKET_FREE: sock=3D0x1e6e3f0 refs=3D1
2012-02-15 05:30:24.676+0000: 14032: debug : virNetSocketFree:730 :
sock=3D0x1e6e3f0 fd=3D15
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollRemoveHandle:180 : EVENT_POLL_REMOVE_HANDLE: watch=3D24
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D0 w=3D1, f=3D7 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D1 w=3D2, f=3D9 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D2 w=3D3, f=3D11 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D3 w=3D4, f=3D12 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D4 w=3D5, f=3D6 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D5 w=3D6, f=3D14 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D6 w=3D8, f=3D16 e=3D1 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollMakePollFDs:383 : Prepare n=3D7 w=3D23, f=3D19 e=3D25 d=3D0
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 5 timers
2012-02-15 05:30:24.676+0000: 14032: debug :
virEventPollCalculateTimeout:351 : Timeout at 0 due in -1 ms
2012-02-15 05:30:24.676+0000: 14032: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=3D8 imeout=3D-1


Waiting for reply,

Tomoya.

2012/2/9 Josh Durgin <josh.durgin@dreamhost.com>:
> On 02/08/2012 03:42 PM, Masuko Tomoya wrote:
>>
>> Hi Christian,
>>
>> Thank you for reply !
>>
>> Could I ask a version of libvirt which is your patch applied ?
>>
>> I'm trying it with libvirt0.9.8-2ubuntu9, but there is same error.
>> (I'm using blow package:
>> https://launchpad.net/ubuntu/precise/+source/libvirt/0.9.8-2ubuntu9)
>>
>> root@compute04:~# dpkg -l | grep libvirt-bin
>> ii =A0libvirt-bin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00.9.8-2ubuntu9
>> =A0 =A0 =A0 =A0 =A0 =A0 programs for the libvirt library
>>
>> /var/log/libvirtd/libvirt.log
>> 2012-02-08 23:33:53.800+0000: 4663: error :
>> qemuMonitorTextAddDrive:2828 : operation failed: open disk image fil=
e
>> failed
>> 2012-02-08 23:33:53.800+0000: 4663: error :
>> virSecurityDACRestoreSecurityFileLabel:143 : cannot resolve symlink
>> rbd/testvolume: No such file or directory
>> 2012-02-08 23:33:54.212+0000: 4663: warning :
>> qemuDomainAttachPciDiskDevice:287 : Unable to restore security label
>> on rbd/testvolume
>
>
> libvirt 0.9.9 fixes this (the applied patch is
> http://www.redhat.com/archives/libvir-list/2011-December/msg00506.htm=
l if
> you're curious).
>
>
>>
>> 2012/2/6 Christian Brunner<christian@brunner-muc.de>:
>>>
>>> Libvirt is trying to set security lables even for network shares. T=
his
>>> will not work. I think this is fixed in newer libvirt versions. For
>>> older versions you can try this patch:
>>>
>>> http://www.redhat.com/archives/libvir-list/2011-May/msg01446.html
>>>
>>> Regards,
>>> Christian
>>>
>>> 2012/2/4 Masuko Tomoya<tomoya.masuko@gmail.com>:
>>>>
>>>> Hi, all.
>>>>
>>>> I'm trying to attach rbd volume from instance on KVM.
>>>> But I have problem.
>>>> Could you help me ?
>>>>
>>>> ---
>>>> I tried to attach rbd volume on ceph01 to instance on compute1 wit=
h
>>>> virsh command.
>>>>
>>>> root@compute1:~# virsh attach-device test-ub16 /root/testvolume.xm=
l
>>>> error: Failed to attach device from /root/testvolume.xml
>>>> error: cannot resolve symlink rbd/testvolume: No such file or dire=
ctory
>>>>
>>>> /var/log/messages
>>>> Feb =A03 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: error :
>>>> qemuMonitorTextAddDevice:2417 : operation failed: adding
>>>>
>>>> virtio-blk-pci,bus=3Dpci.0,addr=3D0x9,drive=3Ddrive-virtio-disk4,i=
d=3Dvirtio-disk4
>>>> device failed: Device needs media, but drive is empty#015#012Devic=
e
>>>> 'virtio-blk-pci' could not be initialized#015#012
>>>> Feb =A03 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: warning :
>>>> qemuDomainAttachPciDiskDevice:188 : qemuMonitorAddDevice failed on
>>>> file=3Drbd:rbd/testvolume,if=3Dnone,id=3Ddrive-virtio-disk4,format=
=3Draw
>>>>
>>>> (virtio-blk-pci,bus=3Dpci.0,addr=3D0x9,drive=3Ddrive-virtio-disk4,=
id=3Dvirtio-disk4)
>>>> Feb =A03 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: error :
>>>> virSecurityDACRestoreSecurityFileLabel:143 : cannot resolve symlin=
k
>>>> rbd/testvolume: No such file or directory
>>>> Feb =A03 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: warning :
>>>> qemuDomainAttachPciDiskDevice:229 : Unable to restore security lab=
el
>>>> on rbd/testvolume
>>>>
>>>> there is no log in /var/log/ceph/mon.0.log of host ceph01.
>>>> ---
>>>>
>>>>
>>>> My environment is below.
>>>> *There are two servers. All server are ubuntu 10.10 x86_64.
>>>> *ceph01: single server configured ceph.(version: 0.41-1maverick)
>>>> *compute1: kvm hypervisor
>>>> =A0-librados2 and librbd1 packages are installed.
>>>> =A0(version: 0.41-1maverick)
>>>> =A0-qemu-kvm is 0.14.0-rc1. I built qemu with rbd enable.
>>>> =A0the output of run 'qemu-img' show 'rbd' at supported formats fi=
eld.
>>>> =A0(I built qemu reffering this page.
>>>> =A0http://ceph.newdream.net/wiki/QEMU-RBD)
>>>> =A0-apparmor is disable.
>>>> =A0-libvirt is 0.8.8
>>>>
>>>> =3D=3D=3D=3D
>>>> =A0-there is ceph.conf on compute1.
>>>> root@compute1:~# ls -l /etc/ceph/
>>>> total 20
>>>> -rw-r--r-- 1 root root 508 2012-02-03 14:38 ceph.conf
>>>> -rw------- 1 root root =A063 2012-02-03 17:04 keyring.admin
>>>> -rw------- 1 root root =A063 2012-02-03 14:38 keyring.bin
>>>> -rw------- 1 root root =A056 2012-02-03 14:38 keyring.mds.0
>>>> -rw------- 1 root root =A056 2012-02-03 14:38 keyring.osd.0
>>>>
>>>> =3D=3D=3D=3D=3D
>>>> =A0-contents of ceph.conf is below.
>>>> root@compute1:~# cat /etc/ceph/ceph.conf
>>>> [global]
>>>> =A0 =A0 =A0 auth supported =3D cephx
>>>> =A0 =A0 =A0 keyring =3D /etc/ceph/keyring.bin
>>>> [mon]
>>>> =A0 =A0 =A0 mon data =3D /data/data/mon$id
>>>> =A0 =A0 =A0 debug ms =3D 1
>>>> [mon.0]
>>>> =A0 =A0 =A0 host =3D ceph01
>>>> =A0 =A0 =A0 mon addr =3D 10.68.119.191:6789
>>>> [mds]
>>>> =A0 =A0 =A0 keyring =3D /etc/ceph/keyring.$name
>>>> [mds.0]
>>>> =A0 =A0 =A0 host =3D ceph01
>>>> [osd]
>>>> =A0 =A0 =A0 keyring =3D /etc/ceph/keyring.$name
>>>> =A0 =A0 =A0 osd data =3D /data/osd$id
>>>> =A0 =A0 =A0 osd journal =3D /data/osd$id/journal
>>>> =A0 =A0 =A0 osd journal size =3D 512
>>>> =A0 =A0 =A0 osd class tmp =3D /var/lib/ceph/tmp
>>>> =A0 =A0 =A0 debug osd =3D 20
>>>> =A0 =A0 =A0 debug ms =3D 1
>>>> =A0 =A0 =A0 debug filestore =3D 20
>>>> [osd.0]
>>>> =A0 =A0 =A0 host =3D ceph01
>>>> =A0 =A0 =A0 btrfs devs =3D /dev/sdb1
>>>>
>>>> =3D=3D=3D
>>>> *conten of keyring.admin is below
>>>> root@compute1:~# cat /etc/ceph/keyring.admin
>>>> [client.admin]
>>>> =A0 =A0 =A0 key =3D AQDFeCxPyBlNIRAAxS1DcRHpMXRpcjY/GNMwYg=3D=3D
>>>>
>>>>
>>>> =3D=3D=3D
>>>> *output of run 'ceph auth list'
>>>> root@ceph01:/etc/ceph# ceph auth list
>>>> 2012-02-03 20:34:59.507451 mon<- [auth,list]
>>>> 2012-02-03 20:34:59.508785 mon.0 -> =A0'installed auth entries:
>>>> mon.
>>>> =A0 =A0 =A0 key: AQDFeCxPiK04IxAAslDBNkrOGKWxcbCh2iysqg=3D=3D
>>>> mds.0
>>>> =A0 =A0 =A0 key: AQDFeCxPsJ+LGhAAJ3/rmkAtGXSv/eHh0yXgww=3D=3D
>>>> =A0 =A0 =A0 caps: [mds] allow
>>>> =A0 =A0 =A0 caps: [mon] allow rwx
>>>> =A0 =A0 =A0 caps: [osd] allow *
>>>> osd.0
>>>> =A0 =A0 =A0 key: AQDFeCxPoEK+ExAAecD7+tWgpIRoZx2AT7Jwbg=3D=3D
>>>> =A0 =A0 =A0 caps: [mon] allow rwx
>>>> =A0 =A0 =A0 caps: [osd] allow *
>>>> client.admin
>>>> =A0 =A0 =A0 key: AQDFeCxPyBlNIRAAxS1DcRHpMXRpcjY/GNMwYg=3D=3D
>>>> =A0 =A0 =A0 caps: [mds] allow
>>>> =A0 =A0 =A0 caps: [mon] allow *
>>>> =A0 =A0 =A0 caps: [osd] allow *
>>>> ' (0)
>>>>
>>>> =3D=3D=3D=3D
>>>> *xml file is below.
>>>> root@compute1:~# cat /root/testvolume.xml
>>>> <disk type=3D'network' device=3D'disk'>
>>>> =A0<driver name=3D'qemu' type=3D'raw'/>
>>>> =A0<source protocol=3D'rbd' name=3D'rbd/testvolume'>
>>>> =A0 <host name=3D'10.68.119.191' port=3D'6789'/>
>>>> =A0</source>
>>>> =A0<target dev=3D'vde' bus=3D'virtio'/>
>>>> </disk>
>>>>
>>>> =3D=3D=3D=3D
>>>> *testvolume is on rados pools.
>>>> root@compute1:~# qemu-img info rbd:rbd/testvolume
>>>> image: rbd:rbd/testvolume
>>>> file format: raw
>>>> virtual size: 1.0G (1073741824 bytes)
>>>> disk size: unavailable
>>>>
>>>>
>>>> Waiting for reply,
>>>>
>>>> Tomoya.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
