From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 13:52:15 -0600
Message-ID: <510190EF.60306@bmrb.wisc.edu>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <CAJH6TXhwBY+gTDDksCfMroDodeN1b8ttM7zjNc2tn5PXzYbcZg@mail.gmail.com> <51013D5F.7090105@bmrb.wisc.edu> <CAKMAVE9HMo4x3seuG7ppeafSRJmBwjUXrLv0GUA-z5kDXyhoQA@mail.gmail.com> <51015318.8000404@bmrb.wisc.edu> <CAM2gkg6
 m2S0DtgapSOg16GTmGQHsj7fz=a3XzH0ZsvcCWHcBtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB23A71B7883D63B1B64E3323"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:46709 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209Ab3AXTwQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 14:52:16 -0500
In-Reply-To: <CAM2gkg6m2S0DtgapSOg16GTmGQHsj7fz=a3XzH0ZsvcCWHcBtg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Wilkins <john.wilkins@inktank.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB23A71B7883D63B1B64E3323
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/24/2013 12:38 PM, John Wilkins wrote:
> Dima,
>=20
> I'm working on a new monitoring and troubleshooting guide now that will=

> answer most of the questions related to OSD and placement group states.=
 I
> hope to have it done this week. I have not actually tested the quick st=
arts
> on centos or rhel distributions, but it's on our radar. The intention o=
f
> the quick starts is to get you up and running quickly. It doesn't cover=

> deeper issues like how to monitor and troubleshoot. I'm working on addi=
ng a
> lot more substantive content there now.

A couple of things in the quick start:

- there should be no space between "rw," and "noatime" in
osd mount options {fs-type} =3D {mount options} # default mount option is=

"rw, noatime"

- for ext4, you need to specify "user_xattr" there or mkcephfs will fail
(with --mkfs at least).

--=20
Dimitri Maziuk
Programmer/sysadmin
BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu


--------------enigB23A71B7883D63B1B64E3323
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFRAZDvxzG8ttqkbbgRAjQ7AKCEodvxZd1WD6xS+Rg0KoIec6lRhgCggxS1
b7qmj7Pp+YoA+G5PnLcje+o=
=/410
-----END PGP SIGNATURE-----

--------------enigB23A71B7883D63B1B64E3323--
