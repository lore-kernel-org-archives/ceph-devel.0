From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: pg balancing
Date: Wed, 5 Jun 2013 13:49:21 -0600
Message-ID: <51AF9641.60403@sandia.gov>
References: <alpine.DEB.2.00.1305131730380.10961@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:48943 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757088Ab3FETtt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jun 2013 15:49:49 -0400
In-Reply-To: <alpine.DEB.2.00.1305131730380.10961@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

On 05/13/2013 06:35 PM, Sage Weil wrote:
> Hi Jim-
> 
> You mentioned the other day your concerns about the uniformity of the PG 
> and data distribution.  There are several ways to attack it (including 
> increasing the number of PGs), but one that we haven't tested much yet is 
> the 'reweight-by-utilization' function in the monitor.
> 
> The idea is that there will always be some statistical variance in the 
> distribution and a non-zero probability of having outlier OSDs with too 
> many PG.  We adjust for this by taking nodes that are substantially above 
> the mean down by some adjustment factor in an automated way.
> 
>  ceph osd reweight-by-utilization MIN
> 
> where MIN is the minimum relative utilization at which we will start 
> adjusting down.  It is always > 100 (100% of the mean), and defaults to 
> 120.  After it adjusts the reweights, you should see the result in 'ceph 
> osd tree' output
> 
> Have you played with this at all on your cluster?  I'd be very interested 
> in how well this does/does not improve things for you.

I've been experimenting with re-weighting, and have found that
it works well to redistribute data, as you expected.

Here's a few observations:

- when an OSD goes out and comes back in, its weight gets reset
    to 1.  It would be nice if it could remember its old weight.

- in order to reach the data distribution uniformity I'm after, I
    need to run multiple iterations of re-weighting - each iteration
    pushes data off the most highly utilized OSDs, but some ends up
    on average OSDs and pushes them over the limit.

- as you expected, to reach the uniformity I'm after, a _lot_ of data
    needs to move.  I've got some scripts I'm using to generate 
    'ceph osd reweight OSD WEIGHT' commands based on PG distribution,
    and I can use these after I create a new filesystem, to get a
    suitably uniform PG distribution before there is any data to
    move.  Some iteration is required here as well, and this is
    working really well for me.  When I start writing data to such
    a re-weighted filesystem, the data distribution pretty closely
    mirrors the PG distribution (once you write enough data).

- re-weighting to get a more uniform data distribution works better
    if there are more PGs to work with.  At 576 OSDs, I can't quite
    get things as uniform as I'd like with 64K PGs, but I can with
    128K PGs.  FWIW, here's the (max PGs/OSD)/(min PGs/OSD) I've
    measured for various numbers of PGs on 576 OSDs, with no
    re-weighting:

        PGs     (max PGs/OSD) / (min PGs/OSD)
 
        65536               1.478
       131073               1.308
       262144               1.240
       524288               1.155
      1048576               1.105

    (BTW, your recent leveldb work enabled those 512K and 1M
    measurements.  Thanks!)

    With 128K PGs and iterative re-weighting, I can get
    (max PGs/OSD)/(min PGs/OSD) < 1.05, and after writing
    enough data to consume ~33% of available storage, I
    get (max OSD data use)/(min OSD data use) ~ 1.06.
    OSD weights end up in the 0.85 - 1.0 range for such a
    distribution.

So, re-weighting is definitely working for me.

-- Jim

> 
> Thanks!
> sage
> 
> 
> 


