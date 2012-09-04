From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: ceph-fs tests
Date: Wed, 05 Sep 2012 01:26:06 +0200
Message-ID: <50468E0E.6070807@smart-weblications.de>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.smart-weblications.de ([188.65.144.39]:55218 "EHLO
	mx04.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751154Ab2IDX0U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 19:26:20 -0400
Received: from office.smart-weblications.net (office.smart-weblications.net [91.204.168.193])
	by mx04.smart-weblications.de (Postfix) with ESMTPA id DB49C2786258
	for <ceph-devel@vger.kernel.org>; Tue,  4 Sep 2012 23:26:18 +0000 (UTC)
Received: from [192.168.201.110] (unknown [192.168.201.110])
	by office.smart-weblications.net (Postfix) with ESMTPA id 407C211404D3
	for <ceph-devel@vger.kernel.org>; Wed,  5 Sep 2012 01:26:18 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi,


i set up a 3 node ceph cluster 0.48.1argonaut to test ceph-fs.

i mount ceph via fuse, then i downloaded kernel tree and decompressed a=
 few
times, then stopping one osd (osd.1), afer a while of recovering, sudde=
nly:

tar: linux-3.5.3/drivers/media/video/zoran/zr36060.h: Kann write nicht
ausf=C3=83=C2=BChren: Auf dem Ger=C3=83=C2=A4t ist kein Speicherplatz m=
ehr verf=C3=83=C2=BCgbar
linux-3.5.3/drivers/media/video/zr364xx.c
tar: linux-3.5.3/drivers/media/video/zr364xx.c: Kann write nicht ausf=C3=
=83=C2=BChren: Auf
dem Ger=C3=83=C2=A4t ist kein Speicherplatz mehr verf=C3=83=C2=BCgbar
linux-3.5.3/drivers/memory/

no space left on device, but:

2012-09-04 18:46:38.242840 mon.0 [INF] pgmap v2883: 576 pgs: 512 active=
+clean,
64 active+recovering; 1250 MB data, 14391 MB used, 844 MB / 15236 MB av=
ail;
36677/215076 degraded (17.053%)

there is space left?
--=20

Mit freundlichen Gr=C3=BC=C3=9Fen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=C3=A4ftsf=C3=BChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
