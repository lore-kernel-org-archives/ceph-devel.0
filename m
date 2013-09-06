From: Sage Weil <sage@inktank.com>
Subject: Re: OSD crash during repair
Date: Fri, 6 Sep 2013 08:21:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309060815320.2805@cobra.newdream.net>
References: <20130906000409.GA10181@onthe.net.au> <alpine.DEB.2.00.1309051937410.6929@cobra.newdream.net> <20130906025004.GA15642@onthe.net.au> <alpine.DEB.2.00.1309051952200.6929@cobra.newdream.net> <20130906031221.GA16201@onthe.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42356 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab3IFPVH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Sep 2013 11:21:07 -0400
In-Reply-To: <20130906031221.GA16201@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

On Fri, 6 Sep 2013, Chris Dunlop wrote:
> On Thu, Sep 05, 2013 at 07:55:52PM -0700, Sage Weil wrote:
> > On Fri, 6 Sep 2013, Chris Dunlop wrote:
> >> Hi Sage,
> >> 
> >> Does this answer your question?
> >> 
> >> 2013-09-06 09:30:19.813811 7f0ae8cbc700  0 log [INF] : applying configuration change: internal_safe_to_start_threads = 'true'
> >> 2013-09-06 09:33:28.303658 7f0ae94bd700  0 log [ERR] : 2.12 osd.7: soid 56987a12/rb.0.17d9b.2ae8944a.000000001e11/head//2 extra attr _, extra attr snapset
> >> 2013-09-06 09:33:28.303685 7f0ae94bd700  0 log [ERR] : repair 2.12 56987a12/rb.0.17d9b.2ae8944a.000000001e11/head//2 no 'snapset' attr
> >> 2013-09-06 09:34:45.138468 7f0ae94bd700  0 log [ERR] : 2.12 repair stat mismatch, got 2722/2723 objects, 339/339 clones, 11307104768/11311299072 bytes.
> >> 2013-09-06 09:34:45.142215 7f0ae94bd700  0 log [ERR] : 2.12 repair 0 missing, 1 inconsistent objects
> >> 2013-09-06 09:34:45.206621 7f0ae94bd700 -1 *** Caught signal (Aborted) **
> >> 
> >> I've just attached the full 'debug_osd 0/10' log to the bug report.
> > 
> > This suggests to me that the object on osd.6 is missing those xattrs; can 
> > you confirm with getfattr -d on the in osd.6's data directory?
> 
> I haven't yet wrapped my head around how to translate an oid
> like those above into a underlying file system object. What 
> directory should I be looking at?

It's the osd.6 data directory (maybe /var/lib/ceph/osd/ceph-6, or 
whatever you configured), 
/currrent/$pgid_head/.../*rb.0.17d9b.2ae8944a.000000001e11*.
In your case $pgid is 2.12.  Do a 

 find . | grep rb.0.17d9b.2ae8944a.000000001e11

and you will see it pop up (with head in there along with some other 
stuff).  getfattr -d $file to confirm the user.ceph._ and 
user.ceph.snapset xattrs are missing.  I would also confirm that they are 
present on the same file in osd.7's data directory.  Maybe do a sanity 
check to make sure the objects otherwise look like the match (file size, 
md5sum, etc.).  Assuming osd.7 doesn't look obviously wrong (e.g., 0 
bytes or something), rename the bad osd.6 copy out of the way and let 
repair recover it for you.

Note that you might have to do repair twice to make the pg stats number 
reflect the just-repaired object.

> > If that is indeed the case, you should be able to move the object out of 
> > the way (don't delete it, just in case) and then do the repair.  The osd.6 
> > should recover by copying the object from osd.7 (which has the needed 
> > xattrs).  Bobtail is smart enough to recover missing objects but not to 
> > recover just missing xattrs.
> 
> Do you want me to hold off on any repairs to allow tracking down
> the crash, or is the current code sufficiently different that
> there's little point?

There is little point with bobtail.
 
> > Also, you should upgrade to dumpling.  :)
> 
> I've been considering it. It was initially a little scary with
> the various issues that were cropping up but that all seems to
> have quietened down.
> 
> Of course I'd like my cluster to be clean before attempting an upgrade!

Definitely.  Let us know how it goes! :)

sage
