From: Vladislav Gorbunov <vadikgo@gmail.com>
Subject: Segmentation fault on rbd client ceph version 0.48.2argonaut
Date: Tue, 11 Dec 2012 09:54:02 +1200
Message-ID: <CAD+Ap5bAgNczG_JusPYSXJYD9ScjUtxRD6k5xXZuG-2E0dkYcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59900 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2LJVyE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 16:54:04 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so2392538lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 13:54:02 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

I'm have the cluster with pools:
root@bender:~# rados lspools
data
metadata
rbd
rados
iscsi

and rbd images on iscsi pool
root@bender:~# rbd ls iscsi
seodo1
siri
siri1

Cluster status is ok.
root@bender:~# ceph -s
   health HEALTH_OK
   monmap e5: 3 mons at
{0=10.166.10.24:6789/0,1=10.166.10.25:6789/0,2=10.166.6.127:6789/0},
election epoch 52, quorum 0,1,2 0,1,2
   osdmap e3684: 5 osds: 5 up, 5 in
    pgmap v2265899: 400 pgs: 400 active+clean; 713 GB data, 1453 GB
used, 10271 GB / 11725 GB avail
   mdsmap e1: 0/0/1 up


access to iscsi/siri1 success:
root@bender:~# rbd info iscsi/siri1
rbd image 'siri1':
size 256 GB in 65536 objects
order 22 (4096 KB objects)
block_name_prefix: rb.0.27cf.a17d043
parent:  (pool -1)

but access to iscsi/seodo1 and iscsi/siri1 fail on every rbd client
hosts. Data completely inaccessible.

root@bender:~# rbd info iscsi/seodo1
*** Caught signal (Segmentation fault) **
 in thread 7fb8c93f5780
 ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
 1: rbd() [0x41dfea]
 2: (()+0xfcb0) [0x7fb8c796fcb0]
 3: (()+0x16244d) [0x7fb8c6ae444d]
 4: (librbd::read_header_bl(librados::IoCtx&, std::string const&,
ceph::buffer::list&, unsigned long*)+0xf9) [0x7fb8c8fadb99]
 5: (librbd::read_header(librados::IoCtx&, std::string const&,
rbd_obj_header_ondisk*, unsigned long*)+0x82) [0x7fb8c8fadda2]
 6: (librbd::ictx_refresh(librbd::ImageCtx*)+0x90b) [0x7fb8c8fb05eb]
 7: (librbd::open_image(librbd::ImageCtx*)+0x1b5) [0x7fb8c8fb1165]
 8: (librbd::RBD::open(librados::IoCtx&, librbd::Image&, char const*,
char const*)+0x5f) [0x7fb8c8fb16af]
 9: (main()+0x73c) [0x41721c]
 10: (__libc_start_main()+0xed) [0x7fb8c69a376d]
 11: rbd() [0x41a0c9]
2012-12-11 09:33:14.264755 7fb8c93f5780 -1 *** Caught signal
(Segmentation fault) **
 in thread 7fb8c93f5780

 ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
 1: rbd() [0x41dfea]
 2: (()+0xfcb0) [0x7fb8c796fcb0]
 3: (()+0x16244d) [0x7fb8c6ae444d]
 4: (librbd::read_header_bl(librados::IoCtx&, std::string const&,
ceph::buffer::list&, unsigned long*)+0xf9) [0x7fb8c8fadb99]
 5: (librbd::read_header(librados::IoCtx&, std::string const&,
rbd_obj_header_ondisk*, unsigned long*)+0x82) [0x7fb8c8fadda2]
 6: (librbd::ictx_refresh(librbd::ImageCtx*)+0x90b) [0x7fb8c8fb05eb]
 7: (librbd::open_image(librbd::ImageCtx*)+0x1b5) [0x7fb8c8fb1165]
 8: (librbd::RBD::open(librados::IoCtx&, librbd::Image&, char const*,
char const*)+0x5f) [0x7fb8c8fb16af]
 9: (main()+0x73c) [0x41721c]
 10: (__libc_start_main()+0xed) [0x7fb8c69a376d]
 11: rbd() [0x41a0c9]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- begin dump of recent events ---
   -67> 2012-12-11 09:33:14.251328 7fb8c93f5780  5 asok(0x1e625e0)
register_command perfcounters_dump hook 0x1e63890
   -66> 2012-12-11 09:33:14.251361 7fb8c93f5780  5 asok(0x1e625e0)
