From: Sebastien Han <sebastien.han@enovance.com>
Subject: Re: ceph-standalone
Date: Sun, 23 Feb 2014 23:33:43 +0100
Message-ID: <AAA9F1FF-2397-422E-BA8A-A6B681AD069E@enovance.com>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: multipart/signed; boundary="Apple-Mail=_7C85514F-32D1-4ED9-9EFF-743E6B8C40C8"; protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:34691 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbaBWWdr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Feb 2014 17:33:47 -0500
In-Reply-To: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--Apple-Mail=_7C85514F-32D1-4ED9-9EFF-743E6B8C40C8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

This seems quite useful and could improve the user experience.
This looks more or less like a ceph-deploy wrapper to me and shouldn=92t =
be that difficult to make (except for the RGW part since nothing is =
there).
A simple bash script could be used I guess.

I just wonder if it=92s worth investing into a RGW with ceph-deploy and =
then just write a bash script that wraps up everything on a single =
setup.

What do you think?

Cheers.
=96=96=96=96=20
S=E9bastien Han=20
Cloud Engineer=20

"Always give 100%. Unless you're giving blood.=94=20

Phone: +33 (0)1 49 70 99 72=20
Mail: sebastien.han@enovance.com=20
Address : 10, rue de la Victoire - 75009 Paris=20
Web : www.enovance.com - Twitter : @enovance=20

On 23 Feb 2014, at 21:30, Sage Weil <sage@inktank.com> wrote:

> One idea kicking around is to create a simple ceph-standalone package =
that=20
> is meant to make it really easy to play around with Ceph.  It would:
>=20
> - depend on all the relevant ceph packages
> - install a simple, generic ceph.conf for use on localhost (or perhaps=20=

> whatever /etc/hosts has for our hostname)
> - mkfs and start up a mon
> - start up an osd (or two?) in /var/lib/ceph (no dedicated =
disk/volume)
> - start an mds
> - add an apache2 site in /etc/apache2/sites-available (or whatever)
>=20
> The idea would be to do
>=20
> $ sudo apt-get install ceph-standalone
> $ ceph -s
> [...]
>=20
> and have a usable mini-cluster.  That makes it really easy for users =
to=20
> play with the basics, like:
>=20
> $ mkdir /mnt/ceph
> $ sudo ceph-fuse /mnt/ceph
>=20
> $ rbd create ...
> $ rbd map ...
>=20
> $ curl http://localhost:8000/
> <more rgw stuff>
>=20
> Does this sound useful?  Any takers?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Apple-Mail=_7C85514F-32D1-4ED9-9EFF-743E6B8C40C8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTCndHAAoJECPrkYfpbtGTU+oH/A+QQMnnDEGhwzns2IKrOFSM
iRy871N5v/9e7FGqsxt5LrwY9YCmzMrA7f+GA1t2F8koTaFnIGCjyJ5w6t6dzoX2
0hU09fQHnLYGWA/AyDxYXLHn6/N9osQjwEaoJbeosl4cfRlQhhLseIJYWnhY3NaI
t3SLvvQiXGMa7P6JNdFMc553hmMtmioD8/Pddxi8f+gQyguB4aUlAmGtvEkLohBD
pqVdmxPmX219nvl3v2SkhXRVd+xmWe/GnXsjiV7PEtJykkJ5Fx6QdniMgNYyKlXq
rh/RBVPMwyqUFoIOCz+F8pzUoqjuyUoLGE3R6dXkZBU1dC2RePDpNlyT5EGjhzU=
=l3Kj
-----END PGP SIGNATURE-----

--Apple-Mail=_7C85514F-32D1-4ED9-9EFF-743E6B8C40C8--
