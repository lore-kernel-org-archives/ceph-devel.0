From: Jonathan Dieter <jdieter@lesbg.com>
Subject: Re: Compilation issues on Fedora 13 and Fedora 15
Date: Sun, 25 Mar 2012 20:45:09 +0300
Message-ID: <1332697509.2102.9.camel@jdlaptop.lesbg.loc>
References: <1332665829.7312.8.camel@indica.cc.iitb.ac.in>
	 <1332689005.2102.3.camel@jdlaptop.lesbg.loc>
	 <Pine.LNX.4.64.1203250834500.23214@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-QFXBaHzehKzxsln/N7VV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47487 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639Ab2CYRpN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Mar 2012 13:45:13 -0400
Received: by wgbdr13 with SMTP id dr13so3256169wgb.1
        for <ceph-devel@vger.kernel.org>; Sun, 25 Mar 2012 10:45:12 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1203250834500.23214@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--=-QFXBaHzehKzxsln/N7VV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2012-03-25 at 08:40 -0700, Sage Weil wrote:
> Hi Jonathan,
>=20
> On Sun, 25 Mar 2012, Jonathan Dieter wrote:
> > On Sun, 2012-03-25 at 14:27 +0530, Ajit K Jena wrote:
> > > Hello All,
> > >=20
> > > I have lost touch with the growth of ceph after version 0.30.
> > > I am trying to compile version 0.43 and 0.44 on FC13 and FC15.
> >=20
> > FWIW, we've pushed 0.43 in Fedora 17. We don't have anything later than
> > 0.41 in versions lower than 17 because of Fedora's updates policies. =
=20
> >=20
> > However, you could take the source rpm from F17 and rebuild it for olde=
r
> > versions of Fedora.
> >=20
> > It's available at
> > http://kojipkgs.fedoraproject.org/packages/ceph/0.43/1.fc17/src/ceph-0.=
43-1.fc17.src.rpm
> >=20
> > I'll probably push 0.44 to F17 once I manage to get the RPM built.
>=20
> I just pushed two patches to the stable branch that should address this:=
=20
> d3bcac241f25f681a585c2115a79befe43dd7d6c and=20
> 3ab28950beabe9d452da35ec2f2d583751764a9a.  Can you verify the problem goe=
s=20
> away?

Ok, with the two patches, ceph builds, but leveldb doesn't seem to be
using our compiler flags.

The build is at:
http://koji.fedoraproject.org/koji/taskinfo?taskID=3D3930921

And the x86_64 build log is at:
http://koji.fedoraproject.org/koji/getfile?taskID=3D3930922&name=3Dbuild.lo=
g

If you scroll down to where leveldb builds and then to where ceph starts
building after that, you'll see the difference in the build flags.

Jonathan

--=-QFXBaHzehKzxsln/N7VV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAk9vWaUACgkQH3CnpFdSY1wfIQCgv+tzDeU+aHaRulGJMO9G6++o
21sAmwRuOkW72p4Mj3EVy9J1+1uEs8OS
=2xHl
-----END PGP SIGNATURE-----

--=-QFXBaHzehKzxsln/N7VV--

