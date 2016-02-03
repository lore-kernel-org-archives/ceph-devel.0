From: Casey Bodley <cbodley@redhat.com>
Subject: Re: inline vector container
Date: Wed, 3 Feb 2016 16:26:11 -0500 (EST)
Message-ID: <59448274.31581132.1454534771209.JavaMail.zimbra@redhat.com>
References: <CY1PR0201MB189757D3C50DF09DDD8F2877E8D00@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1602031503230.28963@cpach.fuggernut.com> <1382260306.31547015.1454533040094.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:56672 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbcBCV0O convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 16:26:14 -0500
In-Reply-To: <1382260306.31547015.1454533040094.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel@vger.kernel.org

Hi Allen,

I did spend some time a couple months ago experimenting with a custom a=
llocator
with inline storage for standard containers. You can find my branch on =
github
at https://github.com/cbodley/ceph/commits/wip-preallocator.

I was aiming for a general solution that worked with non-contiguous con=
tainers,
but couldn't find a good way to handle deallocations. So the approach w=
as really
only a good fit for std::vector.

I also had trouble getting it to do the right thing with the copy and m=
ove
operators. I found that it was trying to use the new allocator to relea=
se memory
that came from the old allocator. Presumably there's a way to make this=
 work
using std::allocator_traits; have you had better luck here? I'd love to=
 see your
prototype.

I tend to agree that we should go with the boost solution if we can. Bu=
t if
a) we can't use boost::small_vector in the near-term due to versioning,=
 and
b) we can get a custom version tested and working, it might be worth pu=
rsuing.

Casey

----- Original Message -----
> Hi,
>=20
> I think we should go with small_vector for this role, yes.  I found t=
wo
> issues.  First, there are critical defects in small_vector prior to b=
oost
> 1.6.0.  Second, though it is header-only, the coupling with related
> version-specific boost types (container, allocator, respective detail=
 types,
> and platform-specific selectors...) seems to make pulling it in separ=
ately
> pretty unrealistic as an option.  I looked at the cost of pulling in =
and
> selectively compiling (libs) an entire boost 1.6, and that went a lot=
 easier
> (added less than a minute to my build time).
>=20
> Matt
>=20
> ----- Original Message -----
> > From: "Sage Weil" <sweil@redhat.com>
> > To: "Allen Samuels" <Allen.Samuels@sandisk.com>
> > Cc: ceph-devel@vger.kernel.org, mbenjami@redhat.com, cbodley@redhat=
=2Ecom
> > Sent: Wednesday, February 3, 2016 3:04:57 PM
> > Subject: Re: inline vector container
> >=20
> > On Wed, 3 Feb 2016, Allen Samuels wrote:
> > > One thing that the code base needs is a simple vector container t=
hat is
> > > optimized for a small number of elements, i.e., for small element=
 counts
> > > we
> > > avoid the malloc/free overhead. But fully supports being resized =
into
> > > larger
> > > containers that are unbounded. Of course it will need to follow a=
ll of
> > > the
> > > proper object copy/move semantics so that things like unique_ptr,=
 etc
> > > work
> > > correctly.
> > >=20
> > > I heard rumors that there was one available in the boost world, b=
ut I
> > > can=E2=80=99t
> > > seem to find it. Do you know about one being available?
> >=20
> > http://www.boost.org/doc/libs/1_60_0/doc/html/boost/container/small=
_vector.html
> >=20
> > > I=E2=80=99ve been prototyping one myself, just to get re-familiar=
 with all of the
> > > C++11 move sementics, and trivial constructors, etc.
> > >=20
> > > The code is pretty complete, but the testing gets rather involved=
=2E
> > > There=E2=80=99s
> > > no reason to contain this if it=E2=80=99s available elsewhere. Bu=
t if it isn=E2=80=99t I
> > > plan on continuing this=E2=80=A6
> >=20
> > I think Casey had prototyped something similar using a custom alloc=
ator,
> > too, but I didn't actually look at the result.  And Matt talked abo=
ut just
> > pulling the boost one in-tree until we get updated boost in the sup=
ported
> > distros, but I forget if he ran into problems there or not...
> >=20
> > sage
>=20
> --
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>=20
> http://www.redhat.com/en/technologies/storage
>=20
> tel.  734-707-0660
> fax.  734-769-8938
> cel.  734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
