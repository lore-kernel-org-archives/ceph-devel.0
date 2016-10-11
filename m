From: Sage Weil <sage@newdream.net>
Subject: Re: Single slow OSD can cause unfound object
Date: Tue, 11 Oct 2016 13:45:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610111340430.31080@piezo.us.to>
References: <ed8ed02e-4fb7-25ad-3a5f-d462f70409e2@sadziu.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-649248288-1476193527=:31080"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57800 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbcJKNp2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2016 09:45:28 -0400
In-Reply-To: <ed8ed02e-4fb7-25ad-3a5f-d462f70409e2@sadziu.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Pawe=B3_Sadowski?= <ceph@sadziu.pl>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-649248288-1476193527=:31080
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi Pawel,

On Tue, 11 Oct 2016, Paweł Sadowski wrote:
> Hi,
> 
> I managed to trigger unfound objects on a pool with size 3 and min_size
> 2 just by removing 'slow' OSD (out and then stop) which is quite
> frightening. Shouldn't Ceph stop IO if there is only one copy in this
> case (even during recovery/peering/etc)? I'm able to reproduce this on
> Hammer (0.94.5, 0.94.9) and Jewel (10.2.3). So far I wasn't able to
> trigger this behavior by just stopping such OSD (still testing).

This is definitely concerning.  I have a couple questions...

1. Looking at the log, I see that at one point all of the OSDs mark 
themselves down, here:

2016-10-11 08:46:23.473335 mon.0 10.99.128.50:6789/0 3275 : cluster [INF] 
osd.1 marked itself down

Do you know why they do that?

2. Are you throttling the CPU on just a single OSD, or on a whole host?  I 
also see that the monitors are calling elections.  (This shouldn't have 
anything to do with the problem, but I'm not sure I understand the test 
setup.)
 
> Second thing: throttling mechanism is blocking recovery operations/whole
> OSD[4] when there is a lot of client requests for missing objects. I
> think it shouldn't be like that.

Yeah, there is a similar problem with a PG is inactive and requests pile 
up, eventually preventing ops even on active PGs... and 'ceph tell $pgid 
query' admin commands.  It's non-trivial to fix, though: we need a way to 
inform the client that a PG or individual object is blocked so that they 
stop sending requests... and then also a way to inform them that the PG is 
unblocked so they can start again.

> 1: logs from Jewel
> https://gist.github.com/anonymous/c8618adca8984132c82f16c351222883

Do you mind reproducing this sequence with debug ms = 1, debug osd = 20, 
and capture all of the OSD logs as well as the cluster ceph.log?  You can 
send us the tarball with the ceph-post-file utility.

Thanks!
sage



> 2: steps to reproduce
>  - put some load on the cluster (run FIO with high iodepth)
>  - slow down single OSD (in my case reduce CPU time using cgroups:
> cpu.cfs_quota_us 15000)
>  - sleep 120
>  - ceph osd out 6
>  - sleep 15
>  - stop ceph-osd id=6
>  - unfound objects appear
> 
> This is not 100% reproducible but in my test lab (9 OSDs) I'm able to
> trigger this very easily.
> 
> 3:
> mon-01:~ # ceph osd pool get rbd size
> size: 3
> mon-01:~ # ceph osd pool get rbd min_size
> min_size: 2
> mon-01:~ # ceph --version
> ceph version 10.2.3 (ecc23778eb545d8dd55e2e4735b53cc93f92e65b)
> 
> 4:
> perf dump | grep -A 2 'throttle-osd_client_messages'
>     "throttle-osd_client_messages": {
>         "val": 100,
>         "max": 100,
> 
> ops_in_flight:
> https://gist.github.com/anonymous/643607fa3f959c91ba7a9794e5d99dea
> 
> 
> -- 
> PS
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-649248288-1476193527=:31080--
