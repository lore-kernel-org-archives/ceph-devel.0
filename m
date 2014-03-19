From: Sebastien Han <sebastien.han@enovance.com>
Subject: Re: [ceph-users] qemu non-shared storage migration of nova instances?
Date: Wed, 19 Mar 2014 14:05:13 +0100
Message-ID: <F7E20A5E-9D85-4E59-9F58-7CB2F42E2119@enovance.com>
References: <CA+z5Dsx0SFjcKfXqoV_a7_EbpW3a-B7N=fZFG61OayueuPOGbw@mail.gmail.com> <CA+z5DszqaLuE+bwPvRMFQZQEUQaQYPvxrD+ap=1ehR7voK7_qA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: multipart/signed; boundary="Apple-Mail=_4F58D376-AFC1-4CB3-9C74-D8F180295EB9"; protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:21480 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964900AbaCSNFR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Mar 2014 09:05:17 -0400
In-Reply-To: <CA+z5DszqaLuE+bwPvRMFQZQEUQaQYPvxrD+ap=1ehR7voK7_qA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blair Bethwaite <blair.bethwaite@gmail.com>
Cc: ceph-devel@vger.kernel.org


--Apple-Mail=_4F58D376-AFC1-4CB3-9C74-D8F180295EB9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hi Blair,

Hum so the problem is:

While block-migrating a VM with local ephemeral storage (VM disk is a =
file under /var/lib/nova/instances/) the RBD volume attached to the =
instance gets copied also?

Am I correct?

=96=96=96=96=20
S=E9bastien Han=20
Cloud Engineer=20

"Always give 100%. Unless you're giving blood.=94=20

Phone: +33 (0)1 49 70 99 72=20
Mail: sebastien.han@enovance.com=20
Address : 11 bis, rue Roqu=E9pine - 75008 Paris
Web : www.enovance.com - Twitter : @enovance=20

On 19 Mar 2014, at 13:57, Blair Bethwaite <blair.bethwaite@gmail.com> =
wrote:

> Hi Sebastian,
>=20
> As you seem to favor this configuration too, and are very =
knowledgeable in these areas, I wonder if you have found an answer to my =
question about block-migration with attached volumes?
>=20
> Best regards,
> ~Blair
>=20
>=20
> On 18 March 2014 09:08, Blair Bethwaite <blair.bethwaite@gmail.com> =
wrote:
> Message: 20
> Date: Mon, 17 Mar 2014 16:05:17 +0100
> From: Sebastien Han <sebastien.han@enovance.com>
> To: "Don Talton (dotalton)" <dotalton@cisco.com>
> Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>
> Subject: Re: [ceph-users] qemu non-shared storage migration of nova
>         instances?
> Message-ID: <86ED699A-DE8B-4864-860F-E324A6F11CC5@enovance.com>
> Content-Type: text/plain; charset=3D"windows-1252"
>=20
> Hi,
>=20
> I use the following live migration flags: =
VIR_MIGRATE_UNDEFINE_SOURCE,VIR_MIGRATE_PEER2PEER,VIR_MIGRATE_LIVE,VIR_MIG=
RATE_PERSIST_DEST
> It deletes the libvirt.xml and re-creates it on the other side.
>=20
> We use this setup (local direct-attached ephemeral storage and Ceph =
for persistent volumes) in a production OpenStack cloud. The biggest =
problem (which I think is still present with newer Qemu&Libvirt, though =
we are on 1.0 and 1.1.1 respectively at the moment) with this is that =
live-block-migrations copy all block device contents from source to =
destination... i.e., even volumes get transferred in a ridiculous =
sequence of "source hypervisor reads blocks from storage cluster -> =
source hypervisor streams blocks to destination hypervisor -> =
destination hypervisor writes blocks back to the storage cluster".
>=20
> Is that something others have run into and found workarounds for?
>=20
> --=20
> Cheers,
> ~Blairo
>=20
>=20
>=20
> --=20
> Cheers,
> ~Blairo


--Apple-Mail=_4F58D376-AFC1-4CB3-9C74-D8F180295EB9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTKZYJAAoJECPrkYfpbtGTrPIH/2w1wzDTji0rno38OMEjA25o
V/SBhzsnzUBbo1L4B7ksZmadR35EWiBWh5d3GjUksywU/chprZyBQgMhqGczrnos
dN38t4B0y0bZbEUuTtVzP8y7sjVmkw1QXaiONzSPZEfHSaeRU3QvdbwPWQeDSIAt
ScIfk1kisvVlHPLcYV+5PB2p5TMlCw6I4i5fRzvT6vzOL0AKW1r42ExvbZSXBPrl
ZFvj19Ro5U/FaT5TgTZv56wdIBN9iXvF8zygj26P6HqkbpVTIalJmE5dy98XfvnF
YifcRY5frkUNkMNkh5skDgy6y0b6SRie4NdyjWda14/6JXkNkirdSx0aREPzIX8=
=/u8q
-----END PGP SIGNATURE-----

--Apple-Mail=_4F58D376-AFC1-4CB3-9C74-D8F180295EB9--
