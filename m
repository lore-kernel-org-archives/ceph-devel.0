From: Sage Weil <sage@inktank.com>
Subject: Re: Very unbalanced storage
Date: Tue, 4 Sep 2012 09:43:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209040939450.14139@cobra.newdream.net>
References: <50409BDC.5010006@gmail.com> <alpine.DEB.2.00.1208310904570.1531@cobra.newdream.net> <5041785E.3040707@gmail.com> <alpine.DEB.2.00.1208312000160.27708@cobra.newdream.net> <5041B204.7000008@aktzero.com> <CADvuQRGGE9hcqO+NevwTdj97hmUe2eCPCO6mBT5B-oon0zaODw@mail.gmail.com>
 <504629FB.30801@aktzero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40005 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757383Ab2IDQnL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 12:43:11 -0400
In-Reply-To: <504629FB.30801@aktzero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Thompson <andrewkt@aktzero.com>
Cc: Tommi Virtanen <tv@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 4 Sep 2012, Andrew Thompson wrote:
> On 9/4/2012 11:59 AM, Tommi Virtanen wrote:
> > On Fri, Aug 31, 2012 at 11:58 PM, Andrew Thompson <andrewkt@aktzero.com>
> > wrote:
> > > Looking at old archives, I found this thread which shows that to mount a
> > > pool as cephfs, it needs to be added to mds:
> > > 
> > > http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/5685
> > > 
> > > I started a `rados cppool data tempstore` a couple hours ago. When it
> > > finishes, will I need to remove the current pool from mds somehow(other
> > > than
> > > just deleting the pool)?
> > > 
> > > Is `ceph mds add_data_pool <poolname>` still required? (It's not listed in
> > > `ceph --help`.)
> > If the pool you are trying to grow pg_num for really is a CephFS data
> > pool, I fear a "rados cppool" is nowhere near enough to perform a
> > migration. My understanding is that each of the inodes stored in
> > cephfs/on ceph-mds'es knows what pool the file data resides in; you
> > shoveling the objects into another pool with "rados cppool" doesn't
> > change these pointers, removing the old pool will just break the
> > filesystem.
> > 
> > Before we go too far down this road: is your problem pool *really*
> > being use as a cephfs data pool? Based on how it's not named "data"
> > and you're just now asking about "ceph mds add_data_pool", it seems
> > that's not likely..
> 
> Well, I guess it's time to wipe this cluster and start over.
> 
> Yes, it was my `data` pool I was trying to grow. After renaming and removing
> the original data pool, I can `ls` my folders/files, but not access them.

Yeah.  Sorry I didn't catch this earlier, but TV is right: the ceph fs 
inodes refer to the data pool pool by id #, not by name, so the cppool 
trick won't work in the fs case.

> I attempted a tar backup beforehand, so unless it flaked out, I should be able
> to recover data.
> 
> I was concerned the small number of PGs created by default by mkcephfs would
> be an issue, so I was trying to up it a bit. I'm not going to have 100+ OSDs
> or petabytes of data. I just want a relatively safe place to store my files
> that I can easily extend as needed.

mkcephfs picks the pg_num by taking the initial osd count and shiftin 'osd 
pg bits' bits to the left.  Adjusting that (by default it is 6) in 
ceph.conf should give you larger initial pools.

> So far, I'm 0 and 5... I keep blowing up the filesystem, one way or another.

Sorry to hear that!  The pg splitting (i.e., online pg_num adjustment) is 
still the next major osd project on the roadmap, but we've been a bit 
sidetracked with performance these past few weeks.

sage


> 
> -- 
> Andrew Thompson
> http://aktzero.com/
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
