From: Sage Weil <sweil@redhat.com>
Subject: Re: issue #8752 (inconsistent PGs on RBD caching pool)
Date: Thu, 2 Oct 2014 08:28:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410020824060.14393@cobra.newdream.net>
References: <alpine.DEB.2.00.1409191642270.19460@cobra.newdream.net> <1545276.B1zDlULSSV@debstor> <alpine.DEB.2.00.1409211900410.27396@cobra.newdream.net> <3415192.gCaj5vu5sy@debstor>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50709 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbaJBP2Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Oct 2014 11:28:16 -0400
In-Reply-To: <3415192.gCaj5vu5sy@debstor>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dmitry Smirnov <onlyjob@debian.org>
Cc: ceph-devel@vger.kernel.org

On Thu, 2 Oct 2014, Dmitry Smirnov wrote:
> On Sun, 21 Sep 2014 19:01:52 Sage Weil wrote:
> > This is one we have never seen in our QA environment, and no real leads.
> 
> I'm much surprised about this... Is it really that unusual to use replicated 
> caching pool in front of RBD erasure pool? All my OSDs are Btrfs-based and 
> recently I've upgraded all kernels (i.e. kernel RBD clients) to 3.16.3.

My guess is a btrfs issue.  The weird thing about your report is the byte 
totals are off by an uneven number of bytes (3 bytes, 9 bytes, etc.).  
We haven't ever seen this.  We do test RBD over cache tiers on btrfs, 
but not with EC on the base.  I'll add that combo to the matrix.  My first 
guess is a btrfs issue, honestly.

> Unlike some shifty issues that may be hard to replicate this particular one 
> was very persistent and noticeable, no effort to reproduce at all. I've been  
> observing it for several months already...

Does it continue to come up after the kernels are upgraded (and after a 
full cycle of scrub and repairs have been done to clear out 
inconsistencies introduced while running the older kernel)?

sage

> It is unlikely that I have anything special in my v0.80.5 cluster's 
> configuration...
>
> > There are a couple slightly different scrub issues that pop up
> > occasionally that we are trying to nail down, but this one is a bit
> > different.  Being able to reliably reproduce it and generate logs is the
> > usual strategy...
> 
> Please advise what kind of logs could be useful. Something like "(debug ms = 
> 1, debug osd = 20)" from primary OSD where inconsistent PG lies at a time when 
> "scrub" command is given?
> 
> Thanks.
> 
> -- 
> All the best,
>  Dmitry Smirnov.
> 