register_command 1 hook 0x1e63890
   -65> 2012-12-11 09:33:14.251367 7fb8c93f5780  5 asok(0x1e625e0)
register_command perf dump hook 0x1e63890
   -64> 2012-12-11 09:33:14.251377 7fb8c93f5780  5 asok(0x1e625e0)
register_command perfcounters_schema hook 0x1e63890
   -63> 2012-12-11 09:33:14.251384 7fb8c93f5780  5 asok(0x1e625e0)
register_command 2 hook 0x1e63890
   -62> 2012-12-11 09:33:14.251387 7fb8c93f5780  5 asok(0x1e625e0)
register_command perf schema hook 0x1e63890
   -61> 2012-12-11 09:33:14.251395 7fb8c93f5780  5 asok(0x1e625e0)
register_command config show hook 0x1e63890
   -60> 2012-12-11 09:33:14.251402 7fb8c93f5780  5 asok(0x1e625e0)
register_command config set hook 0x1e63890
   -59> 2012-12-11 09:33:14.251405 7fb8c93f5780  5 asok(0x1e625e0)
register_command log flush hook 0x1e63890
   -58> 2012-12-11 09:33:14.251409 7fb8c93f5780  5 asok(0x1e625e0)
register_command log dump hook 0x1e63890
   -57> 2012-12-11 09:33:14.251416 7fb8c93f5780  5 asok(0x1e625e0)
register_command log reopen hook 0x1e63890
   -56> 2012-12-11 09:33:14.256284 7fb8c93f5780  1 librados: starting
msgr at :/0
   -55> 2012-12-11 09:33:14.256308 7fb8c93f5780  1 librados: starting objecter
   -54> 2012-12-11 09:33:14.256362 7fb8c93f5780  1 -- :/0 messenger.start
   -53> 2012-12-11 09:33:14.256406 7fb8c93f5780  1 librados: setting wanted keys
   -52> 2012-12-11 09:33:14.256413 7fb8c93f5780  1 librados: calling
monclient init
   -51> 2012-12-11 09:33:14.256444 7fb8c93f5780  2 auth: CephX auth is
not supported.
   -50> 2012-12-11 09:33:14.256623 7fb8c93f5780  1 -- :/1009726 -->
10.166.6.127:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0
0x1e81de0 con 0x1e81a50
   -49> 2012-12-11 09:33:14.257282 7fb8c2a0a700  1 --
172.20.0.171:0/1009726 learned my addr 172.20.0.171:0/1009726
   -48> 2012-12-11 09:33:14.258396 7fb8c2909700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) get 473 (0 ->
473)
   -47> 2012-12-11 09:33:14.258476 7fb8c2909700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) get 24 (473 ->
497)
   -46> 2012-12-11 09:33:14.258476 7fb8c4a0e700  1 --
172.20.0.171:0/1009726 <== mon.0 10.166.6.127:6789/0 1 ==== mon_map v1
==== 473+0+0 (3519270711 0 0) 0x7fb8b4000be0 con 0x1e81a50
   -45> 2012-12-11 09:33:14.258551 7fb8c4a0e700  1 monclient(hunting):
found mon.2
   -44> 2012-12-11 09:33:14.258562 7fb8c4a0e700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) put 473
(0x680b68 -> 24)
   -43> 2012-12-11 09:33:14.258567 7fb8c4a0e700  1 --
172.20.0.171:0/1009726 <== mon.0 10.166.6.127:6789/0 2 ====
auth_reply(proto 1 0 Success) v1 ==== 24+0+0 (630459259 0 0)
0x7fb8b4001050 con 0x1e81a50
   -42> 2012-12-11 09:33:14.258598 7fb8c4a0e700  1 --
172.20.0.171:0/1009726 --> 10.166.6.127:6789/0 --
mon_subscribe({monmap=0+}) v2 -- ?+0 0x1e82160 con 0x1e81a50
   -41> 2012-12-11 09:33:14.258621 7fb8c4a0e700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) put 24
(0x680b68 -> 0)
   -40> 2012-12-11 09:33:14.258630 7fb8c93f5780  5 monclient:
authenticate success, global_id 10203
   -39> 2012-12-11 09:33:14.258697 7fb8c93f5780  5 asok(0x1e625e0)
register_command objecter_requests hook 0x1e815d0
   -38> 2012-12-11 09:33:14.258722 7fb8c93f5780  1 --
