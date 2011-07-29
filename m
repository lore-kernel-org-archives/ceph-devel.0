From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: userland nfs server
Date: Fri, 29 Jul 2011 15:05:46 -0400 (EDT)
Message-ID: <1459789254.140.1311966346661.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <CAN4=B2n6NyFj1TBU52+4cdwEfh+q_fkZf_rUwUd7c1xZJwFqRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([134.215.213.37]:4921 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012Ab1G2TFx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2011 15:05:53 -0400
In-Reply-To: <CAN4=B2n6NyFj1TBU52+4cdwEfh+q_fkZf_rUwUd7c1xZJwFqRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Hi Brian,

=46SAL_CEPH doesn't involve the kernel client, rather an incidentally m=
odified libceph and libRADOS--it's linked into Ganesha, not using POSIX=
=2E  Writing directly to OSDs is part of the pNFS parallel access strat=
egy.

Matt

----- "Brian Chrisman" <brchrisman@gmail.com> wrote:

> On Fri, Jul 29, 2011 at 9:30 AM, Matt W. Benjamin <matt@linuxbox.com>
> wrote:
> > Hi Sage,
> >
> > We (Linux Box) have built and published a native FSAL for Ceph,
> which is pretty advanced, and we've submitted the FSAL driver code
> upstream for review Philippe Deniel.
>=20
> Looking at the FSAL_CEPH, is this expecting the filesystem to be
> mounted via the ceph kernel client?  Have you considered building out
> an FSAL using libceph as opposed as to writing directly to OSDs
> (assumedly via libRADOS or librbd).
>=20
> >
> > In addition, we're working on pNFS support in Ganesha and Ceph, and
> have a prototype file-based pNFS layout driver for the FSAL that take=
s
> advantage of Ceph OSDs for parallel IO.
> >
> > We're actively extending these efforts and there should be some
> publication forthcoming.
> >
> > We have an external git repository here:
> >
> > =C2=A0 =C2=A0git://github.com/aemerson-linuxbox/ganesha.git
> >
> > We would really appreciate your feedback--and guidance on how to
> participate in Ceph, we'd like to.
> >
> > Matt
> >
> > ----- "Sage Weil" <sage@newdream.net> wrote:
> >
> >> Has anyone looked at Genesha?
> >>
> >> =C2=A0 =C2=A0 =C2=A0 http://sourceforge.net/apps/trac/nfs-ganesha/
> >>
> >> In principle it would probably be pretty straightforward to wire
> that
> >> up
> >> to libceph and avoid the kernel NFS server for reexporting ceph
> via
> >> NFS...
> >>
> >> sage
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> ceph-devel"
> >> in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info=
=2Ehtml
> >
> > --
> >
> > Matt Benjamin
> >
> > The Linux Box
> > 206 South Fifth Ave. Suite 150
> > Ann Arbor, MI =C2=A048104
> >
> > http://linuxbox.com
> >
> > tel. 734-761-4689
> > fax. 734-769-8938
> > cel. 734-216-5309
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
> >

--=20

Matt Benjamin

The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel. 734-761-4689
fax. 734-769-8938
cel. 734-216-5309
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
