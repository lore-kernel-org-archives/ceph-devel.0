From: Loic Dachary <loic@dachary.org>
Subject: Calculating the expected PGs distribution
Date: Mon, 8 May 2017 11:49:09 +0200
Message-ID: <4538c9b9-18a2-11b9-e5f1-00a0243c1d88@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40639 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753964AbdEHJtN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 May 2017 05:49:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xavier Villaneau <xvillaneau@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Xavier,

When trying to optimize the distribution for a bucket, the expected PGs for a given OSD is calculated as follows:

(OSD weight)/(sum of all OSD weights) * number of PGs

So, for instance with a one replica pool of 100 PGs and OSDs with weights:

5 1 1 1 1

we expect them to get 56 11 11 11 11 PGs respectively. And (this is where it gets interesting ;-) with a two replica pool of 100 PGs we expect 112 22 22 22 22. Only that cannot happen because the second replica needs to be on a different OSD than the first. The OSD with weight 5 can't get 56 PGs for the second replica, it can only get 44 PGs otherwise it would violate the constraint. The expected number of PGs needs to be calculated differently to account for this case.

I can't figure out the formula myself, my maths are not good enough. Could you please guide me in the right direction ?

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
