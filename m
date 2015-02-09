From: Loic Dachary <loic@dachary.org>
Subject: Re: RBD tests on the next dumpling release
Date: Mon, 09 Feb 2015 11:12:58 +0100
Message-ID: <54D8882A.6010804@dachary.org>
References: <54D3EEF6.1070701@dachary.org> <1050495133.7647881.1423231520223.JavaMail.zimbra@redhat.com> <54D4CD03.8000806@dachary.org> <408976183.7693525.1423233776228.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pGa2LbVfJrEKxaVwapO2sldB9ohG2e6RJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:40987 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932238AbbBIKNC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Feb 2015 05:13:02 -0500
In-Reply-To: <408976183.7693525.1423233776228.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pGa2LbVfJrEKxaVwapO2sldB9ohG2e6RJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Your backport of http://tracker.ceph.com/issues/9854 at https://github.co=
m/ceph/ceph/pull/3655 was added to the dumpling-backports branch and the =
RBD suite run came back with one error.

http://tracker.ceph.com/issues/10560#teuthology-runs-on-3944c77c404c4a058=
86fe8276d5d0dd7e4f20410-6-february

I'm under the impression that this is unrelated. What do you think ?

The error found in the previous run

http://tracker.ceph.com/issues/10560#teuthology-runs-on-fd37e5a9749c5579a=
592ebe926a3c576be0617cd-3-february

could not be repeated by another run of the same test

http://pulpito.ceph.com/loic-2015-02-05_21:41:04-rbd-dumpling-backports--=
-basic-multi/

and I closed the ticket as "Can't reproduce" since you did not reproduce =
it locally either. Feel free to change the state of the ticket if, for in=
stance, you would like it to remain open during a few weeks in case it sh=
ows up again.

Cheers

On 06/02/2015 15:42, Jason Dillaman wrote:
> I would say #9854 is critical for this dumpling point release since it =
fixes a regression that would otherwise be introduced by this point relea=
se.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--pGa2LbVfJrEKxaVwapO2sldB9ohG2e6RJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTYiCoACgkQ8dLMyEl6F21pzwCgvPVsaQ+cA+JFNm+3cOavIV6t
4fsAoKjBwOXp6Sa69BYzHkH9r9xb5J+q
=Wxcv
-----END PGP SIGNATURE-----

--pGa2LbVfJrEKxaVwapO2sldB9ohG2e6RJ--
