From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Issue with upgrade from 0.94.9 to 10.2.5
Date: Tue, 17 Jan 2017 12:52:34 +0100
Message-ID: <9fd022a0-d09e-b3ff-ce5c-f55d5b2d1167@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 10.mo302.mail-out.ovh.net ([137.74.110.83]:47043 "EHLO
        10.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdAQLwk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jan 2017 06:52:40 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hello,

During our testing we found out that during upgrade from 0.94.9 to 10.2.5 
we're hitting issue http://tracker.ceph.com/issues/17386 ("Upgrading 0.94.6 
-> 0.94.9 saturating mon node networking"). Apparently, there's a few 
commits for both hammer and jewel which are supposed to fix this issue for 
upgrades from 0.94.6 to 0.94.9 (and possibly for others), but we're still 
seeing this upgrading to Jewel, and symptoms are exactly same - after 
upgrading MONs, each not yet upgraded OSD takes full OSDMap from monitors 
after failing the CRC check. Anyone else encountered this?

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
