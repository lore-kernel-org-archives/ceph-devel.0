From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 12:58:28 -0600
Message-ID: <51018454.1050101@bmrb.wisc.edu>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <CAJH6TXhwBY+gTDDksCfMroDodeN1b8ttM7zjNc2tn5PXzYbcZg@mail.gmail.com> <51013D5F.7090105@bmrb.wisc.edu> <CAKMAVE9HMo4x3seuG7ppeafSRJmBwjUXrLv0GUA-z5kDXyhoQA@mail.gmail.com> <51015318.8000404@bmrb.wisc.edu> <51017A4D
 .2000901@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC1AD778405DEE2F17115E7EC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:46519 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab3AXS6w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 13:58:52 -0500
Received: from stingray.bmrb.wisc.edu (stingray.bmrb.wisc.edu [144.92.167.179])
	by mail.bmrb.wisc.edu (Postfix) with ESMTP id B65352C0361
	for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 12:58:51 -0600 (CST)
In-Reply-To: <51017A4D.2000901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC1AD778405DEE2F17115E7EC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/24/2013 12:15 PM, Dan Mick wrote:
> On 01/24/2013 07:28 AM, Dimitri Maziuk wrote:
>> On 1/24/2013 8:20 AM, Sam Lang wrote:
>>
>>> Yep it means that you only have one OSD with replication level of 2.
>>> If you had a rep level of 3, you would see degraded (66.667%). If you=

>>> just want to make the message go away (for testing purposes), you can=

>>> set the rep level to 1
>>> (http://ceph.com/w/index.php?title=3DAdjusting_replication_level&redi=
rect=3Dno).
>>>
>>
>> OK, thanks Sam and Dino -- I kinda suspected that but didn't find any
>> docs.
>>
>> This looks like it's not adjustable via ceph.conf, I can only do it at=

>> runtime, correct?
>=20
> or you could just add another OSD.

Obviously. You'd think that only one [osd] section in ceph.conf implies
nrep =3D 1, though. (And then you can go on adding OSDs and changing nrep=

accordingly -- that was my plan.)

--=20
Dimitri Maziuk
Programmer/sysadmin
BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu


--------------enigC1AD778405DEE2F17115E7EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFRAYRrxzG8ttqkbbgRAl6sAKC3x4d5SkQkkbMCKAv3Pn+dAJRY3ACgjaHP
T8rQdLCLjt7geKFWlGhXaXQ=
=rewF
-----END PGP SIGNATURE-----

--------------enigC1AD778405DEE2F17115E7EC--
