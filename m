From: Loic Dachary <loic@dachary.org>
Subject: CephFS and the next jewel release v10.2.3
Date: Tue, 23 Aug 2016 10:59:53 +0200
Message-ID: <57BC1089.9080209@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:44806 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757601AbcHWJBD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2016 05:01:03 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id CBBAC47B972
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 11:00:58 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Gregory Farnum <gfarnum@redhat.com>

Hi John,

The next jewel release as found at https://github.com/ceph/ceph/tree/jewel passed the fs suite (http://tracker.ceph.com/issues/16344#note-30 except for three valgrind failures). Do you think the jewel branch is ready for QE to start their own round of testing ?

Cheers

P.S. CC'ing Greg because John is on vacation, in case a decision is to be made before he returns.

-- 
Loïc Dachary, Artisan Logiciel Libre
