From: Loic Dachary <loic@dachary.org>
Subject: Re: rgw and the next dumpling release
Date: Fri, 06 Feb 2015 00:07:49 +0100
Message-ID: <54D3F7C5.6030701@dachary.org>
References: <54D3F0E5.8060906@dachary.org> <974116011.8222626.1423177154743.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0cLvCaVEu8kcUn16Uft2ntmXtRDPACKnP"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39527 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751091AbbBEXHv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Feb 2015 18:07:51 -0500
In-Reply-To: <974116011.8222626.1423177154743.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0cLvCaVEu8kcUn16Uft2ntmXtRDPACKnP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks !

On 05/02/2015 23:59, Yehuda Sadeh-Weinraub wrote:
>=20
> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Yehuda Sadeh" <yehuda@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Thursday, February 5, 2015 2:38:29 PM
>> Subject: rgw and the next dumpling release
>>
>> Hi Yehuda,
>>
>> The rados teuthology suite for the next dumpling release as found in
>> https://github.com/ceph/ceph/commits/dumpling-backports came back gree=
n
>> http://pulpito.ceph.com/loic-2015-02-03_14:46:09-rgw-dumpling-backport=
s---basic-multi/.
>> Do you think it is ready for QE to start their own round of testing ?
>>
>=20
> We should also backport a9dd4af401328e8f9071dee52470a0685ceb296b to dum=
pling. I think I saw a dumpling run failing due to the lack of this one, =
and since we now run on environments that use apache 2.4. Looking at this=
 commit, it's not going to be applied trivially, so I'm preparing one for=
 dumpling now.
>=20
> Yehuda
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--0cLvCaVEu8kcUn16Uft2ntmXtRDPACKnP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTT98UACgkQ8dLMyEl6F23dOQCfX+ogdomL1NfpKWwg27/eR+s3
jKEAnjRtckQULQ34wHBXA61MjSaUg43A
=ibCw
-----END PGP SIGNATURE-----

--0cLvCaVEu8kcUn16Uft2ntmXtRDPACKnP--
