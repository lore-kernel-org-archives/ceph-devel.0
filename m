From: Amon Ott <a.ott@m-privacy.de>
Subject: Stable/Master debian/rules not stripping all packages
Date: Tue, 3 Jul 2012 13:58:20 +0200
Message-ID: <201207031358.20801.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:51029 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632Ab2GCL6a convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 07:58:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id 4290E63BBE
	for <ceph-devel@vger.kernel.org>; Tue,  3 Jul 2012 13:58:25 +0200 (CEST)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 04561-08 for <ceph-devel@vger.kernel.org>;
 Tue,  3 Jul 2012 13:58:18 +0200 (CEST)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id 56CA863BBD
	for <ceph-devel@vger.kernel.org>; Tue,  3 Jul 2012 13:58:18 +0200 (CEST)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id B75CB220CA
	for <ceph-devel@vger.kernel.org>; Tue,  3 Jul 2012 13:58:21 +0200 (CEST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

just found out that some Debian binary packages do not get stripped - a=
 53MB=20
ceph-mds does look a bit weird.

Identified packages ceph-mds and gceph and added these lines:
        dh_strip -pceph-mds --dbg-package=3Dceph-mds-dbg
        dh_strip -pgceph --dbg-package=3Dgceph-dbg

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
