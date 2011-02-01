From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Long time to start the ceph osd and mount
Date: Tue, 1 Feb 2011 18:01:03 +1300
Message-ID: <AANLkTikmrQWpYL6PhqB9w29jD=TKQQ1-U5sr0JNe=x=r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:45462 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab1BAFBN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Feb 2011 00:01:13 -0500
Received: by qwa26 with SMTP id 26so6291125qwa.19
        for <ceph-devel@vger.kernel.org>; Mon, 31 Jan 2011 21:01:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm using the unstable version dated 20th-Jan.

When I was starting up multiple OSDs, e.g., 3 or more.
iostat shows, after the start, the OSDs utilizes to 100% themselves
(there's not much of traffic going on)

If I tried to mount during this time, it fails; 'can't read superblock'
So I have to wait until all of the OSDs become 0% utilized.
here's the output of ceph -w

2011-02-02 04:29:23.183819    pg v13: 6168 pgs: 6168 peering; 0 KB
data, 716 MB used, 5221 GB / 5501 GB avail
2011-02-02 04:29:23.194341   mds e3: 1/1/1 up {0=up:creating}
2011-02-02 04:29:23.194374   osd e7: 3 osds: 3 up, 3 in
2011-02-02 04:29:23.194423   log 2011-02-02 04:29:01.883344 mon0
192.168.1.4:6789/0 5 : [INF] mds? 192.168.1.4:6800/10998 up:boot
2011-02-02 04:29:23.194464   mon e1: 1 mons at {0=192.168.1.4:6789/0}
2011-02-02 04:29:25.474455    pg v14: 6168 pgs: 6168 peering; 0 KB
data, 806 MB used, 5221 GB / 5501 GB avail
2011-02-02 04:30:58.974502    pg v15: 6168 pgs: 6168 peering; 0 KB
data, 903 MB used, 5221 GB / 5501 GB avail
2011-02-02 04:32:06.375210    pg v16: 6168 pgs: 830 active+clean, 5338
peering; 0 KB data, 913 MB used, 5221 GB / 5501 GB avail
2011-02-02 04:32:06.720736    pg v17: 6168 pgs: 1764 active+clean,
4404 peering; 0 KB data, 915 MB used, 5221 GB / 5501 GB avail
2011-02-02 04:32:09.138013    pg v18: 6168 pgs: 2412 active+clean,
3756 peering; 0 KB data, 921 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:32:10.031244    pg v19: 6168 pgs: 2412 active+clean,
3756 peering; 2 KB data, 921 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:32:11.608600    pg v20: 6168 pgs: 3682 active+clean,
2486 peering; 3 KB data, 929 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:32:14.107651    pg v21: 6168 pgs: 3682 active+clean,
2486 peering; 4 KB data, 931 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:32:15.575727    pg v22: 6168 pgs: 3682 active+clean,
2486 peering; 10 KB data, 942 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:32:49.358811    pg v23: 6168 pgs: 4834 active+clean,
1334 peering; 16 KB data, 974 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:33:01.284383    pg v24: 6168 pgs: 4834 active+clean,
1334 peering; 18 KB data, 974 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:33:05.508232    pg v25: 6168 pgs: 6168 active+clean; 20
KB data, 995 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:33:07.807677    pg v26: 6168 pgs: 6168 active+clean; 24
KB data, 1005 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:33:18.614125   mds e4: 1/1/1 up {0=up:active}
2011-02-02 04:33:18.916440   log 2011-02-02 04:33:18.613981 mon0
192.168.1.4:6789/0 6 : [INF] mds0 192.168.1.4:6800/10998 up:active
2011-02-02 04:33:26.166186    pg v27: 6168 pgs: 6168 active+clean; 24
KB data, 1047 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:33:27.292841    pg v28: 6168 pgs: 6168 active+clean; 24
KB data, 1086 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:34:13.770478    pg v29: 6168 pgs: 6168 active+clean; 24
KB data, 1102 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:36:13.811773    pg v30: 6168 pgs: 6168 active+clean; 24
KB data, 1106 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:38:13.820139    pg v31: 6168 pgs: 6168 active+clean; 24
KB data, 1107 MB used, 5220 GB / 5501 GB avail
2011-02-02 04:38:21.756720    pg v32: 6168 pgs: 6168 active+clean; 24
KB data, 1107 MB used, 5220 GB / 5501 GB avail

so between 29 to 38 (about 10 minutes) I cannot mount or it fails, and
it seemed to cause the 'degrading'.
I made sure before restarting ceph (using 'stop.sh all'), the the OSDs
are empty (deleted all files, remount clean), as well as cephlog
directories, anymore to clean.

Also, Is there a way to increase some pagelimit or disk IO to max out
the performance? any known issue?
For example, just using 2 SSDs at 1x normal (no)replication, I can max
out the link (using dd), including all the way to 6 (all maxed) , but
when set at 2x, no increase I see, and slowly increases to max link
speed by 6 SSDs.
The SSDs are already fast enough to do all kinds of replication IO
workloads, and so I don't understand given that there's virtually no
CPU bottleneck I see.
It seems that there's a clear bottleneck somewhere in the system, more
like a system configuration issue.? I don't see MDS/MON use any
significant amount of process or memory.


Any suggestions?

Thanks a lot
