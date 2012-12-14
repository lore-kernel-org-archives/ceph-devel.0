From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: osd crash after reboot
Date: Fri, 14 Dec 2012 09:22:02 +0100
Message-ID: <50CAE1AA.80801@profihost.ag>
References: <50CADF58.4010902@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:52940 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab2LNIWE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 03:22:04 -0500
In-Reply-To: <50CADF58.4010902@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

same log more verbose:
11 ec=10 les/c 3307/3307 3306/3306/3306) [] r=0 lpr=0 lcod 0'0 mlcod 0'0 
inactive] read_log done
    -11> 2012-12-14 09:17:50.648572 7fb6e0d6b780 10 osd.3 pg_epoch: 3996 
pg[3.44b( v 3988'3969 (1379'2968,3988'3969] local-les=3307 n=11 ec=10 
les/c 3307/3307 3306/3306/3306) [3,12] r=0 lpr=0 lcod 0'0 mlcod 0'0 
inactive] handle_loaded
    -10> 2012-12-14 09:17:50.648581 7fb6e0d6b780 20 osd.3 pg_epoch: 3996 
pg[3.44b( v 3988'3969 (1379'2968,3988'3969] local-les=3307 n=11 ec=10 
les/c 3307/3307 3306/3306/3306) [3,12] r=0 lpr=0 lcod 0'0 mlcod 0'0 
inactive] exit Initial 0.015080 0 0.000000
     -9> 2012-12-14 09:17:50.648591 7fb6e0d6b780 20 osd.3 pg_epoch: 3996 
pg[3.44b( v 3988'3969 (1379'2968,3988'3969] local-les=3307 n=11 ec=10 
les/c 3307/3307 3306/3306/3306) [3,12] r=0 lpr=0 lcod 0'0 mlcod 0'0 
inactive] enter Reset
     -8> 2012-12-14 09:17:50.648599 7fb6e0d6b780 20 osd.3 pg_epoch: 3996 
pg[3.44b( v 3988'3969 (1379'2968,3988'3969] local-les=3307 n=11 ec=10 
les/c 3307/3307 3306/3306/3306) [3,12] r=0 lpr=0 lcod 0'0 mlcod 0'0 
inactive] set_last_peering_reset 3996
     -7> 2012-12-14 09:17:50.648609 7fb6e0d6b780 10 osd.3 4233 load_pgs 
