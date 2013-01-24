From: Sage Weil <sage@inktank.com>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 13:48:13 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301241347120.13935@cobra.newdream.net>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com>
 <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com>
 <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <CAJH6TXhwBY+gTDDksCfMroDodeN1b8ttM7zjNc2tn5PXzYbcZg@mail.gmail.com> <51013D5F.7090105@bmrb.wisc.edu> <CAKMAVE9HMo4x3seuG7ppeafSRJmBwjUXrLv0GUA-z5kDXyhoQA@mail.gmail.com>
 <51015318.8000404@bmrb.wisc.edu> <51017A4D.2000901@inktank.com> <51018454.1050101@bmrb.wisc.edu> <5101A275.5070408@inktank.com> <5101AB96.6030708@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40886 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab3AXVsN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 16:48:13 -0500
In-Reply-To: <5101AB96.6030708@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: Dan Mick <dan.mick@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, john.wilkins@inktank.com, sam.lang@inktank.com

On Thu, 24 Jan 2013, Dimitri Maziuk wrote:
> On 01/24/2013 03:07 PM, Dan Mick wrote:
> ...
> > Yeah; it's probably mostly just that one-OSD configurations are so
> > uncommon that we never special-cased that small user set.  Also, you can
> > run with a cluster in that state forever (well, until that one OSD dies
> > at least); I do that regularly with the default vstart.sh local test
> > cluster
> 
> Well, this goes back to the quick start guide: to me a more natural way
> to start is with one host, then add another. That's what I was trying to
> do, however, the quick start page ends with
> 
> "When your cluster echoes back HEALTH_OK, you may begin using Ceph."
> 
> and that doesn't happen with one host: you get "384 pgs stuck unclean"
> instead of "HEALTH_OK". To me that means I may *not* begin using ceph.
> 
> I did run "ceph osd pool set ... size 1" on each of the 3 default pools,
> verified that it took with "ceph osd dump | grep 'rep size'", and gave
> it a good half hour to settle. I still got "384 pgs stuck unclean" from
> "ceph health".
> 
> So I re-done it with 2 OSDs and got the expected HEALTH_OK right from
> the start.
> 
> John,
> 
> a) a note saying "if you have only one OSD you won't get HEALTH_OK until
> you add another one; you can start using the cluster" may be a useful
> addition to the quick start,
> 
> b) more importantly, if there are any plans to write more quickstart
> pages, I'd love to see the "add another OSD (MDS, MON) to an existing
> pool in 5 minutes".

There may be a related issue at work here: the default crush rules now 
replicate across hosts instead of across osds, so single-host configs may 
have similar problems (depending on whether you used mkcephfs to create 
the cluster or not).

sage
