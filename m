From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 16:15:29 -0600
Message-ID: <5101B281.6050206@bmrb.wisc.edu>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <CAJH6TXhwBY+gTDDksCfMroDodeN1b8ttM7zjNc2tn5PXzYbcZg@mail.gmail.com> <51013D5F.7090105@bmrb.wisc.edu> <CAKMAVE9HMo4x3seuG7ppeafSRJmBwjUXrLv0GUA-z5kDXyhoQA@mail.gmail.com> <51015318.8000404@bmrb.wisc.edu> <CAM2gkg6
 m2S0DtgapSOg16GTmGQHsj7fz=a3XzH0ZsvcCWHcBtg@mail.gmail.com> <510190EF.60306@bmrb.wisc.edu> <CAM2gkg6pN2546gBS8J0J=RUtL6RONzBunkF1ovPoRtP_MynzjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9937DBDC69663DD3770F07A5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:47168 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab3AXWPa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 17:15:30 -0500
In-Reply-To: <CAM2gkg6pN2546gBS8J0J=RUtL6RONzBunkF1ovPoRtP_MynzjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Wilkins <john.wilkins@inktank.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9937DBDC69663DD3770F07A5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

John,

in block device quick start (http://ceph.com/docs/master/start/quick-rbd/=
)

"sudo rbd map foo --pool rbd --name client.admin"

maps the image to /dev/rbd0 here (centos 6.3/bobtail) so the subsequent

"4. Use the block device. In the following example, create a file system.=


sudo mkfs.ext4 -m0 /dev/rbd/rbd/foo"

should end with "/dev/rbd0" instead of "/dev/rbd/rbd/foo".

--=20
Dimitri Maziuk
Programmer/sysadmin
BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu


--------------enig9937DBDC69663DD3770F07A5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFRAbKBxzG8ttqkbbgRAugdAJ9l13yznxfipQrYPsg1YpJ3AtYUyACfc70y
RaDH0KgLr7H+xtFyvKGrVCw=
=JcPK
-----END PGP SIGNATURE-----

--------------enig9937DBDC69663DD3770F07A5--
