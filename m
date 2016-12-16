From: Amon Ott <a.ott@m-privacy.de>
Subject: Ceph connections with TLS
Date: Fri, 16 Dec 2016 11:15:22 +0100
Message-ID: <7a01ab71-66eb-46d2-3990-c325f8d36a16@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www1.m-privacy.de ([85.214.254.135]:48858 "EHLO
        www1.m-privacy.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbcLPKbV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2016 05:31:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by www1.m-privacy.de (Postfix) with ESMTP id 5CE7524009E
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2016 11:15:30 +0100 (CET)
Received: from www1.m-privacy.de ([127.0.0.1])
 by localhost (www1.m-privacy.de [127.0.0.1]) (maiad, port 10024) with ESMTP
 id 28489-09 for <ceph-devel@vger.kernel.org>;
 Fri, 16 Dec 2016 11:15:24 +0100 (CET)
Received: from gw.compuniverse.de (x4e33e80e.dyn.telefonica.de [78.51.232.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "gw.compuniverse.de", Issuer "gw.compuniverse.de" (not verified))
        by www1.m-privacy.de (Postfix) with ESMTPSA id 68635240098
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2016 11:15:24 +0100 (CET)
Received: from [192.168.201.30] (tgham.compuniverse.de [192.168.201.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by gw.compuniverse.de (Postfix) with ESMTPS id 76277872E2
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2016 11:15:23 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>

Hello Ceph,

for a customer we are currently designing a ceph cluster, which shall be
spread over two data centers. Data in the Ceph cluster is slightly
confidential, so we would like to encrypt at least all Ceph traffic over
the fast data center connection link.

AFAICS, Ceph does not support data encryption at connection level yet,
so we would have to setup VPN links between the two cluster networks.
This means extra configuration, maintenance and overhead.

How far away is TLS support or something similar for the Ceph
connections? AFAIK, TLS support should not be hard to implement, but I
am not too familiar with Ceph internals.

Thoughts?

Amon Ott
-- 
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Werner-Voß-Damm 62       Fax: +49 30 99296856
12101 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Geschäftsführer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

