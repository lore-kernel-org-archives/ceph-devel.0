From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 15:51:31 -0600
Message-ID: <5101ACE3.5030905@bmrb.wisc.edu>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <CAJH6TXhwBY+gTDDksCfMroDodeN1b8ttM7zjNc2tn5PXzYbcZg@mail.gmail.com> <51013D5F.7090105@bmrb.wisc.edu> <CAKMAVE9HMo4x3seuG7ppeafSRJmBwjUXrLv0GUA-z5kDXyhoQA@mail.gmail.com> <51015318.8000404@bmrb.wisc.edu> <51017A4D
 .2000901@inktank.com> <51018454.1050101@bmrb.wisc.edu> <5101A275.5070408@inktank.com> <5101AB96.6030708@bmrb.wisc.edu> <alpine.DEB.2.00.1301241347120.13935@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig890D434DBEA4ACCA3995AE6A"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:47085 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab3AXVvc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 16:51:32 -0500
In-Reply-To: <alpine.DEB.2.00.1301241347120.13935@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, john.wilkins@inktank.com, sam.lang@inktank.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig890D434DBEA4ACCA3995AE6A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/24/2013 03:48 PM, Sage Weil wrote:
> On Thu, 24 Jan 2013, Dimitri Maziuk wrote:

>> So I re-done it with 2 OSDs and got the expected HEALTH_OK right from
>> the start.

> There may be a related issue at work here: the default crush rules now =

> replicate across hosts instead of across osds, so single-host configs m=
ay=20
> have similar problems (depending on whether you used mkcephfs to create=
=20
> the cluster or not).

Right, that's with 2nd osd on another host, not with 2 osds on the same
host.

--=20
Dimitri Maziuk
Programmer/sysadmin
BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu


--------------enig890D434DBEA4ACCA3995AE6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFRAazjxzG8ttqkbbgRAg1OAJ4sET4sqBwLtefQlkyluOKneVV6mQCfRSZL
nSVFm6kKa6t7SKCDMgBCph4=
=jQCE
-----END PGP SIGNATURE-----

--------------enig890D434DBEA4ACCA3995AE6A--
