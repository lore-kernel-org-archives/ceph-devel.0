From: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?=
        <bartlomiej.swiecki@corp.ovh.com>
Subject: Question about recovery vs backfill priorities
Date: Thu, 1 Dec 2016 11:21:35 +0100
Message-ID: <3b219d94-431d-0a4f-e656-826003028a9d@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 7.mo301.mail-out.ovh.net ([137.74.110.70]:44517 "EHLO
        7.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbcLAKVj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Dec 2016 05:21:39 -0500
Received: from EX4.OVH.local (gw1.corp.ovh.com [51.255.55.226])
        by mo301.mail-out.ovh.net (Postfix) with ESMTPS id 2518B1863
        for <ceph-devel@vger.kernel.org>; Thu,  1 Dec 2016 11:21:37 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,


We're currently being hit by an issue with cluster recovery. The cluster 
size has been significantly extended (~50% new OSDs) and started recovery.
During recovery there was a HW failure and we ended up with some PGS in 
peered state with size < min_size (inactive).
Those peered PGs are waiting for backfill but the cluster still prefers 
recovery of recovery_wait PGs - in our case this could be even few hours 
before all recovery is finished (we're speeding up recovery up to limits 
to get the downtime as short as possible). Those peered PGs are blocked 
during this time and the whole cluster just struggles to operate at a 
reasonable level.

We're running hammer 0.94.6 there and from the code it looks like 
recovery will always have higher priority (jewel seems similar).
Documentation only says that log-based recovery must finish before 
backfills. Is this requirement needed for data consistency or something 
else?

Ideally we'd like it to be this order: undersized inactive (size < 
min_size) recovery_wait => undersized inactive (size < min_size) 
wait_backfill => degraded recovery_wait => degraded wait_backfill => 
remapped wait_backfill.
Changing priority calculation doesn't seem to be that hard but would it 
end up with inconsistent data?

Bartek

