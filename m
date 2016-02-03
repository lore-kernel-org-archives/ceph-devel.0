From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: inline vector container
Date: Wed, 3 Feb 2016 16:24:51 -0500 (EST)
Message-ID: <901964622.31580193.1454534691235.JavaMail.zimbra@redhat.com>
References: <CY1PR0201MB189757D3C50DF09DDD8F2877E8D00@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1602031503230.28963@cpach.fuggernut.com> <1382260306.31547015.1454533040094.JavaMail.zimbra@redhat.com> <CANP1eJEd+R1mb=UVyfSzpb+d1hvS_26poaM7tJpfCyFCrsuDFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:52773 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763AbcBCVYz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 16:24:55 -0500
In-Reply-To: <CANP1eJEd+R1mb=UVyfSzpb+d1hvS_26poaM7tJpfCyFCrsuDFw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Sage Weil <sweil@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>, cbodley@redhat.com

Yeah, that looks a lot more reasonable if we must split it out, though =
I would prefer boost.

Matt

----- Original Message -----
> From: "Milosz Tanski" <milosz@adfin.com>
> To: "Matt Benjamin" <mbenjamin@redhat.com>
> Cc: "Sage Weil" <sweil@redhat.com>, "Allen Samuels" <Allen.Samuels@sa=
ndisk.com>, "ceph-devel"
> <ceph-devel@vger.kernel.org>, cbodley@redhat.com
> Sent: Wednesday, February 3, 2016 4:21:12 PM
> Subject: Re: inline vector container
>=20
> On Wed, Feb 3, 2016 at 3:57 PM, Matt Benjamin <mbenjamin@redhat.com> =
wrote:
> >
> > Hi,
> >
> > I think we should go with small_vector for this role, yes.  I found=
 two
> > issues.  First, there are critical defects in small_vector prior to=
 boost
> > 1.6.0.  Second, though it is header-only, the coupling with related
> > version-specific boost types (container, allocator, respective deta=
il
> > types, and platform-specific selectors...) seems to make pulling it=
 in
> > separately pretty unrealistic as an option.  I looked at the cost o=
f
> > pulling in and selectively compiling (libs) an entire boost 1.6, an=
d that
> > went a lot easier (added less than a minute to my build time).
> >
> > Matt
> >
> > ----- Original Message -----
> > > From: "Sage Weil" <sweil@redhat.com>
> > > To: "Allen Samuels" <Allen.Samuels@sandisk.com>
> > > Cc: ceph-devel@vger.kernel.org, mbenjami@redhat.com, cbodley@redh=
at.com
> > > Sent: Wednesday, February 3, 2016 3:04:57 PM
> > > Subject: Re: inline vector container
> > >
> > > On Wed, 3 Feb 2016, Allen Samuels wrote:
> > > > One thing that the code base needs is a simple vector container=
 that is
> > > > optimized for a small number of elements, i.e., for small eleme=
nt
> > > > counts we
> > > > avoid the malloc/free overhead. But fully supports being resize=
d into
> > > > larger
> > > > containers that are unbounded. Of course it will need to follow=
 all of
> > > > the
> > > > proper object copy/move semantics so that things like unique_pt=
r, etc
> > > > work
> > > > correctly.
> > > >
> > > > I heard rumors that there was one available in the boost world,=
 but I
> > > > can=E2=80=99t
> > > > seem to find it. Do you know about one being available?
> > >
> > > http://www.boost.org/doc/libs/1_60_0/doc/html/boost/container/sma=
ll_vector.html
>=20
>=20
> The fb / folly code also has a small vector:
> https://github.com/facebook/folly/blob/master/folly/small_vector.h
> that used a C++11 move semantics whenever possible. Compared other
> parts of folly this has pretty small dependencies on folly and those
> can prob be ripped out.
>=20
> >
> >
> > >
> > > > I=E2=80=99ve been prototyping one myself, just to get re-famili=
ar with all of
> > > > the
> > > > C++11 move sementics, and trivial constructors, etc.
> > > >
> > > > The code is pretty complete, but the testing gets rather involv=
ed.
> > > > There=E2=80=99s
> > > > no reason to contain this if it=E2=80=99s available elsewhere. =
But if it isn=E2=80=99t
> > > > I
> > > > plan on continuing this=E2=80=A6
> > >
> > > I think Casey had prototyped something similar using a custom all=
ocator,
> > > too, but I didn't actually look at the result.  And Matt talked a=
bout
> > > just
> > > pulling the boost one in-tree until we get updated boost in the s=
upported
> > > distros, but I forget if he ran into problems there or not...
> > >
> > > sage
> >
> > --
> > --
> > Matt Benjamin
> > Red Hat, Inc.
> > 315 West Huron Street, Suite 140A
> > Ann Arbor, Michigan 48103
> >
> > http://www.redhat.com/en/technologies/storage
> >
> > tel.  734-707-0660
> > fax.  734-769-8938
> > cel.  734-216-5309
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
>=20
> --
> Milosz Tanski
> CTO
> 16 East 34th Street, 15th floor
> New York, NY 10016
>=20
> p: 646-253-9055
> e: milosz@adfin.com
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
