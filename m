From: Sage Weil <sage@inktank.com>
Subject: Re: extreme ceph-osd cpu load for rand. 4k write
Date: Thu, 8 Nov 2012 07:01:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211080658560.11845@cobra.newdream.net>
References: <509AC772.5010606@profihost.ag> <509BC878.3090804@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57533 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427Ab2KHPBF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 10:01:05 -0500
In-Reply-To: <509BC878.3090804@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 8 Nov 2012, Stefan Priebe - Profihost AG wrote:
> Is there any way to find out why a ceph-osd process takes around 10 times more
> load on rand 4k writes than on 4k reads?

Something like perf or oprofile is probably your best bet.  perf can be 
tedious to deploy, depending on where your kernel is coming from.  
oprofile seems to be deprecated, although I've had good results with it in 
the past.

 would love to see where the CPU is spending most of it's time.  This is 
on current master?  I expect there are still some low-hanging fruit that 
can bring CPU utilization down (or even boost iops).

sage



> 
> Stefan
> 
> Am 07.11.2012 21:41, schrieb Stefan Priebe:
> > Hello list,
> > 
> > whiling benchmarking i was wondering, why the ceph-osd load is so
> > extreme high while having random 4k write i/o.
> > 
> > Here an example while benchmarking:
> > 
> > random 4k write: 16.000 iop/s 180% CPU Load in top from EACH ceph-osd
> > process
> > 
> > random 4k read: 16.000 iop/s 19% CPU Load in top from EACH ceph-osd process
> > 
> > seq 4M write: 800MB/s 14% CPU Load in top from EACH ceph-osd process
> > 
> > seq 4M read: 1600MB/s 9% CPU Load in top from EACH ceph-osd process
> > 
> > I can't understand why in this single case the load is so EXTREMELY high.
> > 
> > Greets
> > Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
