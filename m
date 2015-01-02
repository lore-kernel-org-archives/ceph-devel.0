From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-deploy osd destroy feature
Date: Fri, 02 Jan 2015 23:29:28 +0100
Message-ID: <54A71BC8.1060502@dachary.org>
References: <CACkq2moPdXgDGCtr-jtd+rxEGT3H_SFnVGruvKqfXDuvU8eagg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xXEqk32cJf7CvWVNdveVPf1q7XmIWofhB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:32858 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752197AbbABW3a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jan 2015 17:29:30 -0500
In-Reply-To: <CACkq2moPdXgDGCtr-jtd+rxEGT3H_SFnVGruvKqfXDuvU8eagg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xXEqk32cJf7CvWVNdveVPf1q7XmIWofhB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Travis (and happy new year ;-),

It would probably make sense to implement part of the removal steps in ce=
ph-disk ( http://tracker.ceph.com/issues/7454 ), don't you think ?

Cheers

On 02/01/2015 22:31, Travis Rhoden wrote:
> Hi everyone,
>=20
> There has been a long-standing request [1] to implement an OSD
> "destroy" capability to ceph-deploy.  A community user has submitted a
> pull request implementing this feature [2].  While the code needs a
> bit of work (there are a few things to work out before it would be
> ready to merge), I want to verify that the approach is sound before
> diving into it.
>=20
> As it currently stands, the new feature would do allow for the followin=
g:
>=20
> ceph-deploy osd destroy <host> --osd-id <id>
>=20
>>From that command, ceph-deploy would reach out to the host, do "ceph
> osd out", stop the ceph-osd service for the OSD, then finish by doing
> "ceph osd crush remove", "ceph auth del", and "ceph osd rm".  Finally,
> it would umount the OSD, typically in /var/lib/ceph/osd/...
>=20
>=20
> Does this high-level approach seem sane?  Anything that is missing
> when trying to remove an OSD?
>=20
>=20
> There are a few specifics to the current PR that jump out to me as
> things to address.  The format of the command is a bit rough, as other
> "ceph-deploy osd" commands take a list of [host[:disk[:journal]]] args
> to specify a bunch of disks/osds to act on at one.  But this command
> only allows one at a time, by virtue of the --osd-id argument.  We
> could try to accept [host:disk] and look up the OSD ID from that, or
> potentially take [host:ID] as input.
>=20
> Additionally, what should be done with the OSD's journal during the
> destroy process?  Should it be left untouched?
>=20
> Should there be any additional barriers to performing such a
> destructive command?  User confirmation?
>=20
>=20
>  - Travis
>=20
> [1] http://tracker.ceph.com/issues/3480
> [2] https://github.com/ceph/ceph-deploy/pull/254
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--xXEqk32cJf7CvWVNdveVPf1q7XmIWofhB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSnG8gACgkQ8dLMyEl6F21nYwCffFKyoPXdL952gox10h/KnW7R
hkYAoJ8jOLTtM+wgsMCEGqxfyp4O5pqQ
=iEP2
-----END PGP SIGNATURE-----

--xXEqk32cJf7CvWVNdveVPf1q7XmIWofhB--
