From: Loic Dachary <loic@dachary.org>
Subject: Lowering the weight to move PGs out
Date: Sun, 28 May 2017 11:17:26 +0300
Message-ID: <51ba058a-8ecf-4b43-1ee8-e5aae04f661a@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52190 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdE1IRa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 28 May 2017 04:17:30 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

The most time consuming part of the optimization algorithm[1] comes from lowering the weight of the most over filled item. We cannot know exactly which value will push the desired number of PGs out. The values influenced by the weight are calculated during mapping[2] and derived from the parameters.

It would be useful find a way to expose all ln values (i.e. log(hash(PGid,r,item)) without the weight applied. A function behaving like map() but returning all straws from bucket_straw2_choose instead of chosing one based on the weights.

With the actual values influenced by the weights, we can calculate how much to lower the weight of a given item so that it does not win. Instead of trying small increments, we calculate the exact value.

What do you think ?

Cheers

[1] An algorithm to fix uneven CRUSH distributions in Ceph http://dachary.org/?p=4055
[2] https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L323
-- 
Loïc Dachary, Artisan Logiciel Libre
