From: Amon Ott <a.ott@m-privacy.de>
Subject: ceph-deploy with monitor port number?
Date: Wed, 08 Apr 2015 12:06:08 +0200
Message-ID: <5524FD90.6000203@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.155.129]:33154 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbbDHKGR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 8 Apr 2015 06:06:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id 2B80E2400E0
	for <ceph-devel@vger.kernel.org>; Wed,  8 Apr 2015 12:06:16 +0200 (CEST)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (maiad, port 10024) with ESMTP
 id 16270-03 for <ceph-devel@vger.kernel.org>;
 Wed,  8 Apr 2015 12:06:09 +0200 (CEST)
Received: from gw.compuniverse.de (f052212217.adsl.alicedsl.de [78.52.212.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id 2D4CB2400E1
	for <ceph-devel@vger.kernel.org>; Wed,  8 Apr 2015 12:06:09 +0200 (CEST)
Received: from [192.168.201.30] (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by gw.compuniverse.de (Postfix) with ESMTPS id BD9B78251C
	for <ceph-devel@vger.kernel.org>; Wed,  8 Apr 2015 12:06:08 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello all,

AFAICS, ceph-deploy does not yet support specifying the monitor port
number for the "new" command. It would be great if "new" could take
another parameter like

ceph-deploy --cluster mycluster --monport 6790 node1 node2 node3 ...

Our current workaround is to add the port number in the .conf file
"mon_host" line by hand after "new" and before "mon create-initial".
With that change, all commands work as expected.

Thanks,

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Werner-Vo=C3=9F-Damm 62       Fax: +49 30 99296856
12101 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=C3=A4ftsf=C3=BChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
