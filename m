From: Loic Dachary <loic@dachary.org>
Subject: crush_reweight_uniform_bucket documentation
Date: Wed, 25 Jan 2017 00:11:55 +0100
Message-ID: <7b20a259-5918-9180-a544-be43ec937609@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38906 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdAXXL7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jan 2017 18:11:59 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

While documenting crush_reweight_bucket[1] I came accross something that I don't understand when reweighting uniform buckets[2]. The associated commit[3] is six years old but maybe your remember why the item_weight had to be adjusted with the average of the weight of the buckets... but only if there are more buckets than leaves ?

Cheers

[1] http://libcrush.org/main/libcrush/blob/wip-2-doxygen/crush/builder.h#L111
[2] http://libcrush.org/main/libcrush/blob/wip-2-doxygen/crush/builder.c#L1282
[3] http://libcrush.org/main/libcrush/commit/60f627f88c6314c5a89bb7119ead907ca8b8ef37

-- 
Loïc Dachary, Artisan Logiciel Libre
