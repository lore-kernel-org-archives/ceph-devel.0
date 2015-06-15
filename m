From: Loic Dachary <loic@dachary.org>
Subject: Re: Please help triage these old backports
Date: Mon, 15 Jun 2015 12:58:51 +0200
Message-ID: <557EAFEB.6000809@dachary.org>
References: <557E9C37.809@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xkNjKx6TxJfdiAvFMrnK11htIri2H7u4D"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34067 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753933AbbFOK6z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jun 2015 06:58:55 -0400
In-Reply-To: <557E9C37.809@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xkNjKx6TxJfdiAvFMrnK11htIri2H7u4D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding ceph-devel for other backporters benefit]

Hi Nathan,

On 15/06/2015 11:34, Nathan Cutler wrote:
> Hi Loic:
>=20
> I went over the list of old untriaged backports at
>=20
> http://tracker.ceph.com/projects/ceph/issues?utf8=3D%E2%9C%93&set_filte=
r=3D1&f[]=3Dstatus_id&op[status_id]=3D%3D&v[status_id][]=3D14&f[]=3Dcf_2&=
op[cf_2]=3D!*&f[]=3D&c[]=3Dproject&c[]=3Dtracker&c[]=3Dstatus&c[]=3Dprior=
ity&c[]=3Dsubject&c[]=3Dassigned_to&c[]=3Dupdated_on&c[]=3Dcategory&c[]=3D=
fixed_version&c[]=3Dcf_3&group_by=3D
>=20
> and processed those that I could figure out. There are four remaining
> issues there - can you take a look?
>=20

I triaged three of them. The fourth was about krbd which has an entirely =
different lifecycle. I think we can assume the meaning of "Pending Backpo=
rt" for the project http://tracker.ceph.com/projects/ceph-kclient is diff=
erent from what we have at http://tracker.ceph.com/projects/ceph-releases=
=2E I've updated http://tracker.ceph.com/projects/ceph-releases/wiki/HOWT=
O_triage_incoming_Pending_backport_issues with the following request inst=
ead of collecting all "Pending Backport" issues from all projects regardl=
ess.

http://tracker.ceph.com/projects/ceph/issues?utf8=3D%E2%9C%93&set_filter=3D=
1&f[]=3Dstatus_id&op[status_id]=3D%3D&v[status_id][]=3D14&f[]=3Dcf_2&op[c=
f_2]=3D!*&f[]=3Dsubproject_id&op[subproject_id]=3D%3D&v[subproject_id][]=3D=
8&v[subproject_id][]=3D13&v[subproject_id][]=3D9&v[subproject_id][]=3D10&=
v[subproject_id][]=3D14&f[]=3D&c[]=3Dproject&c[]=3Dtracker&c[]=3Dstatus&c=
[]=3Dpriority&c[]=3Dsubject&c[]=3Dassigned_to&c[]=3Dupdated_on&c[]=3Dcate=
gory&c[]=3Dfixed_version&c[]=3Dcf_3&group_by=3D

Do you see an problem with that ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--xkNjKx6TxJfdiAvFMrnK11htIri2H7u4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlV+r+sACgkQ8dLMyEl6F231+QCeKrx6v25kYU9cCfhxMIpgkkB5
kHEAn0QutEY65t+Xm2OFuEaEpXpQP5lm
=vR7q
-----END PGP SIGNATURE-----

--xkNjKx6TxJfdiAvFMrnK11htIri2H7u4D--
