From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Tue, 12 Apr 2016 09:56:32 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604120837120.29593@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com> <20160412083925.5106311d@batzmaru.gol.ad.jp> <alpine.DEB.2.11.1604112046570.29593@cpach.fuggernut.com> <20160412114341.098486f7@batzmaru.gol.ad.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41299 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932605AbcDLN4f (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Apr 2016 09:56:35 -0400
In-Reply-To: <20160412114341.098486f7@batzmaru.gol.ad.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Balzer <chibi@gol.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

Hi all,

I've posted a pull request that updates any mention of ext4 in the docs:

	https://github.com/ceph/ceph/pull/8556

In particular, I would appreciate any feedback on

	https://github.com/ceph/ceph/pull/8556/commits/49604303124a2b546e66d6e130ad4fa296602b01

both on substance and delivery.

Given the previous lack of clarity around ext4, and that it works well 
enough for RBD and other short object name workloads, I think the most we 
can do now is deprecate it to steer any new OSDs away.

And at least in the non-RGW case, I mean deprecate in the "recommend 
alternative" sense of the word, not that it won't be tested or that any 
code will be removed.

	https://en.wikipedia.org/wiki/Deprecation#Software_deprecation

If there are ext4 + RGW users, that is still a difficult issue, since it 
is broken now, and expensive to fix.


On Tue, 12 Apr 2016, Christian Balzer wrote:
> Only RBD on all clusters so far and definitely no plans to change that 
> for the main, mission critical production cluster. I might want to add 
> CephFS to the other production cluster at some time, though.

That's good to hear.  If you continue to use ext4 (by adjusting down the 
max object length), the only limitation you should hit is an indirect cap 
on the max RBD image name length.

> No RGW, but if/when RGW supports "listing objects quickly" (is what I
> vaguely remember from my conversation with Timo Sirainen, the Dovecot
> author) we would be very interested in that particular piece of Ceph as
> well. On a completely new cluster though, so no issue.

OT, but I suspect he was referring to something slightly different here.  
Our conversations about object listing vs the dovecot backend surrounded 
the *rados* listing semantics (hash-based, not prefix/name based).  RGW 
supports fast sorted/prefix name listings, but you pay for it by 
maintaining an index (which slows down PUT).  The latest RGW in Jewel has 
experimental support for a non-indexed 'blind' bucket as well for users 
that need some of the RGW features (ACLs, striping, etc.) but not the 
ordered object listing and other index-dependent features.

> Again, most people that deploy Ceph in a commercial environment (that is
> working for a company) will be under pressure by the penny-pinching
> department to use their HW for 4-5 years (never mind the pace of
> technology and Moore's law).
> 
> So you will want to:
> a) Announce the end of FileStore ASAP, but then again you can't really
> do that before BlueStore is stable.
> b) support FileStore for 4 years at least after BlueStore is the default. 
> This could be done by having a _real_ LTS release, instead of dragging
> Filestore into newer version.

Right.  Nothing can be done until the preferred alternative is completely 
stable, and from then it will take quite some time to drop support or 
remove it given the install base.

> > > Which brings me to the reasons why people would want to migrate (NOT
> > > talking about starting freshly) to bluestore.
> > > 
> > > 1. Will it be faster (IOPS) than filestore with SSD journals? 
> > > Don't think so, but feel free to prove me wrong.
> > 
> > It will absolutely faster on the same hardware.  Whether BlueStore on
> > HDD only is faster than FileStore HDD + SSD journal will depend on the 
> > workload.
> > 
> Where would the Journal SSDs enter the picture with BlueStore? 
> Not at all, AFAIK, right?

BlueStore can use as many as three devices: one for the WAL (journal, 
though it can be much smaller than FileStores, e.g., 128MB), one for 
metadata (e.g., an SSD partition), and one for data.

> I'm thinking again about people with existing HW again. 
> What do they do with those SSDs, which aren't necessarily sized in a
> fashion to be sensible SSD pools/cache tiers?

We can either use them for BlueStore wal and metadata, or as a cache for 
the data device (e.g., dm-cache, bcache, FlashCache), or some combination 
of the above.  It will take some time to figure out which gives the 
best performance (and for which workloads).

> > > 2. Will it be bit-rot proof? Note the deafening silence from the devs
> > > in this thread: 
> > > http://www.spinics.net/lists/ceph-users/msg26510.html
> > 
> > I missed that thread, sorry.
> > 
> > We (Mirantis, SanDisk, Red Hat) are currently working on checksum
> > support in BlueStore.  Part of the reason why BlueStore is the preferred
> > path is because we will probably never see full checksumming in ext4 or
> > XFS.
> > 
> Now this (when done correctly) and BlueStore being a stable default will
> be a much, MUCH higher motivation for people to migrate to it than
> terminating support for something that works perfectly well (for my use
> case at least).

Agreed.

> > > > How:
> > > > 
> > > > To make this change as visible as possible, the plan is to make
> > > > ceph-osd refuse to start if the backend is unable to support the
> > > > configured max object name (osd_max_object_name_len).  The OSD will
> > > > complain that ext4 cannot store such an object and refuse to start.
> > > > A user who is only using RBD might decide they don't need long file
> > > > names to work and can adjust the osd_max_object_name_len setting to
> > > > something small (say, 64) and run successfully.  They would be
> > > > taking a risk, though, because we would like to stop testing on ext4.
> > > > 
> > > > Is this reasonable?  
> > > About as reasonable as dropping format 1 support, that is not at all.
> > > https://www.mail-archive.com/ceph-users@lists.ceph.com/msg28070.html
> > 
> > Fortunately nobody (to my knowledge) has suggested dropping format 1 
> > support.  :)
> > 
> I suggest you look at that thread and your official release notes:
> ---
> * The rbd legacy image format (version 1) is deprecated with the Jewel release.
>   Attempting to create a new version 1 RBD image will result in a warning.
>   Future releases of Ceph will remove support for version 1 RBD images.
> ---

"Future releases of Ceph *may* remove support" might be more accurate, but 
it doesn't make for as compelling a warning, and it's pretty likely that 
*eventually* it will make sense to drop it.  That won't happen without a 
proper conversation about user impact and migration, though.  There are 
real problems with format 1 besides just the lack of new features (e.g., 
rename vs watchers).

This is what 'deprecation' means: we're not dropping support now (that 
*would* be unreasonable), but we're warning users that at some future 
point we (probably) will.  If there is any reason why new images shouldn't 
be created with v2, please let us know.  Obviously v1 -> v2 image 
conversion remains an open issue.

Thanks-
sage
