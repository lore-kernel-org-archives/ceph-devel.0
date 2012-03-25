From: Jonathan Dieter <jdieter@lesbg.com>
Subject: Re: Compilation issues on Fedora 13 and Fedora 15
Date: Sun, 25 Mar 2012 18:23:25 +0300
Message-ID: <1332689005.2102.3.camel@jdlaptop.lesbg.loc>
References: <1332665829.7312.8.camel@indica.cc.iitb.ac.in>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-K3+YlR1LOZU7In+Z7vq2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35919 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756330Ab2CYPXb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Mar 2012 11:23:31 -0400
Received: by wibhq7 with SMTP id hq7so3571304wib.1
        for <ceph-devel@vger.kernel.org>; Sun, 25 Mar 2012 08:23:30 -0700 (PDT)
In-Reply-To: <1332665829.7312.8.camel@indica.cc.iitb.ac.in>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--=-K3+YlR1LOZU7In+Z7vq2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2012-03-25 at 14:27 +0530, Ajit K Jena wrote:
> Hello All,
>=20
> I have lost touch with the growth of ceph after version 0.30.
> I am trying to compile version 0.43 and 0.44 on FC13 and FC15.

FWIW, we've pushed 0.43 in Fedora 17. We don't have anything later than
0.41 in versions lower than 17 because of Fedora's updates policies. =20

However, you could take the source rpm from F17 and rebuild it for older
versions of Fedora.

It's available at
http://kojipkgs.fedoraproject.org/packages/ceph/0.43/1.fc17/src/ceph-0.43-1=
.fc17.src.rpm

I'll probably push 0.44 to F17 once I manage to get the RPM built.

Jonathan

--=-K3+YlR1LOZU7In+Z7vq2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAk9vOG0ACgkQH3CnpFdSY1xGtwCdG4aGjG5LJCxkdHCAsvQiyfKt
hN0AoNQCHc2Nxgm0SGAIoEFXH+cyT+Vt
=7PrW
-----END PGP SIGNATURE-----

--=-K3+YlR1LOZU7In+Z7vq2--

