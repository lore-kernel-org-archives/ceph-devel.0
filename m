From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Mon, 11 Apr 2016 21:12:14 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604112046570.29593@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com> <20160412083925.5106311d@batzmaru.gol.ad.jp>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1727901744-1460423537=:29593"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33910 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755399AbcDLBMS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 Apr 2016 21:12:18 -0400
In-Reply-To: <20160412083925.5106311d@batzmaru.gol.ad.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Balzer <chibi@gol.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1727901744-1460423537=:29593
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

On Tue, 12 Apr 2016, Christian Balzer wrote:
> 
> Hello,
> 
> What a lovely missive to start off my working day...
> 
> On Mon, 11 Apr 2016 17:39:37 -0400 (EDT) Sage Weil wrote:
> 
> > Hi,
> > 
> > ext4 has never been recommended, but we did test it.  
> Patently wrong, as Shinobu just pointed.
> 
> Ext4 never was (especially recently) flogged as much as XFS, but it always
> was a recommended, supported filestorage filesystem, unlike the
> experimental BTRFS of ZFS. 
> And for various reasons people, including me, deployed it instead of XFS.

Greg definitely wins the prize for raising this as a major issue, then 
(and for naming you as one of the major ext4 users).

I was not aware that we were recommending ext4 anywhere.  FWIW, here's 
what the docs currently say:

 Ceph OSD Daemons rely heavily upon the stability and performance of the 
 underlying filesystem.

 Note: We currently recommend XFS for production deployments. We recommend 
 btrfs for testing, development, and any non-critical deployments. We 
 believe that btrfs has the correct feature set and roadmap to serve Ceph 
 in the long-term, but XFS and ext4 provide the necessary stability for 
 today¢s deployments. btrfs development is proceeding rapidly: users should 
 be comfortable installing the latest released upstream kernels and be able 
 to track development activity for critical bug fixes.

 Ceph OSD Daemons depend on the Extended Attributes (XATTRs) of the 
 underlying file system for various forms of internal object state and 
 metadata. The underlying filesystem must provide sufficient capacity for 
 XATTRs. btrfs does not bound the total xattr metadata stored with a file. 
 XFS has a relatively large limit (64 KB) that most deployments won¢t 
 encounter, but the ext4 is too small to be usable.

(http://docs.ceph.com/docs/master/rados/configuration/filesystem-recommendations/?highlight=ext4)

Unfortunately that second paragraph, second sentence indirectly says ext4 
is stable.  :( :(  I'll prepare a PR tomorrow to revise this whole section 
based on the new information.

If anyone knows of other docs that recommend ext4, please let me know!  
They need to be updated.

> > After Jewel is out, we would like explicitly recommend *against* ext4 
> > and stop testing it.
> > 
> Changing your recommendations is fine, stopping testing/supporting it
> isn't. 
> People deployed Ext4 in good faith and can be expected to use it at least
> until their HW is up for replacement (4-5 years).

I agree, which is why I asked.

And part of it depends on what it's being used for.  If there are major 
users using ext4 for RGW then their deployments are at risk and they 
should swap it out for data safety reasons alone.  (Or, we need to figure 
out how to fix long object name support on ext4.)  On the other hand, if 
the only ext4 users are using RBD only, then they can safely continue with 
lower max object names, and upstream testing is important to let those 
OSDs age out naturally.

Does your cluster support RBD, RGW, or something else?

> > Why:
> > 
> > Recently we discovered an issue with the long object name handling that
> > is not fixable without rewriting a significant chunk of FileStores
> > filename handling.  (There is a limit in the amount of xattr data ext4
> > can store in the inode, which causes problems in LFNIndex.)
> > 
> Is that also true if the Ext4 inode size is larger than default?

I'm not sure... Sam, do you know?  (It's somewhat academic, though, since 
we can't change the inode size on existing file systems.)
 
> > We *could* invest a ton of time rewriting this to fix, but it only
> > affects ext4, which we never recommended, and we plan to deprecate
> > FileStore once BlueStore is stable anyway, so it seems like a waste of
> > time that would be better spent elsewhere.
> > 
> If you (that is RH) is going to declare bluestore stable this year, I
> would be very surprised.

My hope is that it can be the *default* for L (next spring).  But we'll 
see.

> Either way, dropping support before the successor is truly ready doesn't
> sit well with me.

Yeah, I misspoke.  Once BlueStore is supported and the default, support 
for FileStore won't be dropped immediately.  But we'll want to communicate 
that eventually it will lose support.  How strongly that is messaged 
probably depends on how confident we are in BlueStore at that point.  And 
I confess I haven't thought much about how long "long enough" is yet.

> Which brings me to the reasons why people would want to migrate (NOT
> talking about starting freshly) to bluestore.
> 
> 1. Will it be faster (IOPS) than filestore with SSD journals? 
> Don't think so, but feel free to prove me wrong.

It will absolutely faster on the same hardware.  Whether BlueStore on HDD 
only is faster than FileStore HDD + SSD journal will depend on the 
workload.

> 2. Will it be bit-rot proof? Note the deafening silence from the devs in
> this thread: 
> http://www.spinics.net/lists/ceph-users/msg26510.html

I missed that thread, sorry.

We (Mirantis, SanDisk, Red Hat) are currently working on checksum support 
in BlueStore.  Part of the reason why BlueStore is the preferred path is 
because we will probably never see full checksumming in ext4 or XFS.

> > Also, by dropping ext4 test coverage in ceph-qa-suite, we can 
> > significantly improve time/coverage for FileStore on XFS and on
> > BlueStore.
> > 
> Really, isn't that fully automated?

It is, but hardware and time are finite.  Fewer tests on FileStore+ext4 
means more tests on FileStore+XFS or BlueStore.  But this is a minor 
point.

> > The long file name handling is problematic anytime someone is storing 
> > rados objects with long names.  The primary user that does this is RGW, 
> > which means any RGW cluster using ext4 should recreate their OSDs to use 
> > XFS.  Other librados users could be affected too, though, like users 
> > with very long rbd image names (e.g., > 100 characters), or custom 
> > librados users.
> > 
> > How:
> > 
> > To make this change as visible as possible, the plan is to make ceph-osd 
> > refuse to start if the backend is unable to support the configured max 
> > object name (osd_max_object_name_len).  The OSD will complain that ext4 
> > cannot store such an object and refuse to start.  A user who is only
> > using RBD might decide they don't need long file names to work and can
> > adjust the osd_max_object_name_len setting to something small (say, 64)
> > and run successfully.  They would be taking a risk, though, because we
> > would like to stop testing on ext4.
> > 
> > Is this reasonable?  
> About as reasonable as dropping format 1 support, that is not at all.
> https://www.mail-archive.com/ceph-users@lists.ceph.com/msg28070.html

Fortunately nobody (to my knowledge) has suggested dropping format 1 
support.  :)

> I'm officially only allowed to do (preventative) maintenance during weekend
> nights on our main production cluster. 
> That would mean 13 ruined weekends at the realistic rate of 1 OSD per
> night, so you can see where my lack of enthusiasm for OSD recreation comes
> from.

Yeah.  :(

> > If there significant ext4 users that are unwilling
> > to recreate their OSDs, now would be the time to speak up.
> > 
> Consider that done.

Thank you for the feedback!

sage
--8323329-1727901744-1460423537=:29593--
