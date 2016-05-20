From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: Initial proposal for bluestore compression control and statistics
Date: Fri, 20 May 2016 16:14:00 +0200
Message-ID: <20160520141400.GA5041@predictor>
References: <2ec0367c-ea9e-469e-4a80-b2a242c84f0f@mirantis.com>
 <20160519175708.GE22208@predictor>
 <4c89f7ee-bff1-8a9a-096a-c9459aba992b@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:60073 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbcETOLs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 May 2016 10:11:48 -0400
Content-Disposition: inline
In-Reply-To: <4c89f7ee-bff1-8a9a-096a-c9459aba992b@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, May 20, 2016 at 04:52:18PM +0300, Igor Fedotov wrote:
>=20
> On 19.05.2016 20:57, Piotr Da=C5=82ek wrote:
> >I would also add ability to set minimum acceptable compression ratio=
,
> >with at least two options (any and no-expand). "Any" would store com=
pressed
> >objects regardless how well they've compressed and "No-expand" would=
 store
> >object in compressed format only if compressed size is smaller than
> >uncompressed size.
>
> Why do we need "Any" option? Isn't "No-expand" enough?

=46or example, when someone wants to benchmark Bluestore compression in=
 worst case
scenario, or when someone wants to use compression as data-masking tech=
nique. And
finally, "no-expand" implies additional code in compressor/decompressor=
 code
path and this option would go around it.=20
(Not particularly practical uses, but there might be someone who finds =
this
useful... and it's not difficult to do in code).

--=20
Piotr Da=C5=82ek
branch@predictor.org.pl
http://blog.predictor.org.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
