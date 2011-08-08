From: huang jun <hjwsm1989@gmail.com>
Subject: osd down after adding OSDs
Date: Mon, 8 Aug 2011 21:19:14 +0800
Message-ID: <CABAwU-amM1mTyyquDFyc+BQsh21D6vkw-ER+X4ZPNm7_CH5PPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55862 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab1HHNTP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Aug 2011 09:19:15 -0400
Received: by vxi9 with SMTP id 9so2429117vxi.19
        for <ceph-devel@vger.kernel.org>; Mon, 08 Aug 2011 06:19:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
as i said before, use ceph 0.32 to test adding OSDs, there are many osds down.
we used the follow method to add OSDs
build a cluster with 20 osds(osd0~osd19),
at first, start osd0~osd9 process
$ mount -t ceph 192.168.0.11:/ /mnt
$ mkdir /mnt/test
$ dd if=/dev/zero of=test1 bs=4M count=2500
it doesn't finished, start osd10~osd19 process.
then we find many osds down and out
there are two types of osd debug log:
1) 2011-08-08 20:17:37.395713 7f3322236700 -- 192.168.0.116:6804/6535
<== osd8 192.168.0.109:6802/10812 2 ==== osd_ping(e229 as_of 342
heartbeat) v1 ==== 61+0+0 (791047524 0 0) 0x33ba000 con 0x2e78dc0
2011-08-08 20:17:37.395717 7f3322236700 osd15 342 heartbeat_dispatch 0x33ba000
2011-08-08 20:17:37.395724 7f3322236700 osd15 342 handle_osd_ping osd8
192.168.0.109:6802/10812
2011-08-08 20:17:37.395730 7f3322236700 osd15 342 note_peer_epoch osd8
has 342 >= 229
2011-08-08 20:17:37.395736 7f3322236700 osd15 342 _share_map_outgoing
osd8 192.168.0.109:6801/10812 already has epoch 342
2011-08-08 20:17:37.395746 7f3322236700 -- 192.168.0.116:6804/6535
dispatch_throttle_release 61 to dispatch throttler 61/104857600
2011-08-08 20:17:37.395752 7f3322236700 -- 192.168.0.116:6804/6535
done calling dispatch on 0x33ba000
2011-08-08 20:17:37.395765 7f331b1f7700 -- 192.168.0.116:6804/6535 >>
192.168.0.109:6802/10812 pipe(0x2ac7000 sd=23 pgs=1124 cs=1 l=
0).writer: state = 2 policy.server=0
2011-08-08 20:17:37.395796 7f331b1f7700 -- 192.168.0.116:6804/6535 >>
192.168.0.109:6802/10812 pipe(0x2ac7000 sd=23 pgs=1124 cs=1 l=
0).write_ack 2
2011-08-08 20:17:37.395822 7f331b1f7700 -- 192.168.0.116:6804/6535 >>
192.168.0.109:6802/10812 pipe(0x2ac7000 sd=23 pgs=1124 cs=1 l=
0).writer: state = 2 policy.server=0
2011-08-08 20:17:37.395842 7f331b1f7700 -- 192.168.0.116:6804/6535 >>
192.168.0.109:6802/10812 pipe(0x2ac7000 sd=23 pgs=1124 cs=1 l=
0).writer sleeping
2011-08-08 20:17:37.399379 7f332a246700 -- 192.168.0.116:6804/6535
accepter poll got 1
2011-08-08 20:17:37.399403 7f332a246700 -- 192.168.0.116:6804/6535 pfd.revents=1
2011-08-08 20:17:37.399426 7f332a246700 -- 192.168.0.116:6804/6535
accepted incoming on sd 15
2011-08-08 20:17:37.399467 7f332a246700 -- 192.168.0.116:6804/6535
accepter calling poll
2011-08-08 20:17:37.399518 7f33197dd700 -- 192.168.0.116:6804/6535 >>
:/0 pipe(0x4685000 sd=15 pgs=0 cs=0 l=0).accept
2011-08-08 20:17:37.399627 7f33197dd700 -- 192.168.0.116:6804/6535 >>
:/0 pipe(0x4685000 sd=15 pgs=0 cs=0 l=0).accept sd=15
2011-08-08 20:17:37.400171 7f33197dd700 -- 192.168.0.116:6804/6535 >>
192.168.0.106:6801/10437 pipe(0x4685000 sd=15 pgs=0 cs=0 l=0).
accept peer addr is 192.168.0.106:6801/10437
2011-08-08 20:17:37.400324 7f33197dd700 -- 192.168.0.116:6804/6535 >>
192.168.0.106:6801/10437 pipe(0x4685000 sd=15 pgs=0 cs=0 l=0).
accept got peer connect_seq 1 global_seq 233
2011-08-08 20:17:37.400352 7f33197dd700 -- 192.168.0.116:6804/6535 >>
192.168.0.106:6801/10437 pipe(0x4685000 sd=15 pgs=0 cs=0 l=0).accept
of host_type 4, policy.lossy=0
2011-08-08 20:17:37.400373 7f33197dd700 -- 192.168.0.116:6804/6535 >>
192.168.0.106:6801/10437 pipe(0x4685000 sd=15 pgs=0 cs=0 l=0).accept
my proto 8, their proto 8
2011-08-08 20:17:37.400408 7f33197dd700 -- 192.168.0.116:6804/6535 >>
192.168.0.106:6801/10437 pipe(0x4685000 sd=15 pgs=0 cs=0 l=0).accept
existing 0x3fe9c80.gseq 231 <= 233, looks ok
2011-08-08 20:17:37.400433 7f33197dd700 -- 192.168.0.116:6804/6535 >>
192.168.0.106:6801/10437 pipe(0x4685000 sd=15 pgs=0 cs=0 l=0).accept
connect_seq 1 vs existing 1 state 3
2011-08-08 20:17:37.400441 7f33197dd700 -- 192.168.0.116:6804/6535 >>
192.168.0.106:6801/10437 pipe(0x4685000 sd=15 pgs=0 cs=0 l=0).accept
connection race, existing 0x3fe9c80.cseq 1 == 1, sending WAIT
msg/SimpleMessenger.cc: In function 'int
SimpleMessenger::Pipe::accept()', in thread '0x7f33197dd700'
msg/SimpleMessenger.cc: 841: FAILED assert(existing->state ==
STATE_CONNECTING || existing->state == STATE_OPEN)
 ceph version 0.32 (commit:c08d08baa6a945d989427563e46c992f757ad5eb)
 1: (SimpleMessenger::Pipe::accept()+0x36da) [0x5c180a]
 2: (SimpleMessenger::Pipe::reader()+0xdfc) [0x5c291c]
 3: (SimpleMessenger::Pipe::Reader::entry()+0xd) [0x49bb1d]
 4: (()+0x68ba) [0x7f332daa28ba]
 5: (clone()+0x6d) [0x7f332c53202d]
 ceph version 0.32 (commit:c08d08baa6a945d989427563e46c992f757ad5eb)
 1: (SimpleMessenger::Pipe::accept()+0x36da) [0x5c180a]
 2: (SimpleMessenger::Pipe::reader()+0xdfc) [0x5c291c]
 3: (SimpleMessenger::Pipe::Reader::entry()+0xd) [0x49bb1d]
 4: (()+0x68ba) [0x7f332daa28ba]
 5: (clone()+0x6d) [0x7f332c53202d]
