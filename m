From: Sebastien Han <sebastien.han@enovance.com>
Subject: Re: Ceph Ansible Repo
Date: Thu, 6 Mar 2014 11:14:26 +0100
Message-ID: <90E136A4-51C0-4991-BC23-4ECF078D6B52@enovance.com>
References: <FA727FEF-D416-4D0E-810F-72C72E184DC1@enovance.com> <CAJH6TXiWC0yRWSgU8B0=-mNDXc0tdQ62O3=K2t+Dq5T3emSCOg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: multipart/signed; boundary="Apple-Mail=_DE461126-175E-4EBC-B083-FB53C2BF1358"; protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:59137 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbaCFKO3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 05:14:29 -0500
In-Reply-To: <CAJH6TXiWC0yRWSgU8B0=-mNDXc0tdQ62O3=K2t+Dq5T3emSCOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Weil Sage <sage@inktank.com>, Patrick McGarry <patrick@inktank.com>


--Apple-Mail=_DE461126-175E-4EBC-B083-FB53C2BF1358
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hi Gandalf,

Answers inline:

=96=96=96=96=20
S=E9bastien Han=20
Cloud Engineer=20

"Always give 100%. Unless you're giving blood.=94=20

Phone: +33 (0)1 49 70 99 72=20
Mail: sebastien.han@enovance.com=20
Address : 11 bis, rue Roqu=E9pine - 75008 Paris
Web : www.enovance.com - Twitter : @enovance=20

On 06 Mar 2014, at 10:36, Gandalf Corvotempesta =
<gandalf.corvotempesta@gmail.com> wrote:

> Hi to all.
> Some question about ansible repo.
>=20
> 1. is possible to specify multiple journal devices for each OSD node?
> We have OSD with 12 spinning disks and 2 SSD as journal. We would like
> to use SSD1 for OSD1 to 6 and SSD2 for OSD 7 to 12. Is this possible ?

No this is currently not supported.
We can only select on drive per server.
Can you submit an issue on Github for enhancement?

>=20
> 2. With this repo, each OSD node must be identical to each other,
> right? What if OSD server1 has 3 spinning disks and OSD server2 has
> just 2 ?

Yes they must be identical. If a device doesn=92t exist Ansible will =
simply hang on the =93parted=94 test, it will probably timeout at some =
point, however I haven=92t tested this.
However I just pushed a pull request to workaround this issue.
https://github.com/ceph/ceph-ansible/pull/4

>=20
>=20
> 2014-03-03 0:26 GMT+01:00 Sebastien Han <sebastien.han@enovance.com>:
>> Hi,
>>=20
>> As discussed during the Ceph day, I achieved the Ansible playbook for =
Ceph.
>> It currently lives on my github, but I'd like to see it on =
github.com/ceph.
>>=20
>> Does anyone can create the corresponding repo so I can send a pull =
request?
>>=20
>> Thanks!
>>=20
>> ----
>> S=E9bastien Han
>> Cloud Engineer
>>=20
>> "Always give 100%. Unless you're giving blood."
>>=20
>> Phone: +33 (0)1 49 70 99 72
>> Mail: sebastien.han@enovance.com
>> Address : 11 bis, rue Roqu=E9pine - 75008 Paris
>> Web : www.enovance.com - Twitter : @enovance
>>=20


--Apple-Mail=_DE461126-175E-4EBC-B083-FB53C2BF1358
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTGEqCAAoJECPrkYfpbtGT66oH+wcPWcBszeF+BfrHWt9er9Pd
qKc2D7xoOpW0QaopNUoR/praJGTfgeHHi7iaINMqtmM8juqkEpfztniGcwmr/Ezr
qml04EcF8AscoJrFGj5gGUiMfsPX40IBy7XWBBYo3cLNl0O0BANjaQChOHBa9b/L
aj2O20UXzuGwTzo7g3fLRKGqp1bivq0n6LJNoFEhnNY1v20/Juvhqxfxv06UleZc
v7SoaEGhQvbLB96kEFM8/vmECqNeDHsLQR54IHx/zWsXLaz96N4yFDcGaHsQ5RJI
0d91scXBNTBaxOwZIYSvTDhGSc7EpkFU6CskbhhM9t2Gjt0L1oLtDjQ3gBkidSI=
=0Nqt
-----END PGP SIGNATURE-----

--Apple-Mail=_DE461126-175E-4EBC-B083-FB53C2BF1358--
