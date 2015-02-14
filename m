From: Loic Dachary <loic@dachary.org>
Subject: Re: [Ceph-qa] 1 hung, 11 passed in teuthology-2015-02-11_16:13:01-samba-giant-distro-basic-multi
Date: Sat, 14 Feb 2015 07:34:04 +0100
Message-ID: <54DEEC5C.4030605@dachary.org>
References: <20150213035821.17712282150@teuthology.front.sepia.ceph.com> <CAC6JEv9pUeCtjs_SBeqr5N=4aSUUuUsbDW3eMipVsBTq5AkZkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FPL9Jlo46FB8HCSwECoHmNcU1MUgtol0S"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43935 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753781AbbBNHpA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Feb 2015 02:45:00 -0500
In-Reply-To: <CAC6JEv9pUeCtjs_SBeqr5N=4aSUUuUsbDW3eMipVsBTq5AkZkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FPL9Jlo46FB8HCSwECoHmNcU1MUgtol0S
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Greg,

I'm curious to know how you handle the flow of mails from QA runs. Here i=
s a wild guess:

* from time to time check that the nightlies run the suites that should b=
e run
* read the ceph-qa reports daily
* for each failed job, either relate it to an issue or create one or decl=
are it noise
* if a job fails on an existing ticket store a link to the job if it's ra=
re occurrence and the cause is not yet known
* bi-weekly bug scrub makes sure no issue, old or new, is forgotten
* at release time you decide that it is ready based on:
** the list of urgent/immediate issues that you can browse to ensure no i=
ssue is a blocker
** the last run of each suite to ensure they are recent enough and enviro=
nmental noise did not permanently shadow anything

Cheers


On 13/02/2015 20:29, Gregory Farnum wrote:
> On Thu, Feb 12, 2015 at 7:58 PM,
> <teuthworker@teuthology.front.sepia.ceph.com> wrote:
>> Test Run: teuthology-2015-02-11_16:13:01-samba-giant-distro-basic-mult=
i
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> info:   http://pulpito.ceph.com/teuthology-2015-02-11_16:13:01-samba-g=
iant-distro-basic-multi/
>> logs:   http://qa-proxy.ceph.com/teuthology/teuthology-2015-02-11_16:1=
3:01-samba-giant-distro-basic-multi/
>> failed: 0
>> hung:   1
>> passed: 11
>>
>> Hung
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [752393] samba/{clusters/samba-basic.yaml debug/mds_client.yaml fs/btr=
fs.yaml install/install.yaml mount/noceph.yaml workload/smbtorture.yaml}
>> info:   http://pulpito.ceph.com/teuthology-2015-02-11_16:13:01-samba-g=
iant-distro-basic-multi/752393/
>=20
> Looks like http://tracker.ceph.com/issues/10413, the upstream fix for
> which should be trickling down soon.
>=20
>>
>> Passed
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> _______________________________________________
> Ceph-qa mailing list
> Ceph-qa@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-qa-ceph.com
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--FPL9Jlo46FB8HCSwECoHmNcU1MUgtol0S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTe7FwACgkQ8dLMyEl6F20IYACfUcxXQJ1DyRXuKIjePXSzFSJ5
EPwAn3kgLOvU2iRKH89BZxrsCKXpYvJK
=1Tyg
-----END PGP SIGNATURE-----

--FPL9Jlo46FB8HCSwECoHmNcU1MUgtol0S--
