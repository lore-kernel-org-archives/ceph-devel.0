From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-qa analysis output
Date: Sun, 18 Jan 2015 00:27:27 +0100
Message-ID: <54BAEFDF.50106@dachary.org>
References: <54BA5E8D.30508@dachary.org> <CAJBxG-tjfWt+=HGJF0sZBFRFnYuCs_VdVpQzO8XAXs3ooE4e1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="B1qD7R072heauwvIQhBDIfjm6L7LbvvXK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42579 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751562AbbAQX13 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Jan 2015 18:27:29 -0500
In-Reply-To: <CAJBxG-tjfWt+=HGJF0sZBFRFnYuCs_VdVpQzO8XAXs3ooE4e1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B1qD7R072heauwvIQhBDIfjm6L7LbvvXK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17/01/2015 23:08, Yuri Weinstein wrote:
> Hi Loic,
>=20
> I'd love to.
>=20
> Let's chat on Monday to finalize format.
>=20
> (
> PS:  I think format would be easier to maintain like new lines enforced=
, e,g.
>=20
> '701575', '701576', '701582', '701590'
>  ttp://tracker.ceph.com/issues/10543
> FAILED assert(m_seed < old_pg_num

Yes, as long as it's consistent enough to be machine readable, that works=
 :-)

>=20
> PPS: Again this ticket http://tracker.ceph.com/issues/10455 would be
> helpful in what we are discussing here.
>=20

I'm not sure where the output of such a parsing would go. The update redm=
ine API is currently broken (the read API works ok) but if it was fixed t=
he tickets could be updated indeed.

Cheers

> Thx
> YuriW
>=20
> On Sat, Jan 17, 2015 at 5:07 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Yuri,
>>
>> It would be great if the analysis you compile daily was machine readab=
le. For instance, in a mail you sent to ceph-qa I read
>>
>> '701575', '701576', '701582', '701590' - known issue
>> http://tracker.ceph.com/issues/10543
>>
>> "FAILED assert(m_seed < old_pg_num)"
>>
>> (duplicate of http://tracker.ceph.com/issues/10430)
>>
>> which could be something like:
>>
>> '701575', '701576', '701582', '701590': http://tracker.ceph.com/issues=
/10543 FAILED assert(m_seed < old_pg_num)
>>
>> or any other format you find easier to use consistently.
>>
>> The reason I ask is because it would help me write a script that assoc=
iates redmine tickets to your findings, in the context of backporting. It=
's just an idea, not a request ;-)
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--B1qD7R072heauwvIQhBDIfjm6L7LbvvXK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS6798ACgkQ8dLMyEl6F22cwgCgvojHHEbV/DJP8El3OHSMZJ3c
2NEAn0QHwdaIXuIHWmuF8wGyM8weJ2b8
=yv0f
-----END PGP SIGNATURE-----

--B1qD7R072heauwvIQhBDIfjm6L7LbvvXK--
