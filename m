From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Understanding Ceph
Date: Wed, 23 Jan 2013 18:10:52 -0600
Message-ID: <51007C0C.2030107@bmrb.wisc.edu>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig28301531FBA5F7AEC010D049"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:43739 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab3AXAKx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 19:10:53 -0500
Received: from stingray.bmrb.wisc.edu (stingray.bmrb.wisc.edu [144.92.167.179])
	by mail.bmrb.wisc.edu (Postfix) with ESMTP id B9DA82C0598
	for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 18:10:52 -0600 (CST)
In-Reply-To: <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig28301531FBA5F7AEC010D049
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/23/2013 10:19 AM, Patrick McGarry wrote:

> http://ceph.com/howto/building-a-public-ami-with-ceph-and-openstack/

> On Wed, Jan 23, 2013 at 10:13 AM, Sam Lang <sam.lang@inktank.com> wrote=
:

>> http://ceph.com/docs/master/rbd/rbd-openstack/

These are both great, I'm sure, but Patrick's page says "I chose to
follow the 5 minute quickstart guide" and the rbd-openstack page says
"Important ... you must have a running Ceph cluster."

My problem is I can;t find a "5 minute quickstart guide" for RHEL 6. and
I didn't get a "running ceph cluster" by trying to follow the existing
(ubuntu) guide and adjust for centos 6.3.

So I'm stuck at a point way before those guides become relevant: once I
had one OSD/MDS/MON box up, I got "HEALTH_WARN 384 pgs degraded; 384 pgs
stuck unclean; recovery 21/42 degraded (50.000%)" (384 appears be the
number of placement groups created by default).

What does that mean? That I only have one OSD? Or is it genuinely unhealt=
hy?

--=20
Dimitri Maziuk
Programmer/sysadmin
BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu


--------------enig28301531FBA5F7AEC010D049
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFRAHwMxzG8ttqkbbgRAkPTAKCz4sBaf0CSUC1I7Tx6yRl1dGd80ACeMTbX
QXyjsZ4/ww/sKRrw6PjPUpc=
=1uco
-----END PGP SIGNATURE-----

--------------enig28301531FBA5F7AEC010D049--
