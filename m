From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer/firefly backports upgrade suite
Date: Thu, 30 Jul 2015 10:03:31 +0200
Message-ID: <55B9DA53.9050904@dachary.org>
References: <55B946D0.3070308@dachary.org> <55B9D0D7.607@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fdSPFdRsrmiW9BJqE07Urjw6BMGDHQ1Wp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58672 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750868AbbG3IDi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 04:03:38 -0400
In-Reply-To: <55B9D0D7.607@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fdSPFdRsrmiW9BJqE07Urjw6BMGDHQ1Wp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 30/07/2015 09:23, Nathan Cutler wrote:
>> It turns out the mistake was to use upgrade/firefly-x and upgrade/hamm=
er-x instead of upgrade/firelfy and upgrade/hammer. When -c hammer-backpo=
rts or -c firefly-backports is given to teuthology-suite, it will upgrade=
 to this version, from older versions of the same stable branch.
>>
>> I've updated:
>>
>> http://tracker.ceph.com/issues/11644#upgrade
>> http://tracker.ceph.com/issues/11990#upgrade
>>
>> whith the fix and they are running (using the OpenStack cluster though=
, there may be issues with the firefly upgrade suite but the hammer upgra=
de suite must run fine, it has run at http://ceph.aevoo.fr:8081/ enough t=
imes to suggest there are no OpenStack specific issues).
>=20
> Hi Loic:
>=20
> As you predicted, the firefly upgrade suite finished with quite a few f=
ailures. I looked at the first one and the log said:
>=20
> ERROR:teuthology.misc:. teuthology/test/integration/openrc.sh && openst=
ack network show -f json unknown error ERROR: openstack No networks with =
a name or ID of 'unknown' found
>=20
> Nathan

These can be ignored. I'll fix that so it does not show in the future.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--fdSPFdRsrmiW9BJqE07Urjw6BMGDHQ1Wp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW52lMACgkQ8dLMyEl6F20v3wCdFrNQKCl6F8f3vT5NPXP6fJIl
1H0AoKxxUBxgJQ79jp9JTm6QrvCOZvVo
=6VOG
-----END PGP SIGNATURE-----

--fdSPFdRsrmiW9BJqE07Urjw6BMGDHQ1Wp--
