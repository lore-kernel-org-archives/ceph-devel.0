From: Stefan Priebe <s.priebe@profihost.ag>
Subject: osd crash after reboot
Date: Fri, 14 Dec 2012 09:12:08 +0100
Message-ID: <50CADF58.4010902@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35899 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab2LNIMI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 03:12:08 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

after a reboot of my node i see this on all OSDs of this node after the 
reboot:

2012-12-14 09:03:20.393224 7f8e652f8780 -1 osd/OSD.cc: In function 
'OSDMapRef OSDService::get_map(epoch_t)' thread 7f8e652f8780 time 
2012-12-14 09:03:20.392528
osd/OSD.cc: 4385: FAILED assert(_get_map_bl(epoch, bl))

  ceph version 0.55-239-gc951c27 (c951c270a42b94b6f269992c9001d90f70a2b824)
  1: (OSDService::get_map(unsigned int)+0x918) [0x607f78]
  2: (OSD::load_pgs()+0x13ed) [0x6168ad]
  3: (OSD::init()+0xaff) [0x617a5f]
  4: (main()+0x2de6) [0x55a416]
  5: (__libc_start_main()+0xfd) [0x7f8e63093c8d]
  6: /usr/bin/ceph-osd() [0x557269]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- begin dump of recent events ---
    -29> 2012-12-14 09:03:20.266349 7f8e652f8780  5 asok(0x285c000) 
register_command perfcounters_dump hook 0x2850010
    -28> 2012-12-14 09:03:20.266366 7f8e652f8780  5 asok(0x285c000) 
register_command 1 hook 0x2850010
    -27> 2012-12-14 09:03:20.266369 7f8e652f8780  5 asok(0x285c000) 
register_command perf dump hook 0x2850010
    -26> 2012-12-14 09:03:20.266379 7f8e652f8780  5 asok(0x285c000) 
register_command perfcounters_schema hook 0x2850010
    -25> 2012-12-14 09:03:20.266383 7f8e652f8780  5 asok(0x285c000) 
register_command 2 hook 0x2850010
    -24> 2012-12-14 09:03:20.266386 7f8e652f8780  5 asok(0x285c000) 
register_command perf schema hook 0x2850010
    -23> 2012-12-14 09:03:20.266389 7f8e652f8780  5 asok(0x285c000) 
register_command config show hook 0x2850010
    -22> 2012-12-14 09:03:20.266392 7f8e652f8780  5 asok(0x285c000) 
register_command config set hook 0x2850010
    -21> 2012-12-14 09:03:20.266396 7f8e652f8780  5 asok(0x285c000) 
register_command log flush hook 0x2850010
    -20> 2012-12-14 09:03:20.266398 7f8e652f8780  5 asok(0x285c000) 
register_command log dump hook 0x2850010
    -19> 2012-12-14 09:03:20.266401 7f8e652f8780  5 asok(0x285c000) 
register_command log reopen hook 0x2850010
    -18> 2012-12-14 09:03:20.267686 7f8e652f8780  0 ceph version 
0.55-239-gc951c27 (c951c270a42b94b6f269992c9001d90f70a2b824), process 
ceph-osd, pid 7212
    -17> 2012-12-14 09:03:20.268738 7f8e652f8780  1 finished 
global_init_daemonize
    -16> 2012-12-14 09:03:20.275957 7f8e652f8780  0 
filestore(/ceph/osd.1/) mount FIEMAP ioctl is supported and appears to work
    -15> 2012-12-14 09:03:20.275968 7f8e652f8780  0 
filestore(/ceph/osd.1/) mount FIEMAP ioctl is disabled via 'filestore 
fiemap' config option
    -14> 2012-12-14 09:03:20.276177 7f8e652f8780  0 
filestore(/ceph/osd.1/) mount did NOT detect btrfs
    -13> 2012-12-14 09:03:20.277051 7f8e652f8780  0 
filestore(/ceph/osd.1/) mount syscall(__NR_syncfs, fd) fully supported
    -12> 2012-12-14 09:03:20.277585 7f8e652f8780  0 
filestore(/ceph/osd.1/) mount found snaps <>
    -11> 2012-12-14 09:03:20.278899 7f8e652f8780  0 
filestore(/ceph/osd.1/) mount: enabling WRITEAHEAD journal mode: btrfs 
not detected
    -10> 2012-12-14 09:03:20.290745 7f8e652f8780  0 journal  kernel 
version is 3.6.10
     -9> 2012-12-14 09:03:20.320728 7f8e652f8780  0 journal  kernel 
version is 3.6.10
     -8> 2012-12-14 09:03:20.328381 7f8e652f8780  0 
filestore(/ceph/osd.1/) mount FIEMAP ioctl is supported and appears to work
     -7> 2012-12-14 09:03:20.328391 7f8e652f8780  0 
filestore(/ceph/osd.1/) mount FIEMAP ioctl is disabled via 'filestore 
fiemap' config option
     -6> 2012-12-14 09:03:20.328574 7f8e652f8780  0 
filestore(/ceph/osd.1/) mount did NOT detect btrfs
     -5> 2012-12-14 09:03:20.329579 7f8e652f8780  0 
filestore(/ceph/osd.1/) mount syscall(__NR_syncfs, fd) fully supported
     -4> 2012-12-14 09:03:20.329612 7f8e652f8780  0 
filestore(/ceph/osd.1/) mount found snaps <>
     -3> 2012-12-14 09:03:20.330786 7f8e652f8780  0 
filestore(/ceph/osd.1/) mount: enabling WRITEAHEAD journal mode: btrfs 
not detected
     -2> 2012-12-14 09:03:20.340711 7f8e652f8780  0 journal  kernel 
version is 3.6.10
     -1> 2012-12-14 09:03:20.370707 7f8e652f8780  0 journal  kernel 
version is 3.6.10
      0> 2012-12-14 09:03:20.393224 7f8e652f8780 -1 osd/OSD.cc: In 
function 'OSDMapRef OSDService::get_map(epoch_t)' thread 7f8e652f8780 
time 2012-12-14 09:03:20.392528
osd/OSD.cc: 4385: FAILED assert(_get_map_bl(epoch, bl))

  ceph version 0.55-239-gc951c27 (c951c270a42b94b6f269992c9001d90f70a2b824)
  1: (OSDService::get_map(unsigned int)+0x918) [0x607f78]
  2: (OSD::load_pgs()+0x13ed) [0x6168ad]
  3: (OSD::init()+0xaff) [0x617a5f]
  4: (main()+0x2de6) [0x55a416]
  5: (__libc_start_main()+0xfd) [0x7f8e63093c8d]
  6: /usr/bin/ceph-osd() [0x557269]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

Stefan
