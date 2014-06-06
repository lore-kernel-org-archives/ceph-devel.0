From: Kevin Cox <kevincox@kevincox.ca>
Subject: Wireshark Dissector Preview
Date: Fri, 06 Jun 2014 15:51:58 -0400
Message-ID: <53921BDE.5050006@kevincox.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vHHgpwJ8q23EhBsuXLkwi7rBJbHKEQhqw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:50280 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbaFFTwF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jun 2014 15:52:05 -0400
Received: by mail-ie0-f170.google.com with SMTP id to1so3005493ieb.29
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jun 2014 12:52:04 -0700 (PDT)
Received: from [192.168.1.9] (CPE0014bf9e1938-CM001692fa0ada.cpe.net.cable.rogers.com. [99.235.186.224])
        by mx.google.com with ESMTPSA id vm1sm63343485igc.3.2014.06.06.12.52.02
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 12:52:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vHHgpwJ8q23EhBsuXLkwi7rBJbHKEQhqw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I am pleased to announce an alpha version of the Ceph Wireshark
Dissector.  As some you you may know I am working on this dissector as a
GSOC project this summer.  I have gotten some initial work completed and
wanted to share in case someone finds it useful.

So far the dissector can parse the protocol and display the messages,
however there are currently very few messages that are dissected
themselves.  This means that you can see who is sending what messages
but the contents of those messages will just be binary data.

I imagine that this basic level of dissection will still be useful to
some people, especially those working on the network protocol as they
can see exactly what is being sent, and sysadmins who can gain useful
information from just the message types.

You can find the current code on my github account[0] in the "ceph"
branch.  You can also download a tarball[1] if you prefer.  The code
should build using CMake although you may need to add the
-DDISABLE_WERROR=3D1 flag.

[0] https://github.com/kevincox/wireshark/tree/ceph
[1] https://github.com/kevincox/wireshark/archive/ceph.tar.gz

Any feedback would be appreciated, especially things that are not being
dissected properly or that can be improved.

Also, I am looking for captures of ceph network traffic.  If you could
provide captures it would allow be to focus on the messages that are
being used the most and implement those first.  Please be careful
however, and ensure there is no sensitive information in your capture.
Captures can be uploaded here[2] or mailed to me directly.

[2] https://seafile.kevincox.ca/u/d/2dd934002d/

Cheers,
Kevin


--vHHgpwJ8q23EhBsuXLkwi7rBJbHKEQhqw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iF4EAREIAAYFAlOSG+EACgkQwHWKOzTVLnSjYAD/YKbumQ79TLU3Rrtiz6JAduF3
n+U1YBNwqkPSGOs4TwUA/Rg7jv+AS9BGixMyVrLQOjXTGnhaBtvF9vh2T5fYV6jy
=srEI
-----END PGP SIGNATURE-----

--vHHgpwJ8q23EhBsuXLkwi7rBJbHKEQhqw--
