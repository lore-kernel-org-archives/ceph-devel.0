From: Sebastien Ponce <sebastien.ponce@cern.ch>
Subject: Re: libradosstriper
Date: Wed, 29 Jun 2016 17:03:40 +0200
Message-ID: <1467212620.603.13.camel@cern.ch>
References: <alpine.DEB.2.11.1606272216370.7088@piezo.us.to>
	 <CAN=+7FVmmgAuVF6cjwvGdyAU4YEXr8jLX-qiNjH50w6_YMs02g@mail.gmail.com>
	 <1467084445.32200.8.camel@cern.ch>
	 <CAN=+7FXrt6Y=TPRRdjkXZathXXKneV0eqT5VA6hQ5LOrxKoF3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db3on0073.outbound.protection.outlook.com ([157.55.234.73]:13965
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752741AbcF2PE3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jun 2016 11:04:29 -0400
In-Reply-To: <CAN=+7FXrt6Y=TPRRdjkXZathXXKneV0eqT5VA6hQ5LOrxKoF3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Well, I'm not sure what you are exactly looking for : I see now that I
look more carefully that there is a file called ceph_test_rados that
looks like a wrapper around the ceph_test_rados_* tests.
The equivalent does not seem to exist for striper (although the same
wrapper would probably work), but the ceph_test_rados_striper_* tests
do exist.
Should we/I create a wrapper for striper ? I'm not sure I have the
whole understanding of the structure of the whole test system...

Sebastien


On Tue, 2016-06-28 at 09:07 -0700, Samuel Just wrote:
> I don't remember anything like ceph_test_rados which uses
> libradosstriper.=C2=A0=C2=A0Did I miss it?
> -Sam
>=20
> On Mon, Jun 27, 2016 at 8:27 PM, Sebastien Ponce
> <sebastien.ponce@cern.ch> wrote:
> >=20
> > Would be great indeed. As it's already there, it can be done
> > already
> > now.
> >=20
> > Sebastien
> >=20
> > On Mon, 2016-06-27 at 15:25 -0700, Samuel Just wrote:
> > >=20
> > > The something like ceph_test_rados could then be wired into
> > > ceph-qa-suite to be tested with osd thrashing to ensure that
> > > ordering
> > > works and continues to work as expected.
> > > -Sam
> > >=20
> > > On Mon, Jun 27, 2016 at 3:18 PM, Sage Weil <sweil@redhat.com>
> > > wrote:
> > > >=20
> > > >=20
> > > > Hi Sebastien,
> > > >=20
> > > > Do you mind updating us on the current status of
> > > > libradosstriper?=C2=A0=C2=A0Where
> > > > does it stand feature-wise with what you need, how are you
> > > > currently using
> > > > it or how do you plan to use it, and what is still missing?
> > > >=20
> > > > Also, one thing we really want to see is test coverage for the
> > > > code
> > > > so
> > > > that we can comfortably point users toward it.=C2=A0=C2=A0This =
ideally
> > > > would
> > > > look
> > > > something like the ceph_test_rados_api_* tests that verify
> > > > individual
> > > > operations behave as expected, and/or something like
> > > > ceph_test_rados that
> > > > throws random operations at is and verifies it returns correct
> > > > results
> > > > that match its in-memory model.
> > > >=20
> > > > Thanks!
> > > > sage
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-
> > > > devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majord=
omo-info.h
> > > > tml
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
