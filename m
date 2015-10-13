From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: monitor crashing
Date: Tue, 13 Oct 2015 07:35:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510130734380.6589@cobra.newdream.net>
References: <CACx0BdM2qsO0n492Y7R=+FBfJzJT+4HxbBYaU1rkG0mZV=caJw@mail.gmail.com> <CACx0BdNRPk64Etwvs7_tEce=xwFw7E4Ube=8raav_-EFhhP2Fw@mail.gmail.com> <CACx0BdMi79jokSX4aPy9XJrUorE-2Fa-_oBDjYwW3bBuee5A7g@mail.gmail.com> <alpine.DEB.2.00.1510130624270.6589@cobra.newdream.net>
 <CACx0BdOOY0k02kJSacm_rHgBz0wLKv0YtganjuGy9Vtj63QVPQ@mail.gmail.com> <alpine.DEB.2.00.1510130637450.6589@cobra.newdream.net> <561D0C9B.2050706@dachary.org> <alpine.DEB.2.00.1510130658330.6589@cobra.newdream.net>
 <CACx0BdNgjD5nWEXdP61phPK-T90x=Pso2=oG0LV+1wpesiOK0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2079603334-1444746931=:6589"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42887 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbbJMOfc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 10:35:32 -0400
In-Reply-To: <CACx0BdNgjD5nWEXdP61phPK-T90x=Pso2=oG0LV+1wpesiOK0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Periquito <periquito@gmail.com>
Cc: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2079603334-1444746931=:6589
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Oct 2015, Luis Periquito wrote:
> Hi Sage,
>=20
> awesome help.
>=20
> Sorry for not telling before, but I'm running 2xMON in precise and
> 1xMON in trusty. Looking at the status page
> (http://ceph.com/gitbuilder.cgi) it seems the precise build is
> failing... Can you have a look?

I've repushed the branch, this time cherry-picking the master fix.  Let m=
e=20
know if you run into other problems!

Thanks-
sage

>=20
> thanks,
>=20
>=20
> On Tue, Oct 13, 2015 at 2:59 PM, Sage Weil <sage@newdream.net> wrote:
> > On Tue, 13 Oct 2015, Loic Dachary wrote:
> >> https://github.com/ceph/ceph/compare/hammer...wip-ecpool-hammer
> >>
> >> In order to bypass the crush verification, you could:
> >>
> >> ceph tell mon.* injectargs --crushtool /bin/true
> >
> > Ah, good trick!
> >
> >         http://tracker.ceph.com/issues/13477
> >
> > is the ticket, and my fix for master is
> >
> >         https://github.com/ceph/ceph/pull/6246
> >
> > sage
> >
> >>
> >> Cheers
> >>
> >> On 13/10/2015 15:41, Sage Weil wrote:
> >> > On Tue, 13 Oct 2015, Luis Periquito wrote:
> >> >> the store.db dir is 3.4GB big :(
> >> >>
> >> >> can I do it on my side?
> >> >
> >> > Nevermind, I was able to reproduce it from the bugzilla.  I've pus=
hed a
> >> > branch wip-ecpool-hammer.  Not sure which distro you're on, but pa=
ckages
> >> > will appear at gitbuilder.ceph.com in 30-45 minutes.  This fixes t=
he mon
> >> > crash, which will let you delete the pool.  I suggest stopping the=
 OSDs
> >> > before starting the mon with this or else they might get pg create
> >> > messages and crash too.  Once the pool is removed you can start th=
em
> >> > again.  They shouldn't need to be upgraded.
> >> >
> >> > Note that the latest hammer doesn't let you create the pool at all=
 because
> >> > it fails the crush safety check (I had to disable the check to rep=
roduce
> >> > this), so that's good at least!
> >> >
> >> > sage
> >> >
> >> >>
> >> >> On Tue, Oct 13, 2015 at 2:25 PM, Sage Weil <sage@newdream.net> wr=
ote:
> >> >>> On Tue, 13 Oct 2015, Luis Periquito wrote:
> >> >>>> Any ideas? I'm growing desperate :(
> >> >>>>
> >> >>>> I've tried compiling from source, and including
> >> >>>> https://github.com/ceph/ceph/pull/5276, but it still crashes on=
 boot
> >> >>>> of the ceph-mon
> >> >>>
> >> >>> If you can email a (link to a) tarball of your mon data director=
y I'd love
> >> >>> to extract the osdmap and see why crush is crashing.. it's obvio=
usly not
> >> >>> supposed to do that (even with a bad rule).  You can also use
> >> >>> the ceph-post-file utility.
> >> >>>
> >> >>> Thanks!
> >> >>> sage
> >> >>>
> >> >>>
> >> >>>>
> >> >>>> ---------- Forwarded message ----------
> >> >>>> From: Luis Periquito <periquito@gmail.com>
> >> >>>> Date: Tue, Oct 13, 2015 at 12:26 PM
> >> >>>> Subject: Re: monitor crashing
> >> >>>> To: Ceph Users <ceph-users@lists.ceph.com>
> >> >>>>
> >> >>>>
> >> >>>> I'm currently running Hammer (0.94.3), created an invalid LRC p=
rofile
> >> >>>> (typo in the l=3D, should have been l=3D4 but was l=3D3, and no=
w I don't
> >> >>>> have enough different ruleset-locality) and created a pool. Is =
there
> >> >>>> any way to delete this pool? remember I can't start the ceph-mo=
n...
> >> >>>>
> >> >>>> On Tue, Oct 13, 2015 at 11:56 AM, Luis Periquito <periquito@gma=
il.com> wrote:
> >> >>>>> It seems I've hit this bug:
> >> >>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1231630
> >> >>>>>
> >> >>>>> is there any way I can recover this cluster? It worked in our =
test
> >> >>>>> cluster, but crashed the production one...
> >> >>>> --
> >> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
> >> >>>> the body of a message to majordomo@vger.kernel.org
> >> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
> >> >>>>
> >> >>>>
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> >> >>
> >> >>
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >
> >>
> >> --
> >> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-2079603334-1444746931=:6589--
