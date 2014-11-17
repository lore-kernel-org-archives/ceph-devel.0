From: Loic Dachary <loic@dachary.org>
Subject: Re: Question on Ceph LRC design
Date: Mon, 17 Nov 2014 02:04:00 +0100
Message-ID: <54694980.2010302@dachary.org>
References: <06681238D8946F44A60AA400760A1CBF01E28FBD@SHSMSX104.ccr.corp.intel.com> <06681238D8946F44A60AA400760A1CBF01E290AB@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uSGWXxPxrAGEvNNgJLbRXopv68cLknnIF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37910 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751734AbaKQBED (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Nov 2014 20:04:03 -0500
In-Reply-To: <06681238D8946F44A60AA400760A1CBF01E290AB@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhou, Yuan" <yuan.zhou@intel.com>, "Andreas.Joachim.Peters@cern.ch" <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uSGWXxPxrAGEvNNgJLbRXopv68cLknnIF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I believe Andreas has a more elaborate answer on this topic. The current =
implementation is not as good as what is described in the paper you menti=
on, this is correct. My incentive for chosing this path is that I was abl=
e to understand it, mainly. It is not much more than stacking layers of e=
rasure coded chunks on top of each other ;-)

Now that we have this plugin, it would be nice to have another implementa=
tion that uses less space and possible even less network when reconstruct=
ing. During the OpenStack summit we discussed this with Kevin Greenan and=
 there are promising directions. It would help a lot to have a sample cod=
e to study so that it can be adapted to what we have currently in Ceph. D=
o you know of such an implementation of LRC or other similar code designe=
d to reduce the network bandwidth during reconstruction ?

Cheers

On 17/11/2014 01:52, Zhou, Yuan wrote:
> Hi Loic/Anderas,
>=20
> =20
>=20
> I was trying to understand the LRC design in Ceph EC. Per my understand=
ing, it seems Ceph was using a slightly different design with the Microso=
ft LRC: the local parities were calculated with the global parities inclu=
ded. Is there any special consideration on this change?
>=20
> I was asking because in a typical MS LRC design the global and local pa=
rities could be calculated at the same time actually(I mean inside the Er=
asure Code library). But with this new design, we lost this potential opt=
imization.
>=20
> =20
>=20
> Thanks, -Yuan
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--uSGWXxPxrAGEvNNgJLbRXopv68cLknnIF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRpSYAACgkQ8dLMyEl6F20uEgCeIquoXQRBCHG3cKkXaWsZNAeu
1SYAn1m+Jt85Gw9flV7Bcx8c8UBlyPij
=4lYI
-----END PGP SIGNATURE-----

--uSGWXxPxrAGEvNNgJLbRXopv68cLknnIF--
