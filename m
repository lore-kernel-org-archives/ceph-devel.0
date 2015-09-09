From: Loic Dachary <loic@dachary.org>
Subject: Re: bug with cache/tiering and snapshot reads
Date: Wed, 09 Sep 2015 09:04:03 +0200
Message-ID: <55EFD9E3.4070300@dachary.org>
References: <55EF6CBF.4090703@dachary.org> <1807779066.25465139.1441760102338.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3P8WQW8mapSEoCc25isbCC8BJP2OqbiRv"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52261 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751861AbbIIHEH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Sep 2015 03:04:07 -0400
In-Reply-To: <1807779066.25465139.1441760102338.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3P8WQW8mapSEoCc25isbCC8BJP2OqbiRv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Thanks for the quick reply :-)

Cheers

On 09/09/2015 02:55, Jason Dillaman wrote:
>> Does "bug with cache/tiering and snapshot reads"
>> http://tracker.ceph.com/issues/12748 sound familiar to you ? Although =
it
>> looks like a tiering problem, it involves rbd and maybe it rings a bel=
l ? If
>> not, don't worry about it and I'll dig further: I can repeat it every =
time
>> using the script from the description. I kind of remember something si=
milar
>> but it involved erasure coded pools and is probably different.
>=20
> I believe it's related to this thread [1].  There is an cache tier / EC=
 pool issue wrt proxied writes, but this is different.  =20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--3P8WQW8mapSEoCc25isbCC8BJP2OqbiRv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXv2eMACgkQ8dLMyEl6F22ofwCeNBtdyuNPRrCF6MxsJCsbCF0Z
8rcAnAhI0fEoIvXTxd4VHnUgo9nStXfF
=PQqG
-----END PGP SIGNATURE-----

--3P8WQW8mapSEoCc25isbCC8BJP2OqbiRv--
