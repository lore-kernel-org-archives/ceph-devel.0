From: Sage Weil <sage@newdream.net>
Subject: Re: Help on ext4/xattr linux kernel stability issue / ceph xattr
 use?
Date: Mon, 9 Nov 2015 05:24:14 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511090522470.27153@cobra.newdream.net>
References: <1447062090.2019.557.camel@guerby.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47888 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbKINYQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 08:24:16 -0500
In-Reply-To: <1447062090.2019.557.camel@guerby.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laurent GUERBY <laurent@guerby.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 9 Nov 2015, Laurent GUERBY wrote:
> Hi,
> 
> Part of our ceph cluster is using ext4 and we recently hit major kernel
> instability in the form of kernel lockups every few hours, issues
> opened:
> 
> http://tracker.ceph.com/issues/13662
> https://bugzilla.kernel.org/show_bug.cgi?id=107301
> 
> On kernel.org kernel developpers are asking about ceph usage of xattr,
> in particular wether there are lots of common xattr key/value or wether
> they are all differents.
> 
> I attached a file with various xattr -l outputs:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=107301#c8
> https://bugzilla.kernel.org/attachment.cgi?id=192491
> 
> Looks like the "big" xattr "user.ceph._" is always different, same for
> the intermediate size "user.ceph.hinfo_key".
> 
> "user.cephos.spill_out" and "user.ceph.snapset" seem to have small
> values, and within a small value set.
> 
> Our cluster is used exclusively for virtual machines block devices with
> rbd, on replicated (3) and erasure coded pools (4+1 and 8+2).
> 
> Could someone knowledgeable add some information on ceph use of xattr in
> the kernel.org bugzilla above?

The above is all correct.  The mbcache (didn't know that existed!) is 
definitely not going to be useful here.
 
> Also I think it is necessary to warn ceph users to avoid ext4 at all
> costs until this kernel/ceph issue is sorted out: we went from
> relatively stable production for more than a year to crashes everywhere
> all the time since two weeks ago, probably after hitting some magic
> limit. We migrated our machines to ubuntu trusty, our SSD based
> filesystem to XFS but our HDD are still mostly on ext4 (60 TB
> of data to move so not that easy...).

Was there a ceph upgrade in there somewhere?  The size of the user.ceph._ 
xattr has increased over time, and (somewhat) recently crossed the 255 
byte threshold (on average) which also triggered a performance regression 
on XFS...

sage

