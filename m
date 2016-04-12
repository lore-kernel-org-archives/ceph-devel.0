From: Christian Balzer <chibi@gol.com>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Tue, 12 Apr 2016 11:43:41 +0900
Message-ID: <20160412114341.098486f7@batzmaru.gol.ad.jp>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
	<20160412083925.5106311d@batzmaru.gol.ad.jp>
	<alpine.DEB.2.11.1604112046570.29593@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:56682 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbcDLCnr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 22:43:47 -0400
In-Reply-To: <alpine.DEB.2.11.1604112046570.29593@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com


Hello,

On Mon, 11 Apr 2016 21:12:14 -0400 (EDT) Sage Weil wrote:

> On Tue, 12 Apr 2016, Christian Balzer wrote:
> >=20
> > Hello,
> >=20
> > What a lovely missive to start off my working day...
> >=20
> > On Mon, 11 Apr 2016 17:39:37 -0400 (EDT) Sage Weil wrote:
> >=20
> > > Hi,
> > >=20
> > > ext4 has never been recommended, but we did test it. =20
> > Patently wrong, as Shinobu just pointed.
> >=20
> > Ext4 never was (especially recently) flogged as much as XFS, but it
> > always was a recommended, supported filestorage filesystem, unlike =
the
> > experimental BTRFS of ZFS.=20
> > And for various reasons people, including me, deployed it instead o=
f
> > XFS.
>=20
> Greg definitely wins the prize for raising this as a major issue, the=
n=20
> (and for naming you as one of the major ext4 users).
>=20
I'm sure there are other ones, it's often surprising how people will pi=
pe
up on this ML for the first time with really massive deployments they'v=
e
been running for years w/o ever being on anybody's radar.

> I was not aware that we were recommending ext4 anywhere.  FWIW, here'=
s=20
> what the docs currently say:
>=20
>  Ceph OSD Daemons rely heavily upon the stability and performance of =
the=20
>  underlying filesystem.
>=20
>  Note: We currently recommend XFS for production deployments. We
> recommend btrfs for testing, development, and any non-critical
> deployments. We believe that btrfs has the correct feature set and
> roadmap to serve Ceph in the long-term, but XFS and ext4 provide the
> necessary stability for today=E2=80=99s deployments. btrfs developmen=
t is
> proceeding rapidly: users should be comfortable installing the latest
> released upstream kernels and be able to track development activity f=
or
> critical bug fixes.
>=20
>  Ceph OSD Daemons depend on the Extended Attributes (XATTRs) of the=20
>  underlying file system for various forms of internal object state an=
d=20
>  metadata. The underlying filesystem must provide sufficient capacity
> for XATTRs. btrfs does not bound the total xattr metadata stored with=
 a
