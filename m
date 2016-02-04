From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: inline vector container
Date: Thu, 4 Feb 2016 09:42:58 -0500 (EST)
Message-ID: <1606323224.32079941.1454596978667.JavaMail.zimbra@redhat.com>
References: <CY1PR0201MB189757D3C50DF09DDD8F2877E8D00@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1602031503230.28963@cpach.fuggernut.com> <1382260306.31547015.1454533040094.JavaMail.zimbra@redhat.com> <59448274.31581132.1454534771209.JavaMail.zimbra@redhat.com> <CY1PR0201MB1897486B3D49159CEDCD3007E8D00@CY1PR0201MB1897.namprd02.prod.outlook.com> <1674294591.31606738.1454537442587.JavaMail.zimbra@redhat.com> <56B33EB6.5030004@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:38539 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbcBDOnF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Feb 2016 09:43:05 -0500
In-Reply-To: <56B33EB6.5030004@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Casey Bodley <cbodley@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

Hi Willem,

Milosz pasted a file inline.  Facebook's upstream repo is https://githu=
b.com/facebook/folly (Mr. Google), but what I was agreeing is, for the =
present, if we can't realize boost small_vector, we might adapt just th=
at type from Folly for the short term (that was Milosz meaning, in this=
 thread).

(So don't panic ;)

Matt

----- Original Message -----
> From: "Willem Jan Withagen" <wjw@digiware.nl>
> To: "Matt Benjamin" <mbenjamin@redhat.com>, "Allen Samuels" <Allen.Sa=
muels@sandisk.com>
> Cc: "Casey Bodley" <cbodley@redhat.com>, "Sage Weil" <sweil@redhat.co=
m>, ceph-devel@vger.kernel.org
> Sent: Thursday, February 4, 2016 7:06:14 AM
> Subject: Re: inline vector container
>=20
> On 3-2-2016 23:10, Matt Benjamin wrote:
> > I'll prioritize this.  Using more of folly may be a worthy project =
as well,
> > but that can wait for later... :)
>=20
> Hi Matt,
>=20
> Can you give me a URL for the folly stuff.
> Since I cannot find any reference to it in the FreeBSD ports.
>=20
> I think I'd otherwise prefer Boost, since the ports already contains =
a
> fair amount of Boost stuff.
>=20
> Currently I have installed:
> boost-all-1.55.0      The "meta-port" for boost libraries
> boost-docs-1.55.0     Documentation for libraries from boost.org
> boost-jam-1.55.0      Build tool from the boost.org
> boost-libs-1.55.0_9   Free portable C++ libraries (without Boost.Pyth=
on)
>=20
> But I see that the new ports have migrated to:
> /usr/ports/devel/boost_build/Makefile:PORTVERSION=3D      2.0.m12
>=20
> So that would move it beyond 1.6, I presume.
>=20
> --WjW
>=20
>=20
> > tx!
> >=20
> > Matt
> >=20
> > ----- Original Message -----
> >> From: "Allen Samuels" <Allen.Samuels@sandisk.com>
> >> To: "Casey Bodley" <cbodley@redhat.com>, "Matt Benjamin"
> >> <mbenjamin@redhat.com>
> >> Cc: "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org
> >> Sent: Wednesday, February 3, 2016 5:06:57 PM
> >> Subject: RE: inline vector container
> >>
> >> I would say that just pulling the latest boost into the tree and u=
sing it
> >> for
> >> builds is the best path forward. But I'm in no way competent to ma=
ke that
> >> kind of change in the build system -- especially during the automa=
ke cmake
> >> changeover period.
> >>
> >>
> >> Allen Samuels
> >> Software Architect, Fellow, Systems and Software Solutions
> >>
> >> 2880 Junction Avenue, San Jose, CA 95134
> >> T: +1 408 801 7030| M: +1 408 780 6416
> >> allen.samuels@SanDisk.com
> >>
> >>
> >> -----Original Message-----
> >> From: Casey Bodley [mailto:cbodley@redhat.com]
> >> Sent: Wednesday, February 03, 2016 1:26 PM
> >> To: Matt Benjamin <mbenjamin@redhat.com>
> >> Cc: Sage Weil <sweil@redhat.com>; Allen Samuels
> >> <Allen.Samuels@sandisk.com>;
> >> ceph-devel@vger.kernel.org
> >> Subject: Re: inline vector container
> >>
> >> Hi Allen,
> >>
> >> I did spend some time a couple months ago experimenting with a cus=
tom
> >> allocator with inline storage for standard containers. You can fin=
d my
> >> branch on github at
> >> https://github.com/cbodley/ceph/commits/wip-preallocator.
> >>
> >> I was aiming for a general solution that worked with non-contiguou=
s
> >> containers, but couldn't find a good way to handle deallocations. =
So the
> >> approach was really only a good fit for std::vector.
> >>
> >> I also had trouble getting it to do the right thing with the copy =
and move
> >> operators. I found that it was trying to use the new allocator to =
release
> >> memory that came from the old allocator. Presumably there's a way =
to make
> >> this work using std::allocator_traits; have you had better luck he=
re? I'd
> >> love to see your prototype.
> >>
> >> I tend to agree that we should go with the boost solution if we ca=
n. But
> >> if
> >> a) we can't use boost::small_vector in the near-term due to versio=
ning,
> >> and
> >> b) we can get a custom version tested and working, it might be wor=
th
> >> pursuing.
> >>
> >> Casey
> >>
> >> ----- Original Message -----
> >>> Hi,
> >>>
> >>> I think we should go with small_vector for this role, yes.  I fou=
nd
> >>> two issues.  First, there are critical defects in small_vector pr=
ior
> >>> to boost 1.6.0.  Second, though it is header-only, the coupling w=
ith
> >>> related version-specific boost types (container, allocator, respe=
ctive
> >>> detail types, and platform-specific selectors...) seems to make
> >>> pulling it in separately pretty unrealistic as an option.  I look=
ed at
> >>> the cost of pulling in and selectively compiling (libs) an entire
> >>> boost 1.6, and that went a lot easier (added less than a minute t=
o my
> >>> build
> >>> time).
> >>>
> >>> Matt
> >>>
> >>> ----- Original Message -----
> >>>> From: "Sage Weil" <sweil@redhat.com>
> >>>> To: "Allen Samuels" <Allen.Samuels@sandisk.com>
> >>>> Cc: ceph-devel@vger.kernel.org, mbenjami@redhat.com,
> >>>> cbodley@redhat.com
> >>>> Sent: Wednesday, February 3, 2016 3:04:57 PM
> >>>> Subject: Re: inline vector container
> >>>>
> >>>> On Wed, 3 Feb 2016, Allen Samuels wrote:
> >>>>> One thing that the code base needs is a simple vector container
> >>>>> that is optimized for a small number of elements, i.e., for sma=
ll
> >>>>> element counts we avoid the malloc/free overhead. But fully
> >>>>> supports being resized into larger containers that are unbounde=
d.
> >>>>> Of course it will need to follow all of the proper object
> >>>>> copy/move semantics so that things like unique_ptr, etc work
> >>>>> correctly.
> >>>>>
> >>>>> I heard rumors that there was one available in the boost world,
> >>>>> but I can=E2=80=99t seem to find it. Do you know about one bein=
g
> >>>>> available?
> >>>>
> >>>> http://www.boost.org/doc/libs/1_60_0/doc/html/boost/container/sm=
all_
> >>>> vector.html
> >>>>
> >>>>> I=E2=80=99ve been prototyping one myself, just to get re-famili=
ar with all
> >>>>> of the
> >>>>> C++11 move sementics, and trivial constructors, etc.
> >>>>>
> >>>>> The code is pretty complete, but the testing gets rather involv=
ed.
> >>>>> There=E2=80=99s
> >>>>> no reason to contain this if it=E2=80=99s available elsewhere. =
But if it
> >>>>> isn=E2=80=99t I plan on continuing this=E2=80=A6
> >>>>
> >>>> I think Casey had prototyped something similar using a custom
> >>>> allocator, too, but I didn't actually look at the result.  And M=
att
> >>>> talked about just pulling the boost one in-tree until we get upd=
ated
> >>>> boost in the supported distros, but I forget if he ran into prob=
lems
> >>>> there or not...
> >>>>
> >>>> sage
> >>>
> >>> --
> >>> --
> >>> Matt Benjamin
> >>> Red Hat, Inc.
> >>> 315 West Huron Street, Suite 140A
> >>> Ann Arbor, Michigan 48103
> >>>
> >>> http://www.redhat.com/en/technologies/storage
> >>>
> >>> tel.  734-707-0660
> >>> fax.  734-769-8938
> >>> cel.  734-216-5309
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"
> >>> in the body of a message to majordomo@vger.kernel.org More majord=
omo
> >>> info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >> PLEASE NOTE: The information contained in this electronic mail mes=
sage is
> >> intended only for the use of the designated recipient(s) named abo=
ve. If
> >> the
> >> reader of this message is not the intended recipient, you are here=
by
> >> notified that you have received this message in error and that any=
 review,
> >> dissemination, distribution, or copying of this message is strictl=
y
> >> prohibited. If you have received this communication in error, plea=
se
> >> notify
> >> the sender by telephone or e-mail (as shown above) immediately and=
 destroy
> >> any and all copies of this message in your possession (whether har=
d copies
> >> or electronically stored copies).
> >>
> >=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
--=20
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
