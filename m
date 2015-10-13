From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: monitor crashing
Date: Tue, 13 Oct 2015 06:59:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510130658330.6589@cobra.newdream.net>
References: <CACx0BdM2qsO0n492Y7R=+FBfJzJT+4HxbBYaU1rkG0mZV=caJw@mail.gmail.com> <CACx0BdNRPk64Etwvs7_tEce=xwFw7E4Ube=8raav_-EFhhP2Fw@mail.gmail.com> <CACx0BdMi79jokSX4aPy9XJrUorE-2Fa-_oBDjYwW3bBuee5A7g@mail.gmail.com> <alpine.DEB.2.00.1510130624270.6589@cobra.newdream.net>
 <CACx0BdOOY0k02kJSacm_rHgBz0wLKv0YtganjuGy9Vtj63QVPQ@mail.gmail.com> <alpine.DEB.2.00.1510130637450.6589@cobra.newdream.net> <561D0C9B.2050706@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1942428536-1444744780=:6589"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42689 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbbJMN7k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 09:59:40 -0400
In-Reply-To: <561D0C9B.2050706@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Luis Periquito <periquito@gmail.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1942428536-1444744780=:6589
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Oct 2015, Loic Dachary wrote:
> https://github.com/ceph/ceph/compare/hammer...wip-ecpool-hammer
>=20
> In order to bypass the crush verification, you could:
>=20
> ceph tell mon.* injectargs --crushtool /bin/true

Ah, good trick!

	http://tracker.ceph.com/issues/13477

is the ticket, and my fix for master is

	https://github.com/ceph/ceph/pull/6246

sage

>=20
> Cheers
>=20
> On 13/10/2015 15:41, Sage Weil wrote:
> > On Tue, 13 Oct 2015, Luis Periquito wrote:
> >> the store.db dir is 3.4GB big :(
> >>
> >> can I do it on my side?
> >=20
> > Nevermind, I was able to reproduce it from the bugzilla.  I've pushed=
 a=20
> > branch wip-ecpool-hammer.  Not sure which distro you're on, but packa=
ges=20
> > will appear at gitbuilder.ceph.com in 30-45 minutes.  This fixes the =
mon=20
> > crash, which will let you delete the pool.  I suggest stopping the OS=
Ds=20
> > before starting the mon with this or else they might get pg create=20
> > messages and crash too.  Once the pool is removed you can start them=20
> > again.  They shouldn't need to be upgraded.
> >=20
> > Note that the latest hammer doesn't let you create the pool at all be=
cause=20
> > it fails the crush safety check (I had to disable the check to reprod=
uce=20
> > this), so that's good at least!
> >=20
> > sage
> >=20
> >>
> >> On Tue, Oct 13, 2015 at 2:25 PM, Sage Weil <sage@newdream.net> wrote=
:
> >>> On Tue, 13 Oct 2015, Luis Periquito wrote:
> >>>> Any ideas? I'm growing desperate :(
> >>>>
> >>>> I've tried compiling from source, and including
> >>>> https://github.com/ceph/ceph/pull/5276, but it still crashes on bo=
ot
> >>>> of the ceph-mon
> >>>
> >>> If you can email a (link to a) tarball of your mon data directory I=
'd love
> >>> to extract the osdmap and see why crush is crashing.. it's obviousl=
y not
> >>> supposed to do that (even with a bad rule).  You can also use
> >>> the ceph-post-file utility.
> >>>
> >>> Thanks!
> >>> sage
> >>>
> >>>
> >>>>
> >>>> ---------- Forwarded message ----------
> >>>> From: Luis Periquito <periquito@gmail.com>
> >>>> Date: Tue, Oct 13, 2015 at 12:26 PM
> >>>> Subject: Re: monitor crashing
> >>>> To: Ceph Users <ceph-users@lists.ceph.com>
> >>>>
> >>>>
> >>>> I'm currently running Hammer (0.94.3), created an invalid LRC prof=
ile
> >>>> (typo in the l=3D, should have been l=3D4 but was l=3D3, and now I=
 don't
> >>>> have enough different ruleset-locality) and created a pool. Is the=
re
> >>>> any way to delete this pool? remember I can't start the ceph-mon..=
.
> >>>>
> >>>> On Tue, Oct 13, 2015 at 11:56 AM, Luis Periquito <periquito@gmail.=
com> wrote:
> >>>>> It seems I've hit this bug:
> >>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1231630
> >>>>>
> >>>>> is there any way I can recover this cluster? It worked in our tes=
t
> >>>>> cluster, but crashed the production one...
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>
> >>>>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20
--557981400-1942428536-1444744780=:6589--
