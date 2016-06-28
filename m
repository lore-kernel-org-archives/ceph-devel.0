From: Sebastien Ponce <sebastien.ponce@cern.ch>
Subject: Re: libradosstriper
Date: Tue, 28 Jun 2016 05:26:31 +0200
Message-ID: <1467084391.32200.7.camel@cern.ch>
References: <alpine.DEB.2.11.1606272216370.7088@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-am1on0064.outbound.protection.outlook.com ([157.56.112.64]:10368
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750704AbcF1EZH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jun 2016 00:25:07 -0400
In-Reply-To: <alpine.DEB.2.11.1606272216370.7088@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 2016-06-27 at 22:18 +0000, Sage Weil wrote:
> Hi Sebastien,
>=20
> Do you mind updating us on the current status of
> libradosstriper?=C2=A0=C2=A0Where=C2=A0does it stand feature-wise wit=
h what you
> need, how are you currently using it or how do you plan to use it,
> and what is still missing?

Most of the feature we need are there and they are being used,
including in production. However, I have a couple of improvements to
propose, in particular a faster remove implementation (using async
removal of the subparts) and the few async APIs I've mentioned at the
ceph day. I've just prepared the commits in the plane yesterday, I'll
try to create the pull request this week.


> Also, one thing we really want to see is test coverage for the code
> so that we can comfortably point users toward it.=C2=A0=C2=A0This ide=
ally would
> look=C2=A0something like the ceph_test_rados_api_* tests that verify
> individual=C2=A0operations behave as expected, and/or something like
> ceph_test_rados that=C2=A0throws random operations at is and verifies=
 it
> returns correct results that match its in-memory model.

I believe the test coverage for individual operations is complete for
what exists, and the new improvements will come with their tests too.
They are called ceph_test_radosstriper.
Now I do not think I have the random operation one. Probably something
to be added.

Cheers,

Sebastien
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
