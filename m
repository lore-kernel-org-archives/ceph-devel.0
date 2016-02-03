From: Milosz Tanski <milosz@adfin.com>
Subject: Re: inline vector container
Date: Wed, 3 Feb 2016 16:21:12 -0500
Message-ID: <CANP1eJEd+R1mb=UVyfSzpb+d1hvS_26poaM7tJpfCyFCrsuDFw@mail.gmail.com>
References: <CY1PR0201MB189757D3C50DF09DDD8F2877E8D00@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<alpine.DEB.2.11.1602031503230.28963@cpach.fuggernut.com>
	<1382260306.31547015.1454533040094.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36844 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933510AbcBCVVN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 16:21:13 -0500
Received: by mail-lb0-f176.google.com with SMTP id dx2so19869791lbd.3
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 13:21:12 -0800 (PST)
In-Reply-To: <1382260306.31547015.1454533040094.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>, cbodley@redhat.com

On Wed, Feb 3, 2016 at 3:57 PM, Matt Benjamin <mbenjamin@redhat.com> wr=
ote:
>
> Hi,
>
> I think we should go with small_vector for this role, yes.  I found t=
wo issues.  First, there are critical defects in small_vector prior to =
boost 1.6.0.  Second, though it is header-only, the coupling with relat=
ed version-specific boost types (container, allocator, respective detai=
l types, and platform-specific selectors...) seems to make pulling it i=
n separately pretty unrealistic as an option.  I looked at the cost of =
pulling in and selectively compiling (libs) an entire boost 1.6, and th=
at went a lot easier (added less than a minute to my build time).
>
> Matt
>
> ----- Original Message -----
> > From: "Sage Weil" <sweil@redhat.com>
> > To: "Allen Samuels" <Allen.Samuels@sandisk.com>
> > Cc: ceph-devel@vger.kernel.org, mbenjami@redhat.com, cbodley@redhat=
=2Ecom
> > Sent: Wednesday, February 3, 2016 3:04:57 PM
> > Subject: Re: inline vector container
> >
> > On Wed, 3 Feb 2016, Allen Samuels wrote:
> > > One thing that the code base needs is a simple vector container t=
hat is
> > > optimized for a small number of elements, i.e., for small element=
 counts we
> > > avoid the malloc/free overhead. But fully supports being resized =
into
> > > larger
> > > containers that are unbounded. Of course it will need to follow a=
ll of the
> > > proper object copy/move semantics so that things like unique_ptr,=
 etc work
> > > correctly.
> > >
> > > I heard rumors that there was one available in the boost world, b=
ut I can=E2=80=99t
> > > seem to find it. Do you know about one being available?
> >
> > http://www.boost.org/doc/libs/1_60_0/doc/html/boost/container/small=
_vector.html


The fb / folly code also has a small vector:
https://github.com/facebook/folly/blob/master/folly/small_vector.h
that used a C++11 move semantics whenever possible. Compared other
parts of folly this has pretty small dependencies on folly and those
can prob be ripped out.

>
>
> >
> > > I=E2=80=99ve been prototyping one myself, just to get re-familiar=
 with all of the
> > > C++11 move sementics, and trivial constructors, etc.
> > >
> > > The code is pretty complete, but the testing gets rather involved=
=2E There=E2=80=99s
> > > no reason to contain this if it=E2=80=99s available elsewhere. Bu=
t if it isn=E2=80=99t I
> > > plan on continuing this=E2=80=A6
> >
> > I think Casey had prototyped something similar using a custom alloc=
ator,
> > too, but I didn't actually look at the result.  And Matt talked abo=
ut just
> > pulling the boost one in-tree until we get updated boost in the sup=
ported
> > distros, but I forget if he ran into problems there or not...
> >
> > sage
>
> --
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-707-0660
> fax.  734-769-8938
> cel.  734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
