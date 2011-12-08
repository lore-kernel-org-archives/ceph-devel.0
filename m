From: Amon Ott <a.ott@m-privacy.de>
Subject: Return stale file handle (-ESTALE) like NFS instead of hanging forever?
Date: Thu, 8 Dec 2011 14:55:55 +0100
Message-ID: <201112081455.56365.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:56970 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252Ab1LHN4G convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 08:56:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id 477B285F10
	for <ceph-devel@vger.kernel.org>; Thu,  8 Dec 2011 14:56:04 +0100 (CET)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 06464-07 for <ceph-devel@vger.kernel.org>;
 Thu,  8 Dec 2011 14:55:57 +0100 (CET)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id CFD4185F0F
	for <ceph-devel@vger.kernel.org>; Thu,  8 Dec 2011 14:55:57 +0100 (CET)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id 4885426D7E
	for <ceph-devel@vger.kernel.org>; Thu,  8 Dec 2011 14:55:57 +0100 (CET)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

if file access through Ceph kernel client cannot continue, e.g. because=
 there=20
is no mds available, it hangs forever.

I would prefer if after a timeout the application would get an error co=
de,=20
e.g. the -ESTALE that NFS and Gluster return if something goes wrong. T=
his=20
would allow for the application to handle the error instead of blocking=
=20
forever without a chance to recover.

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
