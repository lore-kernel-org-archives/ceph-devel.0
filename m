From: Sage Weil <sage@newdream.net>
Subject: Re: Multiple disks per server.
Date: Wed, 5 May 2010 21:02:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005052052001.27095@cobra.newdream.net>
References: <4BE01091.7040103@embl.fr> <20100506041827.c1e51f92.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1079599493-1273118527=:27095"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42643 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab0EFD7R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 May 2010 23:59:17 -0400
In-Reply-To: <20100506041827.c1e51f92.ctpm@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Cc: =?UTF-8?B?TWlja2HDq2wgQ2Fuw6l2ZXQ=?= <canevet@embl.fr>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1079599493-1273118527=:27095
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 6 May 2010, Cl=E1udio Martins wrote:
>  I too am facing a similar dilemma:
>=20
>  Scenario 1:
>  I can set up an MD raid6 array for each OSD box and so can afford up
> to 2 simultaneous disk failures without Ceph noticing anything wrong.
> When the 3rd drive fails, a long time will be spent redistributing data
> across the cluster (though much less time than a simple 25TB raid6
> rebuild) . This setup should be quite simple, and a 16 disk raid6
> should give generally nice performance, though. I probably would use
> 2-way data replication (on Ceph config.) for this case.
>=20
>  Scenario 2:
>=20
>  I can try to configure 1 OSD per disk. As soon as a drive fails, there
> will be data redistribution across the remaining OSDs - but this should
> be quite fast, as only the content of a single drive (or slightly more)
> has to be redistributed across the cluster (worst case). In this case I
> would use 3-way replication for added protection against simultaneous
> double drive failures and to compensate for the OSDs not having a raid
> array underneath them.

Disadvantages of Scenario 2:

* If a drive fails, data re-replication bandwidth will be _between_ hosts,=
=20
over the network, instead of being confined to the host or host's RAID=20
controller.

* 3x replication will consume more disk than 2x * (N+2)/N RAID overhead.


>  I can see several potential advantages in "Scenario 2":

* I suspect that if you do the math the 3x replication will be more=20
reliable.  Notably, losing two hosts (disk aren't the only things that=20
fail) can't take out all replicas (even temporarily).  It's a matter of=20
tradeoffs...
=20
>  * Greater simplicity and ease of administration, as there's no need to
> worry about RAID arrays, their configuration and their possible bugs.
> You have one less layer in the stack to worry about, and that has to be
> good news.
>=20
>  * You can replace failed drives with different drives without worrying
> about wasted capacity because they are bigger (as you would on raid),
> and you can even take advantage of older, smaller drives that would
> otherwise go to the trash can. This will give greater liberty when
> upgrading hardware, overall.
>=20
>  * Degradation of available cluster capacity and bandwidth would be
> much softer. In fact, assuming that you don't have many power supplies
> or mainboards burning up, your cluster will maintain redundancy as
> drives go failing. That is, as long as you have more drives than
> (amount_of_data * replication_level) your cluster will probably be in a
> good, fully redundant state. That should make for better sleep at night.
>=20
>  * Workloads with small, spread writes should perform better. In a RAID
> array those could cause entire stripes to be read, thus requiring data
> chunks to be read from a lot of disks just to compute the redundancy
> chunks. This one should be quite an advantage for big mail server
> workloads, which is one of the workloads I'm interested in.
>=20
>  * Large write performance should be no worse than with raid, since Ceph
> also spreads chunks across OSDs.
>=20
>=20
>  Having said that, there are some aspects about how Ceph would behave
> in Scenario 2 that I still have to investigate:
>=20
>  * If multiple OSDs per node is a well suported option. Do multiple OSDs
> per node play well with each other and with a node's resources?

Generally speaking, the cosd daemon is pretty heavily threaded, but all=20
threadpools are adjustable in size, so you can tune according to your=20
resources.

>  * If there are issues with network ports/addresses when setting up more
> than 1 OSD per node.

None.

>  * OSD behaviour when getting I/O errors from its drive -- this is
> really the most complex and important one, and the one I wish I could
> hear your opinions about:
>=20
>   Usually, in a RAID array, when there is a fatal failure, the upper
> layers will just get permanent I/O errors and you can assume that
> storage area is dead and go on with life.
>  However, this is frequently not true when you consider single drives
> as in Scenario 2, at least for reads: the drive may return read errors
> for a small region but still be quite ok for the remaining data.
>=20
>  So, ideally, a Ceph OSD receiving a read error from the filesystem
> would request a copy of the Object in question from another OSD and try
> to rewrite it several times before giving up and declaring the drive
> dead (1). This is actually what Linux MD does on recent kernels and I
> know from my experience that it increases array survivability a lot.

There is not yet any specific error handling in the osd.  There is some=20
low-level stuff to grab other replicas of an object, but it's only used by=
=20
the scrub function currently when inconsistencies are found.  Some work=20
needs to be done to cleanly trigger it on read errors.

In general, btrfs is (will be) pretty good about dealing with individual=20
drive errors internally when it has any redundancy.  Currently there's=20
only replication (RAID[56] is a work in progress), but moving forward that=
=20
situation will improve.

>  Background data scrubbing would help a lot with the above, and I guess
> BTRFS checksuming will simplify things here.

Yes.. the plan is to leverage the btrfs checksums when comparing replicas=
=20
during the scrub.  Checksums can be verified locally, then compared across=
=20
nodes.

sage
--557981400-1079599493-1273118527=:27095--
