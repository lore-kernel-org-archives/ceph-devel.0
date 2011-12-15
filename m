From: Stratos Psomadakis <psomas@grnet.gr>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 15 Dec 2011 17:32:25 +0200
Message-ID: <4EEA1309.9030602@grnet.gr>
References: <1404301.on6okQVZ04@pc10>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAA38D013F3277E8379BCA829"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:39821 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751570Ab1LOPci (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Dec 2011 10:32:38 -0500
In-Reply-To: <1404301.on6okQVZ04@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAA38D013F3277E8379BCA829
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/15/2011 05:07 PM, Guido Winkelmann wrote:
> Hi,
>
> I've got a small ceph cluster with one mon, one mds and two osds (all o=
n the=20
> same machine, for now), that I want to use as a block- and file storage=
 backend=20
> for qemu machine virtualisation.
>
> I found that read access to some of the rbd images, or parts of some of=
 them=20
> sometimes blocks indefinitely, usually after the image has been sitting=
 around=20
> untouched for a while, for example over night. This has the effect that=
 virtual=20
> machines that try to access their disks as well as rbd commands like "r=
bd cp"=20
> will just hang indefinitely.
>
>  I found that these blocks can usually be "fixed" by restarting one of =
the=20
> osds.
>
> The last time this happened, ceph -s reported one of the osds to be in =
state=20
> "active+clean+scrubbing". (I'm afraid I don't have the complete output =
from=20
> ceph -s anymore.)
>
> Does anybody have any idea what could be going wrong here?
I think it's fixed in v0.39

> 	Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
Stratos Psomadakis
<psomas@grnet.gr>



--------------enigAA38D013F3277E8379BCA829
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7qEw8ACgkQid1lVeNDMmDctgCfa19ducY71oB2ont6IB8vaYUP
aVcAoK/yEkT2fAVJJP9i1NmosInwaPC8
=fDTK
-----END PGP SIGNATURE-----

--------------enigAA38D013F3277E8379BCA829--
