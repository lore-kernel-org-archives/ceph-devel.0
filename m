From: Amon Ott <a.ott@m-privacy.de>
Subject: Use 2 as fallback inode number on 32 Bit kernel
Date: Mon, 23 Jan 2012 15:31:18 +0100
Message-ID: <201201231531.18469.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_28WHPVFhYHmrqZn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:57075 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317Ab2AWOb2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Jan 2012 09:31:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id 8120285EFD
	for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2012 15:31:26 +0100 (CET)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 09473-08 for <ceph-devel@vger.kernel.org>;
 Mon, 23 Jan 2012 15:31:20 +0100 (CET)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id 01E4A85EFC
	for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2012 15:31:20 +0100 (CET)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id 771EB262D4
	for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2012 15:31:19 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--Boundary-00=_28WHPVFhYHmrqZn
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,

the current code in 32 Bit use 1 as fallback number, if the inode number=20
calculation returns 0. This always collides with the inode number of the ro=
ot=20
inode. The attached patch changes the fallback number to 2, which seems to =
be=20
unused on our test systems.

Amon Ott
=2D-=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

--Boundary-00=_28WHPVFhYHmrqZn
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="ceph-32bit-inode-fallback-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ceph-32bit-inode-fallback-2.patch"

commit e9b257a3b1364980f3247e110c4ded56b4fbe54a
Author: Amon Ott <ao@m-privacy.de>
Date:   Fri Jan 20 15:40:51 2012 +0100

    Use 2 instead of 1 as fallback for 32 Bit inode number.
    
    The root directory of the Ceph mount has inode number 1, so falling back
    to 1 always creates a collision. 2 is unused on my test systems and seems
    less likely to collide.
    
    Signed-off-by: Amon Ott <ao@m-privacy.de>

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 9d19790..595f026 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -351,7 +351,7 @@ static inline u32 ceph_ino_to_ino32(__u64 vino)
 	u32 ino = vino & 0xffffffff;
 	ino ^= vino >> 32;
 	if (!ino)
-		ino = 1;
+		ino = 2;
 	return ino;
 }
 

--Boundary-00=_28WHPVFhYHmrqZn--