172.20.0.171:0/1009726 --> 10.166.6.127:6789/0 --
mon_subscribe({monmap=6+,osdmap=0}) v2 -- ?+0 0x1e7e600 con 0x1e81a50
   -37> 2012-12-11 09:33:14.258744 7fb8c93f5780  1 --
172.20.0.171:0/1009726 --> 10.166.6.127:6789/0 --
mon_subscribe({monmap=6+,osdmap=0}) v2 -- ?+0 0x1e82ba0 con 0x1e81a50
   -36> 2012-12-11 09:33:14.258757 7fb8c93f5780  1 librados: waiting for osdmap
   -35> 2012-12-11 09:33:14.259236 7fb8c2909700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) get 473 (0 ->
473)
   -34> 2012-12-11 09:33:14.259275 7fb8c2909700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) get 20 (473 ->
493)
   -33> 2012-12-11 09:33:14.259276 7fb8c4a0e700  1 --
172.20.0.171:0/1009726 <== mon.0 10.166.6.127:6789/0 3 ==== mon_map v1
==== 473+0+0 (3519270711 0 0) 0x7fb8b4001050 con 0x1e81a50
   -32> 2012-12-11 09:33:14.259300 7fb8c4a0e700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) put 473
(0x680b68 -> 20)
   -31> 2012-12-11 09:33:14.259305 7fb8c4a0e700  1 --
172.20.0.171:0/1009726 <== mon.0 10.166.6.127:6789/0 4 ====
mon_subscribe_ack(300s) v1 ==== 20+0+0 (3060382165 0 0) 0x7fb8b4001260
con 0x1e81a50
   -30> 2012-12-11 09:33:14.259317 7fb8c4a0e700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) put 20
(0x680b68 -> 0)
   -29> 2012-12-11 09:33:14.259571 7fb8c2909700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) get 4180 (0 ->
4180)
   -28> 2012-12-11 09:33:14.259614 7fb8c2909700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) get 20 (4180
-> 4200)
   -27> 2012-12-11 09:33:14.259614 7fb8c4a0e700  1 --
172.20.0.171:0/1009726 <== mon.0 10.166.6.127:6789/0 5 ====
osd_map(3684..3684 src has 3184..3684) v3 ==== 4180+0+0 (3681574298 0
0) 0x7fb8b4002050 con 0x1e81a50
   -26> 2012-12-11 09:33:14.259706 7fb8c2909700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) get 4180 (4200
-> 8380)
   -25> 2012-12-11 09:33:14.259733 7fb8c2909700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) get 20 (8380
-> 8400)
   -24> 2012-12-11 09:33:14.259775 7fb8c4a0e700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) put 4180
(0x680b68 -> 4220)
   -23> 2012-12-11 09:33:14.259780 7fb8c4a0e700  1 --
172.20.0.171:0/1009726 <== mon.0 10.166.6.127:6789/0 6 ====
mon_subscribe_ack(300s) v1 ==== 20+0+0 (3060382165 0 0) 0x7fb8b40022b0
con 0x1e81a50
   -22> 2012-12-11 09:33:14.259790 7fb8c4a0e700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) put 20
(0x680b68 -> 4200)
   -21> 2012-12-11 09:33:14.259793 7fb8c4a0e700  1 --
172.20.0.171:0/1009726 <== mon.0 10.166.6.127:6789/0 7 ====
osd_map(3684..3684 src has 3184..3684) v3 ==== 4180+0+0 (3681574298 0
0) 0x7fb8b4003610 con 0x1e81a50
   -20> 2012-12-11 09:33:14.259816 7fb8c93f5780  1 librados: init done
   -19> 2012-12-11 09:33:14.259828 7fb8c4a0e700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) put 4180
(0x680b68 -> 20)
   -18> 2012-12-11 09:33:14.259835 7fb8c4a0e700  1 --
172.20.0.171:0/1009726 <== mon.0 10.166.6.127:6789/0 8 ====
mon_subscribe_ack(300s) v1 ==== 20+0+0 (3060382165 0 0) 0x7fb8b4003a10
con 0x1e81a50
   -17> 2012-12-11 09:33:14.259849 7fb8c4a0e700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) put 20
(0x680b68 -> 0)
   -16> 2012-12-11 09:33:14.259907 7fb8c93f5780  5
throttle(objecter_bytes 0x1e7ff78) get_or_fail 0 success (0 -> 0)
   -15> 2012-12-11 09:33:14.259917 7fb8c93f5780  5
