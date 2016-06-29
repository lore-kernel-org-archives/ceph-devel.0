From: Sebastien Ponce <sebastien.ponce@cern.ch>
Subject: Re: libradosstriper
Date: Wed, 29 Jun 2016 17:44:27 +0200
Message-ID: <1467215067.603.20.camel@cern.ch>
References: <alpine.DEB.2.11.1606272216370.7088@piezo.us.to>
	 <CAN=+7FVmmgAuVF6cjwvGdyAU4YEXr8jLX-qiNjH50w6_YMs02g@mail.gmail.com>
	 <1467084445.32200.8.camel@cern.ch>
	 <CAN=+7FXrt6Y=TPRRdjkXZathXXKneV0eqT5VA6hQ5LOrxKoF3Q@mail.gmail.com>
	 <1467212620.603.13.camel@cern.ch>
	 <CAN=+7FWi1pMFa-=fYYiaaNNyaKmm_8E8dbQOOdOwdTz5n8x34A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-am1on0089.outbound.protection.outlook.com ([157.56.112.89]:6056
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752934AbcF2P7u (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jun 2016 11:59:50 -0400
In-Reply-To: <CAN=+7FWi1pMFa-=fYYiaaNNyaKmm_8E8dbQOOdOwdTz5n8x34A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Oh I see, I did not know this one indeed.
I used the flag approach for the rados command line and it was really
easy, as the API is identical, you only have to use a Striper object
instead of an IOContext.
Now looking at the RadosModel class, I see that the user API (like
read/write/aio_read,...) is almost not used. Almost everything goes
through the aio_operate calls wich are not present in Striper.
So I believe the simplest would be to add a couple of=C2=A0TestOpType,
namely 5 of them : TEST_OP_READ/WRITE/DELETE/SETXATTR/RMXATTR_STRIPER
and implement the corresponding classes inheriting from TestOp.
This would also have the advantage to mix striped and regular objects
in the test, which is absolutely valid and thus should be tested.

Sebastien


On Wed, 2016-06-29 at 08:30 -0700, Samuel Just wrote:
> Ah, sorry.=C2=A0=C2=A0See src/test/osd/RadosModel.* and
> src/test/osd/TestRados.cc.=C2=A0=C2=A0It's gotten to be a somewhat kl=
udgy mess,
> but it's a really valuable stress test for verifying that the osd and
> librados are behaving properly, especially when combined with failure
> injection and osd thrashing.=C2=A0=C2=A0I'd like to either create a (=
less
> kludgy, I can only hope) seperate version for librados striper, or
> add
> a flag to the existing one which causes it to use the striper instead
> (and only allows ops where it makes sense).=C2=A0=C2=A0libradosstripe=
r should
> have the same ordering properties for piplined writes as normal
> librados (right?), so modifying the existing test would probably get
> us the most coverage for the least effort.
> -Sam
>=20
> On Wed, Jun 29, 2016 at 8:03 AM, Sebastien Ponce
> <sebastien.ponce@cern.ch> wrote:
> >=20
> > Well, I'm not sure what you are exactly looking for : I see now
> > that I
> > look more carefully that there is a file called ceph_test_rados
> > that
> > looks like a wrapper around the ceph_test_rados_* tests.
> > The equivalent does not seem to exist for striper (although the
> > same
> > wrapper would probably work), but the ceph_test_rados_striper_*
> > tests
> > do exist.
> > Should we/I create a wrapper for striper ? I'm not sure I have the
> > whole understanding of the structure of the whole test system...
> >=20
> > Sebastien
> >=20
> >=20
> > On Tue, 2016-06-28 at 09:07 -0700, Samuel Just wrote:
> > >=20
> > > I don't remember anything like ceph_test_rados which uses
> > > libradosstriper.=C2=A0=C2=A0Did I miss it?
> > > -Sam
> > >=20
> > > On Mon, Jun 27, 2016 at 8:27 PM, Sebastien Ponce
> > > <sebastien.ponce@cern.ch> wrote:
> > > >=20
> > > >=20
> > > > Would be great indeed. As it's already there, it can be done
> > > > already
> > > > now.
> > > >=20
> > > > Sebastien
> > > >=20
> > > > On Mon, 2016-06-27 at 15:25 -0700, Samuel Just wrote:
> > > > >=20
> > > > >=20
> > > > > The something like ceph_test_rados could then be wired into
> > > > > ceph-qa-suite to be tested with osd thrashing to ensure that
> > > > > ordering
> > > > > works and continues to work as expected.
> > > > > -Sam
> > > > >=20
> > > > > On Mon, Jun 27, 2016 at 3:18 PM, Sage Weil <sweil@redhat.com>
> > > > > wrote:
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > Hi Sebastien,
> > > > > >=20
> > > > > > Do you mind updating us on the current status of
> > > > > > libradosstriper?=C2=A0=C2=A0Where
> > > > > > does it stand feature-wise with what you need, how are you
> > > > > > currently using
> > > > > > it or how do you plan to use it, and what is still missing?
> > > > > >=20
> > > > > > Also, one thing we really want to see is test coverage for
> > > > > > the
> > > > > > code
> > > > > > so
> > > > > > that we can comfortably point users toward it.=C2=A0=C2=A0T=
his
> > > > > > ideally
> > > > > > would
> > > > > > look
> > > > > > something like the ceph_test_rados_api_* tests that verify
> > > > > > individual
> > > > > > operations behave as expected, and/or something like
> > > > > > ceph_test_rados that
> > > > > > throws random operations at is and verifies it returns
> > > > > > correct
> > > > > > results
> > > > > > that match its in-memory model.
> > > > > >=20
> > > > > > Thanks!
> > > > > > sage
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe
> > > > > > ceph-
> > > > > > devel" in
> > > > > > the body of a message to majordomo@vger.kernel.org
> > > > > > More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/ma=
jordomo-in
> > > > > > fo.h
> > > > > > tml
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-
> > > devel"
> > > in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordom=
o-info.htm
> > > l
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
