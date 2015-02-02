From: Loic Dachary <loic@dachary.org>
Subject: Re: workloads/rbd_fsx_cache_writethrough.yaml hangs on dumpling
Date: Mon, 02 Feb 2015 16:00:48 +0100
Message-ID: <54CF9120.30509@dachary.org>
References: <54CF7927.7010908@dachary.org> <CAAM7YAmrh_DeJgPY-QECbiZqO4w0R=ummQBug=5B8dyoZrkjWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="n8CUwQRWhO9IojMnsIxMqPMVr57Em474G"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51287 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752529AbbBBPAv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Feb 2015 10:00:51 -0500
In-Reply-To: <CAAM7YAmrh_DeJgPY-QECbiZqO4w0R=ummQBug=5B8dyoZrkjWw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Jason Dillaman <dillaman@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n8CUwQRWhO9IojMnsIxMqPMVr57Em474G
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 02/02/2015 14:48, Yan, Zheng wrote:
> On Mon, Feb 2, 2015 at 9:18 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi,
>>
>> http://pulpito.ceph.com/loic-2015-01-29_15:39:38-rbd-dumpling-backport=
s---basic-multi/730029/ hangs on dumpling and got killed after two days.
>>
>> Although workloads/rbd_fsx_cache_writethrough.yaml  was running with t=
he thrasher, it does not seem to be related to http://tracker.ceph.com/is=
sues/10513 : it was running on a mira070 (16GB RAM) and plana78 (8GB RAM)=
=2E
>>
>> I don't see anything in https://github.com/ceph/ceph-qa-suite/blob/mas=
ter/tasks/rbd_fsx.py that would suggest it needs backporting a fix to the=
 ceph-qa-suite branch of dumpling.
>>
>> I browsed the commits related to RBD that are in the dumpling-backport=
s branch ( see here for the list I used http://tracker.ceph.com/issues/10=
560 ). I don't see anything in the issues that need backporting to dumpli=
ng either.
>>
>> Another run of this specific test has been scheduled to check if it al=
ways happens at http://pulpito.ceph.com/loic-2015-02-02_13:58:32-rbd:thra=
sh:workloads:rbd_fsx_cache_writethrough.yaml-dumpling-backports---basic-m=
ulti/
>>
>> Does that ring a bell by any chance ?
>>
>=20
> maybe it's the same as http://tracker.ceph.com/issues/10498
>=20

I hoped it would be but from what I read the bug crashes and creates a co=
re dump, right ? What I'm seeing is the test hanging indefinitely and no =
core.

Cheers

>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--n8CUwQRWhO9IojMnsIxMqPMVr57Em474G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTPkSAACgkQ8dLMyEl6F23+MACfb/+lGKAcv9q5M80JaOmrtJQT
IKYAniFiomZjOvzEg66AZl/rWcIGeaKb
=xkfN
-----END PGP SIGNATURE-----

--n8CUwQRWhO9IojMnsIxMqPMVr57Em474G--
