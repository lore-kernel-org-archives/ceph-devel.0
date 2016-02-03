From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: inline vector container
Date: Wed, 3 Feb 2016 15:57:20 -0500 (EST)
Message-ID: <1382260306.31547015.1454533040094.JavaMail.zimbra@redhat.com>
References: <CY1PR0201MB189757D3C50DF09DDD8F2877E8D00@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1602031503230.28963@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:35379 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184AbcBCU5W convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 15:57:22 -0500
In-Reply-To: <alpine.DEB.2.11.1602031503230.28963@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel@vger.kernel.org, cbodley@redhat.com

Hi,

I think we should go with small_vector for this role, yes.  I found two=
 issues.  First, there are critical defects in small_vector prior to bo=
ost 1.6.0.  Second, though it is header-only, the coupling with related=
 version-specific boost types (container, allocator, respective detail =
types, and platform-specific selectors...) seems to make pulling it in =
separately pretty unrealistic as an option.  I looked at the cost of pu=
lling in and selectively compiling (libs) an entire boost 1.6, and that=
 went a lot easier (added less than a minute to my build time).

Matt

----- Original Message -----
> From: "Sage Weil" <sweil@redhat.com>
> To: "Allen Samuels" <Allen.Samuels@sandisk.com>
> Cc: ceph-devel@vger.kernel.org, mbenjami@redhat.com, cbodley@redhat.c=
om
> Sent: Wednesday, February 3, 2016 3:04:57 PM
> Subject: Re: inline vector container
>=20
> On Wed, 3 Feb 2016, Allen Samuels wrote:
> > One thing that the code base needs is a simple vector container tha=
t is
> > optimized for a small number of elements, i.e., for small element c=
ounts we
> > avoid the malloc/free overhead. But fully supports being resized in=
to
> > larger
> > containers that are unbounded. Of course it will need to follow all=
 of the
> > proper object copy/move semantics so that things like unique_ptr, e=
tc work
> > correctly.
> >=20
> > I heard rumors that there was one available in the boost world, but=
 I can=E2=80=99t
> > seem to find it. Do you know about one being available?
>=20
> http://www.boost.org/doc/libs/1_60_0/doc/html/boost/container/small_v=
ector.html
>=20
> > I=E2=80=99ve been prototyping one myself, just to get re-familiar w=
ith all of the
> > C++11 move sementics, and trivial constructors, etc.
> >=20
> > The code is pretty complete, but the testing gets rather involved. =
There=E2=80=99s
> > no reason to contain this if it=E2=80=99s available elsewhere. But =
if it isn=E2=80=99t I
> > plan on continuing this=E2=80=A6
>=20
> I think Casey had prototyped something similar using a custom allocat=
or,
> too, but I didn't actually look at the result.  And Matt talked about=
 just
> pulling the boost one in-tree until we get updated boost in the suppo=
rted
> distros, but I forget if he ran into problems there or not...
>=20
> sage

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
