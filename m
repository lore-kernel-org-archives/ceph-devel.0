From: Sage Weil <sage@inktank.com>
Subject: Re: Can we mount cephfs in centos 5.7 ?
Date: Wed, 6 Jun 2012 09:27:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206060924500.5397@cobra.newdream.net>
References: <8512670932FB654F81AF0FEF1BE6D49D01790CEA@WHQBEMAIL1.whq.wistron>
 <CAAs1YtF5UkoG1O6yKBZq0KY4Z-MDsQ2K9VxneySpr5+JHFcA=g@mail.gmail.com>
 <CACkq2mpduy_6g=jUmXjwAHciuc+wsw41C231fpaENfmfZMp8yQ@mail.gmail.com>
 <CACkq2mrVkfGfAO4WJJA5DJ+TW-nt_1JC2M4Q6MZb8bMe_k-gCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-578140878-1339000023=:5397"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35031 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab2FFQ1K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 12:27:10 -0400
In-Reply-To: <CACkq2mrVkfGfAO4WJJA5DJ+TW-nt_1JC2M4Q6MZb8bMe_k-gCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel@vger.kernel.org, sam.zaydel@inktank.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-578140878-1339000023=:5397
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 6 Jun 2012, Travis Rhoden wrote:
> Sorry for the re-post.=A0 First attempt got eaten by the mailing list
> because it wasn't plain text.=A0 My first attempt!
>=20
> > With CephFS not quite ready for production, what would be the=20
> > recommended way for sharing Ceph to older operating systems?=A0=20
> > Specifically, I want to share a file system (i.e. mount a common=20
> > directory) on several CentOS5 and CentOS6 nodes.=A0 I don't think I can=
=20
> > mount an RBD from more than one node, so what is my best bet?
> >
> > Mount an RBD on a file "head" and export it via NFS?
> >
> > I feel like that is the only sane choice, but wanted to ask in case I=
=20
> > am missing something better.

Two things:

* 2.6.18 is crazy-old.  It's possible the libceph and rbd bits could be=20
merged in, but getting the fs to work with ancient VFS will be a world of=
=20
pain. =20

* NFS reexport works in basic scenarios, but should not be used in=20
production as there are various conditions that can lead to ESTALE. =20
Making it work is somewhere on the mid-term roadmap, but it'll be a while.

Your best bet is to run cephfs on a modern kernel.  But be warned, we=20
aren't ready to support the fs just yet.  Soon!

sage


>=20
>  =A0- Travis
> >
> >
> > On Wed, Jun 6, 2012 at 9:58 AM, Sam Zaydel <sam.zaydel@inktank.com> wro=
te:
> >>
> >> I think you will be able to build from source the client bits that you
> >> need, but I saw this from an earlier similar discussion mentioning
> >> Python version, so I would make sure that python > 2.5 is used,
> >> realistically 2.6 should be the norm today.
> >>
> >> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/5717
> >>
> >> On Tue, Jun 5, 2012 at 6:16 PM, =A0<Eric_YH_Chen@wiwynn.com> wrote:
> >> > Dear All:
> >> >
> >> >=FF=FF=FF=FF My ceph cluster is installed on Ubuntu 12.04 with kernel=
 3.2.0.
> >> >
> >> >=FF=FF=FF=FF =A0=A0But I have a situation that I may need to mount ce=
phfs on centos 5.7, which with kernel 2.6.18.
> >> >
> >> > =A0 =A0(that is to say , I only need to execute mount.ceph on the ce=
ntos 5.7, not the whole ceph system)
> >> >
> >> > =A0 =A0I want to find a solution that can provide reliable and high =
availability share file system.
> >> >
> >> > =A0 =A0Is it possible to do this? Or any other recommend way? =A0Ex:=
 =A0export NFS=FF=FF
> >> >
> >> > =A0 =A0Thanks!
> >> >
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >>
> >>
> >> --
> >> Inked by Sam Zaydel
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-578140878-1339000023=:5397--
