From: Loic Dachary <loic@dachary.org>
Subject: Re: RFC: teuthology field in commit messages
Date: Sun, 29 Nov 2015 21:25:48 +0100
Message-ID: <565B5F4C.30308@dachary.org>
References: <5659CE92.4000203@dachary.org>
 <CALe9h7edX3zQVri_KRRNRmjOnvcxhxq0EJXn=5nhF+AQY51g3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FcvHidNjEXBLannsKhXsLmKxtBeVUhDci"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41061 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752268AbbK2UZu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Nov 2015 15:25:50 -0500
In-Reply-To: <CALe9h7edX3zQVri_KRRNRmjOnvcxhxq0EJXn=5nhF+AQY51g3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FcvHidNjEXBLannsKhXsLmKxtBeVUhDci
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29/11/2015 21:08, John Spray wrote:
> On Sat, Nov 28, 2015 at 3:56 PM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Ceph,
>>
>> An optional teuthology field could be added to a commit message like s=
o:
>>
>> teuthology: --suite rbd
>>
>> to state that this commit should be tested with the rbd suite. It coul=
d be parsed by bots and humans.
>>
>> It would make it easy and cost effective to run partial teuthology sui=
tes automatically on pull requests.
>>
>> What do you think ?
>=20
> Hmm, we are usually testing things at the branch/PR level rather than
> on the per-commit level, so it feels a bit strange to have this in the
> commit message.

Indeed. But what is a branch if not the HEAD commit ?

> However, if a system existed that would auto-test things when I put
> something magic in a commit message, I would probably use it!
>=20
> John
>=20
>=20
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--FcvHidNjEXBLannsKhXsLmKxtBeVUhDci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZbX0wACgkQ8dLMyEl6F23NSwCffnx8KsStQUi64/yfJ+g9ewi4
GzgAn2Y1mHXlNFslgwH8Ws/T8lJIIxO/
=jjEQ
-----END PGP SIGNATURE-----

--FcvHidNjEXBLannsKhXsLmKxtBeVUhDci--