throttle(objecter_ops 0x1e7fff0) get_or_fail 1 success (0 -> 1)
   -14> 2012-12-11 09:33:14.259992 7fb8c93f5780  1 --
172.20.0.171:0/1009726 --> 10.166.10.26:6800/25747 --
osd_op(client.10203.0:1 seodo1.rbd [stat 0~0] 4.fe0ab176) v4 -- ?+0
0x1e84620 con 0x1e84300
   -13> 2012-12-11 09:33:14.262454 7fb8c1806700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) get 125 (0 ->
125)
   -12> 2012-12-11 09:33:14.262524 7fb8c4a0e700  1 --
172.20.0.171:0/1009726 <== osd.0 10.166.10.26:6800/25747 1 ====
osd_op_reply(1 seodo1.rbd [stat 0~0] = 0) v4 ==== 109+0+16 (1903754457
0 1940624315) 0x7fb8b0000b20 con 0x1e84300
   -11> 2012-12-11 09:33:14.262563 7fb8c4a0e700  5
throttle(objecter_bytes 0x1e7ff78) put 0 (0x680b68 -> 0)
   -10> 2012-12-11 09:33:14.262568 7fb8c4a0e700  5
throttle(objecter_ops 0x1e7fff0) put 1 (0x680b68 -> 0)
    -9> 2012-12-11 09:33:14.262591 7fb8c4a0e700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) put 125
(0x680b68 -> 0)
    -8> 2012-12-11 09:33:14.262617 7fb8c93f5780  5
throttle(objecter_bytes 0x1e7ff78) get_or_fail 4096 success (0 ->
4096)
    -7> 2012-12-11 09:33:14.262626 7fb8c93f5780  5
throttle(objecter_ops 0x1e7fff0) get_or_fail 1 success (0 -> 1)
    -6> 2012-12-11 09:33:14.262638 7fb8c93f5780  1 --
172.20.0.171:0/1009726 --> 10.166.10.26:6800/25747 --
osd_op(client.10203.0:2 seodo1.rbd [read 0~4096] 4.fe0ab176) v4 -- ?+0
0x1e84a90 con 0x1e84300
    -5> 2012-12-11 09:33:14.264141 7fb8c1806700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) get 109 (0 ->
109)
    -4> 2012-12-11 09:33:14.264181 7fb8c4a0e700  1 --
172.20.0.171:0/1009726 <== osd.0 10.166.10.26:6800/25747 2 ====
osd_op_reply(2 seodo1.rbd [read 0~0] = 0) v4 ==== 109+0+0 (2824963832
0 0) 0x7fb8b0000b20 con 0x1e84300
    -3> 2012-12-11 09:33:14.264199 7fb8c4a0e700  5
throttle(objecter_bytes 0x1e7ff78) put 4096 (0x680b68 -> 0)
    -2> 2012-12-11 09:33:14.264205 7fb8c4a0e700  5
throttle(objecter_ops 0x1e7fff0) put 1 (0x680b68 -> 0)
    -1> 2012-12-11 09:33:14.264223 7fb8c4a0e700  5
throttle(msgr_dispatch_throttler-radosclient 0x1e7eef0) put 109
(0x680b68 -> 0)
     0> 2012-12-11 09:33:14.264755 7fb8c93f5780 -1 *** Caught signal
(Segmentation fault) **
 in thread 7fb8c93f5780

 ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
 1: rbd() [0x41dfea]
 2: (()+0xfcb0) [0x7fb8c796fcb0]
 3: (()+0x16244d) [0x7fb8c6ae444d]
 4: (librbd::read_header_bl(librados::IoCtx&, std::string const&,
ceph::buffer::list&, unsigned long*)+0xf9) [0x7fb8c8fadb99]
 5: (librbd::read_header(librados::IoCtx&, std::string const&,
rbd_obj_header_ondisk*, unsigned long*)+0x82) [0x7fb8c8fadda2]
 6: (librbd::ictx_refresh(librbd::ImageCtx*)+0x90b) [0x7fb8c8fb05eb]
 7: (librbd::open_image(librbd::ImageCtx*)+0x1b5) [0x7fb8c8fb1165]
 8: (librbd::RBD::open(librados::IoCtx&, librbd::Image&, char const*,
char const*)+0x5f) [0x7fb8c8fb16af]
 9: (main()+0x73c) [0x41721c]
 10: (__libc_start_main()+0xed) [0x7fb8c69a376d]
 11: rbd() [0x41a0c9]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- end dump of recent events ---
Segmentation fault
