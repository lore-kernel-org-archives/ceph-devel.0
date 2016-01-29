From: Loic Dachary <loic@dachary.org>
Subject: Re: Publishing hammer v0.94.6
Date: Sat, 30 Jan 2016 00:43:47 +0700
Message-ID: <56ABA4D3.4060009@dachary.org>
References: <56AAFAB2.9010103@dachary.org>
 <alpine.DEB.2.11.1601290951320.6524@cpach.fuggernut.com>
 <CAANLjFqWTCGBTbzRkhPXTAnj=UiYVmzDKJMKR2b62FJ7ThzgqA@mail.gmail.com>
 <56AB9875.7020609@dachary.org>
 <CAANLjFp9nB9Qh+ruBvSW7fkpKZ7dTTFiuq22fgkcn0uCSuAhSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40806 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbcA2Rn4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jan 2016 12:43:56 -0500
In-Reply-To: <CAANLjFp9nB9Qh+ruBvSW7fkpKZ7dTTFiuq22fgkcn0uCSuAhSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 30/01/2016 00:06, Robert LeBlanc wrote:
> I've ran it through run-make-check.sh and it passed. Is that what you
> are asking?

I'm refering to the rados suite (see http://pulpito.ceph.com/loic-2016-=
01-29_02:04:23-rados-hammer-backports---basic-multi/ for instance). I c=
an explain further if teuthology is unfamiliar.

Cheers

>=20
> Thanks,
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>=20
>=20
> On Fri, Jan 29, 2016 at 9:51 AM, Loic Dachary  wrote:
>> Hi Robert,
>=20
>> Thanks for the comments update :-) It needs a rados run before it is=
 merged. Can you do that ?
>=20
>> Cheers
>=20
>> On 29/01/2016 23:35, Robert LeBlanc wrote:
>>> We'd really like to have http://tracker.ceph.com/issues/14329 in
>>> 0.94.6. I think I fixed the comments. Please let me know.
>>> ----------------
>>> Robert LeBlanc
>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>>>
>>>
>>> On Fri, Jan 29, 2016 at 7:51 AM, Sage Weil  wrote:
>>>> Let's do it!
>>>
>>>> On Fri, 29 Jan 2016, Loic Dachary wrote:
>>>
>>>>> Hi Sage,
>>>>>
>>>>> Now that the test infrastructure is back, we could try to publish=
 v0.94.6. These are the issues it fixes: http://tracker.ceph.com/versio=
ns/505. And these are the backports that are in flight and would not be=
 in v0.94.6 if we decide to cut the release today: http://tracker.ceph.=
com/projects/ceph/issues?query_id=3D78
>>>>>
>>>>> What do you think ?
>>>>>
>>>>> --
>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>
>>>>>
>>>
>>>
>=20
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
