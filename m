From: Loic Dachary <loic@dachary.org>
Subject: Re: make check bot paused
Date: Tue, 11 Aug 2015 10:37:58 +0200
Message-ID: <55C9B466.8070804@dachary.org>
References: <55C55500.3000303@dachary.org> <alpine.DEB.2.00.1508080449510.22099@cobra.newdream.net> <55C8A593.6030703@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IRQdt5Va9mXa8EvIoSxVH3gCau170OvqJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36345 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755246AbbHKIiB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Aug 2015 04:38:01 -0400
Received: from [10.9.0.14] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id E7DBC42B29
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2015 10:37:58 +0200 (CEST)
In-Reply-To: <55C8A593.6030703@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IRQdt5Va9mXa8EvIoSxVH3gCau170OvqJ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

The make check bot starts sending reports again. It is running about 24h =
late, meaning the report of the make check run for a new pull request wil=
l be available 24h later. It is expected to catchup within 48h.

I will be watching false negatives but if you find something weird, pleas=
e ping me with a comment in the pull request including @dachary in the bo=
dy so that I receive a notification.

Cheers

On 10/08/2015 15:22, Loic Dachary wrote:
> Hi,
>=20
> The make check bot is back to work. It will not send any report for ano=
ther 24h to 48h to avoid a burst false negative. In the meantime you can =
run it locally with:
>=20
>   run-make-check.sh
>=20
> It is the same script that the bot uses and should work from a fresh gi=
t clone of Ceph.
>=20
> Cheers
>=20
> On 08/08/2015 13:50, Sage Weil wrote:
>> On Sat, 8 Aug 2015, Loic Dachary wrote:
>>> Hi,
>>>
>>> The make check bot is paused until the master branch passes make chec=
k=20
>>> again.
>>
>> Several fixes here that need review:
>>
>> 	https://github.com/ceph/ceph/pull/5515
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--IRQdt5Va9mXa8EvIoSxVH3gCau170OvqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXJtGYACgkQ8dLMyEl6F20DaACdGs3AM/gDA+0MiEBJ1iWNAiVu
QVAAnAm+D42CL0vVDgHkKeL3PJQPcwOT
=oIOO
-----END PGP SIGNATURE-----

--IRQdt5Va9mXa8EvIoSxVH3gCau170OvqJ--
