From: Dmitry Smirnov <onlyjob@debian.org>
Subject: Re: issue #8752 (inconsistent PGs on RBD caching pool)
Date: Fri, 03 Oct 2014 07:09:41 +1000
Message-ID: <4085610.Ynnm5zoT22@debstor>
References: <alpine.DEB.2.00.1409191642270.19460@cobra.newdream.net> <3415192.gCaj5vu5sy@debstor> <alpine.DEB.2.00.1410020824060.14393@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2157465.JEDHnlc3zO"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34189 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbaJBVJt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Oct 2014 17:09:49 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so3507734pab.30
        for <ceph-devel@vger.kernel.org>; Thu, 02 Oct 2014 14:09:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1410020824060.14393@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org


--nextPart2157465.JEDHnlc3zO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Thu, 2 Oct 2014 08:28:16 Sage Weil wrote:
> My guess is a btrfs issue.  The weird thing about your report is the =
byte
> totals are off by an uneven number of bytes (3 bytes, 9 bytes, etc.).=

> We haven't ever seen this.  We do test RBD over cache tiers on btrfs,=

> but not with EC on the base.  I'll add that combo to the matrix.  My =
first
> guess is a btrfs issue, honestly.

I think I found where it is happening: for a while I was using Btrfs-ba=
sed=20
OSDs with journals on ext4 partition on SSD. As an experiment I've deci=
ded to=20
try moving all journal files back to their OSDs and it eliminated=20
inconsistencies. I've updated the ticket with this information.
This behaviour is reproducible on 0.80.6.

It looks like Btrfs snapshotting do not affect this issue.


> Does it continue to come up after the kernels are upgraded (and after=
 a
> full cycle of scrub and repairs have been done to clear out
> inconsistencies introduced while running the older kernel)?

Yes, I tried many times after every kernel update or any change in clus=
ter=20
whatsoever. Repair is usually ineffective and doesn't change anything: =
it=20
would log "repair 1 errors, 1 fixed" but "ceph pg scrub" will find an e=
rror=20
right away. Moreover repair is not even necessary -- inconsistencies st=
ay on=20
some PGs for a while then "move" to different PGs. For example "ceph pg=
 scrub=20
19.NN" sometimes would be clearing affected pg from "inconsistent" stat=
e or=20
discover a new inconsistency seemingly at random.

Thank you.

=2D-=20
Cheers,
 Dmitry Smirnov.

=2D--

Odious ideas are not entitled to hide from criticism behind the human
shield of their believers' feelings.
        -- Richard Stallman

--nextPart2157465.JEDHnlc3zO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAABCAAGBQJULb8YAAoJEFK2u9lTlo0bs+kQAMapbFLVxfYXvB8sdf0pFB06
siUNS0sLjeAUalt5IJXfLdRkx3IFFWras29psIJ/3xijcjt+u5OUphsOtyWrms+O
a+FawagJ2w98INnJkZNHdygFs+gQ8lSH7ax3TUp2iR62Rdx+awjB+vkJT8XQnEp3
glqKiAvx6ePIOA9mhpln5cahpaqatqGkttEopp33wKCisZsdqxBp9ydWiHRksiZc
5VWOY0kr3opbNI1WEaI+Dp4YR/P9I8ABMWM+mb6mjjvuIvu9uMBxt1+p5CSqxRGS
X74YWWefpdHRddOuSveJTfwUFiH469rkCuRnPv6veiY+fPrmEgXZB33CGU1fE71l
SHaDG1zsG+V/CQDy7OoAxa3IbYRHtkhr7Z4p0L1kCXIn/2GJajGq7rlmi+EKRZ+a
rjX21+QYhbDslPCFILe2eTHMgKytvykire1UxMsPTl3u5aVFgsh4GjiToJGrKDDL
njy+Aw+JAn9kgg1/HkAAsUlSCzQK9k5TUd/YSLRvOqsAUHsL//cuMUe8IQ1wI/QS
eXUjVUNON1eLPwJwQXuqRh/14p6ITCOWTik7WpvE2d0DJ0w14baNbXXU5GkkSx/u
g+mPNC7exyKHuWH1Ixqgu6V33s+gb3GL1sR0TsICTzkcZbdg/agMu+PJYNb6a6l9
XHjYWc/ShQxrQcnJ8S+A
=PIeV
-----END PGP SIGNATURE-----

--nextPart2157465.JEDHnlc3zO--

