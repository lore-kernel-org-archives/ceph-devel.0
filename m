From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-qa analysis output
Date: Sun, 18 Jan 2015 11:35:35 +0100
Message-ID: <54BB8C77.7080208@dachary.org>
References: <54BA5E8D.30508@dachary.org>	<CAJBxG-tjfWt+=HGJF0sZBFRFnYuCs_VdVpQzO8XAXs3ooE4e1g@mail.gmail.com>	<54BAEFDF.50106@dachary.org> <CAJBxG-v8+jWxaVpCspv72DPjXfO+7+FeFZr2y+6umsh9xD22=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TMRVBwtxnf73FcvuSc4MN93dsM5stxmKx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42695 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751357AbbARKfj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Jan 2015 05:35:39 -0500
In-Reply-To: <CAJBxG-v8+jWxaVpCspv72DPjXfO+7+FeFZr2y+6umsh9xD22=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TMRVBwtxnf73FcvuSc4MN93dsM5stxmKx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

I did not know about scrape. It looks extremely useful, thanks ! Do you h=
ave more magic items in your bag ? ;-)

Cheers

P.S. And thanks to John for writing scrape :-)

On 18/01/2015 01:27, Yuri Weinstein wrote:
> Sounds good, Loic
>=20
> Are you aware BTW about scrape tool written by John Spray?
> https://github.com/jcsp/scrape
>=20
> I use it for test runs analysis often.
>=20
> Just FYI
>=20
> Thx
> YuriW
>=20
> On Sat, Jan 17, 2015 at 3:27 PM, Loic Dachary <loic@dachary.org> wrote:=

>>
>>
>> On 17/01/2015 23:08, Yuri Weinstein wrote:
>>> Hi Loic,
>>>
>>> I'd love to.
>>>
>>> Let's chat on Monday to finalize format.
>>>
>>> (
>>> PS:  I think format would be easier to maintain like new lines enforc=
ed, e,g.
>>>
>>> '701575', '701576', '701582', '701590'
>>>  ttp://tracker.ceph.com/issues/10543
>>> FAILED assert(m_seed < old_pg_num
>>
>> Yes, as long as it's consistent enough to be machine readable, that wo=
rks :-)
>>
>>>
>>> PPS: Again this ticket http://tracker.ceph.com/issues/10455 would be
>>> helpful in what we are discussing here.
>>>
>>
>> I'm not sure where the output of such a parsing would go. The update r=
edmine API is currently broken (the read API works ok) but if it was fixe=
d the tickets could be updated indeed.
>>
>> Cheers
>>
>>> Thx
>>> YuriW
>>>
>>> On Sat, Jan 17, 2015 at 5:07 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>> Hi Yuri,
>>>>
>>>> It would be great if the analysis you compile daily was machine read=
able. For instance, in a mail you sent to ceph-qa I read
>>>>
>>>> '701575', '701576', '701582', '701590' - known issue
>>>> http://tracker.ceph.com/issues/10543
>>>>
>>>> "FAILED assert(m_seed < old_pg_num)"
>>>>
>>>> (duplicate of http://tracker.ceph.com/issues/10430)
>>>>
>>>> which could be something like:
>>>>
>>>> '701575', '701576', '701582', '701590': http://tracker.ceph.com/issu=
es/10543 FAILED assert(m_seed < old_pg_num)
>>>>
>>>> or any other format you find easier to use consistently.
>>>>
>>>> The reason I ask is because it would help me write a script that ass=
ociates redmine tickets to your findings, in the context of backporting. =
It's just an idea, not a request ;-)
>>>>
>>>> Cheers
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--TMRVBwtxnf73FcvuSc4MN93dsM5stxmKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS7jHcACgkQ8dLMyEl6F22+5ACgjI/NID+88evChd2aotki6+Ag
FOMAnjd8GlVSXF2uPIPQSWDaXegzziMI
=3IIw
-----END PGP SIGNATURE-----

--TMRVBwtxnf73FcvuSc4MN93dsM5stxmKx--
