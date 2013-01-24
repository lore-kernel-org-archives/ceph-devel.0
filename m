From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Understanding Ceph
Date: Wed, 23 Jan 2013 20:36:30 -0600
Message-ID: <51009E2E.10206@bmrb.wisc.edu>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <96316186-B7ED-46F9-A01D-C88165C40530@jnielsen.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig359702C216B26FEC6A3AF4F6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:44130 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab3AXCgr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 21:36:47 -0500
Received: from stingray.bmrb.wisc.edu (stingray.bmrb.wisc.edu [144.92.167.179])
	by mail.bmrb.wisc.edu (Postfix) with ESMTP id 06DF72C0375
	for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 20:36:47 -0600 (CST)
In-Reply-To: <96316186-B7ED-46F9-A01D-C88165C40530@jnielsen.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig359702C216B26FEC6A3AF4F6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/23/2013 06:17 PM, John Nielsen wrote:
=2E..
> http://ceph.com/docs/master/install/rpm/
> http://ceph.com/docs/master/start/quick-start/
>=20
> Between those two links my own quick-start on CentOS 6.3 was maybe 6 mi=
nutes. YMMV.

It does, obviously, since

"Deploy the configuration
=2E..
2. Execute the following on the Ceph server host
cd /etc/ceph
sudo mkcephfs -a -c /etc/ceph/ceph.conf -k ceph.keyring
"

was failing here until I booted an elrepo 3.7 kernel with rbd.ko.

>> HEALTH_WARN 384 pgs degraded; 384 pgs stuck unclean; recovery 21/42 de=
graded (50.000%)

>> What does that mean? That I only have one OSD? Or is it genuinely unhe=
althy?

> Assuming you have more than one host ...

I just said I have one host. So is that expected when I only have one hos=
t?

--=20
Dimitri Maziuk
Programmer/sysadmin
BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu


--------------enig359702C216B26FEC6A3AF4F6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFRAJ4+xzG8ttqkbbgRAhTxAKC3LO+V9DdMD+GjCBIvp/EaDKWHmQCfdhqH
hIdb6aStSfGf/Fjza+vODC0=
=YHFZ
-----END PGP SIGNATURE-----

--------------enig359702C216B26FEC6A3AF4F6--
