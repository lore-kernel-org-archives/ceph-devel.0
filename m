From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: Hammer vs Jewel librbd performance testing and git bisection
 results
Date: Wed, 11 May 2016 15:35:04 +0200
Message-ID: <20160511133504.GB6902@predictor>
References: <f9f54455-8348-42b7-153b-e38850eed5e1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:45329 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932543AbcEKNdA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 May 2016 09:33:00 -0400
Content-Disposition: inline
In-Reply-To: <f9f54455-8348-42b7-153b-e38850eed5e1@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Wed, May 11, 2016 at 08:21:18AM -0500, Mark Nelson wrote:
> Hi Guys,
>=20
> [..]
> The gist of this is that Jewel is faster than Hammer for many random
> workloads (Read, Write, and Mixed).  There is one specific case
> where performance degrades significantly: 64-128k sequential reads.
> We couldn't find anything obviously wrong with these tests, so we
> spent some time running git bisects between hammer and jewel with
> the NVMe test configuration (these tests were faster to setup/run
> than the HDD setup).  We tested about 45 different commits with
> anywhere from 1-5 samples depending on how confident the results
> looked:
>=20
> https://docs.google.com/spreadsheets/d/1hbsyNM5pr-ZwBuR7lqnphEd-4kQUi=
d0C9eRyta3ohOA/edit?usp=3Dsharing
>=20
> There are several commits of interest that have a noticeable effect
> on 128K sequential read performance:
>=20
> [..]
> 2) https://github.com/ceph/ceph/commit/c474ee42
>=20
> This commit had a very large impact, reducing performance by another =
20-25%.

https://github.com/ceph/ceph/commit/c474ee42#diff-254555dde8dcfb7fb9087=
91ab8214b92R318
I would check if temporarily forcing unique_lock_name() to return its a=
rg
(or other constant) would change things. If so, probably a more efficie=
nt way
to construct unique lock name may be in order.

--=20
Piotr Da=C5=82ek
branch@predictor.org.pl
http://blog.predictor.org.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
