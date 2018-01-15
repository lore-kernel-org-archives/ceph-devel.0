From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Porting snap trim queue check to Luminous
Date: Mon, 15 Jan 2018 10:12:15 +0100
Message-ID: <6258c4a1-3fa1-3627-1e47-cde2bcb4742e@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 1.mo301.mail-out.ovh.net ([137.74.110.64]:42778 "EHLO
        1.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbeAOJMS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jan 2018 04:12:18 -0500
Received: from EX3.OVH.local (gw1.corp.ovh.com [51.255.55.226])
        by mo301.mail-out.ovh.net (Postfix) with ESMTPS id 52E5F313F6
        for <ceph-devel@vger.kernel.org>; Mon, 15 Jan 2018 10:12:16 +0100 (CET)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

With Mimic, there are a new fields added to pg_stat_t: "state" and 
"purged_snaps". My snap trim queue check 
(https://github.com/ceph/ceph/pull/19520) adds one more field 
("snaptrimq_len") and it is positioned quite unfortunately - AFTER those 
two, meaning that I can't add it without adding the other two. Knowing that 
Mimic is not out, there are three options:

1 - Backport just 
https://github.com/ceph/ceph/pull/19520/commits/dc7781cf17d11cb09067656cb25c0d710ab60d71 
that adds snap_trimq_len field to "pg query" command and leave out the rest. 
That's not entirely satisfying from my perspective, but it's still a little 
step forward.
2 - Fill "state" and "purged snaps" with dummy data in Luminous, but that 
can screw up upgrades from Luminous to Mimic.
3 - Reorder fields in master/Mimic and add snaptrimq_len before state and 
purged snaps. Probably no impact as Mimic is not out yet.

Which option is the best in that particular case?

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
