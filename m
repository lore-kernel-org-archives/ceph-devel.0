From: Sebastien Ponce <sebastien.ponce@cern.ch>
Subject: Re: libradosstriper
Date: Tue, 28 Jun 2016 05:27:25 +0200
Message-ID: <1467084445.32200.8.camel@cern.ch>
References: <alpine.DEB.2.11.1606272216370.7088@piezo.us.to>
	 <CAN=+7FVmmgAuVF6cjwvGdyAU4YEXr8jLX-qiNjH50w6_YMs02g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db3on0075.outbound.protection.outlook.com ([157.55.234.75]:35840
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750836AbcF1EBj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jun 2016 00:01:39 -0400
In-Reply-To: <CAN=+7FVmmgAuVF6cjwvGdyAU4YEXr8jLX-qiNjH50w6_YMs02g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Would be great indeed. As it's already there, it can be done already
now.

Sebastien

On Mon, 2016-06-27 at 15:25 -0700, Samuel Just wrote:
> The something like ceph_test_rados could then be wired into
> ceph-qa-suite to be tested with osd thrashing to ensure that ordering
> works and continues to work as expected.
> -Sam
>=20
> On Mon, Jun 27, 2016 at 3:18 PM, Sage Weil <sweil@redhat.com> wrote:
> >=20
> > Hi Sebastien,
> >=20
> > Do you mind updating us on the current status of
> > libradosstriper?=C2=A0=C2=A0Where
> > does it stand feature-wise with what you need, how are you
> > currently using
> > it or how do you plan to use it, and what is still missing?
> >=20
> > Also, one thing we really want to see is test coverage for the code
> > so
> > that we can comfortably point users toward it.=C2=A0=C2=A0This idea=
lly would
> > look
> > something like the ceph_test_rados_api_* tests that verify
> > individual
> > operations behave as expected, and/or something like
> > ceph_test_rados that
> > throws random operations at is and verifies it returns correct
> > results
> > that match its in-memory model.
> >=20
> > Thanks!
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-
> > devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-=
info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
