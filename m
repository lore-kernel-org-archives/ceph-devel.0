From: Sage Weil <sage@inktank.com>
Subject: Re: OSD Hardware questions
Date: Thu, 28 Jun 2012 08:33:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206280831590.32016@cobra.newdream.net>
References: <5d5b400b-c2b4-4bce-9231-b412ce1aff03@mailpro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49861 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab2F1Pde (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 11:33:34 -0400
In-Reply-To: <5d5b400b-c2b4-4bce-9231-b412ce1aff03@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>

On Thu, 28 Jun 2012, Alexandre DERUMIER wrote:
> Hi,
> maybe it can help, I'm doing same tests that stefan, 
> random write  with 4K with 3 nodes with 5 osds (with 15K drives)
> fio --filename=[disk] --direct=1 --rw=randwrite --bs=4k --size=100M --numjobs=50 --runtime=30 --group_reporting --name=file1 
> 
> I can achieve 5500io/s (disks are not at 100%)
> 
> cpu is around 30%idle ( 8 cores E5420  @ 2.50GHz)

Have you tried adjusting 'osd op threads'?  The default is 2, but bumping 
that to, say, 8, might give you better concurrency and throughput.

"Mark Nelson" <mark.nelson@inktank.com> wrote:
> It would be interesting to see where all your CPU time is being spent. 
> What benchmark are you using to do the random writes? 

Definitely.  Seeing perf/oprofile/whatever results for the osd under that 
workload would be very interesting!  We need to get perf going in our 
testing environment...

sage
