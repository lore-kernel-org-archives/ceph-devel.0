From: Sebastien Han <sebastien.han@enovance.com>
Subject: Re: Ceph Ansible Repo
Date: Thu, 6 Mar 2014 11:42:47 +0100
Message-ID: <B43365B2-B0C1-4117-867B-3D7E772D30AA@enovance.com>
References: <FA727FEF-D416-4D0E-810F-72C72E184DC1@enovance.com> <CAJH6TXiWC0yRWSgU8B0=-mNDXc0tdQ62O3=K2t+Dq5T3emSCOg@mail.gmail.com> <90E136A4-51C0-4991-BC23-4ECF078D6B52@enovance.com> <CAJH6TXjvu4A_1pZKfOr22M00kCx+k08uEN8JFaYrTwXRmXQjjA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: multipart/signed; boundary="Apple-Mail=_CB880DBD-9525-4532-8AE5-A0EDBD2B1A07"; protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:61646 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbaCFKmx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 05:42:53 -0500
In-Reply-To: <CAJH6TXjvu4A_1pZKfOr22M00kCx+k08uEN8JFaYrTwXRmXQjjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Weil Sage <sage@inktank.com>, Patrick McGarry <patrick@inktank.com>


--Apple-Mail=_CB880DBD-9525-4532-8AE5-A0EDBD2B1A07
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Cool :)

Yes you will be able to pre-provision all the disks.
During the next run it will retry all the disks, some will be installed =
some will not therefore it will configure them :).

=96=96=96=96=20
S=E9bastien Han=20
Cloud Engineer=20

"Always give 100%. Unless you're giving blood.=94=20

Phone: +33 (0)1 49 70 99 72=20
Mail: sebastien.han@enovance.com=20
Address : 11 bis, rue Roqu=E9pine - 75008 Paris
Web : www.enovance.com - Twitter : @enovance=20

On 06 Mar 2014, at 11:28, Gandalf Corvotempesta =
<gandalf.corvotempesta@gmail.com> wrote:

> 2014-03-06 11:14 GMT+01:00 Sebastien Han <sebastien.han@enovance.com>:
>> No this is currently not supported.
>> We can only select on drive per server.
>> Can you submit an issue on Github for enhancement?
>=20
> I'll do in a couple of minutes.
>=20
>> Yes they must be identical. If a device doesn't exist Ansible will =
simply hang on the "parted" test, it will probably timeout at some =
point, however I haven't tested this.
>> However I just pushed a pull request to workaround this issue.
>> https://github.com/ceph/ceph-ansible/pull/4
>=20
> Cool.
> In this case I'll be able to specify all 12 spinning disks for my
> servers even if they aren't installed.
> Is Ansible smart enough to detect and configure newly added disks in
> the next run ?


--Apple-Mail=_CB880DBD-9525-4532-8AE5-A0EDBD2B1A07
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTGFEoAAoJECPrkYfpbtGTDHYH/RqSNUmOzir3Idhit0JzAxE3
59YvO0aj6HM0BSiLZky5DLFKa4etza+ySDhOWRpZ7ovnLB0iwqVKHtLSxZtZOpUl
zlIPhLtjDYJTrz3oVn5PN2ZMV1xHI3Gk91gjAxWBRDa8mZuNzm6l1KRA3tJ1819D
7MecMV0puFxGoev1uuMYtRxDPb5gpL2EkAMPDRBqN5aZoiO9AL1vC1zNopJqapWQ
uIjeFtLUGsBRQ3c5pA+Zvw/DYnuTVOLCWfwkzNkvqNVVsS6FDZdnYy/abOTEKKZJ
gMtIeqZNNG5PiwMAHMTY9K/7q/T5x/HqgUDSJknduYZ7ML4tKAy169QbaaTc+aw=
=Dzhv
-----END PGP SIGNATURE-----

--Apple-Mail=_CB880DBD-9525-4532-8AE5-A0EDBD2B1A07--
