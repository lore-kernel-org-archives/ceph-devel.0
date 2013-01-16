From: Sage Weil <sage@inktank.com>
Subject: Re: 8 out of 12 OSDs died after expansion on 0.56.1 (void
 OSD::do_waiters())
Date: Wed, 16 Jan 2013 10:03:59 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301161003210.27925@cobra.newdream.net>
References: <50F6CD90.3070007@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46607 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab3APSEA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 13:04:00 -0500
In-Reply-To: <50F6CD90.3070007@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Wido,

Do you have any logs leading up to the crash?  I'm hoping the last message 
was osd_map, in which case I can explain this.. but let me know.

http://tracker.newdream.net/issues/3816

Thanks!
sage


On Wed, 16 Jan 2013, Wido den Hollander wrote:

> Hi,
> 
> I'm testing a small Ceph cluster with Asus C60M1-1 mainboards.
> 
> The setup is:
> - AMD Fusion C60 CPU
> - 8GB DDR3
> - 1x Intel 520 120GB SSD (OS + Journaling)
> - 4x 1TB disk
> 
> I had two of these systems running, but yesterday I wanted to add a third one.
> 
> So I had 8 OSDs (one per disk) running on 0.56.1 and I added one host bringing
> the total to 12.
> 
> The cluster came into a degraded state (about 50%) and it started to recover
> until it reached somewhere about 48%
> 
> In a manner of about 5 minutes all the original 8 OSDs had crashed with the
> same backtrace:
> 
>     -1> 2013-01-15 17:20:29.058426 7f95a0fd8700 10 --
> [2a00:f10:113:0:6051:e06c:df3:f374]:6803/4913 reaper done
>      0> 2013-01-15 17:20:29.061054 7f959cfd0700 -1 osd/OSD.cc: In function
> 'void OSD::do_waiters()' thread 7f959cfd0700 time 2013-01-15 17:20:29.057714
> osd/OSD.cc: 3318: FAILED assert(osd_lock.is_locked())
> 
>  ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
>  1: (OSD::do_waiters()+0x2c3) [0x6251f3]
>  2: (OSD::ms_dispatch(Message*)+0x1c4) [0x62d714]
>  3: (DispatchQueue::entry()+0x349) [0x8ba289]
>  4: (DispatchQueue::DispatchThread::entry()+0xd) [0x8137cd]
>  5: (()+0x7e9a) [0x7f95a95dae9a]
>  6: (clone()+0x6d) [0x7f95a805ecbd]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
> 
> So osd.0 - osd.7 were down and osd.8 - osd.11 (the new ones) were still
> running happily.
> 
> I have to note that during this recovery the load of the first two machines
> spiked to 10 and the CPUs were 0% idle.
> 
> This morning I started all the OSDs again with a default loglevel since I
> don't want to stress the CPUs even more.
> 
> I know the C60 CPU is kind of limited, but it's a test-case!
> 
> The recovery started again and it showed about 90MB/sec (Gbit network) coming
> into the new node.
> 
> After about 4 hours the recovery successfully completed:
> 
> 736 pgs: 1736 active+clean; 837 GB data, 1671 GB used, 9501 GB / 11172 GB
> avail
> 
> Now, there was no high logging level on the OSDs prior to their crash, I only
> have the default logs.
> 
> And nothing happened after I started them again, all 12 are up now.
> 
> Is this a known one? If not, I'll file a bug in the tracker.
> 
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
