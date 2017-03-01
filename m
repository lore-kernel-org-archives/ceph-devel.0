From: Loic Dachary <loic@dachary.org>
Subject: documenting crush tunables & rule step set_*
Date: Wed, 1 Mar 2017 01:25:47 +0100
Message-ID: <5d566eae-660d-8975-453b-c8c9cac820b0@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:37883 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbdCADR7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2017 22:17:59 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 9ACC747E805
        for <ceph-devel@vger.kernel.org>; Wed,  1 Mar 2017 01:26:55 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

While reading the implementation and the commits related to crush tunables & rule step set_* I got the impression that vary_r[1] introduced early 2014 is a better solution than local_fallback_tries etc. [2] introduced around 2012. Both are helping to select an alternative item when there is a collision.

If that's not the case I'll try to research the motivation to set local_fallback_retries = 1 instead of the default value 0 it has in tunables since bobtail[3]. And although nothing forbids using local_fallback_tries = 1 & vary_r = 1, it looks like the vary_r implementation did not take into account that combination.

Cheers

[1] vary_r https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L470
[2] local_fallback_tries https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L479
[3] bobtail tunables https://github.com/ceph/ceph/blob/master/src/crush/CrushWrapper.h#L113
-- 
Loïc Dachary, Artisan Logiciel Libre
