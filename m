From: Loic Dachary <loic@dachary.org>
Subject: Re: Publishing hammer v0.94.6
Date: Fri, 29 Jan 2016 23:51:01 +0700
Message-ID: <56AB9875.7020609@dachary.org>
References: <56AAFAB2.9010103@dachary.org>
 <alpine.DEB.2.11.1601290951320.6524@cpach.fuggernut.com>
 <CAANLjFqWTCGBTbzRkhPXTAnj=UiYVmzDKJMKR2b62FJ7ThzgqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40615 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384AbcA2QvO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jan 2016 11:51:14 -0500
In-Reply-To: <CAANLjFqWTCGBTbzRkhPXTAnj=UiYVmzDKJMKR2b62FJ7ThzgqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>, Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Robert,

Thanks for the comments update :-) It needs a rados run before it is me=
rged. Can you do that ?

Cheers

On 29/01/2016 23:35, Robert LeBlanc wrote:
> We'd really like to have http://tracker.ceph.com/issues/14329 in
> 0.94.6. I think I fixed the comments. Please let me know.
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>=20
>=20
> On Fri, Jan 29, 2016 at 7:51 AM, Sage Weil  wrote:
>> Let's do it!
>=20
>> On Fri, 29 Jan 2016, Loic Dachary wrote:
>=20
>>> Hi Sage,
>>>
>>> Now that the test infrastructure is back, we could try to publish v=
0.94.6. These are the issues it fixes: http://tracker.ceph.com/versions=
/505. And these are the backports that are in flight and would not be i=
n v0.94.6 if we decide to cut the release today: http://tracker.ceph.co=
m/projects/ceph/issues?query_id=3D78
>>>
>>> What do you think ?
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>>>
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
