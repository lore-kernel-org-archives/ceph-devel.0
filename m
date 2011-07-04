From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: scrub loadavg too high
Date: Sun, 3 Jul 2011 22:49:45 -0700
Message-ID: <CA+qbEUPXdjNo39e4PSR=Z56w2jKsmyvr2JaS0-96miAVQzwygQ@mail.gmail.com>
References: <CABAwU-aaJE10=ZtbkXn-OyEmMpO3Nz8BvpS=x39mSr6y0JZQyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:47722 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab1GDFtr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 01:49:47 -0400
Received: by fxd18 with SMTP id 18so4916861fxd.11
        for <ceph-devel@vger.kernel.org>; Sun, 03 Jul 2011 22:49:45 -0700 (PDT)
In-Reply-To: <CABAwU-aaJE10=ZtbkXn-OyEmMpO3Nz8BvpS=x39mSr6y0JZQyQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Jul 3, 2011 at 6:42 AM, huang jun <hjwsm1989@gmail.com> wrote:
> hi,all
> I test ceph 0.30 on linux-2.6.37 recently,after i build the cluster
> bsd12:/# ceph -s
> 2011-07-04 09:37:42.920166 =A0 =A0pg v66: 198 pgs: 198
> active+clean+degraded; 1008 MB data, 11363 MB used, 2986 MB / 15118 M=
B
> avail; 273/546 degraded (50.000%)
> 2011-07-04 09:37:42.920674 =A0 mds e4: 1/1/1 up {0=3D0=3Dup:active}
> 2011-07-04 09:37:42.920723 =A0 osd e2: 1 osds: 1 up, 1 in
> 2011-07-04 09:37:42.920786 =A0 log 2011-07-04 09:15:47.239098 osd0
> 192.168.1.102:6801/7646 73 : [INF] 1.6 scrub ok
> 2011-07-04 09:37:42.920860 =A0 mon e1: 1 mons at {0=3D192.168.1.102:6=
789/0}
>
> then, mount ceph fs on /mnt
> bsd12:/mnt/dd# dd if=3D/dev/zero of=3Dsa bs=3D4M count=3D200
> and get nothing, is dead
>
> during the writing, use sar to monitor the eth0,
> but find there isn't any data transfered at all, like:
> 09:31:29 PM =A0 =A0 IFACE =A0 rxpck/s =A0 txpck/s =A0 =A0rxkB/s =A0 =A0=
txkB/s
> rxcmp/s =A0 txcmp/s =A0rxmcst/s
> 09:31:30 PM =A0 =A0 =A0 =A0lo =A0 =A0 =A00.00 =A0 =A0 =A00.00 =A0 =A0=
 =A00.00 =A0 =A0 =A00.00
> 0.00 =A0 =A0 =A00.00 =A0 =A0 =A00.00
> 09:31:30 PM =A0 =A0 =A0eth0 =A0 =A0 =A00.00 =A0 =A0 =A00.00 =A0 =A0 =A0=
0.00 =A0 =A0 =A00.00
> 0.00 =A0 =A0 =A00.00 =A0 =A0 =A00.00
> 09:31:30 PM =A0 =A0 =A0eth1 =A0 =A0 =A04.00 =A0 =A0 =A02.00 =A0 =A0 =A0=
0.41 =A0 =A0 =A00.26
> 0.00 =A0 =A0 =A00.00 =A0 =A0 =A00.00
>
> it seems OSD didn't do write, so result in client can not go on writi=
ng.
> from the osd log, the scrub loadavg is very high:
> 2011-07-04 09:25:52.163742 7f0b56f2c700 osd0 2 tick
> 2011-07-04 09:25:52.163788 7f0b56f2c700 osd0 2 scrub_should_schedule
> loadavg 2 >=3D max 0.5 =3D no, load too high
> 2011-07-04 09:25:52.163804 7f0b56f2c700 osd0 2 do_mon_report
> 2011-07-04 09:25:52.163819 7f0b56f2c700 osd0 2 send_alive up_thru
> currently 0 want 0
> 2011-07-04 09:25:52.163833 7f0b56f2c700 osd0 2 send_pg_stats
> 2011-07-04 09:25:52.782851 7f0b4d517700 osd0 2 update_osd_stat
> osd_stat(11363 MB used, 2986 MB avail, 15118 MB total, peers []/[])
> 2011-07-04 09:25:52.782887 7f0b4d517700 osd0 2 heartbeat:
> stat(2011-07-04 09:25:52.782813 oprate=3D0.339098 qlen=3D0 recent_qle=
n=3D0
> rdlat=3D0 / 0 fshedin=3D0)
> 2011-07-04 09:25:52.782902 7f0b4d517700 osd0 2 heartbeat:
> osd_stat(11363 MB used, 2986 MB avail, 15118 MB total, peers []/[])
> 2011-07-04 09:25:53.012934 7f0b51f22700 FileStore: sync_entry timed
> out after 600 seconds.
> 2011-07-04 09:25:53.012969 1: (SafeTimer::timer_thread()+0x311) [0x60=
28d1]
> 2011-07-04 09:25:53.012976 2: (SafeTimerThread::entry()+0xd) [0x604f3=
d]
> 2011-07-04 09:25:53.012985 3: (()+0x68ba) [0x7f0b5bba78ba]
> 2011-07-04 09:25:53.012992 4: (clone()+0x6d) [0x7f0b5a80302d]
> 2011-07-04 09:25:53.012997 *** Caught signal (Aborted) **
> =A0in thread 0x7f0b51f22700
>
> i'd like to know, does scrub workload too high results in OSD abort?
> and why we design scrub here ? to protect the consistence of PG?

That error only occurs when 10 minutes go past without any activity.
It seems unlikely that any amount of scrubbing could cause the
filesystem to pause for that long. Are there any backtraces from btrfs
in the syslog? Also, you might try mounting the btrfs filesystem
yourself to see if it works for you.

regards,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
