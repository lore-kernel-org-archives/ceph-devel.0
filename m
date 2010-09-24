From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Re: Ceph, make (22nd-sept unstable) fails, and slow write issues.
Date: Fri, 24 Sep 2010 14:32:58 +1200
Message-ID: <AANLkTinPPeOwQ=DM4U+3OOF9iNUHLsPkeMtP8wGYj+2y@mail.gmail.com>
References: <AANLkTim6p641hc8OWudCtSiagwi1rC6n9ymjbUBJxDLQ@mail.gmail.com>
	<AANLkTi=QA5n0pXNzFGtHYY7n0tb0TgwskDZVM-1H=RM0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:9705 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960Ab0IXCdD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Sep 2010 22:33:03 -0400
Received: by ywh1 with SMTP id 1so815664ywh.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Sep 2010 19:32:58 -0700 (PDT)
In-Reply-To: <AANLkTi=QA5n0pXNzFGtHYY7n0tb0TgwskDZVM-1H=RM0@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

Hi all:

> Hmmm -- it looks like the scripts are split on whether you have
> tcmalloc installed in your system, and I don't see any obvious issues
> when I go over them. Do you have tcmalloc installed? Did you try a
> "make clean; make" cycle?

So I did make clean; make, but it still gave the error,, so I just
reverted back to 0.21.3 (master) and it compiled.
probably because the system had mixtures of ceph versions (not all
completely uninstalled), and something just went wrong... :-(
I think I should just remove entire 'ceph' filenames in the system and
do the fresh start again, because make clean worked in one of other
PC.


> Wow, these levels seem oddly slow. What filesystem are those disks running?
> What tool are you using to test IOPS, and what's your network setup?
> If you can move the journal onto a separate device it will help.
> -Greg
>

I have changed the OSD to SSD (OCZ Vertex2)
To simplify the problem, only one OSD is used,
so now,  3 PCs  - 1OSD, 1MDS, 1MON (all similar spec, except the OSD's
1TB disk replaced with 60GB SSD), using btrfs
all connected to 1G/s managed switch. Iperf gives about 980Mb/s

I ran dbench, on the OSD PC.
Local vs /ceph

using dbench -t 10 100 -D /data/osd0/
-  gives 150MB/s, good and as expected.

using dbench -t 10 100 -D /ceph
-  gives 15MB/s

The results were similar when I ran it from other PCs.

All I did was following the preliminary guide on the Wiki on starting up.
Do I supposed to further configure some settings? e.g., placements,
replications, crush, etc?

so this time, I've tried on a faster PC, E3110 2core @ 3.75Ghz (Intel
X48 chipset SATA 3Gbps), and ran all (OSD,MDS,MON) on PC, i.e.,
simplest setup possible

Local, gave 290MB/s (good!) (iostat ~ 100% use)
/ceph mount gave merely 34MB/s (again this is local) (iostat
utilization gives about 30% use)

CPU utilization was about 50%, 70% the highest..
So it sounds to me that the network configuration or PC isn't
bottlenecking, something else..

Also, I often get errors from dbench while benchmarking (only when
/ceph mounts, not elsewhere)

[323] unlink '/media/cephlocal/clients/client25/~dmtmp/WORD/CHAP10.DOC'
failed - No such file or directory
  52  cleanup  14 sec
  39  cleanup  15 sec
[323] unlink '/media/cephlocal/clients/client24/~dmtmp/WORDPRO/NEWS1_1.LWP'
failed - No such file or directory
[323] unlink '/media/cephlocal/clients/client91/~dmtmp/WORD/CHAP10.DOC'
failed - No such file or directory
[323] unlink '/media/cephlocal/clients/client27/~dmtmp/WORDPRO/RESULTS.XLS'
failed - No such file or directory

and

[31] open /media/cephlocal/clients/client258/filler.001 failed for
handle 9939 (No such file or directory)
[31] open /media/cephlocal/clients/client220/filler.001 failed for
handle 9939 (No such file or directory)
[111] open /media/cephlocal/clients/client218/~dmtmp/WORD failed for
handle 9943 (No such file or directory)
[91] open /media/cephlocal/clients/client986/filler.004 failed for
handle 9942 (No such file or directory)


possibly due to the files being corrupted or just don't exist anymore?

Thanks a lot
