From: Loic Dachary <loic@dachary.org>
Subject: Re: Pyramid erasure codes and replica hinted recovery
Date: Mon, 13 Jan 2014 09:38:47 +0100
Message-ID: <52D3A617.9010409@dachary.org>
References: <CAHxYaFMa_peMz8StZpJ=if0W4LmHBDO71vNnYnmgcNMab0-3aQ@mail.gmail.com>	<52D1F060.8050108@dachary.org>	<CAHxYaFOg6N2ZP1=OuOWajXUqMFtGsq0u94DG=Ub8NcAaqFtj+g@mail.gmail.com>	<52D2EEF8.8020009@dachary.org> <CAHxYaFOzaeeRPv+N0mU_uWODUOvQnAe2kAn8rkuuSchFigkBAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="I1oqtBpDMPjW6LbHEExDWOWSknljnHFg4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41841 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbaAMIiw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jan 2014 03:38:52 -0500
In-Reply-To: <CAHxYaFOzaeeRPv+N0mU_uWODUOvQnAe2kAn8rkuuSchFigkBAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I1oqtBpDMPjW6LbHEExDWOWSknljnHFg4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 13/01/2014 03:35, Kyle Bader wrote:
>> How is it different from what is described above? There must be someth=
ing I fail to understand.
>=20
> No misunderstanding on your part, on second look that does achieve the
> desired placement. Could you please help walk me through the following
> scenarios:
>=20
> Can data or local parity chunks that have been lost (erasures) be
> recovered locally, with no inter-dc backfill traffic?

If the primary happens to be located in the same data enter as the lost c=
hunk and the layout is as described previously, then it will be recovered=
 without the need for inter-dc traffic. If the primary is not in the same=
 datacenter, it may be possible to move it to the datacenter where the lo=
st chunk is located. When the primary OSD is lost, another must be chosen=
=2E It would be nice to change the primary not only when it is lost but a=
lso when doing so helps recovery.=20

> Global parity chunks that are lost require reading....6x data or
> global parity chunks (effectively 1x the original write)?

=46rom the point of view of recovery, global parity chunks are treated in=
 the same way as data chunks. If you have RS(6,3,3), you will need to rea=
d 6 chunks out of 9 ( 6 data chunks + 3 global parity chunks ) to be able=
 to recover from the loss of 2 or 3 chunks ( data or parity, it does not =
matter ). In other words, to recover from the loss of more chunks than lo=
cal parity allows, you need to read 1x the original write.=20

> Would placement groups containing a data or local parity chunk that
> have been remapped backfill from the local chunk (member of previous
> acting set)?

David is working on multiple backfill at the moment https://github.com/ce=
ph/ceph/pull/931 and will have a definitive answer. The data flows from t=
he primary OSD to the OSDs supporting the other chunks there is no peer-t=
o-peer communication between the OSDs participating in a placement group.=
=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--I1oqtBpDMPjW6LbHEExDWOWSknljnHFg4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLTphcACgkQ8dLMyEl6F20VNgCfcel3pCMBIa1jU3n/tlPe8tpi
PPcAoIPUgCstvj78SlCkRP280EoOkOkh
=jouO
-----END PGP SIGNATURE-----

--I1oqtBpDMPjW6LbHEExDWOWSknljnHFg4--
