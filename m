From: Loic Dachary <loic@dachary.org>
Subject: Re: Backporting from Infernalis and c++11
Date: Tue, 15 Sep 2015 12:19:15 +0200
Message-ID: <55F7F0A3.9090203@dachary.org>
References: <55F7C70B.4000308@dachary.org> <CALe9h7ex+31ouk+ed0d8XyuzuCw+BscM4bj8TWZ0w-RNgFa-hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="MkrWEUgOTdm5ilnxnLk4RAbjqwGSmRQXa"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55638 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751601AbbIOKTS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 06:19:18 -0400
In-Reply-To: <CALe9h7ex+31ouk+ed0d8XyuzuCw+BscM4bj8TWZ0w-RNgFa-hQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MkrWEUgOTdm5ilnxnLk4RAbjqwGSmRQXa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi John,

On 15/09/2015 12:02, John Spray wrote:
> On Tue, Sep 15, 2015 at 8:21 AM, Loic Dachary <loic@dachary.org> wrote:=

>> With Infernalis Ceph move to c++11 (and CMake), we will see more confl=
icts when backporting bug fixes to Hammer. Any ideas you may have to bett=
er deal with this would be most welcome. Since these conflicts will be mo=
stly cosmetic, they should not be too difficult to resolve. The trick wil=
l be for someone not familiar with the codebase to separate what is cosme=
tic and what is not.
>>
>> This does not happen yet, no immediate concern :-) Maybe if we think a=
bout that well in advance we'll be in a better position to deal with it l=
ater on ?
>=20
> I think this came up in conversation but wasn't necessarily made
> official policy yet -- my understanding is that we are (already)
> endeavouring to avoid c++11isms in bug fixes, along with the usual
> principle of fixing bugs in the smallest/neatest patch we can.
>=20
> Perhaps in cases where those of us working on master mistakenly put
> something un-backportable in a bug fix, it would be reasonable for the
> backporter to point it out and poke us for a clean version of the
> patch.

We'll do our best but it's very reassuring to know we can rely on you if =
we struggle with c++11isms :-)

Thanks !

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--MkrWEUgOTdm5ilnxnLk4RAbjqwGSmRQXa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlX38KMACgkQ8dLMyEl6F20rTwCeMUdYeuBt+eTxsff+jK/HzJei
rvYAoLSNwQhP6cArIF4pYNLd2A35/ulX
=juE/
-----END PGP SIGNATURE-----

--MkrWEUgOTdm5ilnxnLk4RAbjqwGSmRQXa--