*** Caught signal (Aborted) **
 in thread 0x7f33197dd700
 ceph version 0.32 (commit:c08d08baa6a945d989427563e46c992f757ad5eb)
 1: /usr/bin/cosd() [0x581269]
 2: (()+0xef60) [0x7f332daaaf60]
 3: (gsignal()+0x35) [0x7f332c495165]
 4: (abort()+0x180) [0x7f332c497f70]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f332cd29dc5]
 6: (()+0xcb166) [0x7f332cd28166]
 7: (()+0xcb193) [0x7f332cd28193]
 8: (()+0xcb28e) [0x7f332cd2828e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x3a7) [0x585997]
 10: (SimpleMessenger::Pipe::accept()+0x36da) [0x5c180a]
 11: (SimpleMessenger::Pipe::reader()+0xdfc) [0x5c291c]
 12: (SimpleMessenger::Pipe::Reader::entry()+0xd) [0x49bb1d]
 13: (()+0x68ba) [0x7f332daa28ba]
 14: (clone()+0x6d) [0x7f332c53202d]

2) 2011-08-08 20:11:34.506899 7f2f85ff6700 osd10 22  0.87 at
2011-08-08 20:05:16.696631 > 2011-08-07 20:11:34.506050 (86400 seconds
ago)
2011-08-08 20:11:34.506903 7f2f85ff6700 osd10 22 sched_scrub done
2011-08-08 20:11:35.191699 7f2f7cee3700 osd10 22 heartbeat_entry woke up
2011-08-08 20:11:35.191724 7f2f7cee3700 osd10 22 heartbeat
2011-08-08 20:11:35.191758 7f2f7cee3700 osd10 22 heartbeat checking stats
2011-08-08 20:11:35.191780 7f2f7cee3700 osd10 22 update_osd_stat
osd_stat(1640 KB used, 931 GB avail, 931 GB total, peers []/[])
2011-08-08 20:11:35.191795 7f2f7cee3700 osd10 22 heartbeat:
osd_stat(1640 KB used, 931 GB avail, 931 GB total, peers []/[])
2011-08-08 20:11:35.191808 7f2f7cee3700 osd10 22 heartbeat map_locked=1
2011-08-08 20:11:35.191820 7f2f7cee3700 osd10 22 heartbeat check
2011-08-08 20:11:35.191828 7f2f7cee3700 osd10 22 heartbeat lonely?
2011-08-08 20:11:35.191835 7f2f7cee3700 osd10 22 heartbeat put map_lock
2011-08-08 20:11:35.191839 7f2f7cee3700 osd10 22 heartbeat done
2011-08-08 20:11:35.191846 7f2f7cee3700 osd10 22 heartbeat_entry
sleeping for 1.1
2011-08-08 20:11:35.506955 7f2f85ff6700 osd10 22 tick
2011-08-08 20:11:35.507011 7f2f85ff6700 osd10 22 scrub_should_schedule
loadavg 0.13 < max 0.5 = no, randomly backing off
2011-08-08 20:11:36.001713 7f2f847f3700 filestore(/data/osd10)
sync_entry woke after 5.000054
2011-08-08 20:11:36.001745 7f2f847f3700 filestore(/data/osd10)
sync_entry committing 2830 sync_epoch 10
2011-08-08 20:11:36.001786 7f2f847f3700 filestore(/data/osd10)
sync_entry doing btrfs SYNC
2011-08-08 20:11:36.077118 7f2f847f3700 filestore(/data/osd10)
sync_entry commit took 0.075372
2011-08-08 20:11:36.077238 7f2f84ff4700 osd10 22 pg[1.309( empty n=0
ec=2 les/c 6/20 21/21/21) [3] r=-1 stray] _activate_committed 8, that
was an old interval
2011-08-08 20:11:36.077278 7f2f84ff4700 osd10 22 pg[1.309( empty n=0
ec=2 les/c 6/20 21/21/21) [3] r=-1 stray] _finish_recovery -- stale
2011-08-08 20:11:36.077291 7f2f847f3700 filestore(/data/osd10)
sync_entry committed to op_seq 2830
2011-08-08 20:11:36.077308 7f2f847f3700 filestore(/data/osd10)
sync_entry waiting for max_interval 5.000000
2011-08-08 20:11:36.077369 7f2f84ff4700 osd10 22 pg[2.429( empty n=0
ec=2 les/c 6/20 21/21/21) [6] r=-1 stray] _activate_committed 8, that
was an old interval
2011-08-08 20:11:36.077412 7f2f84ff4700 osd10 22 pg[2.429( empty n=0
ec=2 les/c 6/20 21/21/21) [6] r=-1 stray] _finish_recovery -- stale
*** Caught signal (Segmentation fault) **
 in thread 0x7f2f84ff4700
 ceph version 0.32 (commit:c08d08baa6a945d989427563e46c992f757ad5eb)
 1: /usr/bin/cosd() [0x581269]
 2: (()+0xef60) [0x7f2f8b854f60]
 3: (PG::_activate_committed(unsigned int)+0x9c) [0x60bc2c]
 4: (Context::complete(int)+0xa) [0x4d9ada]
 5: (C_Contexts::finish(int)+0xdb) [0x4dfcdb]
 6: (Finisher::finisher_thread_entry()+0x188) [0x6a0288]
 7: (()+0x68ba) [0x7f2f8b84c8ba]
 8: (clone()+0x6d) [0x7f2f8a2e602d]

I'm not sure whether it occasionally occured, but i think you test
term should  try this method.
mybe you can see it.

I also have a question about OSD recovery,if osd0 asks osd1 for master
log on PG0 at  epoch v57,
and the osd1 sends the wanted log to osd0, but at this time, the
osd1's osdmap epoch increased to  v61, should the osd0 accepts it?

thanks!