loaded pg[3.44b( v 3988'3969 (1379'2968,3988'3969] local-les=3307 n=11 
ec=10 les/c 3307/3307 3306/3306/3306) [3,12] r=0 lpr=3996 lcod 0'0 mlcod 
0'0 inactive] log(1379'2968,3988'3969]
     -6> 2012-12-14 09:17:50.648649 7fb6e0d6b780 15 
filestore(/ceph/osd.3/) collection_getattr /ceph/osd.3//current/0.1_head 
'info'
     -5> 2012-12-14 09:17:50.648664 7fb6e0d6b780 10 
filestore(/ceph/osd.3/) collection_getattr /ceph/osd.3//current/0.1_head 
'info' = 5
     -4> 2012-12-14 09:17:50.648672 7fb6e0d6b780 20 osd.3 0 get_map 3316 
- loading and decoding 0x2943e00
     -3> 2012-12-14 09:17:50.648678 7fb6e0d6b780 15 
filestore(/ceph/osd.3/) read meta/a09ec88/osdmap.3316/0//-1 0~0
     -2> 2012-12-14 09:17:50.648705 7fb6e0d6b780 10 
filestore(/ceph/osd.3/) error opening file 
/ceph/osd.3//current/meta/DIR_8/DIR_8/osdmap.3316__0_0A09EC88__none with 
flags=0 and mode=0: (2) No such file or directory
     -1> 2012-12-14 09:17:50.648722 7fb6e0d6b780 10 
filestore(/ceph/osd.3/) FileStore::read(meta/a09ec88/osdmap.3316/0//-1) 
open error: (2) No such file or directory
      0> 2012-12-14 09:17:50.649586 7fb6e0d6b780 -1 osd/OSD.cc: In 
function 'OSDMapRef OSDService::get_map(epoch_t)' thread 7fb6e0d6b780 
time 2012-12-14 09:17:50.648733
osd/OSD.cc: 4385: FAILED assert(_get_map_bl(epoch, bl))

  ceph version 0.55-239-gc951c27 (c951c270a42b94b6f269992c9001d90f70a2b824)
  1: (OSDService::get_map(unsigned int)+0x918) [0x607f78]
  2: (OSD::load_pgs()+0x13ed) [0x6168ad]
  3: (OSD::init()+0xaff) [0x617a5f]
  4: (main()+0x2de6) [0x55a416]
  5: (__libc_start_main()+0xfd) [0x7fb6deb06c8d]
  6: /usr/bin/ceph-osd() [0x557269]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- logging levels ---
    0/ 5 none
    0/ 0 lockdep
    0/ 0 context
    0/ 0 crush
    1/ 5 mds
    1/ 5 mds_balancer
    1/ 5 mds_locker
    1/ 5 mds_log
    1/ 5 mds_log_expire
    1/ 5 mds_migrator
    0/ 0 buffer
    0/ 0 timer
    0/ 1 filer
    0/ 1 striper
    0/ 1 objecter
    0/ 5 rados
    0/ 5 rbd
    0/20 journaler
    0/ 5 objectcacher
    0/ 5 client
    0/20 osd
    0/ 0 optracker
    0/ 0 objclass
    0/20 filestore
    0/20 journal
    0/ 0 ms
    1/ 5 mon
    0/ 0 monc
    0/ 5 paxos
    0/ 0 tp
    0/ 0 auth
    1/ 5 crypto
    0/ 0 finisher
    0/ 0 heartbeatmap
    0/ 0 perfcounter
    1/ 5 rgw
    1/ 5 hadoop
    1/ 5 javaclient
    0/ 0 asok
    0/ 0 throttle
   -2/-2 (syslog threshold)
   -1/-1 (stderr threshold)
   max_recent    100000
   max_new         1000
   log_file /var/log/ceph/ceph-osd.3.log
--- end dump of recent events ---
2012-12-14 09:17:50.714676 7fb6e0d6b780 -1 *** Caught signal (Aborted) **
  in thread 7fb6e0d6b780

  ceph version 0.55-239-gc951c27 (c951c270a42b94b6f269992c9001d90f70a2b824)
  1: /usr/bin/ceph-osd() [0x7a1889]
  2: (()+0xeff0) [0x7fb6e0750ff0]
  3: (gsignal()+0x35) [0x7fb6deb1a1b5]
  4: (abort()+0x180) [0x7fb6deb1cfc0]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fb6df3aedc5]
  6: (()+0xcb166) [0x7fb6df3ad166]
  7: (()+0xcb193) [0x7fb6df3ad193]
  8: (()+0xcb28e) [0x7fb6df3ad28e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x7c9) [0x805659]
  10: (OSDService::get_map(unsigned int)+0x918) [0x607f78]
  11: (OSD::load_pgs()+0x13ed) [0x6168ad]
  12: (OSD::init()+0xaff) [0x617a5f]
  13: (main()+0x2de6) [0x55a416]
  14: (__libc_start_main()+0xfd) [0x7fb6deb06c8d]
  15: /usr/bin/ceph-osd() [0x557269]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- begin dump of recent events ---
      0> 2012-12-14 09:17:50.714676 7fb6e0d6b780 -1 *** Caught signal 
(Aborted) **
  in thread 7fb6e0d6b780

  ceph version 0.55-239-gc951c27 (c951c270a42b94b6f269992c9001d90f70a2b824)
  1: /usr/bin/ceph-osd() [0x7a1889]
  2: (()+0xeff0) [0x7fb6e0750ff0]
  3: (gsignal()+0x35) [0x7fb6deb1a1b5]
  4: (abort()+0x180) [0x7fb6deb1cfc0]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fb6df3aedc5]
  6: (()+0xcb166) [0x7fb6df3ad166]
  7: (()+0xcb193) [0x7fb6df3ad193]
  8: (()+0xcb28e) [0x7fb6df3ad28e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x7c9) [0x805659]
  10: (OSDService::get_map(unsigned int)+0x918) [0x607f78]
  11: (OSD::load_pgs()+0x13ed) [0x6168ad]
  12: (OSD::init()+0xaff) [0x617a5f]
  13: (main()+0x2de6) [0x55a416]
  14: (__libc_start_main()+0xfd) [0x7fb6deb06c8d]
  15: /usr/bin/ceph-osd() [0x557269]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- logging levels ---
    0/ 5 none
    0/ 0 lockdep
    0/ 0 context
    0/ 0 crush
    1/ 5 mds
    1/ 5 mds_balancer
    1/ 5 mds_locker
    1/ 5 mds_log
    1/ 5 mds_log_expire
    1/ 5 mds_migrator
    0/ 0 buffer
    0/ 0 timer
    0/ 1 filer
    0/ 1 striper
    0/ 1 objecter
    0/ 5 rados
    0/ 5 rbd
    0/20 journaler
    0/ 5 objectcacher
    0/ 5 client
    0/20 osd
    0/ 0 optracker
    0/ 0 objclass
    0/20 filestore
    0/20 journal
    0/ 0 ms
    1/ 5 mon
    0/ 0 monc
    0/ 5 paxos
    0/ 0 tp
    0/ 0 auth
    1/ 5 crypto
    0/ 0 finisher
    0/ 0 heartbeatmap
    0/ 0 perfcounter
    1/ 5 rgw
    1/ 5 hadoop
    1/ 5 javaclient
    0/ 0 asok
    0/ 0 throttle
   -2/-2 (syslog threshold)
   -1/-1 (stderr threshold)
   max_recent    100000
   max_new         1000
   log_file /var/log/ceph/ceph-osd.3.log
