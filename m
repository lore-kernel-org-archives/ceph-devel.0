From: Loic Dachary <loic@dachary.org>
Subject: Re: creation of the puppet-ceph repository
Date: Sat, 25 Jan 2014 17:45:20 +0100
Message-ID: <52E3EA20.4010403@dachary.org>
References: <52AC97E2.8080907@dachary.org>	<CAJH6TXjCRiomcpt=QoSrdCsn8KSKUwW4hf9MHQtfk5yv7n_CUw@mail.gmail.com>	<52E29EC0.4030405@dachary.org> <CAJH6TXiHaqn7M7UF2EV_Py+D_pbQrOQQ78KrSLENGWuev6jx2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Ub0bs7871ctBJ5eaoHUtvhhcAfcpluibE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:52765 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbaAYQpW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 Jan 2014 11:45:22 -0500
In-Reply-To: <CAJH6TXiHaqn7M7UF2EV_Py+D_pbQrOQQ78KrSLENGWuev6jx2Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ub0bs7871ctBJ5eaoHUtvhhcAfcpluibE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

At the moment I would recommend using ceph-deploy instead of puppet. Alth=
ough there are puppet modules that could be used, they require significan=
tly more work than using ceph-deploy, even for someone who already has a =
running puppet master. The new puppet ceph module is expected to be simpl=
er to use than ceph-deploy and address more use cases, but it is not read=
y yet.

Cheers

On 24/01/2014 18:38, Gandalf Corvotempesta wrote:
> 2014/1/24 Loic Dachary <loic@dachary.org>:
>> Hi,
>>
>> At the moment the module can only be used to deploy mons. It's making =
slow progress but a number of patches went in Ceph and should significant=
ly simplify writing the puppet module, starting in Firefly.
>=20
>=20
> Based on docs, OSD seems to be deployable from puppet.
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--Ub0bs7871ctBJ5eaoHUtvhhcAfcpluibE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLj6iAACgkQ8dLMyEl6F22sbgCgsxZ7ml7o5sMcxTFFzXKB5U4g
6ogAn29crHgl2N0tlu7zjvX5ry/UAE5Q
=rE99
-----END PGP SIGNATURE-----

--Ub0bs7871ctBJ5eaoHUtvhhcAfcpluibE--
