From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: 32bit ceph-osd on 64bit kernel
Date: Sat, 21 Jul 2012 03:43:08 +0200
Message-ID: <500A092C.5050506@smart-weblications.de>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.smart-weblications.de ([188.65.144.37]:46391 "EHLO
	mx02.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753043Ab2GUBne (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 Jul 2012 21:43:34 -0400
Received: from office.smart-weblications.net (office.smart-weblications.net [91.204.168.193])
	by mx02.smart-weblications.de (Postfix) with ESMTPA id 72B45C6E6A3
	for <ceph-devel@vger.kernel.org>; Sat, 21 Jul 2012 01:43:32 +0000 (UTC)
Received: from [192.168.201.110] (unknown [192.168.201.110])
	by office.smart-weblications.net (Postfix) with ESMTPA id D86E69991DB
	for <ceph-devel@vger.kernel.org>; Sat, 21 Jul 2012 03:43:31 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,

when running a 32bit ceph-osd binary on 64bit kernel i get:

[  601.181640] ioctl32(ceph-osd:3399): Unknown cmd fd(20)
cmd(00009408){t:ffffff94;sz:0} arg(0000000f) on /data/ceph_backend/osd
[  612.156104] ioctl32(ceph-osd:3399): Unknown cmd fd(20)
cmd(00009408){t:ffffff94;sz:0} arg(0000000f) on /data/ceph_backend/osd
[  617.478025] ioctl32(ceph-osd:3399): Unknown cmd fd(20)
cmd(00009408){t:ffffff94;sz:0} arg(0000000f) on /data/ceph_backend/osd


is this normal or do i have to worry about something?



--=20

Mit freundlichen Gr=FC=DFen,

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
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
