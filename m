From: Loic Dachary <loic@dachary.org>
Subject: rbd and the next jewel release v10.2.4
Date: Thu, 27 Oct 2016 11:35:13 +0200
Message-ID: <5811CA51.1090408@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:46773 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965106AbcJ0OCK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 10:02:10 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id E99CF47EAB5
        for <ceph-devel@vger.kernel.org>; Thu, 27 Oct 2016 11:35:18 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

Hi Jason,

The next jewel release as found at https://github.com/ceph/ceph/tree/jewel is still missing https://github.com/ceph/ceph/pull/11634 but I'm hopeful it will test positively at http://pulpito.ceph.com/loic-2016-10-27_09:17:10-rbd-wip-pr-11634---basic-smithi/. Assuming this last PR is merged, do you think the jewel branch is ready for QE to start their own round of testing ?

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre

