From: Loic Dachary <loic@dachary.org>
Subject: Re: partprobe or partx or ... ?
Date: Sat, 19 Sep 2015 22:08:36 +0200
Message-ID: <55FDC0C4.6050103@dachary.org>
References: <55FD7DF8.7060601@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jgBhjTrT2cE2I6bWbPxR8USuJSGPctuhX"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58034 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751020AbbISUIj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Sep 2015 16:08:39 -0400
In-Reply-To: <55FD7DF8.7060601@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jgBhjTrT2cE2I6bWbPxR8USuJSGPctuhX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 19/09/2015 17:23, Loic Dachary wrote:
> Hi Ilya,
>=20
> At present ceph-disk uses partprobe to ensure the kernel is aware of th=
e latest partition changes after a new one is created, or after zapping t=
he partition table. Although it works reliably (in the sense that the ker=
nel is indeed aware of the desired partition layout), it goes as far as t=
o remove all partition devices of the current kernel table, only to re-ad=
d them with the new partition table. The delay it implies is not an issue=
 because ceph-disk is rarely called. It however generate many udev events=
 (dozens remove/change/add for a two partition disk) and almost always cr=
eates border cases that are difficult to figure out and debug. While it i=
s a good way to ensure that ceph-disk is idempotent and immune to race co=
nditions, maybe it is needlessly hard.
>=20
> Do you know of a light weight alternative to partprobe ? In the past we=
've used partx but I remember it failed to address some border cases in n=
on-intuitive ways. Do you know of another, simpler, approach to this ?
>=20
> Thanks in advance for your help :-)
>=20

For the record using /sys/block/sdX/device/rescan sounds good but does no=
t exist for devices created via devicemapper (used for dmcrypt and multip=
ath).

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--jgBhjTrT2cE2I6bWbPxR8USuJSGPctuhX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlX9wMQACgkQ8dLMyEl6F20KKgCcChkRFhfd6JczljUq/nc6KMSZ
CUIAoK4ANPaiYxBJXpaFIIAH1b9AhLbG
=VHXo
-----END PGP SIGNATURE-----

--jgBhjTrT2cE2I6bWbPxR8USuJSGPctuhX--
