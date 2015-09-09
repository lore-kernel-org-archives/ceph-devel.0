From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk pyudev implementation
Date: Wed, 09 Sep 2015 09:35:05 +0200
Message-ID: <55EFE129.8030502@dachary.org>
References: <9E914F5BD7F48A4782456CEB550A422824EC8564@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CMOI9wMhrhWbNqX8LECuObIffA6OdLOCw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52274 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752821AbbIIHfI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Sep 2015 03:35:08 -0400
In-Reply-To: <9E914F5BD7F48A4782456CEB550A422824EC8564@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CMOI9wMhrhWbNqX8LECuObIffA6OdLOCw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The approach you describe makes sense to me. And you've done a nice job w=
ith the refactor.

I'm not familiar with pyudev though and other Ceph developers may already=
 have an opinion (or answers). When adding new dependencies to Ceph, I th=
ink we need to assert how stable / reliable those dependencies are. How w=
ell tested do you think it is ? https://github.com/pyudev/pyudev/blob/mas=
ter/Vagrantfile suggests there are tests with good coverage, https://gith=
ub.com/pyudev/pyudev/pulls and https://github.com/pyudev/pyudev/issues?q=3D=
is%3Aopen+is%3Aissue have few open issues and a number of resolved ones. =
The timeline is a bit strange : a burst of recent commits and a large gap=
 back to 2012. But maybe it's widely used and this really is not a concer=
n ?=20

Is there a particular reason why you did not re-use the json format for c=
eph-disk list ?

Could you make your new ceph-disk into a pull request so that it can run =
integration tests ?

Cheers

On 09/09/2015 08:52, Chaitanya Huilgol wrote:
> Hi Loic,
>=20
> As discussed in the multipath tracker, please find the port of ceph-dis=
k which is based on pyudev (https://pyudev.readthedocs.org/en/latest/  py=
thon libudev binding)
>=20
> Here is a short summary on the approach:
> - Current ceph-disk determines various properties on block device by pa=
th string manipulations and /sys/dev properties
> - These are difficult to implement and fragile for device types such as=
 DM multipath.
> - Since different code needs to be added based on the device type, a Bl=
ock device class based approach has been used.
> - Based on the device type supplied a block device object is instantiat=
ed (currently GenericBlockDev or DMBlockDev).
> - Each class implements device specific functionality as an implementat=
ion of the abstract BlockDevBase base class.
>         a. Get partition device from base device
>         b. Get base device from partition
>         c. Get Part UUID and Type
>         d. Determine if device path is partition
>         e. Determine if device is referenced
>          f. Get HW sector size
>         g. List partitions
>=20
> In Prepare/Activate/List code paths, the required device object is inst=
antiated and hence these code paths remain clean
>=20
> This port also support multipath devices with the DMBlockDev Class.
>=20
> https://github.com/chaitanyahuilgol/ceph-disk-udev.git
>=20
> Let us know your thoughts.
>=20
> Regards,
> Chaitanya
>=20
>=20
> ________________________________
>=20
> PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above. =
If the reader of this message is not the intended recipient, you are here=
by notified that you have received this message in error and that any rev=
iew, dissemination, distribution, or copying of this message is strictly =
prohibited. If you have received this communication in error, please noti=
fy the sender by telephone or e-mail (as shown above) immediately and des=
troy any and all copies of this message in your possession (whether hard =
copies or electronically stored copies).
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--CMOI9wMhrhWbNqX8LECuObIffA6OdLOCw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXv4SoACgkQ8dLMyEl6F22g2QCgjg3lHarvbAWzBgo49FY5Llsg
52UAn1+A/lL3zBco2Glm5NMHbxzoFoIn
=fQva
-----END PGP SIGNATURE-----

--CMOI9wMhrhWbNqX8LECuObIffA6OdLOCw--
