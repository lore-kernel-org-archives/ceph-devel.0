From: Loic Dachary <loic@dachary.org>
Subject: Beta testing crush optimization
Date: Wed, 24 May 2017 16:48:16 +0300
Message-ID: <07dda37f-b8c9-f977-c767-6c1c4bc78fd6@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48337 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935319AbdEXNsW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 09:48:22 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Stefan,

Thanks for volunteering to beta test the crush optimization on a live cluster :-)

The "crush optimize" command was published today[1] and you should be able to improve your cluster distribution with the following:

ceph report > report.json
crush optimize --no-forecast --step 64 --crushmap report.json --pool 3 --out-path optimized.crush
ceph osd setcrushmap -i optimized.crush

Note that it will only perform a first optimization step (moving around 64 PGs). You will need to repeat this command a dozen time to fully optimize the cluster. I assume that's what you will want to control the workload. If you want a minimal change at each step, you can try --step 1 but it will require more than a hundred steps.

If you're not worried about the load of the cluster, you can optimize it in one go with:

ceph report > report.json
crush optimize --crushmap report.json --pool 3 --out-path optimized.crush
ceph osd setcrushmap -i optimized.crush

Cheers

[1] http://crush.readthedocs.io/en/latest/ceph/optimize.html

-- 
Loïc Dachary, Artisan Logiciel Libre
