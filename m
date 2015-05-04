From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Upgrade from Giant to Hammer and after some basic
 operations most of the OSD's went down
Date: Mon, 4 May 2015 10:20:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505041019300.24939@cobra.newdream.net>
References: <38d13d8d20504f90212053827aba9ba8@mail.meizo.com>
	<dc614dd85caf6cecfd59897b96a019ad@mail.meizo.com>
	<alpine.DEB.2.00.1505010902490.5458@cobra.newdream.net>
	<56c96198e8b0d8e70fbf96fdd209d70a@mail.meizo.com>
	<90c912f778464020445a8a09c7d8c7f5@mail.meizo.com>
	<alpine.DEB.2.00.1505040828590.24939@cobra.newdream.net>
	<f0d4624d313c49cf355543dbf52d6561@mail.meizo.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="557981400-1632353146-1430760053=:24939"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <f0d4624d313c49cf355543dbf52d6561-Mp+lKDbUk+6SvdrsE3bNcA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Tuomas Juntunen <tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1632353146-1430760053=:24939
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 4 May 2015, Tuomas Juntunen wrote:
> 5827504:        10.20.0.11:6800/3382530 'ceph1' mds.0.262 up:rejoin seq=
 33159

This is why it is 'degraded'... stuck in up:rejoin state.

> The active+clean+replay has been there for a day now, so there must be
> something that is not ok, if it should've gone away in cople of minutes=
.

...possibly because the pg is stuck in replay state.  Can you do 'ceph pg=
=20
<pgid> query' on one of them?  And may be see if bouncing one of the OSDs=
=20
for the pg clears it up (ceph osd down $osdid).

sage