> file. XFS has a relatively large limit (64 KB) that most deployments
> won=E2=80=99t encounter, but the ext4 is too small to be usable.
>=20
> (http://docs.ceph.com/docs/master/rados/configuration/filesystem-reco=
mmendations/?highlight=3Dext4)
>=20
> Unfortunately that second paragraph, second sentence indirectly says
> ext4 is stable.  :( :(  I'll prepare a PR tomorrow to revise this who=
le
> section based on the new information.
>=20
Not only that, the "filestore xattr use omap" section afterwards
reinforces that by clearly suggesting that this is the official
work-around for the XATTR issue.

> If anyone knows of other docs that recommend ext4, please let me know=
! =20
> They need to be updated.
>=20
Not going to try find any cached versions, but when I did my first
deployment with Dumpling I don't think the "Note" section was there or =
as
prominent.=20
Not that it would have stopped me from using Ext4, mind.

> > > After Jewel is out, we would like explicitly recommend *against*
> > > ext4 and stop testing it.
> > >=20
> > Changing your recommendations is fine, stopping testing/supporting =
it
> > isn't.=20
> > People deployed Ext4 in good faith and can be expected to use it at
> > least until their HW is up for replacement (4-5 years).
>=20
> I agree, which is why I asked.
>=20
> And part of it depends on what it's being used for.  If there are maj=
or=20
> users using ext4 for RGW then their deployments are at risk and they=20
> should swap it out for data safety reasons alone.  (Or, we need to
> figure out how to fix long object name support on ext4.)  On the othe=
r
> hand, if the only ext4 users are using RBD only, then they can safely
> continue with lower max object names, and upstream testing is importa=
nt
> to let those OSDs age out naturally.
>=20
> Does your cluster support RBD, RGW, or something else?
>=20
Only RBD on all clusters so far and definitely no plans to change that =
for
the main, mission critical production cluster.
I might want to add CephFS to the other production cluster at some time=
,
though.

No RGW, but if/when RGW supports "listing objects quickly" (is what I
vaguely remember from my conversation with Timo Sirainen, the Dovecot
author) we would be very interested in that particular piece of Ceph as
well. On a completely new cluster though, so no issue.

> > > Why:
> > >=20
> > > Recently we discovered an issue with the long object name handlin=
g
> > > that is not fixable without rewriting a significant chunk of
> > > FileStores filename handling.  (There is a limit in the amount of
> > > xattr data ext4 can store in the inode, which causes problems in
> > > LFNIndex.)
> > >=20
> > Is that also true if the Ext4 inode size is larger than default?
>=20
> I'm not sure... Sam, do you know?  (It's somewhat academic, though,
> since we can't change the inode size on existing file systems.)
> =20
Yes and no.
Some people (and I think not just me) were perfectly capable of reading
between the lines and format their Ext4 FS accordingly:
"mkfs.ext4 -J size=3D1024 -I 2048 -i 65536 ... " (the -I bit)

> > > We *could* invest a ton of time rewriting this to fix, but it onl=
y
> > > affects ext4, which we never recommended, and we plan to deprecat=
e
> > > FileStore once BlueStore is stable anyway, so it seems like a was=
te
> > > of time that would be better spent elsewhere.
> > >=20
> > If you (that is RH) is going to declare bluestore stable this year,=
 I
> > would be very surprised.
>=20
> My hope is that it can be the *default* for L (next spring).  But we'=
ll=20
> see.
>=20
Yeah, that's my most optimistic estimate as well.

> > Either way, dropping support before the successor is truly ready
> > doesn't sit well with me.
>=20
> Yeah, I misspoke.  Once BlueStore is supported and the default, suppo=
rt=20
> for FileStore won't be dropped immediately.  But we'll want to
> communicate that eventually it will lose support.  How strongly that =
is
> messaged probably depends on how confident we are in BlueStore at tha=
t
> point.  And I confess I haven't thought much about how long "long
> enough" is yet.
>=20
Again, most people that deploy Ceph in a commercial environment (that i=
s
working for a company) will be under pressure by the penny-pinching
department to use their HW for 4-5 years (never mind the pace of
technology and Moore's law).

So you will want to:
a) Announce the end of FileStore ASAP, but then again you can't really
do that before BlueStore is stable.
b) support FileStore for 4 years at least after BlueStore is the defaul=
t.=20
This could be done by having a _real_ LTS release, instead of dragging
=46ilestore into newer version.

> > Which brings me to the reasons why people would want to migrate (NO=
T
> > talking about starting freshly) to bluestore.
> >=20
> > 1. Will it be faster (IOPS) than filestore with SSD journals?=20
> > Don't think so, but feel free to prove me wrong.
>=20
> It will absolutely faster on the same hardware.  Whether BlueStore on
> HDD only is faster than FileStore HDD + SSD journal will depend on th=
e=20
> workload.
>=20
Where would the Journal SSDs enter the picture with BlueStore?=20
Not at all, AFAIK, right?

I'm thinking again about people with existing HW again.=20
What do they do with those SSDs, which aren't necessarily sized in a
fashion to be sensible SSD pools/cache tiers?

> > 2. Will it be bit-rot proof? Note the deafening silence from the de=
vs
> > in this thread:=20
> > http://www.spinics.net/lists/ceph-users/msg26510.html
>=20
> I missed that thread, sorry.
>=20
> We (Mirantis, SanDisk, Red Hat) are currently working on checksum
> support in BlueStore.  Part of the reason why BlueStore is the prefer=
red
> path is because we will probably never see full checksumming in ext4 =
or
> XFS.
>=20
Now this (when done correctly) and BlueStore being a stable default wil=
l
be a much, MUCH higher motivation for people to migrate to it than
terminating support for something that works perfectly well (for my use
case at least).

> > > Also, by dropping ext4 test coverage in ceph-qa-suite, we can=20
> > > significantly improve time/coverage for FileStore on XFS and on
> > > BlueStore.
> > >=20
> > Really, isn't that fully automated?
>=20
> It is, but hardware and time are finite.  Fewer tests on FileStore+ex=
t4=20
> means more tests on FileStore+XFS or BlueStore.  But this is a minor=20
> point.
>=20
> > > The long file name handling is problematic anytime someone is
> > > storing rados objects with long names.  The primary user that doe=
s
> > > this is RGW, which means any RGW cluster using ext4 should recrea=
te
> > > their OSDs to use XFS.  Other librados users could be affected to=
o,
> > > though, like users with very long rbd image names (e.g., > 100
> > > characters), or custom librados users.
> > >=20
> > > How:
> > >=20
> > > To make this change as visible as possible, the plan is to make
> > > ceph-osd refuse to start if the backend is unable to support the
> > > configured max object name (osd_max_object_name_len).  The OSD wi=
ll
> > > complain that ext4 cannot store such an object and refuse to star=
t.
> > > A user who is only using RBD might decide they don't need long fi=
le
> > > names to work and can adjust the osd_max_object_name_len setting =
to
> > > something small (say, 64) and run successfully.  They would be
> > > taking a risk, though, because we would like to stop testing on e=
xt4.
> > >=20
> > > Is this reasonable? =20
> > About as reasonable as dropping format 1 support, that is not at al=
l.
> > https://www.mail-archive.com/ceph-users@lists.ceph.com/msg28070.htm=
l
>=20
> Fortunately nobody (to my knowledge) has suggested dropping format 1=20
> support.  :)
>=20
I suggest you look at that thread and your official release notes:
---
* The rbd legacy image format (version 1) is deprecated with the Jewel =
release.
  Attempting to create a new version 1 RBD image will result in a warni=
ng.
  Future releases of Ceph will remove support for version 1 RBD images.
---

> > I'm officially only allowed to do (preventative) maintenance during
> > weekend nights on our main production cluster.=20
> > That would mean 13 ruined weekends at the realistic rate of 1 OSD p=
er
> > night, so you can see where my lack of enthusiasm for OSD recreatio=
n
> > comes from.
>=20
> Yeah.  :(
>=20
> > > If there significant ext4 users that are unwilling
> > > to recreate their OSDs, now would be the time to speak up.
> > >=20
> > Consider that done.
>=20
> Thank you for the feedback!
>=20
Thanks for getting back to me so quickly.

Christian
--=20
Christian Balzer        Network/Systems Engineer               =20
chibi@gol.com   	Global OnLine Japan/Rakuten Communications
http://www.gol.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
