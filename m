From: Laurent GUERBY <laurent@guerby.net>
Subject: Re: Help on ext4/xattr linux kernel stability issue / ceph xattr
 use?
Date: Mon, 09 Nov 2015 15:19:37 +0100
Message-ID: <1447078777.2019.587.camel@guerby.net>
References: <1447062090.2019.557.camel@guerby.net>
	 <alpine.DEB.2.00.1511090522470.27153@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.tetaneutral.net ([91.224.149.83]:44260 "EHLO
	mx1.tetaneutral.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbbKIOTl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 09:19:41 -0500
In-Reply-To: <alpine.DEB.2.00.1511090522470.27153@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 2015-11-09 at 05:24 -0800, Sage Weil wrote:
> The above is all correct.  The mbcache (didn't know that existed!) is 
> definitely not going to be useful here.
> > Also I think it is necessary to warn ceph users to avoid ext4 at all
> > costs until this kernel/ceph issue is sorted out: we went from
> > relatively stable production for more than a year to crashes everywhere
> > all the time since two weeks ago, probably after hitting some magic
> > limit. We migrated our machines to ubuntu trusty, our SSD based
> > filesystem to XFS but our HDD are still mostly on ext4 (60 TB
> > of data to move so not that easy...).
> 
> Was there a ceph upgrade in there somewhere?  The size of the user.ceph._ 
> xattr has increased over time, and (somewhat) recently crossed the 255 
> byte threshold (on average) which also triggered a performance regression 
> on XFS...


Hi Sage,

Thanks for the confirmation.

The history of our cluster is:
- initial cluster on ceph 0.80.7 (september 2014)
debian ext4 since xfs and btrfs were crashing on debian/ceph 
- upgraded to 0.87 (december 2014)
- upgraded to 0.94.2 (june 2015)
- on october 26 2015 we got two disk failures in one night, we replaced
the disks but we started to have random machine freeze during
and after the recovery. We upgraded to 0.94.5 to be able to restart
two of our OSD due to:
http://tracker.ceph.com/issues/13594
- after changing various hardware part, adding new machine
we started to suspect ceph/ext4 so we migrated all
our machines to ubuntu trusty and all SSD to XFS leaving
60 TB of data on rotational ext4 (too long to migrate)

During the whole time cluster and data kept expanding
from 4 machines and 2 TB to 11 machines now and 60TB of data
(~ 75% full).

I have lightly tested a rebuild of the ubuntu trusty 3.19
kernel with the ext4 mbcache code removed, patch here:
https://bugzilla.kernel.org/show_bug.cgi?id=107301#c6

But now we have to decide wether to go live with it.

Sincerely,

Laurent

