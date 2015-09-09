From: Loic Dachary <loic@dachary.org>
Subject: Re: How to save log when test  met bugs
Date: Wed, 09 Sep 2015 10:32:37 +0200
Message-ID: <55EFEEA5.9060103@dachary.org>
References: <6AA21C22F0A5DA478922644AD2EC308C1D1A6A2C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hCU7alSwbxSuPps8FBxleONfu2Eh9IhAs"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52310 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752694AbbIIIco (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Sep 2015 04:32:44 -0400
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C1D1A6A2C@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hCU7alSwbxSuPps8FBxleONfu2Eh9IhAs
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

[adding ceph-devel as this may also be an inconvenient to others]


On 09/09/2015 10:23, Ma, Jianpeng wrote:> Hi Loic:
>   Today, I run test/cephtool-test-mds.sh, because my code has bug cause=
 osd down. I only from the screen saw "osd o down ...." and so on. But I =
don't find the related osd log.
> This because in vstart_wrapper.sh
>>> function vstart_setup()
>>> {
>>>    rm -fr $CEPH_DEV_DIR $CEPH_OUT_DIR
>>>    mkdir -p $CEPH_DEV_DIR
>>>    trap "teardown $CEPH_DIR" EXIT
>  This " trap "teardown $CEPH_DIR" EXIT" will remove the test dir(osd lo=
g in this).
>=20
> I don' know how to resolve this. But I think this really is a bug. Or a=
m missing something?

You're right, it is inconvenient for debug. What I usually do in these si=
tuations is add "exit" or even a sleep 10000000 somewhere to bypass every=
thing and give me time to take a look at the logs. There should really be=
 a way to ask (option, environment variable ?) "please keep the logs when=
 it fails instead of cleaning up".

What do you think ?

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--hCU7alSwbxSuPps8FBxleONfu2Eh9IhAs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXv7qUACgkQ8dLMyEl6F21fqwCcCxGvGT3xLQ9T/rzXcpreHxAk
QHcAn0x7ACX7XxGQbCpjRuq5kOq91Xyv
=s4x0
-----END PGP SIGNATURE-----

--hCU7alSwbxSuPps8FBxleONfu2Eh9IhAs--
