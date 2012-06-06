From: Sage Weil <sage@inktank.com>
Subject: Re: Can we mount cephfs in centos 5.7 ?
Date: Wed, 6 Jun 2012 10:53:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206061052340.5397@cobra.newdream.net>
References: <8512670932FB654F81AF0FEF1BE6D49D01790CEA@WHQBEMAIL1.whq.wistron>
 <CAAs1YtF5UkoG1O6yKBZq0KY4Z-MDsQ2K9VxneySpr5+JHFcA=g@mail.gmail.com>
 <CACkq2mpduy_6g=jUmXjwAHciuc+wsw41C231fpaENfmfZMp8yQ@mail.gmail.com>
 <CACkq2mrVkfGfAO4WJJA5DJ+TW-nt_1JC2M4Q6MZb8bMe_k-gCA@mail.gmail.com>
 <Pine.LNX.4.64.1206060924500.5397@cobra.newdream.net>
 <CACkq2mrgFguqCEdc=-K63C3w3i6J04E2R1NJswpYeqxeprG+BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1285269621-1339005183=:5397"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34814 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757630Ab2FFRxM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 13:53:12 -0400
In-Reply-To: <CACkq2mrgFguqCEdc=-K63C3w3i6J04E2R1NJswpYeqxeprG+BA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, sam.zaydel@inktank.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1285269621-1339005183=:5397
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 6 Jun 2012, Travis Rhoden wrote:
> Thanks folks.
>=20
> > * 2.6.18 is crazy-old.
> Certainly.    I'm hoping I only need to work with CentOS6, then I at
> least get 2.6.32.  I wouldn't try to do RBD with these kernels,
> though.  I would be more likely to have an Ubuntu 12.04 node mount an
> RBD and export with NFS.  But as you mention, that has it's own
> issues.
>=20
> > Your other options are re-exporting NFS or CIFS, or trying to use ceph-=
fuse.
> ceph-fuse would only be for use with cephfs, no?  Or can ceph-fuse
> interface to RBD or radosgw?

Just the fs.
=20
> I'm probably just slightly ahead of the curve here.  I am trying to
> shoehorn ceph into my scenario (exporting a single filesystem to lots
> of cluster nodes) without using cephfs since it's not quite ready.
> Even though I lose parallel file access when using NFS (all traffic
> would go through that one NFS node), I was hoping that mounting an
> RBD, formatting it, and exporting it with NFS would avoid the ESTALE
> issues (as opposed to using cephfs, mounting via ceph-fuse, and then
> exporting _that_ with NFS).

Oh, yeah, exporting an xfs/ext4/whatever on top of rbd via NFS will=20
certainly work!

sage

>=20
> I actually have a phone call with inktank tomorrow.  I'll ask some
> more questions then.
>=20
>  - Travis
>=20
> On Wed, Jun 6, 2012 at 12:27 PM, Sage Weil <sage@inktank.com> wrote:
> > On Wed, 6 Jun 2012, Travis Rhoden wrote:
> >> Sorry for the re-post.=A0 First attempt got eaten by the mailing list
> >> because it wasn't plain text.=A0 My first attempt!
> >>
> >> > With CephFS not quite ready for production, what would be the
> >> > recommended way for sharing Ceph to older operating systems?
> >> > Specifically, I want to share a file system (i.e. mount a common
> >> > directory) on several CentOS5 and CentOS6 nodes.=A0 I don't think I =
can
> >> > mount an RBD from more than one node, so what is my best bet?
> >> >
> >> > Mount an RBD on a file "head" and export it via NFS?
> >> >
> >> > I feel like that is the only sane choice, but wanted to ask in case =
I
> >> > am missing something better.
> >
> > Two things:
> >
> > * 2.6.18 is crazy-old. =A0It's possible the libceph and rbd bits could =
be
> > merged in, but getting the fs to work with ancient VFS will be a world =
of
> > pain.
> >
> > * NFS reexport works in basic scenarios, but should not be used in
> > production as there are various conditions that can lead to ESTALE.
> > Making it work is somewhere on the mid-term roadmap, but it'll be a whi=
le.
> >
> > Your best bet is to run cephfs on a modern kernel. =A0But be warned, we
> > aren't ready to support the fs just yet. =A0Soon!
> >
> > sage
> >
> >
> >>
> >> =A0=A0- Travis
> >> >
> >> >
> >> > On Wed, Jun 6, 2012 at 9:58 AM, Sam Zaydel <sam.zaydel@inktank.com> =
wrote:
> >> >>
> >> >> I think you will be able to build from source the client bits that =
you
> >> >> need, but I saw this from an earlier similar discussion mentioning
> >> >> Python version, so I would make sure that python > 2.5 is used,
> >> >> realistically 2.6 should be the norm today.
> >> >>
> >> >> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/5717
> >> >>
> >> >> On Tue, Jun 5, 2012 at 6:16 PM, =A0<Eric_YH_Chen@wiwynn.com> wrote:
> >> >> > Dear All:
> >> >> >
> >> >> >=FF=FF=FF=FF My ceph cluster is installed on Ubuntu 12.04 with ker=
nel 3.2.0.
> >> >> >
> >> >> >=FF=FF=FF=FF =A0=A0But I have a situation that I may need to mount=
 cephfs on centos 5.7, which with kernel 2.6.18.
> >> >> >
> >> >> > =A0 =A0(that is to say , I only need to execute mount.ceph on the=
 centos 5.7, not the whole ceph system)
> >> >> >
> >> >> > =A0 =A0I want to find a solution that can provide reliable and hi=
gh availability share file system.
> >> >> >
> >> >> > =A0 =A0Is it possible to do this? Or any other recommend way? =A0=
Ex: =A0export NFS=FF=FF
> >> >> >
> >> >> > =A0 =A0Thanks!
> >> >> >
> >> >> >
> >> >> > --
> >> >> > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
> >> >> > the body of a message to majordomo@vger.kernel.org
> >> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
> >> >>
> >> >>
> >> >>
> >> >> --
> >> >> Inked by Sam Zaydel
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >> >
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1285269621-1339005183=:5397--
