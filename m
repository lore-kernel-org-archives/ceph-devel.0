From: huang jun <hjwsm1989@gmail.com>
Subject: scrub loadavg too high
Date: Sun, 3 Jul 2011 21:42:29 +0800
Message-ID: <CABAwU-aaJE10=ZtbkXn-OyEmMpO3Nz8BvpS=x39mSr6y0JZQyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54171 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab1GCNma (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Jul 2011 09:42:30 -0400
Received: by wwe5 with SMTP id 5so4408586wwe.1
        for <ceph-devel@vger.kernel.org>; Sun, 03 Jul 2011 06:42:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
I test ceph 0.30 on linux-2.6.37 recently,after i build the cluster
bsd12:/# ceph -s
2011-07-04 09:37:42.920166    pg v66: 198 pgs: 198
active+clean+degraded; 1008 MB data, 11363 MB used, 2986 MB / 15118 MB
avail; 273/546 degraded (50.000%)
2011-07-04 09:37:42.920674   mds e4: 1/1/1 up {0=0=up:active}
2011-07-04 09:37:42.920723   osd e2: 1 osds: 1 up, 1 in
2011-07-04 09:37:42.920786   log 2011-07-04 09:15:47.239098 osd0
192.168.1.102:6801/7646 73 : [INF] 1.6 scrub ok
2011-07-04 09:37:42.920860   mon e1: 1 mons at {0=192.168.1.102:6789/0}

then, mount ceph fs on /mnt
bsd12:/mnt/dd# dd if=/dev/zero of=sa bs=4M count=200
and get nothing, is dead

during the writing, use sar to monitor the eth0,
but find there isn't any data transfered at all, like:
09:31:29 PM     IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s
rxcmp/s   txcmp/s  rxmcst/s
09:31:30 PM        lo      0.00      0.00      0.00      0.00
0.00      0.00      0.00
09:31:30 PM      eth0      0.00      0.00      0.00      0.00
0.00      0.00      0.00
09:31:30 PM      eth1      4.00      2.00      0.41      0.26
0.00      0.00      0.00

it seems OSD didn't do write, so result in client can not go on writing.
from the osd log, the scrub loadavg is very high:
2011-07-04 09:25:52.163742 7f0b56f2c700 osd0 2 tick
2011-07-04 09:25:52.163788 7f0b56f2c700 osd0 2 scrub_should_schedule
loadavg 2 >= max 0.5 = no, load too high
2011-07-04 09:25:52.163804 7f0b56f2c700 osd0 2 do_mon_report
2011-07-04 09:25:52.163819 7f0b56f2c700 osd0 2 send_alive up_thru
currently 0 want 0
2011-07-04 09:25:52.163833 7f0b56f2c700 osd0 2 send_pg_stats
2011-07-04 09:25:52.782851 7f0b4d517700 osd0 2 update_osd_stat
osd_stat(11363 MB used, 2986 MB avail, 15118 MB total, peers []/[])
2011-07-04 09:25:52.782887 7f0b4d517700 osd0 2 heartbeat:
stat(2011-07-04 09:25:52.782813 oprate=0.339098 qlen=0 recent_qlen=0
rdlat=0 / 0 fshedin=0)
2011-07-04 09:25:52.782902 7f0b4d517700 osd0 2 heartbeat:
osd_stat(11363 MB used, 2986 MB avail, 15118 MB total, peers []/[])
2011-07-04 09:25:53.012934 7f0b51f22700 FileStore: sync_entry timed
out after 600 seconds.
2011-07-04 09:25:53.012969 1: (SafeTimer::timer_thread()+0x311) [0x6028d1]
2011-07-04 09:25:53.012976 2: (SafeTimerThread::entry()+0xd) [0x604f3d]
2011-07-04 09:25:53.012985 3: (()+0x68ba) [0x7f0b5bba78ba]
2011-07-04 09:25:53.012992 4: (clone()+0x6d) [0x7f0b5a80302d]
2011-07-04 09:25:53.012997 *** Caught signal (Aborted) **
 in thread 0x7f0b51f22700

i'd like to know, does scrub workload too high results in OSD abort?
and why we design scrub here ? to protect the consistence of PG?

thanks in advance
