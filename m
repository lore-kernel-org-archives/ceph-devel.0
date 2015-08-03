From: Samuel Just <sjust@redhat.com>
Subject: Re: [ceph-users] Inconsistent PGs that ceph pg repair does not fix
Date: Mon, 3 Aug 2015 12:38:07 -0700
Message-ID: <CAN=+7FUucyFUEm--jkGZWUULFGS7NHGApOG5x=wK7SM0OqTv=g@mail.gmail.com>
References: <D1E53A36.8DB6%apataki@simonsfoundation.org>
	<D1E53B6A.8DC6%apataki@simonsfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33770 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbbHCTiH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 15:38:07 -0400
Received: by oig1 with SMTP id 1so42252581oig.0
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2015 12:38:07 -0700 (PDT)
In-Reply-To: <D1E53B6A.8DC6%apataki@simonsfoundation.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andras Pataki <apataki@simonsfoundation.org>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hrm, that's certainly supposed to work.  Can you make a bug?  Be sure
to note what version you are running (output of ceph-osd -v).
-Sam

On Mon, Aug 3, 2015 at 12:34 PM, Andras Pataki
<apataki@simonsfoundation.org> wrote:
> Summary: I am having problems with inconsistent PG's that the 'ceph pg
> repair' command does not fix.  Below are the details.  Any help would be
> appreciated.
>
> # Find the inconsistent PG's
> ~# ceph pg dump | grep inconsistent
> dumped all in format plain
> 2.439 42080 00 017279507143 31033103 active+clean+inconsistent2015-08-03
> 14:49:17.29288477323'2250145 77480:890566 [78,54]78 [78,54]78
> 77323'22501452015-08-03 14:49:17.29253877323'2250145 2015-08-03
> 14:49:17.292538
> 2.8b9 40830 00 016669590823 30513051 active+clean+inconsistent2015-08-03
> 14:46:05.14006377323'2249886 77473:897325 [7,72]7 [7,72]7
> 77323'22498862015-08-03 14:22:47.83406377323'2249886 2015-08-03
> 14:22:47.834063
>
> # Look at the first one:
> ~# ceph pg deep-scrub 2.439
> instructing pg 2.439 on osd.78 to deep-scrub
>
> # The logs of osd.78 show:
> 2015-08-03 15:16:34.409738 7f09ec04a700  0 log_channel(cluster) log [INF] :
> 2.439 deep-scrub starts
> 2015-08-03 15:16:51.364229 7f09ec04a700 -1 log_channel(cluster) log [ERR] :
> deep-scrub 2.439 b029e439/10000022d93.00000f0c/head//2 on disk data digest
> 0xb3d78a6e != 0xa3944ad0
> 2015-08-03 15:16:52.763977 7f09ec04a700 -1 log_channel(cluster) log [ERR] :
> 2.439 deep-scrub 1 errors
>
> # Finding the object in question:
> ~# find ~ceph/osd/ceph-78/current/2.439_head -name 10000022d93.00000f0c* -ls
> 21510412310 4100 -rw-r--r--   1 root     root      4194304 Jun 30 17:09
> /var/lib/ceph/osd/ceph-78/current/2.439_head/DIR_9/DIR_3/DIR_4/DIR_E/10000022d93.00000f0c__head_B029E439__2
> ~# md5sum
> /var/lib/ceph/osd/ceph-78/current/2.439_head/DIR_9/DIR_3/DIR_4/DIR_E/10000022d93.00000f0c__head_B029E439__2
> 4e4523244deec051cfe53dd48489a5db
> /var/lib/ceph/osd/ceph-78/current/2.439_head/DIR_9/DIR_3/DIR_4/DIR_E/10000022d93.00000f0c__head_B029E439__2
>
> # The object on the backup osd:
> ~# find ~ceph/osd/ceph-54/current/2.439_head -name 10000022d93.00000f0c* -ls
> 6442614367 4100 -rw-r--r--   1 root     root      4194304 Jun 30 17:09
> /var/lib/ceph/osd/ceph-54/current/2.439_head/DIR_9/DIR_3/DIR_4/DIR_E/10000022d93.00000f0c__head_B029E439__2
> ~# md5sum
> /var/lib/ceph/osd/ceph-54/current/2.439_head/DIR_9/DIR_3/DIR_4/DIR_E/10000022d93.00000f0c__head_B029E439__2
> 4e4523244deec051cfe53dd48489a5db
> /var/lib/ceph/osd/ceph-54/current/2.439_head/DIR_9/DIR_3/DIR_4/DIR_E/10000022d93.00000f0c__head_B029E439__2
>
> # They don't seem to be different.
> # When I try repair:
> ~# ceph pg repair 2.439
> instructing pg 2.439 on osd.78 to repair
>
> # The osd.78 logs show:
> 2015-08-03 15:19:21.775933 7f09ec04a700  0 log_channel(cluster) log [INF] :
> 2.439 repair starts
> 2015-08-03 15:19:38.088673 7f09ec04a700 -1 log_channel(cluster) log [ERR] :
> repair 2.439 b029e439/10000022d93.00000f0c/head//2 on disk data digest
> 0xb3d78a6e != 0xa3944ad0
> 2015-08-03 15:19:39.958019 7f09ec04a700 -1 log_channel(cluster) log [ERR] :
> 2.439 repair 1 errors, 0 fixed
> 2015-08-03 15:19:39.962406 7f09ec04a700  0 log_channel(cluster) log [INF] :
> 2.439 deep-scrub starts
> 2015-08-03 15:19:56.510874 7f09ec04a700 -1 log_channel(cluster) log [ERR] :
> deep-scrub 2.439 b029e439/10000022d93.00000f0c/head//2 on disk data digest
> 0xb3d78a6e != 0xa3944ad0
> 2015-08-03 15:19:58.348083 7f09ec04a700 -1 log_channel(cluster) log [ERR] :
> 2.439 deep-scrub 1 errors
>
> The inconsistency is not fixed.  Any hints of what should be done next?
> I have tried  a few things:
>  * Stop the primary osd, remove the object from the filesystem, restart the
> OSD and issue a repair.  It didn't work - it sais that one object is
> missing, but did not copy it from the backup.
>  * I tried the same on the backup (remove the file) - it also didn't get
> copied back from the primary in a repair.
>
> Any help would be appreciated.
>
> Thanks,
>
> Andras
> apataki@simonsfoundation.org
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
