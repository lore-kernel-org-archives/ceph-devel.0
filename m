From: Loic Dachary <loic@dachary.org>
Subject: Re: FileJournal bug : additional information request
Date: Tue, 30 Sep 2014 17:08:24 +0200
Message-ID: <542AC768.80502@dachary.org>
References: <542ABE45.5030808@dachary.org> <CAGW2oNw+ZVDi40SkzdyR1-Dx1kcOxq045hqtbHC6EzcUTqBZVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7dEfGs2lBMfJc6jgNPkkXF5sp8O430Mjp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34947 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750809AbaI3PIa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 11:08:30 -0400
In-Reply-To: <CAGW2oNw+ZVDi40SkzdyR1-Dx1kcOxq045hqtbHC6EzcUTqBZVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjm@inktank.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7dEfGs2lBMfJc6jgNPkkXF5sp8O430Mjp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 30/09/2014 17:06, Sheldon Mustard wrote:
> Hey Loic,
>=20
> Thanks for looking into it, I have attached the one small log file we
> have to the tracker now. Unfortunately I don't have much else to add
> at this point, it was a one off thing so we can't reproduce it with
> debugging turned on.

Thanks a lot !

>=20
> SJM
>=20
> On Tue, Sep 30, 2014 at 10:29 AM, Loic Dachary <loic@dachary.org> wrote=
:
>> Hi Sheldon,
>>
>> I would be greatfull if you could add as much information as possible =
to http://tracker.ceph.com/issues/9570 . In particular the logs of the fa=
iled OSD would be great. Hunting the problem is a nice journey (I did not=
 know this part of the code before) and I'm eager to discover the reason =
for this seemingly impossible event :-)
>>
>> Thanks for your help !
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--7dEfGs2lBMfJc6jgNPkkXF5sp8O430Mjp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQqx2gACgkQ8dLMyEl6F21WHwCfcUaqWcKXWOaRiKN1ZAIFmEME
qOcAnjy3f/v7p1r2R+e8WxG4TCSfqfaQ
=tmGo
-----END PGP SIGNATURE-----

--7dEfGs2lBMfJc6jgNPkkXF5sp8O430Mjp--
