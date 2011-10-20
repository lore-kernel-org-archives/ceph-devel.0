From: Amon Ott <a.ott@m-privacy.de>
Subject: Inode numbers on 32 Bit Linux
Date: Thu, 20 Oct 2011 08:28:26 +0200
Message-ID: <201110200828.26887.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:53240 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131Ab1JTGeX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Oct 2011 02:34:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id 796A285F03
	for <ceph-devel@vger.kernel.org>; Thu, 20 Oct 2011 08:28:36 +0200 (CEST)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 27834-02 for <ceph-devel@vger.kernel.org>;
 Thu, 20 Oct 2011 08:28:29 +0200 (CEST)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id 95A3D85F02
	for <ceph-devel@vger.kernel.org>; Thu, 20 Oct 2011 08:28:29 +0200 (CEST)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id EFA99269C5
	for <ceph-devel@vger.kernel.org>; Thu, 20 Oct 2011 08:28:28 +0200 (CEST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

we need to run 32 Bit Linux kernels, but file identification of our RSB=
AC=20
access control system relies on unique inode numbers. Plain Ceph uses i=
node=20
number 1 for all filesystem objects, leading to id problems. To check=20
yourself, make a "find" and see that it complains about file system loo=
ps=20
because of this. ls -i shows number 1 for all items.

I changed the inode number generation as follows to get unique numbers =
and now=20
everything works fine without collisions.

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 35dc965..bb73b49 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -344,9 +344,10 @@ static inline struct ceph_vino ceph_vino(struct in=
ode=20
*inode)
  * x86_64+ino32  64                     32
  * x86_64        64                     64
  */
-static inline u32 ceph_ino_to_ino32(ino_t ino)
+static inline u32 ceph_ino_to_ino32(__u64 vino)
 {
-       ino ^=3D ino >> (sizeof(ino) * 8 - 32);
+       u32 ino =3D vino & 0xffffffff;
+       ino ^=3D vino >> 32;
        if (!ino)
                ino =3D 1;
        return ino;
@@ -359,9 +360,10 @@ static inline ino_t ceph_vino_to_ino(struct ceph_v=
ino=20
vino)
 {
        ino_t ino =3D (ino_t)vino.ino;  /* ^ (vino.snap << 20); */
 #if BITS_PER_LONG =3D=3D 32
-       ino =3D ceph_ino_to_ino32(ino);
+       return ceph_ino_to_ino32(vino.ino);
+#else
+       return (ino_t)vino.ino;
 #endif
-       return ino;
 }



Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