--- end dump of recent events ---

Stefan

Am 14.12.2012 09:12, schrieb Stefan Priebe:
> Hello list,
>
> after a reboot of my node i see this on all OSDs of this node after the
> reboot:
>
> 2012-12-14 09:03:20.393224 7f8e652f8780 -1 osd/OSD.cc: In function
> 'OSDMapRef OSDService::get_map(epoch_t)' thread 7f8e652f8780 time
> 2012-12-14 09:03:20.392528
> osd/OSD.cc: 4385: FAILED assert(_get_map_bl(epoch, bl))
>
>   ceph version 0.55-239-gc951c27 (c951c270a42b94b6f269992c9001d90f70a2b824)
>   1: (OSDService::get_map(unsigned int)+0x918) [0x607f78]
>   2: (OSD::load_pgs()+0x13ed) [0x6168ad]
>   3: (OSD::init()+0xaff) [0x617a5f]
>   4: (main()+0x2de6) [0x55a416]
>   5: (__libc_start_main()+0xfd) [0x7f8e63093c8d]
>   6: /usr/bin/ceph-osd() [0x557269]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> --- begin dump of recent events ---
>     -29> 2012-12-14 09:03:20.266349 7f8e652f8780  5 asok(0x285c000)
> register_command perfcounters_dump hook 0x2850010
>     -28> 2012-12-14 09:03:20.266366 7f8e652f8780  5 asok(0x285c000)
> register_command 1 hook 0x2850010
>     -27> 2012-12-14 09:03:20.266369 7f8e652f8780  5 asok(0x285c000)
> register_command perf dump hook 0x2850010
>     -26> 2012-12-14 09:03:20.266379 7f8e652f8780  5 asok(0x285c000)
> register_command perfcounters_schema hook 0x2850010
>     -25> 2012-12-14 09:03:20.266383 7f8e652f8780  5 asok(0x285c000)
> register_command 2 hook 0x2850010
>     -24> 2012-12-14 09:03:20.266386 7f8e652f8780  5 asok(0x285c000)
> register_command perf schema hook 0x2850010
>     -23> 2012-12-14 09:03:20.266389 7f8e652f8780  5 asok(0x285c000)
> register_command config show hook 0x2850010
>     -22> 2012-12-14 09:03:20.266392 7f8e652f8780  5 asok(0x285c000)
> register_command config set hook 0x2850010
>     -21> 2012-12-14 09:03:20.266396 7f8e652f8780  5 asok(0x285c000)
> register_command log flush hook 0x2850010
>     -20> 2012-12-14 09:03:20.266398 7f8e652f8780  5 asok(0x285c000)
> register_command log dump hook 0x2850010
>     -19> 2012-12-14 09:03:20.266401 7f8e652f8780  5 asok(0x285c000)
> register_command log reopen hook 0x2850010
>     -18> 2012-12-14 09:03:20.267686 7f8e652f8780  0 ceph version
> 0.55-239-gc951c27 (c951c270a42b94b6f269992c9001d90f70a2b824), process
> ceph-osd, pid 7212
>     -17> 2012-12-14 09:03:20.268738 7f8e652f8780  1 finished
> global_init_daemonize
>     -16> 2012-12-14 09:03:20.275957 7f8e652f8780  0
> filestore(/ceph/osd.1/) mount FIEMAP ioctl is supported and appears to work
>     -15> 2012-12-14 09:03:20.275968 7f8e652f8780  0
> filestore(/ceph/osd.1/) mount FIEMAP ioctl is disabled via 'filestore
> fiemap' config option
>     -14> 2012-12-14 09:03:20.276177 7f8e652f8780  0
> filestore(/ceph/osd.1/) mount did NOT detect btrfs
>     -13> 2012-12-14 09:03:20.277051 7f8e652f8780  0
> filestore(/ceph/osd.1/) mount syscall(__NR_syncfs, fd) fully supported
>     -12> 2012-12-14 09:03:20.277585 7f8e652f8780  0
> filestore(/ceph/osd.1/) mount found snaps <>
>     -11> 2012-12-14 09:03:20.278899 7f8e652f8780  0
> filestore(/ceph/osd.1/) mount: enabling WRITEAHEAD journal mode: btrfs
> not detected
>     -10> 2012-12-14 09:03:20.290745 7f8e652f8780  0 journal  kernel
> version is 3.6.10
>      -9> 2012-12-14 09:03:20.320728 7f8e652f8780  0 journal  kernel
> version is 3.6.10
>      -8> 2012-12-14 09:03:20.328381 7f8e652f8780  0
> filestore(/ceph/osd.1/) mount FIEMAP ioctl is supported and appears to work
>      -7> 2012-12-14 09:03:20.328391 7f8e652f8780  0
> filestore(/ceph/osd.1/) mount FIEMAP ioctl is disabled via 'filestore
> fiemap' config option
>      -6> 2012-12-14 09:03:20.328574 7f8e652f8780  0
> filestore(/ceph/osd.1/) mount did NOT detect btrfs
>      -5> 2012-12-14 09:03:20.329579 7f8e652f8780  0
> filestore(/ceph/osd.1/) mount syscall(__NR_syncfs, fd) fully supported
>      -4> 2012-12-14 09:03:20.329612 7f8e652f8780  0
> filestore(/ceph/osd.1/) mount found snaps <>
>      -3> 2012-12-14 09:03:20.330786 7f8e652f8780  0
> filestore(/ceph/osd.1/) mount: enabling WRITEAHEAD journal mode: btrfs
> not detected
>      -2> 2012-12-14 09:03:20.340711 7f8e652f8780  0 journal  kernel
> version is 3.6.10
>      -1> 2012-12-14 09:03:20.370707 7f8e652f8780  0 journal  kernel
> version is 3.6.10
>       0> 2012-12-14 09:03:20.393224 7f8e652f8780 -1 osd/OSD.cc: In
> function 'OSDMapRef OSDService::get_map(epoch_t)' thread 7f8e652f8780
> time 2012-12-14 09:03:20.392528
> osd/OSD.cc: 4385: FAILED assert(_get_map_bl(epoch, bl))
>
>   ceph version 0.55-239-gc951c27 (c951c270a42b94b6f269992c9001d90f70a2b824)
>   1: (OSDService::get_map(unsigned int)+0x918) [0x607f78]
>   2: (OSD::load_pgs()+0x13ed) [0x6168ad]
>   3: (OSD::init()+0xaff) [0x617a5f]
>   4: (main()+0x2de6) [0x55a416]
>   5: (__libc_start_main()+0xfd) [0x7f8e63093c8d]
>   6: /usr/bin/ceph-osd() [0x557269]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
