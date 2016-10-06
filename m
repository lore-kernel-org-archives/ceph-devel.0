From: Karol Mroz <kmroz@suse.de>
Subject: Jewel + nfs-ganesha v2.4
Date: Thu, 6 Oct 2016 12:37:45 -0700
Message-ID: <20161006193745.roibu5nbaqcge475@birch.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i2ypdyhqqdvypgpx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934676AbcJFTiB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Oct 2016 15:38:01 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DCB9EADD9
        for <ceph-devel@vger.kernel.org>; Thu,  6 Oct 2016 19:37:59 +0000 (UTC)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--i2ypdyhqqdvypgpx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Folks,

Building nfs-ganesha v2.4 against Ceph 10.2.3 (effectively upstream/jewel),=
 it
would appear that the RGW FSAL does not build due to missing:

+#define LIBRGW_FILE_VER_MAJOR 1
+#define LIBRGW_FILE_VER_MINOR 1
+#define LIBRGW_FILE_VER_EXTRA 0

in /usr/include/rados/{librgw.h, rgw_file.h}.

These were added via:

commit 355ccc5ded7f0b459bca24bc8b504b41807c583d
    librgw: add API version defines for librgw and rgw_file

Any plans to backport this to the jewel release branch?

--=20
Regards,
Karol

--i2ypdyhqqdvypgpx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJX9qgDAAoJECp28bThgzatm0cH/RmSiRPIVW5LR9Ww4OlTFEne
eaNdFggP3xAvMEQggyP6dWtsqfFxmyXHE1VZHeE07/M/br2NlXEPi7UiYeDIO4hb
e2v7sboG6LlNLL+/c+CxwsejMd8jP/TuprdoCFJvnFaJ0CR+dVk7NnL96WCF7zAD
fodsX8zCEGBktw+cLSSjdo6Alnfx4l2OruqjNHqCiVId4gIrdVQq9wt8FL44pAR/
KTvPWfvnLhMKh2/Rllpw0GhwCYQn/WoCSMySeNq79Z10RW4Z5cWO7gl1F1OH9ecV
YTDEjtu3pTjTrf7Kc4M0lKXhY6K9I+bOV6ntZj8qT8DPxqzgYRmxoFTtSfWVIgk=
=g/aj
-----END PGP SIGNATURE-----

--i2ypdyhqqdvypgpx--
