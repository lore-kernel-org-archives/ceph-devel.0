From: Loic Dachary <loic@dachary.org>
Subject: Re: new OSD re-using old OSD id fails to boot
Date: Wed, 9 Dec 2015 14:06:55 +0100
Message-ID: <5668276F.90803@dachary.org>
References: <5663158D.1010302@dachary.org> <56678036.5050909@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="goQ5mNpDN1nagIm80ui4DORISKvEhqjGD"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47051 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751592AbbLING6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Dec 2015 08:06:58 -0500
In-Reply-To: <56678036.5050909@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--goQ5mNpDN1nagIm80ui4DORISKvEhqjGD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/12/2015 02:13, David Zafman wrote:
>=20
> Remember I really think we want a disk replacement feature that would r=
etain the OSD id so that it avoids unnecessary data movement.  See tracke=
r http://tracker.ceph.com/issues/13732

I remember this, yes, it is a good idea :-)  Would that help fix http://t=
racker.ceph.com/issues/13988 ?

> David
>=20
> On 12/5/15 8:49 AM, Loic Dachary wrote:
>> Hi Sage,
>>
>> The problem described at "new OSD re-using old OSD id fails to boot" h=
ttp://tracker.ceph.com/issues/13988 consistently fails the ceph-disk suit=
e on master. I wonder if it could be a side effect of the recent optimiza=
tions introduced in the monitor ?
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--goQ5mNpDN1nagIm80ui4DORISKvEhqjGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZoJ28ACgkQ8dLMyEl6F227AwCeIp5cgpG9em8+U5F5gtL7THEH
twwAn3+Odz0SPkSzDr78V3bT+ulf8N8P
=F4zL
-----END PGP SIGNATURE-----

--goQ5mNpDN1nagIm80ui4DORISKvEhqjGD--
