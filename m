From: Loic Dachary <loic@dachary.org>
Subject: Re: Substriping support in ErasureCodeInterface
Date: Fri, 05 Jun 2015 19:46:43 +0200
Message-ID: <5571E083.6020800@dachary.org>
References: <CAA-SLH9NNinYZO2iev5nYnTfR+va73-UNh7GnwAroSjtxCot0Q@mail.gmail.com>	<557198A7.5040805@dachary.org> <CAA-SLH_EZbe=S=GVdPaQj6Bz0gPE1qDqKGUuUdHyQGPy4JT7hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rlesoqcpjNU79Qd9Ul95Na3EXg9rVhDMH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57012 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751909AbbFERqp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jun 2015 13:46:45 -0400
In-Reply-To: <CAA-SLH_EZbe=S=GVdPaQj6Bz0gPE1qDqKGUuUdHyQGPy4JT7hA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sindre Stene <sindrestene@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rlesoqcpjNU79Qd9Ul95Na3EXg9rVhDMH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/06/2015 15:34, Sindre Stene wrote:
> Sending the mail again without pesky html tags.
>=20
> On Fri, Jun 5, 2015 at 2:40 PM, Loic Dachary <loic@dachary.orgwrote:
>> (...)
>> Why do you think the current interface is insufficient ? What would yo=
u
>> need in addition ?
>=20
> I am not sure whether or not the interface is sufficient. Let me try to=

> explain my assumptions, so that we can clarify.
>=20
> Lets say for the sake of simplicity that I have a system of 14 HDDs, wi=
th an
> allocation unit size of 4K, and am using K =3D 10 systematic drives, an=
d M =3D 4
> redundancy drives (and no spares).
> Lets say that I am using an encoding scheme with 8 substripes (for each=
 of
> the 14 stripes), and only one object size, that perfectly matches the
> scheme: 4K * 10 * 8. My raw objects are then of 80 chunks, and i am add=
ing
> 32 chunks of redundancy data, making each encoded object take up 4K*8*1=
4 =3D
> 448K. The chunks are to be physically stored with these offsets:
> HDD0: chunks 0-7
> HDD1: chunks 8-15
> (...)
> HDD13 (redundancy 3): chunks
> Assuming that the coding scheme is MDS, the encoding scheme would guara=
ntee
> recovery of up to 4 lost hard drives. It would not guarantee recovery f=
or 32
> arbitrary chunks (which is the same data amount when considering a sing=
le
> object), as they would have to be organized in adjacent groups of 8.
> Assuming the crush map may be used to configure this sort of chunk
> placement, perhaps the interface is indeed sufficient ?

I think so.=20

> And, not specific to the interface definition, but about how Ceph uses =
the
> interface during operation and during tests:
> Would the interface receive decode requests for sets of chunks that are=
 not
> organized in groups of 8?

The plugin only decodes when at least a chunk is missing, otherwise it ju=
st concatenates the chunks. When it decodes, in the case of jerasure, it =
expects the caller (the OSD in this case) to ask about the minimum amount=
 of chunks that are needed. If I understand correctly the plugin would hi=
de the 8 substripe division from the caller entirely. It the caller needs=
 to be aware of that substripe logic, a new interface would have to be de=
fined and documented.

> Would the subpacketization (or grouping of chunks) create problems with=
 the
> unit tests?
> Do you experts see any other implications or side-effects?
>=20
> Motivation; The required read access for recovering one drive in a (14 =
total
> disks,10 systematic data disks) setup using Reed.Solomon, is 10. This c=
an
> theoretically be reduced by ~40% by introducing substripes (splitting e=
ach
> of the 14 parts into many smaller parts, but fundamentally storing the =
first
> 10 major parts in exactly the same way on the HDD, meaning that the I/O=
 of
> normal reads are not impacted at all). There are many trade-offs to
> consider, and so we wish to test the performance differences.

There is a pull request pending that only reads part of the chunks when t=
he size is smaller than a stripe. This may be useful for workloads involv=
ing small objects. Is it what you're thinking about ?

Cheers

>=20
> Sincerely,
> Sindre B. Stene
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--rlesoqcpjNU79Qd9Ul95Na3EXg9rVhDMH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVx4IMACgkQ8dLMyEl6F20+8QCfXe8F6PA2/Knv7qPymfXS6xa2
DwcAn2n9C6oN+rqaLpuCIeBc2CjCWlZY
=+RjJ
-----END PGP SIGNATURE-----

--rlesoqcpjNU79Qd9Ul95Na3EXg9rVhDMH--
