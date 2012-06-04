From: Hannes Reinecke <hare@suse.de>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 08:22:41 +0200
Message-ID: <4FCC5431.6070002@suse.de>
References: <4FCB1C0A.4050504@profihost.ag> <4FCB5EED.30909@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46752 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219Ab2FDGWo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Jun 2012 02:22:44 -0400
In-Reply-To: <4FCB5EED.30909@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/03/2012 02:56 PM, Mark Nelson wrote:
> On 6/3/12 3:10 AM, Stefan Priebe wrote:
>> Hi List,
>>
>> has anybody already tried CEPH over Infiniband 40GB?
>>
>> Stefan
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>=20
> Hi Stefan,
>=20
> A couple of folks have done DDR IB.  For now you are limited to
> ipoib though.  If you have the hardware available I'd be really
> curious what kind of throughput/latencies you see.
>=20
Hehe.

Good luck with that.

We've tried on 10GigE with _disastrous_ results.
Up to the point where 1GigE was actually _faster_.

So far we've uncovered two issues:
- intel_idle was/is seriously broken (we've tried on 3.0-stable,
  so might've been fixed by now)
- osd-server is calling 'fsync' on each and every write request.
  Does wonders for performance ...

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
