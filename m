From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: No/wrong revdns for redmine tracker SMTP
Date: Thu, 2 Feb 2017 11:51:52 +0100
Message-ID: <cd43ea70-2b4f-e043-d6e2-6e9d0a86865b@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 5.mo301.mail-out.ovh.net ([137.74.110.68]:39712 "EHLO
        5.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdBBKvz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2017 05:51:55 -0500
Received: from EX4.OVH.local (gw1.corp.ovh.com [51.255.55.226])
        by mo301.mail-out.ovh.net (Postfix) with ESMTPS id 8610EC090
        for <ceph-devel@vger.kernel.org>; Thu,  2 Feb 2017 11:51:53 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

We're not receiving emails from Ceph's Redmine, because SMTP server that 
sends them doesn't have proper revdns. Excerpt from our mail server log:

[******] NOQUEUE: reject: RCPT from unknown[158.69.68.89]: 450 4.7.1 Client 
host rejected: cannot find your reverse hostname, [158.69.68.89]; 
from=<redmine@tracker.ceph.com> to=<piotr.dalek@corp.ovh.com> proto=ESMTP 
helo=<tracker.localdomain>

Also, domain sepecified in "helo" is incorrect.
Who should I notifty of this? It's not the first time I'm seeing this.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
