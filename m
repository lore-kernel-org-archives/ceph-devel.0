From: Loic Dachary <loic@dachary.org>
Subject: Re: erasured PG always "peering"
Date: Wed, 12 Mar 2014 21:05:31 +0100
Message-ID: <5320BE0B.4090507@dachary.org>
References: <CAKD2hyHsCTTLWtTR8O6GYMgk=qRw38r_JGz=vAY+yA1DonqYyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Mocnni3NrjTNs60HEmaNjXfRBaomsDOjX"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41367 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbaCLUFm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 16:05:42 -0400
In-Reply-To: <CAKD2hyHsCTTLWtTR8O6GYMgk=qRw38r_JGz=vAY+yA1DonqYyQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?TGx1w61zIFDDoG1pZXMgaSBKdcOhcmV6?= <llpamies@pamies.cat>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mocnni3NrjTNs60HEmaNjXfRBaomsDOjX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi

On 12/03/2014 18:40, Llu=C3=ADs P=C3=A0mies i Ju=C3=A1rez wrote:
> Hi ceph-devel,
>=20
> I have been playing with the new erasure code functionality and I have
> noticed that the erasure coded PG remains in "peering" state forever. I=
s
> that normal?
>=20
> I have a scenario with four servers each with two OSDs (total of eight
> OSDs). Then I define the extra crush rule to get four different OSDs ac=
ross
> hosts:
>=20
> rule reedsol_ruleset {
>     ruleset 1
>     type erasure
>     min_size 4
>     max_size 4
>     step take default
>     step chooseleaf firstn 0 type host

You want to s/firstn/indep/ here. But I don't think it's the source of yo=
ur problem.

=46rom what version are you running (hash of the last commit) ?

Cheers

>     step emit
> }
>=20
> And create a simple pool by:
> sudo ceph osd pool create cauchy 1 1 erasure erasure-code-plugin=3Djera=
sure
> erasure-code-k=3D2 erasure-code-m=3D2 erasure-code-technique=3Dcauchy_g=
ood
> crush_ruleset=3Dreedsol_ruleset
>=20
> After that, the PG status jumps from "creating" to "peering" and stays
> there forever. With "sudo ceph pg dump_stuck" I can see:
>=20
> pg_stat objects mip degr unf bytes log disklog state state_stamp v repo=
rted
> up up_primary acting acting_primary last_scrub scrub_stamp last_deep_sc=
rub
> deep_scrub_stamp
> 5.0 0 0 0 0 0 0 0 peering 2014-03-12 10:30:36.717544 0'0 58:3 [0,6,2,5]=
 0
> [0,6,2,5] 0 0'0 2014-03-12 10:30:36.715589 0'0 2014-03-12 10:30:36.7155=
89
>=20
> I guess that this is not normal and I'm probably doing something wrong.=
 Any
> ideas?
>=20
> Thanks,
> Llu=C3=ADs
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Mocnni3NrjTNs60HEmaNjXfRBaomsDOjX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMgvgsACgkQ8dLMyEl6F21MQgCfWK8fcTQh5NIwByihAf3qAT/T
QIUAn2mlBDIa6KJmgKmfT/lRJGbpQZQO
=Vghu
-----END PGP SIGNATURE-----

--Mocnni3NrjTNs60HEmaNjXfRBaomsDOjX--
