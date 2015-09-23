From: Loic Dachary <loic@dachary.org>
Subject: Re: failed to open http://apt-mirror.front.sepia.ceph.com
Date: Wed, 23 Sep 2015 17:22:00 +0200
Message-ID: <5602C398.7000905@dachary.org>
References: <56027EE3.5080909@gmail.com> <56027F1D.90508@gmail.com> <56028812.1050207@dachary.org> <alpine.DEB.2.00.1509230611360.11876@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bXjgBQTsRKHAIb4MjnWHW979Xuns41Baq"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60043 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754063AbbIWPWD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 11:22:03 -0400
In-Reply-To: <alpine.DEB.2.00.1509230611360.11876@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: wangsongbo <songbo1227@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bXjgBQTsRKHAIb4MjnWHW979Xuns41Baq
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 23/09/2015 15:11, Sage Weil wrote:
> On Wed, 23 Sep 2015, Loic Dachary wrote:
>> Hi,
>>
>> On 23/09/2015 12:29, wangsongbo wrote:
>>> 64.90.32.37 apt-mirror.front.sepia.ceph.com
>>
>> It works for me. Could you send a traceroute=20
>> apt-mirror.front.sepia.ceph.com ?
>=20
> This is a private IP internal to the sepia lab.  Anythign outside the l=
ab=20
> shouldn't be using it...

This is the public facing IP and is required for teuthology to run outsid=
e of the lab (http://tracker.ceph.com/issues/12212).

64.90.32.37 apt-mirror.front.sepia.ceph.com

suggests the workaround was used. And a traceroute will confirm if the re=
solution happens as expected (with the public IP) or with a private IP (m=
eaning the workaround is not in place where it should).

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--bXjgBQTsRKHAIb4MjnWHW979Xuns41Baq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYCw5gACgkQ8dLMyEl6F23WzACfb+yCVyxepxAp1PWIqmWp2dJo
ZtIAnRTF3880c7nP40zp5gjAL5qM1xz3
=zCO4
-----END PGP SIGNATURE-----

--bXjgBQTsRKHAIb4MjnWHW979Xuns41Baq--
