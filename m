From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: leveldb compaction overhead
Date: Fri, 31 May 2013 15:31:26 -0600
Message-ID: <51A916AE.9010700@sandia.gov>
References: <alpine.DEB.2.00.1305291406080.16097@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:44075 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab3EaVcC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 17:32:02 -0400
In-Reply-To: <alpine.DEB.2.00.1305291406080.16097@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

On 05/29/2013 03:07 PM, Sage Weil wrote:
> Hi all-
> 
> I have a couple of branches (wip-5176 and wip-5176-cuttlefish) that try to 
> make the leveldb compaction on the monitor less expensive by doing it in 
> an async thread and compaction only the trimmed range.  If anyone who is 
> experience high monitor io on cuttlefish would like to test it out, 
> feedback on whether/how much it improves things would be much appreciated!

I've been flogging wip-5176-cuttlefish merged into recent cuttlefish
branch (commit 02ef6e918e), and the result has been very stable for
me.  I've been testing OSD reweights, and so have been getting lots
of pgmap updates, and lots of data movement.

I'm no longer seeing stalls, and I see much less data movement
on the monitor hosts.  I haven't seen any monitors drop out
and rejoin, which had been a regular occurrence for me.
I stopped a mon and reinitialized it, and it resync'ed in 
just a few minutes, which is also a big improvement.

This is all with 128K PGs - next week I'll try much higher
PG counts.

Thanks a bunch for these fixes - they are working great
for me!

Thanks -- Jim

> 
> Thanks-
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