>=20
>=20
> Thanks
>=20
> Tuomas
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org]=20
> Sent: 4. toukokuuta 2015 18:29
> To: Tuomas Juntunen
> Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: RE: [ceph-users] Upgrade from Giant to Hammer and after some b=
asic
> operations most of the OSD's went down
>=20
> On Mon, 4 May 2015, Tuomas Juntunen wrote:
> > Hi
> >=20
> > Thanks Sage, I got it working now. Everything else seems to be ok,=20
> > except mds is reporting "mds cluster is degraded", not sure what coul=
d be
> wrong.
> > Mds is running and all osds are up and pg's are active+clean and
> > active+clean+replay.
>=20
> Great!  The 'replay' part should clear after a minute or two.
>=20
> > Had to delete some empty pools which were created while the osd's wer=
e=20
> > not working and recovery started to go through.
> >=20
> > Seems mds is not that stable, this isn't the first time it goes degra=
ded.
> > Before it just started to work, but now I just can't get it back work=
ing.
>=20
> What does 'ceph mds dump' say?
>=20
> sage
>=20
> >=20
> > Thanks
> >=20
> > Br,
> > Tuomas
> >=20
> >=20
> > -----Original Message-----
> > From: tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org
> > [mailto:tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org]
> > Sent: 1. toukokuuta 2015 21:14
> > To: Sage Weil
> > Cc: tuomas.juntunen; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org;=20
> > ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Subject: Re: [ceph-users] Upgrade from Giant to Hammer and after some=
=20
> > basic operations most of the OSD's went down
> >=20
> > Thanks, I'll do this when the commit is available and report back.
> >=20
> > And indeed, I'll change to the official ones after everything is ok.
> >=20
> > Br,
> > Tuomas
> >=20
> > > On Fri, 1 May 2015, tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org wrote:
> > >> Hi
> > >>
> > >> I deleted the images and img pools and started osd's, they still d=
ie.
> > >>
> > >> Here's a log of one of the osd's after this, if you need it.
> > >>
> > >> http://beta.xaasbox.com/ceph/ceph-osd.19.log
> > >
> > > I've pushed another commit that should avoid this case, sha1=20
> > > 425bd4e1dba00cc2243b0c27232d1f9740b04e34.
> > >
> > > Note that once the pools are fully deleted (shouldn't take too long=
=20
> > > once the osds are up and stabilize) you should switch back to the=20
> > > normal packages that don't have these workarounds.
> > >
> > > sage
> > >
> > >
> > >
> > >>
> > >> Br,
> > >> Tuomas
> > >>
> > >>
> > >> > Thanks man. I'll try it tomorrow. Have a good one.
> > >> >
> > >> > Br,T
> > >> >
> > >> > -------- Original message --------
> > >> > From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
> > >> > Date: 30/04/2015  18:23  (GMT+02:00)
> > >> > To: Tuomas Juntunen <tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org>
> > >> > Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > >> > Subject: RE: [ceph-users] Upgrade from Giant to Hammer and after=
=20
> > >> > some basic
> > >>
> > >> > operations most of the OSD's went down
> > >> >
> > >> > On Thu, 30 Apr 2015, tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org wrote:
> > >> >> Hey
> > >> >>
> > >> >> Yes I can drop the images data, you think this will fix it?
> > >> >
> > >> > It's a slightly different assert that (I believe) should not=20
> > >> > trigger once the pool is deleted.=C2=A0 Please give that a try a=
nd if=20
> > >> > you still hit it I'll whip up a workaround.
> > >> >
> > >> > Thanks!
> > >> > sage
> > >> >
> > >> >  >
> > >> >>
> > >> >> Br,
> > >> >>
> > >> >> Tuomas
> > >> >>
> > >> >> > On Wed, 29 Apr 2015, Tuomas Juntunen wrote:
> > >> >> >> Hi
> > >> >> >>
> > >> >> >> I updated that version and it seems that something did=20
> > >> >> >> happen, the osd's stayed up for a while and 'ceph status' go=
t
> updated.
> > >> >> >> But then in couple
> > >> of
> > >> >> >> minutes, they all went down the same way.
> > >> >> >>
> > >> >> >> I have attached new 'ceph osd dump -f json-pretty' and got a=
=20
> > >> >> >> new log
> > >> from
> > >> >> >> one of the osd's with osd debug =3D 20,=20
> > >> >> >> http://beta.xaasbox.com/ceph/ceph-osd.15.log
> > >> >> >
> > >> >> > Sam mentioned that you had said earlier that this was not=20
> > >> >> > critical
> > data?
> > >> >> > If not, I think the simplest thing is to just drop those=20
> > >> >> > pools.=C2 The important thing (from my perspective at least :=
)=20
> > >> >> > is that we understand
> > >> the
> > >> >> > root cause and can prevent this in the future.
> > >> >> >
> > >> >> > sage
> > >> >> >
> > >> >> >
> > >> >> >>
> > >> >> >> Thank you!
> > >> >> >>
> > >> >> >> Br,
> > >> >> >> Tuomas
> > >> >> >>
> > >> >> >>
> > >> >> >>
> > >> >> >> -----Original Message-----
> > >> >> >> From: Sage Weil [mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org]
> > >> >> >> Sent: 28. huhtikuuta 2015 23:57
> > >> >> >> To: Tuomas Juntunen
> > >> >> >> Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > >> >> >> Subject: Re: [ceph-users] Upgrade from Giant to Hammer and=20
> > >> >> >> after some
> > >> basic
> > >> >> >> operations most of the OSD's went down
> > >> >> >>
> > >> >> >> Hi Tuomas,
> > >> >> >>
> > >> >> >> I've pushed an updated wip-hammer-snaps branch.=C2=A0 Can yo=
u=20
> > >> >> >> please
> > try it?
> > >> >> >> The build will appear here
> > >> >> >>
> > >> >> >>
> > >> >> >> http://gitbuilder.ceph.com/ceph-deb-trusty-x86_64-basic/sha1=
/
> > >> >> >> 08
> > >> >> >> bf531331afd5e
> > >> >> >> 2eb514067f72afda11bcde286
> > >> >> >>
> > >> >> >> (or a similar url; adjust for your distro).
> > >> >> >>
> > >> >> >> Thanks!
> > >> >> >> sage
> > >> >> >>
> > >> >> >>
> > >> >> >> On Tue, 28 Apr 2015, Sage Weil wrote:
> > >> >> >>
> > >> >> >> > [adding ceph-devel]
> > >> >> >> >
> > >> >> >> > Okay, I see the problem.=C2=A0 This seems to be unrelated =
ot=20
> > >> >> >> > the giant -> hammer move... it's a result of the tiering=20
> > >> >> >> > changes you
> > made:
> > >> >> >> >
> > >> >> >> > > > > > > > The following:
> > >> >> >> > > > > > > >
> > >> >> >> > > > > > > > ceph osd tier add img images --force-nonempty=20
> > >> >> >> > > > > > > > ceph osd tier cache-mode images forward ceph=20
> > >> >> >> > > > > > > > osd tier set-overlay img images
> > >> >> >> >
> > >> >> >> > Specifically, --force-nonempty bypassed important safety
> checks.
> > >> >> >> >
> > >> >> >> > 1. images had snapshots (and removed_snaps)
> > >> >> >> >
> > >> >> >> > 2. images was added as a tier *of* img, and img's=20
> > >> >> >> > removed_snaps was copied to images, clobbering the=20
> > >> >> >> > removed_snaps value (see
> > >> >> >> > OSDMap::Incremental::propagate_snaps_to_tiers)
> > >> >> >> >
> > >> >> >> > 3. tiering relation was undone, but removed_snaps was stil=
l=20
> > >> >> >> > gone
> > >> >> >> >
> > >> >> >> > 4. on OSD startup, when we load the PG, removed_snaps is=20
> > >> >> >> > initialized with the older map.=C2=A0 later, in=20
> > >> >> >> > PGPool::update(), we assume that removed_snaps alwasy grow=
s=20
> > >> >> >> > (never shrinks) and we
> > trigger an assert.
> > >> >> >> >
> > >> >> >> > To fix this I think we need to do 2 things:
> > >> >> >> >
> > >> >> >> > 1. make the OSD forgiving out removed_snaps getting=20
> > >> >> >> > smaller.=C2 This is probably a good thing anyway: once we=20
> > >> >> >> > know snaps are removed on all OSDs we can prune the=20
> > >> >> >> > interval_set in the
> > OSDMap.=C2=A0 Maybe.
> > >> >> >> >
> > >> >> >> > 2. Fix the mon to prevent this from happening, *even* when=
=20
> > >> >> >> > --force-nonempty is specified.=C2=A0 (This is the root cau=
se.)
> > >> >> >> >
> > >> >> >> > I've opened http://tracker.ceph.com/issues/11493 to track =
this.
> > >> >> >> >
> > >> >> >> > sage
> > >> >> >> >
> > >> >> >> >
> > >> >> >> >
> > >> >> >> > > > > > > >
> > >> >> >> > > > > > > > Idea was to make images as a tier to img, move=
=20
> > >> >> >> > > > > > > > data to img then change
> > >> >> >> > > > > > > clients to use the new img pool.
> > >> >> >> > > > > > > >
> > >> >> >> > > > > > > > Br,
> > >> >> >> > > > > > > > Tuomas
> > >> >> >> > > > > > > >
> > >> >> >> > > > > > > > > Can you explain exactly what you mean by:
> > >> >> >> > > > > > > > >
> > >> >> >> > > > > > > > > "Also I created one pool for tier to be able=
=20
> > >> >> >> > > > > > > > > to move data without
> > >> >> >> > > > > > > outage."
> > >> >> >> > > > > > > > >
> > >> >> >> > > > > > > > > -Sam
> > >> >> >> > > > > > > > > ----- Original Message -----
> > >> >> >> > > > > > > > > From: "tuomas juntunen"
> > >> >> >> > > > > > > > > <tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org>
> > >> >> >> > > > > > > > > To: "Ian Colle" <icolle-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > >> >> >> > > > > > > > > Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > >> >> >> > > > > > > > > Sent: Monday, April 27, 2015 4:23:44 AM
> > >> >> >> > > > > > > > > Subject: Re: [ceph-users] Upgrade from Giant=
=20
> > >> >> >> > > > > > > > > to Hammer and after some basic operations=20
> > >> >> >> > > > > > > > > most of the OSD's went down
> > >> >> >> > > > > > > > >
> > >> >> >> > > > > > > > > Hi
> > >> >> >> > > > > > > > >
> > >> >> >> > > > > > > > > Any solution for this yet?
> > >> >> >> > > > > > > > >
> > >> >> >> > > > > > > > > Br,
> > >> >> >> > > > > > > > > Tuomas
> > >> >> >> > > > > > > > >
> > >> >> >> > > > > > > > >> It looks like you may have hit
> > >> >> >> > > > > > > > >> http://tracker.ceph.com/issues/7915
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >> Ian R. Colle Global Director of Software=20
> > >> >> >> > > > > > > > >> Engineering Red Hat (Inktank is now part of=
=20
> > >> >> >> > > > > > > > >> Red Hat!) http://www.linkedin.com/in/ircoll=
e
> > >> >> >> > > > > > > > >> http://www.twitter.com/ircolle
> > >> >> >> > > > > > > > >> Cell: +1.303.601.7713
> > >> >> >> > > > > > > > >> Email: icolle-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >> ----- Original Message -----
> > >> >> >> > > > > > > > >> From: "tuomas juntunen"
> > >> >> >> > > > > > > > >> <tuomas.juntunen-TGwGjfj4lcphU2BovMVX9g@public.gmane.org>
> > >> >> >> > > > > > > > >> To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > >> >> >> > > > > > > > >> Sent: Monday, April 27, 2015 1:56:29 PM
> > >> >> >> > > > > > > > >> Subject: [ceph-users] Upgrade from Giant to=
=20
> > >> >> >> > > > > > > > >> Hammer and after some basic operations most=
=20
> > >> >> >> > > > > > > > >> of the OSD's went down
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >> I upgraded Ceph from 0.87 Giant to 0.94.1=20
> > >> >> >> > > > > > > > >> Hammer
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >> Then created new pools and deleted some old=
=20
> > >> >> >> > > > > > > > >> ones. Also I created one pool for tier to b=
e=20
> > >> >> >> > > > > > > > >> able to move data without
> > >> >> >> > > outage.
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >> After these operations all but 10 OSD's are=
=20
> > >> >> >> > > > > > > > >> down and creating this kind of messages to=20
> > >> >> >> > > > > > > > >> logs, I get more than 100gb of these in a
> > >> >> >> > > > > > night:
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >>=C2=A0 -19> 2015-04-27 10:17:08.808584=20
> > >> >> >> > > > > > > > >>7fd8e748d700=C2=A0 5
> > >> osd.23
> > >> >> >> > > pg_epoch:
> > >> >> >> > > >
> > >> >> >> > > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7]
> > >> >> >> > > > > > > > >>local-les=3D16609
> > >> >> >> > > > > > > > >> n=3D0
> > >> >> >> > > > > > > > >> ec=3D1 les/c
> > >> >> >> > > > > > > > >> 16609/16659
> > >> >> >> > > > > > > > >> 16590/16590/16590) [24,3,23] r=3D2 lpr=3D17=
838
> > >> >> >> > > > > > > > >> pi=3D15659-16589/42
> > >> >> >> > > > > > > > >> crt=3D8480'7 lcod
> > >> >> >> > > > > > > > >> 0'0 inactive NOTIFY] enter Started =C2=A0=C2=
=A0=C2=A0=20
> > >> >> >> > > > > > > > >>-18>
> > >> >> >> > > > > > > > >>2015-04-27 10:17:08.808596 7fd8e748d700=C2=A0=
 5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7]
