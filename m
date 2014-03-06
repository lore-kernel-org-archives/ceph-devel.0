From: Sebastien Han <sebastien.han@enovance.com>
Subject: Re: Ceph Ansible Repo
Date: Thu, 6 Mar 2014 17:31:14 +0100
Message-ID: <2107CBEA-0AFA-4498-B4CB-2F904B8CE0BA@enovance.com>
References: <FA727FEF-D416-4D0E-810F-72C72E184DC1@enovance.com>	<CAJH6TXiWC0yRWSgU8B0=-mNDXc0tdQ62O3=K2t+Dq5T3emSCOg@mail.gmail.com>	<53186512.6080405@cam.ac.uk> <CAJH6TXhSTRvn3NRqh=WXY5VdPhbW+HxPZAbUGCEqtX6rB6YFWg@mail.gmail.com> <531877FE.6040106@cam.ac.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: multipart/signed; boundary="Apple-Mail=_4E2B3378-1D95-46A1-AA19-A81877DFEF58"; protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:27994 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbaCFQbU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 11:31:20 -0500
In-Reply-To: <531877FE.6040106@cam.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David McBride <dwm37@cam.ac.uk>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Weil Sage <sage@inktank.com>, Patrick McGarry <patrick@inktank.com>


--Apple-Mail=_4E2B3378-1D95-46A1-AA19-A81877DFEF58
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

I believe there is a use case behind the lvm journals.
For instance you can do:

2 SSDs:

* tiny mdadm raid 1 setup for the system; let=92s say /dev/sda1 and =
/dev/sdb1
* then you still have:
	* /dev/sda2
	* /dev/sdb2

They can both host journals, and you usually want to manage them with =
lvm, this is easier than managing partition.
I just open an issue as a feature/enhancement request.

https://github.com/ceph/ceph-ansible/issues/9

This shouldn=92t be that difficult to implement.

=96=96=96=96=20
S=E9bastien Han=20
Cloud Engineer=20

"Always give 100%. Unless you're giving blood.=94=20

Phone: +33 (0)1 49 70 99 72=20
Mail: sebastien.han@enovance.com=20
Address : 11 bis, rue Roqu=E9pine - 75008 Paris
Web : www.enovance.com - Twitter : @enovance=20

On 06 Mar 2014, at 14:28, David McBride <dwm37@cam.ac.uk> wrote:

> On 06/03/14 13:19, Gandalf Corvotempesta wrote:
>> 2014-03-06 13:07 GMT+01:00 David McBride <dwm37@cam.ac.uk>:
>>> This causes the IO load to be nicely balanced across the two SSDs,
>>> removing any hot spots, at the cost of enlarging the failure domain =
of
>>> the loss of an SSD from half a node to a full node.
>>=20
>> This is not a solution for me.
>> Why not using LVM with a VG striped across both SSD ?
>> I've never used LVM without raid, what happens in case of failure
>> of a phisical disks?  The whole VG is lost ?
>=20
> Yes.  A stripe-set depends on all of the members of an array, whether
> managed through MD or LVM.
>=20
> Thus, in a machine with two SSDs, which are striped together, the loss
> of *either* SSD will cause all of the OSDs hosted by that machine to =
be
> lost.
>=20
> (Note: if you want to use LVM rather than GPTs on MD, you will =
probably
> need to remove the '|dm-*' clause from the Ceph udev rules that govern
> OSD assembly before they will work as expected.)
>=20
> Kind regards,
> David
> --=20
> David McBride <dwm37@cam.ac.uk>
> Unix Specialist, University Computing Service


--Apple-Mail=_4E2B3378-1D95-46A1-AA19-A81877DFEF58
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTGKLTAAoJECPrkYfpbtGTE2cH/0fa3XdshVOMSvhgntIcSIZb
f9SMgiwSmnK/myy0gNuCe0h2FQ3S7+damGvD6+yG8ku8JB7UlJiwrRaOEcUjhSkp
ZmxVLTslAXPonm93X5JrtbE7f8DUsYfuOgiqacdNCPH2MLkcyonnARhqf1KvIaRd
1jLtN2+incOYFMK73g3LukeqtTrh/mEB2+zal9Qd7nyci/V9Bh1wk5GDLqUJU6lu
mn2qOqxxxpudwnrX6MKZBDAjQq2lNX9xNiyn6l1sF+gSVaeM4c41Ke4jY6Pl3/0u
ixB2I4aNkJ53V2Q0VFv8Xu6vL1pE+fq/kWDj5kIQPBPgdz3R0Ek0HnkYly6hppg=
=oTEX
-----END PGP SIGNATURE-----

--Apple-Mail=_4E2B3378-1D95-46A1-AA19-A81877DFEF58--
