From: Sage Weil <sage@inktank.com>
Subject: Re: waiting for sub ops
Date: Sun, 13 May 2012 21:28:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205132124190.29887@cobra.newdream.net>
References: <4FACB96F.3050309@profihost.ag> <Pine.LNX.4.64.1205121714120.21796@cobra.newdream.net>
 <4FAFF7B0.2030400@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42761 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab2ENE25 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 00:28:57 -0400
In-Reply-To: <4FAFF7B0.2030400@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Sun, 13 May 2012, Stefan Priebe wrote:
> Hi Sage,
> 
> Am 13.05.2012 02:15, schrieb Sage Weil:
> > On Fri, 11 May 2012, Stefan Priebe - Profihost AG wrote:
> > > Hi,
> > > 
> > > while doing some stress testing with bonnie++ i'm seeing always these
> > > messages accross all osd's here is just an example for osd.2.
> > > 
> > > All machines are connected with 2x 1Gbit/s bonding mode 6 to a HP switch.
> > 
> > These are just telling you that some operations are taking>  30 seconds.
> > The 'waiting for sub ops' means that it is waiting for the write/update to
> > be acked by other replicas.  Either there is some load imbalance (some
> > osds are more busy than others), or everyone is similarly loaded and the
> > request queues are just long across the board.
> 
> mhm but there must be something wrong in my testsetup.
> 
> 1.) th osd bench shows 150MB/s per osd
> 2.) iperf shows constant 930Mbit/s per eth
> 3.) when i write 16GB with dd to the ceph mount i see spikes to 450Mbit/ and
> drops to 90kb/s for long periods of time. The overall dd speed is then
> 40Mbit/s

We were doing some btrfs performance testing this week and seeing similar 
bursty behavior.  (See my May 7th performance on btrfs email for some 
out-of-context detail.)  It currently looks like the workload we're 
presenting to the fs is resulting in non-optimal writeout, but we haven't 
figured out yet how we can improve that or nailed down the source for the 
burstiness.  How that some of the inktank launch stuff is out of the way 
we'll be picking it up again and continuing to work on that this week.

If you're interested in getting involved, ping nhm in #ceph.  It would be 
interesting to capture a block trace from your environment and see if 
what you're seeing is what we're seeing!

sage


> 4.) the speed drops to 90kb/s while seeing the
> "[WRN] slow request received at 2012-05-13 20:01:55.227811:
> osd_op(client.4102.1:38432 10000000004.000003ae [write 0~4194304] 0.5f4dfca8
> snapc 1=[]) currently waiting for sub ops"
> messages.
> 
> The client shows this in dmesg:
> [2012-05-13 19:55:26]  libceph:  tid 38132 timed out on osd2, will reset osd
> [2012-05-13 19:55:46]  libceph:  tid 38400 timed out on osd0, will reset osd
> [2012-05-13 19:56:31]  libceph:  tid 38886 timed out on osd2, will reset osd
> 
> greets and thanks
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