> > >> >> >> > > > > > > > >>local-les=3D16609
> > >> >> >> > > > > > > > >> n=3D0
> > >> >> >> > > > > > > > >> ec=3D1 les/c
> > >> >> >> > > > > > > > >> 16609/16659
> > >> >> >> > > > > > > > >> 16590/16590/16590) [24,3,23] r=3D2 lpr=3D17=
838
> > >> >> >> > > > > > > > >> pi=3D15659-16589/42
> > >> >> >> > > > > > > > >> crt=3D8480'7 lcod
> > >> >> >> > > > > > > > >> 0'0 inactive NOTIFY] enter Start =C2=A0=C2=A0=
=C2=A0 -17>
> > >> >> >> > > > > > > > >>2015-04-27 10:17:08.808608 7fd8e748d700=C2=A0=
 1
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7]
> > >> >> >> > > > > > > > >> local-les=3D16609
> > >> >> >> > > > > > > > >> n=3D0
> > >> >> >> > > > > > > > >> ec=3D1 les/c
> > >> >> >> > > > > > > > >> 16609/16659
> > >> >> >> > > > > > > > >> 16590/16590/16590) [24,3,23] r=3D2 lpr=3D17=
838
> > >> >> >> > > > > > > > >> pi=3D15659-16589/42
> > >> >> >> > > > > > > > >> crt=3D8480'7 lcod
> > >> >> >> > > > > > > > >> 0'0 inactive NOTIFY] state<Start>:=20
> > >> >> >> > > > > > > > >> transitioning to
> > >> Stray
> > >> >> >> > > > > > > > >>=C2=A0=C2=A0=C2=A0 -16> 2015-04-27 10:17:08.=
808621=20
> > >> >> >> > > > > > > > >>7fd8e748d700=C2=A0 5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7]
> > >> >> >> > > > > > > > >>local-les=3D16609
> > >> >> >> > > > > > > > >> n=3D0
> > >> >> >> > > > > > > > >> ec=3D1 les/c
> > >> >> >> > > > > > > > >> 16609/16659
> > >> >> >> > > > > > > > >> 16590/16590/16590) [24,3,23] r=3D2 lpr=3D17=
838
> > >> >> >> > > > > > > > >> pi=3D15659-16589/42
> > >> >> >> > > > > > > > >> crt=3D8480'7 lcod
> > >> >> >> > > > > > > > >> 0'0 inactive NOTIFY] exit Start 0.000025 0
> > >> >> >> > > > > > > > >>0.000000 =C2=A0=C2=A0=C2=A0 -15> 2015-04-27=20
> > >> >> >> > > > > > > > >>10:17:08.808637 7fd8e748d700=C2=A0 5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[0.189( v 8480'7 (0'0,8480'7]
> > >> >> >> > > > > > > > >>local-les=3D16609
> > >> >> >> > > > > > > > >> n=3D0
> > >> >> >> > > > > > > > >> ec=3D1 les/c
> > >> >> >> > > > > > > > >> 16609/16659
> > >> >> >> > > > > > > > >> 16590/16590/16590) [24,3,23] r=3D2 lpr=3D17=
838
> > >> >> >> > > > > > > > >> pi=3D15659-16589/42
> > >> >> >> > > > > > > > >> crt=3D8480'7 lcod
> > >> >> >> > > > > > > > >> 0'0 inactive NOTIFY] enter Started/Stray =C2=
=A0=C2=A0
> > >> >> >> > > > > > > > >>=C2
> > >> >> >> > > > > > > > >>-14> 2015-04-27 10:17:08.808796 7fd8e748d700=
=C2
> > >> >> >> > > > > > > > >>5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[10.181( empty local-les=3D17879 n=3D=
0
> > >> >> >> > > > > > > > >>ec=3D17863  les/c
> > >> >> >> > > > > > > > >> 17879/17879
> > >> >> >> > > > > > > > >> 17863/17863/17863) [25,5,23] r=3D2 lpr=3D17=
879
> > >> >> >> > > > > > > > >>crt=3D0'0  inactive NOTIFY] exit Reset 0.119=
467=20
> > >> >> >> > > > > > > > >>4
> > >> >> >> > > > > > > > >>0.000037 =C2=A0=C2=A0=C2=A0 -13> 2015-04-27=20
> > >> >> >> > > > > > > > >>10:17:08.808817 7fd8e748d700=C2=A0 5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[10.181( empty local-les=3D17879 n=3D=
0
> > >> >> >> > > > > > > > >>ec=3D17863  les/c
> > >> >> >> > > > > > > > >> 17879/17879
> > >> >> >> > > > > > > > >> 17863/17863/17863) [25,5,23] r=3D2 lpr=3D17=
879
> > >> >> >> > > > > > > > >>crt=3D0'0  inactive NOTIFY] enter Started =C2=
=A0=C2=A0=C2
> > >> >> >> > > > > > > > >>-12> 2015-04-27 10:17:08.808828 7fd8e748d700=
=C2
> > >> >> >> > > > > > > > >>5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[10.181( empty local-les=3D17879 n=3D=
0
> > >> >> >> > > > > > > > >>ec=3D17863  les/c
> > >> >> >> > > > > > > > >> 17879/17879
> > >> >> >> > > > > > > > >> 17863/17863/17863) [25,5,23] r=3D2 lpr=3D17=
879
> > >> >> >> > > > > > > > >>crt=3D0'0  inactive NOTIFY] enter Start =C2=A0=
=C2=A0=C2
> > >> >> >> > > > > > > > >>-11> 2015-04-27 10:17:08.808838 7fd8e748d700=
=C2
> > >> >> >> > > > > > > > >>1
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[10.181( empty local-les=3D17879 n=3D=
0
> > >> >> >> > > > > > > > >>ec=3D17863  les/c
> > >> >> >> > > > > > > > >> 17879/17879
> > >> >> >> > > > > > > > >> 17863/17863/17863) [25,5,23] r=3D2 lpr=3D17=
879
> > >> >> >> > > > > > > > >>crt=3D0'0  inactive NOTIFY]
> > >> >> >> > > > > > > > >> state<Start>: transitioning to Stray =C2=A0=
=C2=A0=C2
> > >> >> >> > > > > > > > >>-10> 2015-04-27 10:17:08.808849 7fd8e748d700=
=C2
> > >> >> >> > > > > > > > >>5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[10.181( empty local-les=3D17879 n=3D=
0
> > >> >> >> > > > > > > > >>ec=3D17863  les/c
> > >> >> >> > > > > > > > >> 17879/17879
> > >> >> >> > > > > > > > >> 17863/17863/17863) [25,5,23] r=3D2 lpr=3D17=
879
> > >> >> >> > > > > > > > >>crt=3D0'0  inactive NOTIFY] exit Start 0.000=
020=20
> > >> >> >> > > > > > > > >>0
> > >> >> >> > > > > > > > >>0.000000 =C2=A0=C2=A0=C2=A0=C2=A0 -9> 2015-0=
4-27
> > >> >> >> > > > > > > > >>10:17:08.808861 7fd8e748d700=C2=A0 5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[10.181( empty local-les=3D17879 n=3D=
0
> > >> >> >> > > > > > > > >>ec=3D17863  les/c
> > >> >> >> > > > > > > > >> 17879/17879
> > >> >> >> > > > > > > > >> 17863/17863/17863) [25,5,23] r=3D2 lpr=3D17=
879
> > >> >> >> > > > > > > > >>crt=3D0'0  inactive NOTIFY] enter Started/St=
ray=20
> > >> >> >> > > > > > > > >>=C2 =C2=A0=C2=A0=C2=A0 -8> 2015-04-27 10:17:=
08.809427=20
> > >> >> >> > > > > > > > >>7fd8e748d700=C2=A0 5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[2.189( empty local-les=3D16127 n=3D=
0=20
> > >> >> >> > > > > > > > >>ec=3D1 les/c
> > >> >> >> > > > > > > > >> 16127/16344
> > >> >> >> > > > > > > > >> 16125/16125/16125) [23,5] r=3D0 lpr=3D17838
> > >> >> >> > > > > > > > >>crt=3D0'0 mlcod
> > >> >> >> > > > > > > > >> 0'0 inactive] exit Reset 7.511623 45=20
> > >> >> >> > > > > > > > >>0.000165 =C2=A0=C2=A0=C2=A0=C2=A0 -7> 2015-0=
4-27=20
> > >> >> >> > > > > > > > >>10:17:08.809445 7fd8e748d700=C2=A0 5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[2.189( empty local-les=3D16127 n=3D=
0=20
> > >> >> >> > > > > > > > >>ec=3D1 les/c
> > >> >> >> > > > > > > > >> 16127/16344
> > >> >> >> > > > > > > > >> 16125/16125/16125) [23,5] r=3D0 lpr=3D17838
> > >> >> >> > > > > > > > >>crt=3D0'0 mlcod
> > >> >> >> > > > > > > > >> 0'0 inactive] enter Started =C2=A0=C2=A0=C2=
=A0=C2=A0 -6>
> > >> >> >> > > > > > > > >>2015-04-27 10:17:08.809456 7fd8e748d700=C2=A0=
 5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[2.189( empty local-les=3D16127 n=3D=
0=20
> > >> >> >> > > > > > > > >>ec=3D1 les/c
> > >> >> >> > > > > > > > >> 16127/16344
> > >> >> >> > > > > > > > >> 16125/16125/16125) [23,5] r=3D0 lpr=3D17838
> > >> >> >> > > > > > > > >>crt=3D0'0 mlcod
> > >> >> >> > > > > > > > >> 0'0 inactive] enter Start =C2=A0=C2=A0=C2=A0=
=C2=A0 -5>
> > >> >> >> > > > > > > > >>2015-04-27 10:17:08.809468 7fd8e748d700=C2=A0=
 1
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[2.189( empty local-les=3D16127 n=3D=
0=20
> > >> >> >> > > > > > > > >>ec=3D1 les/c
> > >> >> >> > > > > > > > >> 16127/16344
> > >> >> >> > > > > > > > >> 16125/16125/16125) [23,5] r=3D0 lpr=3D17838
> > >> >> >> > > > > > > > >>crt=3D0'0 mlcod
> > >> >> >> > > > > > > > >> 0'0 inactive]
> > >> >> >> > > > > > > > >> state<Start>: transitioning to Primary =C2=A0=
=C2=A0=C2=A0
> > >> >> >> > > > > > > > >>=C2
> > >> >> >> > > > > > > > >>-4> 2015-04-27 10:17:08.809479 7fd8e748d700=C2=
=A0=20
> > >> >> >> > > > > > > > >>-4> 5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[2.189( empty local-les=3D16127 n=3D=
0=20
> > >> >> >> > > > > > > > >>ec=3D1 les/c
> > >> >> >> > > > > > > > >> 16127/16344
> > >> >> >> > > > > > > > >> 16125/16125/16125) [23,5] r=3D0 lpr=3D17838
> > >> >> >> > > > > > > > >>crt=3D0'0 mlcod
> > >> >> >> > > > > > > > >> 0'0 inactive] exit Start 0.000023 0 0.00000=
0=20
> > >> >> >> > > > > > > > >>=C2 =C2=A0=C2=A0=C2=A0 -3> 2015-04-27 10:17:=
08.809492=20
> > >> >> >> > > > > > > > >>7fd8e748d700=C2=A0 5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[2.189( empty local-les=3D16127 n=3D=
0=20
> > >> >> >> > > > > > > > >>ec=3D1 les/c
> > >> >> >> > > > > > > > >> 16127/16344
> > >> >> >> > > > > > > > >> 16125/16125/16125) [23,5] r=3D0 lpr=3D17838
> > >> >> >> > > > > > > > >>crt=3D0'0 mlcod
> > >> >> >> > > > > > > > >> 0'0 inactive] enter Started/Primary =C2=A0=C2=
=A0=C2=A0=C2
> > >> >> >> > > > > > > > >>-2> 2015-04-27 10:17:08.809502 7fd8e748d700=C2=
=A0=20
> > >> >> >> > > > > > > > >>-2> 5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[2.189( empty local-les=3D16127 n=3D=
0=20
> > >> >> >> > > > > > > > >>ec=3D1 les/c
> > >> >> >> > > > > > > > >> 16127/16344
> > >> >> >> > > > > > > > >> 16125/16125/16125) [23,5] r=3D0 lpr=3D17838
> > >> >> >> > > > > > > > >>crt=3D0'0 mlcod
> > >> >> >> > > > > > > > >> 0'0 inactive] enter Started/Primary/Peering=
=20
> > >> >> >> > > > > > > > >>=C2 =C2=A0=C2=A0=C2=A0 -1> 2015-04-27 10:17:=
08.809513=20
> > >> >> >> > > > > > > > >>7fd8e748d700=C2=A0 5
> > >> >> >> > > > > > > > >> osd.23
> > >> >> >> > > > pg_epoch:
> > >> >> >> > > > >
> > >> >> >> > > > > > > > >> 17882 pg[2.189( empty local-les=3D16127 n=3D=
0=20
> > >> >> >> > > > > > > > >>ec=3D1 les/c
> > >> >> >> > > > > > > > >> 16127/16344
> > >> >> >> > > > > > > > >> 16125/16125/16125) [23,5] r=3D0 lpr=3D17838
> > >> >> >> > > > > > > > >>crt=3D0'0 mlcod
> > >> >> >> > > > > > > > >> 0'0 peering] enter=20
> > >> >> >> > > > > > > > >>Started/Primary/Peering/GetInfo =C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0>
> > >> >> >> > > > > > > > >>2015-04-27 10:17:08.813837 7fd8e748d700 -1
> > >> >> >> > > > > > > ./include/interval_set.h:
> > >> >> >> > > > > > > > >> In
> > >> >> >> > > > > > > > >> function 'void interval_set<T>::erase(T, T)=
=20
> > >> >> >> > > > > > > > >> [with T =3D
> > >> >> >> > > snapid_t]'
> > >> >> >> > > > > > > > >> thread
> > >> >> >> > > > > > > > >> 7fd8e748d700 time 2015-04-27 10:17:08.80989=
9
> > >> >> >> > > > > > > > >> ./include/interval_set.h: 385: FAILED=20
> > >> >> >> > > > > > > > >> assert(_size >=3D
> > >> >> >> > > > > > > > >> 0)
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >>=C2=A0 ceph version 0.94.1
> > >> >> >> > > > > > > > >> (e4bfad3a3c51054df7e537a724c8d0bf9be972ff)
> > >> >> >> > > > > > > > >>=C2=A0 1: (ceph::__ceph_assert_fail(char con=
st*,=20
> > >> >> >> > > > > > > > >>char
> > >> const*,
> > >> >> >> > > > > > > > >> int, char
> > >> >> >> > > > > > > > >> const*)+0x8b)  [0xbc271b] =C2=A0 2:
> > >> >> >> > > > > > > > >>=20
> > >> >> >> > > > > > > > >>(interval_set<snapid_t>::subtract(interval_s=
e
> > >> >> >> > > > > > > > >>t<
> > >> >> >> > > > > > > > >>snapid_t
> > >> >> >> > > > > > > > >> >
> > >> >> >> > > > > > > > >> const&)+0xb0) [0x82cd50] =C2=A0 3:=20
> > >> >> >> > > > > > > > >>(PGPool::update(std::tr1::shared_ptr<OSDMap
> > >> >> >> > > > > > > > >> const>)+0x52e) [0x80113e]
> > >> >> >> > > > > > > > >>=C2=A0 4:
> > >> (PG::handle_advance_map(std::tr1::shared_ptr<OSDMap
> > >> >> >> > > > > > > > >> const>, std::tr1::shared_ptr<OSDMap const>,=
=20
> > >> >> >> > > > > > > > >> const>std::vector<int,
> > >> >> >> > > > > > > > >> std::allocator<int> >&, int,=20
> > >> >> >> > > > > > > > >> std::vector<int, std::allocator<int>
> > >> >> >> > > > > > > > >> >&, int, PG::RecoveryCtx*)+0x282) [0x801652=
]
> > >> >> >> > > > > > > > >>=C2=A0 5: (OSD::advance_pg(unsigned int, PG*=
,=20
> > >> >> >> > > > > > > > >>ThreadPool::TPHandle&, PG::RecoveryCtx*,=20
> > >> >> >> > > > > > > > >>std::set<boost::intrusive_ptr<PG>,
> > >> >> >> > > > > > > > >> std::less<boost::intrusive_ptr<PG> >,=20
> > >> >> >> > > > > > > > >>std::allocator<boost::intrusive_ptr<PG> >
> > >> >> >> > > > > > > > >>>*)+0x2c3)  [0x6b0e43] =C2=A0 6:=20
> > >> >> >> > > > > > > > >>(OSD::process_peering_events(std::list<PG*,
> > >> >> >> > > > > > > > >> std::allocator<PG*>
> > >> >> >> > > > > > > > >> > const&,
> > >> >> >> > > > > > > > >> ThreadPool::TPHandle&)+0x21c) [0x6b191c] =C2=
=A0 7:=20
> > >> >> >> > > > > > > > >>(OSD::PeeringWQ::_process(std::list<PG*,
> > >> >> >> > > > > > > > >> std::allocator<PG*>
> > >> >> >> > > > > > > > >> > const&,
> > >> >> >> > > > > > > > >> ThreadPool::TPHandle&)+0x18) [0x709278] =C2=
=A0 8:
> > >> (ThreadPool::worker(ThreadPool::WorkThread*)+0xa5e)
> > >> >> >> > > > > > > > >> [0xbb38ae]
> > >> >> >> > > > > > > > >>=C2=A0 9: (ThreadPool::WorkThread::entry()+0=
x10)
> > >> >> >> > > > > > > > >>[0xbb4950] =C2=A0 10: (()+0x8182)=20
> > >> >> >> > > > > > > > >>[0x7fd906946182] =C2=A0 11: (clone()+0x6d)=20
> > >> >> >> > > > > > > > >>[0x7fd904eb147d]
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >> Also by monitoring (ceph -w) I get the=20
> > >> >> >> > > > > > > > >> following messages, also lots of
> > >> >> >> > > > > > > them.
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >> 2015-04-27 10:39:52.935812 mon.0 [INF]
> > from=3D'client.?
> > >> >> >> > > > > > > 10.20.0.13:0/1174409'
> > >> >> >> > > > > > > > >> entity=3D'osd.30' cmd=3D[{"prefix": "osd cr=
ush=20
> > >> >> >> > > > > > > > >> create-or-move",
> > >> >> >> > > > "args":
> > >> >> >> > > > > > > > >> ["host=3Dceph3", "root=3Ddefault"], "id": 3=
0,
> > "weight":
> > >> >> 1.82}]:
> > >> >> >>
> > >> >> >> > > > > > > > >> dispatch
> > >> >> >> > > > > > > > >> 2015-04-27 10:39:53.297376 mon.0 [INF]
> > from=3D'client.?
> > >> >> >> > > > > > > 10.20.0.13:0/1174483'
> > >> >> >> > > > > > > > >> entity=3D'osd.26' cmd=3D[{"prefix": "osd cr=
ush=20
> > >> >> >> > > > > > > > >> create-or-move",
> > >> >> >> > > > "args":
> > >> >> >> > > > > > > > >> ["host=3Dceph3", "root=3Ddefault"], "id": 2=
6,
> > "weight":
> > >> >> 1.82}]:
> > >> >> >>
> > >> >> >> > > > > > > > >> dispatch
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >> This is a cluster of 3 nodes with 36 OSD's,=
=20
> > >> >> >> > > > > > > > >> nodes are also mons and mds's to save serve=
rs.
> > >> >> >> > > > > > > > >> All run Ubuntu
> > >> >> >> 14.04.2.
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >> I have pretty much tried everything I could=
=20
> > >> >> >> > > > > > > > >> think
> > of.
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >> Restarting daemons doesn't help.
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >> Any help would be appreciated. I can also=20
> > >> >> >> > > > > > > > >> provide more logs if necessary. They just=20
> > >> >> >> > > > > > > > >> seem to get pretty large in few
> > >> >> >> > > moments.
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >> Thank you
> > >> >> >> > > > > > > > >> Tuomas
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >> ___________________________________________=
_
> > >> >> >> > > > > > > > >> __ _ ceph-users mailing list=20
> > >> >> >> > > > > > > > >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > >> >> >> > > > > > > > >> http://lists.ceph.com/listinfo.cgi/ceph-use=
r
> > >> >> >> > > > > > > > >> s-
> > >> >> >> > > > > > > > >> ceph.com
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >>
> > >> >> >> > > > > > > > >
> > >> >> >> > > > > > > > >
> > >> >> >> > > > > > > > > ____________________________________________=
_
> > >> >> >> > > > > > > > > __ ceph-users mailing list=20
> > >> >> >> > > > > > > > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=20
> > >> >> >> > > > > > > > > http://lists.ceph.com/listinfo.cgi/ceph-user=
s
> > >> >> >> > > > > > > > > -c
> > >> >> >> > > > > > > > > eph.com
> > >> >> >> > > > > > > > >
> > >> >> >> > > > > > > > >
> > >> >> >> > > > > > > > >
> > >> >> >> > > > > > > >
> > >> >> >> > > > > > > >
> > >> >> >> > > > > > > > ______________________________________________=
_
> > >> >> >> > > > > > > > ceph-users mailing list=20
> > >> >> >> > > > > > > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=20
> > >> >> >> > > > > > > > http://lists.ceph.com/listinfo.cgi/ceph-users-=
c
> > >> >> >> > > > > > > > ep
> > >> >> >> > > > > > > > h.com
> > >> >> >> > > > > > > >
> > >> >> >> > > > > > > >
> > >> >> >> > > > > > > >
> > >> >> >> > > > > > > > ______________________________________________=
_
> > >> >> >> > > > > > > > ceph-users mailing list=20
> > >> >> >> > > > > > > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=20
> > >> >> >> > > > > > > > http://lists.ceph.com/listinfo.cgi/ceph-users-=
c
> > >> >> >> > > > > > > > ep
> > >> >> >> > > > > > > > h.com
> > >> >> >> > > > > > > >
> > >> >> >> > > > > > > >
> > >> >> >> > > > > > >
> > >> >> >> > > > > >
> > >> >> >> > > > > >
> > >> >> >> > > > >
> > >> >> >> > > > >
> > >> >> >> > > >
> > >> >> >> > >
> > >> >> >> > >
> > >> >> >> > _______________________________________________
> > >> >> >> > ceph-users mailing list
> > >> >> >> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > >> >> >> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > >> >> >> >
> > >> >> >> >
> > >> >> >>
> > >> >> >
> > >> >>
> > >> >>
> > >> >> --
> > >> >> To unsubscribe from this list: send the line "unsubscribe=20
> > >> >> ceph-devel" in the body of a message to=20
> > >> >> majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at=C2=20
> > >> >> http://vger.kernel.org/majordomo-info.html
> > >> >>
> > >> >>
> > >> > _______________________________________________
> > >> > ceph-users mailing list
> > >> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > >> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > >> >
> > >>
> > >>
> > >>
> >=20
> >=20
> >=20
> >=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1632353146-1430760053=:24939
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-1632353146-1430760053=:24939--
