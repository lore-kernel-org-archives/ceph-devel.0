From: "Dave Humphreys (Datatone)" <dave@datatone.co.uk>
Subject: Cannot Start Ceph Mon
Date: Mon, 19 Nov 2012 16:13:22 -0500
Message-ID: <451141276.iIKpGsKZdm@vault01>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from i01.ip.uk.com ([86.54.60.3]:58126 "EHLO i01.ip.uk.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821Ab2KSVNW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Nov 2012 16:13:22 -0500
Received: from [194.164.232.154] (helo=vault01.localnet)
	by i01.ip.uk.com with esmtp (Exim 4.63)
	(envelope-from <dave@datatone.co.uk>)
	id 1TaYeb-0000CL-8j
	for ceph-devel@vger.kernel.org; Mon, 19 Nov 2012 21:13:19 +0000
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(Apologies if this is seen to be a repeat posting: I think that the last attempt fell into the void).

I can't start my ceph monitor. The log is below.

Though this shows version 0.54, the problem arose whilst using 0.52. Something may have become corrupted when the disk space ran out due to an immense ceph mon log.

Is there anything I can do to recover the situation?

Regards,
David


bash-4.1# cat /var/log/ceph/mon.vault01.log 
2012-11-19 20:38:51.598468 7fc13fdc6780  0 ceph version 0.54 (commit:60b84b095b1009a305d4d6a5b16f88571cbd3150), process ceph-mon, pid 21012
2012-11-19 20:38:51.598482 7fc13fdc6780  1 store(/ceph/mon.vault01) mount
2012-11-19 20:38:51.598527 7fc13fdc6780 20 store(/ceph/mon.vault01) reading at off 0 of 21
2012-11-19 20:38:51.598542 7fc13fdc6780 15 store(/ceph/mon.vault01) get_bl magic = 21 bytes
2012-11-19 20:38:51.598562 7fc13fdc6780 20 store(/ceph/mon.vault01) reading at off 0 of 75
2012-11-19 20:38:51.598567 7fc13fdc6780 15 store(/ceph/mon.vault01) get_bl feature_set = 75 bytes
2012-11-19 20:38:51.598582 7fc13fdc6780 20 store(/ceph/mon.vault01) reading at off 0 of 205
2012-11-19 20:38:51.598586 7fc13fdc6780 15 store(/ceph/mon.vault01) get_bl monmap/latest = 205 bytes
2012-11-19 20:38:51.598809 7fc13fdc6780  1 -- 10.0.1.1:6789/0 learned my addr 10.0.1.1:6789/0
2012-11-19 20:38:51.598818 7fc13fdc6780  1 accepter.accepter.bind my_inst.addr is 10.0.1.1:6789/0 need_addr=0
2012-11-19 20:38:51.599498 7fc13fdc6780  1 -- 10.0.1.1:6789/0 messenger.start
2012-11-19 20:38:51.599508 7fc13fdc6780  1 accepter.accepter.start
2012-11-19 20:38:51.599610 7fc13fdc6780  1 mon.vault01@-1(probing) e1 init fsid 4d7d8d20-338c-4bdc-9918-9bcf04f9a832
2012-11-19 20:38:51.599674 7fc13cdbe700  1 -- 10.0.1.1:6789/0 >> :/0 pipe(0x213c6c0 sd=14 :6789 pgs=0 cs=0 l=0).accept sd=14
2012-11-19 20:38:51.599678 7fc141eff700  1 -- 10.0.1.1:6789/0 >> :/0 pipe(0x213c240 sd=9 :6789 pgs=0 cs=0 l=0).accept sd=9
2012-11-19 20:38:51.599718 7fc13fdc6780 20 store(/ceph/mon.vault01) reading at off 0 of 37
2012-11-19 20:38:51.599723 7fc13fdc6780 15 store(/ceph/mon.vault01) get_bl cluster_uuid = 37 bytes
2012-11-19 20:38:51.599718 7fc13ccbd700  1 -- 10.0.1.1:6789/0 >> :/0 pipe(0x213c480 sd=19 :6789 pgs=0 cs=0 l=0).accept sd=19
2012-11-19 20:38:51.599729 7fc13fdc6780 10 mon.vault01@-1(probing) e1 check_fsid cluster_uuid contains '4d7d8d20-338c-4bdc-9918-9bcf04f9a832'
2012-11-19 20:38:51.599739 7fc13fdc6780 20 store(/ceph/mon.vault01) reading at off 0 of 75
2012-11-19 20:38:51.599745 7fc13fdc6780 15 store(/ceph/mon.vault01) get_bl feature_set = 75 bytes
2012-11-19 20:38:51.599751 7fc13fdc6780 10 mon.vault01@-1(probing) e1 features compat={},rocompat={},incompat={1=initial feature set (~v.18)}
2012-11-19 20:38:51.599759 7fc13fdc6780 15 store(/ceph/mon.vault01) exists_bl joined
2012-11-19 20:38:51.599769 7fc13fdc6780 10 mon.vault01@-1(probing) e1 has_ever_joined = 1
2012-11-19 20:38:51.599794 7fc13fdc6780 15 store(/ceph/mon.vault01) get_int pgmap/last_committed = 133333
2012-11-19 20:38:51.599801 7fc13fdc6780 15 store(/ceph/mon.vault01) get_int pgmap/first_committed = 132833
2012-11-19 20:38:51.599810 7fc13fdc6780 20 store(/ceph/mon.vault01) reading at off 0 of 239840
2012-11-19 20:38:51.599928 7fc13cbbc700  1 -- 10.0.1.1:6789/0 >> :/0 pipe(0x213cd80 sd=20 :6789 pgs=0 cs=0 l=0).accept sd=20
2012-11-19 20:38:51.599950 7fc13fdc6780 15 store(/ceph/mon.vault01) get_bl pgmap/latest = 239840 bytes
--- begin dump of recent events ---2012-11-19 20:38:51.600509 7fc13fdc6780 -1 
*** Caught signal (Aborted) **
 in thread 7fc13fdc6780

 ceph version 0.54 (commit:60b84b095b1009a305d4d6a5b16f88571cbd3150)
 1: ceph-mon() [0x53adf8]
 2: (()+0xfe90) [0x7fc141830e90]
 3: (gsignal()+0x3e) [0x7fc140016dae]
 4: (abort()+0x17b) [0x7fc14001825b]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fc141af300d]
 6: (()+0xb31b6) [0x7fc141af11b6]
 7: (()+0xb31e3) [0x7fc141af11e3]
 8: (()+0xb32de) [0x7fc141af12de]
 9: ceph-mon() [0x5ecb9f]
 10: (Paxos::get_stashed(ceph::buffer::list&)+0x1ed) [0x49e28d]
 11: (Paxos::init()+0x109) [0x49e609]
 12: (Monitor::init()+0x36a) [0x485a4a]
 13: (main()+0x1289) [0x46d909]
 14: (__libc_start_main()+0xed) [0x7fc14000364d]
 15: ceph-mon() [0x46fa09]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

   -55> 2012-11-19 20:38:51.596694 7fc13fdc6780  5 asok(0x213d000) register_command perfcounters_dump hook 0x2131050
   -55> 2012-11-19 20:38:51.596720 7fc13fdc6780  5 asok(0x213d000) register_command 1 hook 0x2131050
   -54> 2012-11-19 20:38:51.596725 7fc13fdc6780  5 asok(0x213d000) register_command perf dump hook 0x2131050
   -53> 2012-11-19 20:38:51.596735 7fc13fdc6780  5 asok(0x213d000) register_command perfcounters_schema hook 0x2131050
   -52> 2012-11-19 20:38:51.596740 7fc13fdc6780  5 asok(0x213d000) register_command 2 hook 0x2131050
   -51> 2012-11-19 20:38:51.596745 7fc13fdc6780  5 asok(0x213d000) register_command perf schema hook 0x2131050
   -50> 2012-11-19 20:38:51.596752 7fc13fdc6780  5 asok(0x213d000) register_command config show hook 0x2131050
   -49> 2012-11-19 20:38:51.596756 7fc13fdc6780  5 asok(0x213d000) register_command config set hook 0x2131050
   -48> 2012-11-19 20:38:51.596761 7fc13fdc6780  5 asok(0x213d000) register_command log flush hook 0x2131050
   -47> 2012-11-19 20:38:51.596765 7fc13fdc6780  5 asok(0x213d000) register_command log dump hook 0x2131050
   -46> 2012-11-19 20:38:51.596770 7fc13fdc6780  5 asok(0x213d000) register_command log reopen hook 0x2131050
   -45> 2012-11-19 20:38:51.598468 7fc13fdc6780  0 ceph version 0.54 (commit:60b84b095b1009a305d4d6a5b16f88571cbd3150), process ceph-mon, pid 21012
   -44> 2012-11-19 20:38:51.598482 7fc13fdc6780  1 store(/ceph/mon.vault01) mount
   -43> 2012-11-19 20:38:51.598527 7fc13fdc6780 20 store(/ceph/mon.vault01) reading at off 0 of 21
   -42> 2012-11-19 20:38:51.598542 7fc13fdc6780 15 store(/ceph/mon.vault01) get_bl magic = 21 bytes
   -41> 2012-11-19 20:38:51.598562 7fc13fdc6780 20 store(/ceph/mon.vault01) reading at off 0 of 75
   -40> 2012-11-19 20:38:51.598567 7fc13fdc6780 15 store(/ceph/mon.vault01) get_bl feature_set = 75 bytes
   -39> 2012-11-19 20:38:51.598582 7fc13fdc6780 20 store(/ceph/mon.vault01) reading at off 0 of 205
   -38> 2012-11-19 20:38:51.598586 7fc13fdc6780 15 store(/ceph/mon.vault01) get_bl monmap/latest = 205 bytes
   -37> 2012-11-19 20:38:51.598809 7fc13fdc6780  1 -- 10.0.1.1:6789/0 learned my addr 10.0.1.1:6789/0
   -36> 2012-11-19 20:38:51.598818 7fc13fdc6780  1 accepter.accepter.bind my_inst.addr is 10.0.1.1:6789/0 need_addr=0
   -35> 2012-11-19 20:38:51.599219 7fc13fdc6780  1 finished global_init_daemonize
   -34> 2012-11-19 20:38:51.599350 7fc13fdc6780  5 asok(0x213d000) init /var/run/ceph/ceph-mon.vault01.asok
   -33> 2012-11-19 20:38:51.599371 7fc13fdc6780  5 asok(0x213d000) bind_and_listen /var/run/ceph/ceph-mon.vault01.asok
   -32> 2012-11-19 20:38:51.599438 7fc13fdc6780  5 asok(0x213d000) register_command 0 hook 0x2130030
   -31> 2012-11-19 20:38:51.599444 7fc13fdc6780  5 asok(0x213d000) register_command version hook 0x2130030
   -30> 2012-11-19 20:38:51.599451 7fc13fdc6780  5 asok(0x213d000) register_command git_version hook 0x2130030
   -29> 2012-11-19 20:38:51.599456 7fc13fdc6780  5 asok(0x213d000) register_command help hook 0x2131040
   -28> 2012-11-19 20:38:51.599472 7fc13edc2700  5 asok(0x213d000) entry start
   -27> 2012-11-19 20:38:51.599498 7fc13fdc6780  1 -- 10.0.1.1:6789/0 messenger.start
   -26> 2012-11-19 20:38:51.599508 7fc13fdc6780  1 accepter.accepter.start
   -25> 2012-11-19 20:38:51.599610 7fc13fdc6780  1 mon.vault01@-1(probing) e1 init fsid 4d7d8d20-338c-4bdc-9918-9bcf04f9a832
   -24> 2012-11-19 20:38:51.599674 7fc13cdbe700  1 -- 10.0.1.1:6789/0 >> :/0 pipe(0x213c6c0 sd=14 :6789 pgs=0 cs=0 l=0).accept sd=14
   -23> 2012-11-19 20:38:51.599678 7fc141eff700  1 -- 10.0.1.1:6789/0 >> :/0 pipe(0x213c240 sd=9 :6789 pgs=0 cs=0 l=0).accept sd=9
   -22> 2012-11-19 20:38:51.599718 7fc13fdc6780 20 store(/ceph/mon.vault01) reading at off 0 of 37
   -21> 2012-11-19 20:38:51.599723 7fc13fdc6780 15 store(/ceph/mon.vault01) get_bl cluster_uuid = 37 bytes
   -20> 2012-11-19 20:38:51.599718 7fc13ccbd700  1 -- 10.0.1.1:6789/0 >> :/0 pipe(0x213c480 sd=19 :6789 pgs=0 cs=0 l=0).accept sd=19
   -19> 2012-11-19 20:38:51.599729 7fc13fdc6780 10 mon.vault01@-1(probing) e1 check_fsid cluster_uuid contains '4d7d8d20-338c-4bdc-9918-9bcf04f9a832'
   -18> 2012-11-19 20:38:51.599739 7fc13fdc6780 20 store(/ceph/mon.vault01) reading at off 0 of 75
   -17> 2012-11-19 20:38:51.599745 7fc13fdc6780 15 store(/ceph/mon.vault01) get_bl feature_set = 75 bytes
   -16> 2012-11-19 20:38:51.599751 7fc13fdc6780 10 mon.vault01@-1(probing) e1 features compat={},rocompat={},incompat={1=initial feature set (~v.18)}
   -15> 2012-11-19 20:38:51.599759 7fc13fdc6780 15 store(/ceph/mon.vault01) exists_bl joined
   -14> 2012-11-19 20:38:51.599769 7fc13fdc6780 10 mon.vault01@-1(probing) e1 has_ever_joined = 1
   -13> 2012-11-19 20:38:51.599794 7fc13fdc6780 15 store(/ceph/mon.vault01) get_int pgmap/last_committed = 133333
   -12> 2012-11-19 20:38:51.599795 7fc13cdbe700  5 throttle(mon_daemon_bytes 0x7fffae473da0) get 56 (0 -> 56)
   -11> 2012-11-19 20:38:51.599801 7fc13fdc6780 15 store(/ceph/mon.vault01) get_int pgmap/first_committed = 132833
   -10> 2012-11-19 20:38:51.599805 7fc13cdbe700  5 throttle(msgr_dispatch_throttler-mon 0x2153488) get 56 (0 -> 56)
    -9> 2012-11-19 20:38:51.599810 7fc13fdc6780 20 store(/ceph/mon.vault01) reading at off 0 of 239840
    -8> 2012-11-19 20:38:51.599904 7fc141eff700  5 throttle(mon_daemon_bytes 0x7fffae473da0) get 56 (56 -> 112)
    -7> 2012-11-19 20:38:51.599910 7fc141eff700  5 throttle(msgr_dispatch_throttler-mon 0x2153488) get 56 (56 -> 112)
    -6> 2012-11-19 20:38:51.599916 7fc13ccbd700  5 throttle(mon_daemon_bytes 0x7fffae473da0) get 62 (112 -> 174)
    -5> 2012-11-19 20:38:51.599929 7fc13ccbd700  5 throttle(msgr_dispatch_throttler-mon 0x2153488) get 62 (112 -> 174)
    -4> 2012-11-19 20:38:51.599928 7fc13cbbc700  1 -- 10.0.1.1:6789/0 >> :/0 pipe(0x213cd80 sd=20 :6789 pgs=0 cs=0 l=0).accept sd=20
    -3> 2012-11-19 20:38:51.599950 7fc13fdc6780 15 store(/ceph/mon.vault01) get_bl pgmap/latest = 239840 bytes
    -2> 2012-11-19 20:38:51.600027 7fc13cbbc700  5 throttle(mon_daemon_bytes 0x7fffae473da0) get 56 (174 -> 230)
    -1> 2012-11-19 20:38:51.600033 7fc13cbbc700  5 throttle(msgr_dispatch_throttler-mon 0x2153488) get 56 (174 -> 230)
     0> 2012-11-19 20:38:51.600509 7fc13fdc6780 -1 *** Caught signal (Aborted) **
 in thread 7fc13fdc6780

 ceph version 0.54 (commit:60b84b095b1009a305d4d6a5b16f88571cbd3150)
 1: ceph-mon() [0x53adf8]
 2: (()+0xfe90) [0x7fc141830e90]
 3: (gsignal()+0x3e) [0x7fc140016dae]
 4: (abort()+0x17b) [0x7fc14001825b]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fc141af300d]
 6: (()+0xb31b6) [0x7fc141af11b6]
 7: (()+0xb31e3) [0x7fc141af11e3]
 8: (()+0xb32de) [0x7fc141af12de]
 9: ceph-mon() [0x5ecb9f]
 10: (Paxos::get_stashed(ceph::buffer::list&)+0x1ed) [0x49e28d]
 11: (Paxos::init()+0x109) [0x49e609]
 12: (Monitor::init()+0x36a) [0x485a4a]
 13: (main()+0x1289) [0x46d909]
 14: (__libc_start_main()+0xed) [0x7fc14000364d]
 15: ceph-mon() [0x46fa09]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 5 lockdep
   0/ 5 context
   1/ 5 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 0 buffer
   0/ 5 timer
   0/ 5 filer
   0/ 0 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 5 filestore
   1/ 5 journal
   1/ 1 ms
  20/20 mon
   0/ 5 monc
  20/20 paxos
   0/ 5 tp
  20/20 auth
   1/ 5 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/ 5 hadoop
   1/ 5 asok
   1/ 5 throttle
  -2/-2 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new      1000000
  log_file /var/log/ceph/mon.vault01.log
--- end dump of recent events ---

