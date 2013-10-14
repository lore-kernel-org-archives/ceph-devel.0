From: "alan.zhang" <alan.zhang@linuxwind.org>
Subject: qemu-kvm with rbd mem slow leak
Date: Mon, 14 Oct 2013 02:42:23 +0000
Message-ID: <0c551c01392760f2ebfb0d98baebe07b@linuxwind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from li497-87.members.linode.com ([106.187.102.87]:44995 "EHLO
	www.linuxwind.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705Ab3JNCul (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Oct 2013 22:50:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by www.linuxwind.org (Postfix) with ESMTP id 9713C12DF6
	for <ceph-devel@vger.kernel.org>; Mon, 14 Oct 2013 02:42:25 +0000 (UTC)
Received: from www.linuxwind.org ([127.0.0.1])
	by localhost (www.linuxwind.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fOTCxrmxMyP7 for <ceph-devel@vger.kernel.org>;
	Mon, 14 Oct 2013 02:42:24 +0000 (UTC)
Received: from mail.linuxwind.org (localhost [127.0.0.1])
	by www.linuxwind.org (Postfix) with ESMTPA id 369B612D77
	for <ceph-devel@vger.kernel.org>; Mon, 14 Oct 2013 02:42:23 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

CPU: Intel(R) Xeon(R) CPU           E5620  @ 2.40GHz *2
MEM: 32GB
KVM: qemu-kvm-0.12.1.2-2.355.el6.2.cuttlefish.async.x86_64
Host: CentOS 6.4, kernel 2.6.32-358.14.1.el6.x86_64
Guest: CentOS 6.4, kernel 2.6.32-279.14.1.el6.x86_64
Ceph: ceph version 0.67.4 (ad85b8bfafea6232d64cb7ba76a8b6e8252fa0c7)
Opennebula: 4.2


top -M info:
top - 10:35:31 up 7 days,  9:19,  1 user,  load average: 0.85, 1.63, 
1.40
Tasks: 454 total,   2 running, 452 sleeping,   0 stopped,   0 zombie
Cpu(s):  8.5%us,  6.6%sy,  0.0%ni, 84.2%id,  0.6%wa,  0.0%hi,  0.0%si,  
0.0%st
Mem:  32865800k total, 32191072k used,   674728k free,    59984k 
buffers
Swap: 10485752k total, 10134076k used,   351676k free,  3474176k cached

   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
20135 oneadmin  20   0 6381m 3.4g 9120 S  2.3 10.8 104:00.48 qemu-kvm
29171 oneadmin  20   0 6452m 3.2g 9072 S  2.0 10.2 168:02.06 qemu-kvm
  8857 oneadmin  20   0 6338m 2.9g 4504 S  2.3  9.3 289:14.48 qemu-kvm
12283 oneadmin  20   0 6591m 2.9g 4464 S  1.3  9.2 268:57.30 qemu-kvm
  6612 oneadmin  20   0 5050m 2.0g 4472 S 12.9  6.3 191:23.51 qemu-kvm
12006 oneadmin  20   0 5532m 1.9g 4468 S  4.3  6.1 236:43.50 qemu-kvm
  7216 oneadmin  20   0 3600m 1.9g 4680 S  1.3  6.1 159:40.53 qemu-kvm
10602 oneadmin  20   0 5333m 1.6g 4636 S  1.3  5.1 208:54.52 qemu-kvm
13162 oneadmin  20   0 3400m 989m 4528 S 50.3  3.1   4151:19 qemu-kvm
  5273 oneadmin  20   0 5168m 842m 4464 S  5.3  2.6 468:20.65 qemu-kvm
  6287 oneadmin  20   0 3150m 761m 4472 S 37.4  2.4 150:32.89 qemu-kvm
  6081 root      20   0 1732m 504m 5744 S  6.3  1.6 243:17.00 ceph-osd
11729 oneadmin  20   0 3541m 498m 4468 S  0.7  1.6  66:48.52 qemu-kvm
12503 oneadmin  20   0 3832m 428m 9336 S  0.3  1.3  19:58.78 qemu-kvm


such as 20135 process command line:
ps -ef | grep 20135
oneadmin 20135     1  2 Oct11 ?        01:44:01 /usr/libexec/qemu-kvm 
-name one-18 -S -M rhel6.4.0 -enable-kvm -m 2048 -smp 
2,sockets=2,cores=1,threads=1 -uuid c40fe8a4-f4fa-9e02-cf2d-6eaaf5062440 
-nodefconfig -nodefaults -chardev 
socket,id=charmonitor,path=/var/lib/libvirt/qemu/one-18.monitor,server,nowait 
-mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc 
-no-shutdown -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 -drive 
file=rbd:one/one-0-18-0:auth_supported=none,if=none,id=drive-virtio-disk0,format=raw,cache=none 
-device 
virtio-blk-pci,scsi=off,bus=pci.0,addr=0x4,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 
-drive 
file=rbd:one/one-2:auth_supported=none,if=none,id=drive-virtio-disk1,format=raw,cache=none 
-device 
virtio-blk-pci,scsi=off,bus=pci.0,addr=0x5,drive=drive-virtio-disk1,id=virtio-disk1 
-drive 
file=/var/lib/one/datastores/0/18/disk.1,if=none,media=cdrom,id=drive-ide0-0-0,readonly=on,format=raw 
-device ide-drive,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0 
-netdev tap,fd=22,id=hostnet0,vhost=on,vhostfd=27 -device 
virtio-net-pci,netdev=hostnet0,id=net0,mac=02:00:c0:a8:0a:3b,bus=pci.0,addr=0x3 
-chardev pty,id=charserial0 -device 
isa-serial,chardev=charserial0,id=serial0 -vnc 0.0.0.0:18 -vga cirrus 
-device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x6

I have only give it 2GB,but as you see, VIRT/RES (6381m/3.4g).

I think it must be mem leak.

could any one give me a hand?

-- 
Talk is cheap,lead by example.
Blog: https://www.linuxwind.org
