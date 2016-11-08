From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: auto stop of scrubbing and deep scrubbing while backfilling or
 recovering
Date: Tue, 8 Nov 2016 09:35:16 +0100
Message-ID: <bcfd3f34-dcd2-9d6d-52ef-1d39e9f54593@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:19915 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932243AbcKHIfU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 03:35:20 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

i'm wondering if anybody has already thought about automatically
stopping srub and deep-scrub in case of backfilling or recovering. I've
seen several situations where scrubbing massivly raises the latency
while doing backfilling or recovering.

Greets,
Stefan
