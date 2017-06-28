From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Luminous "upgrade"
Date: Thu, 29 Jun 2017 00:07:42 +0200
Message-ID: <ac2ebcde-f3d1-7706-86bc-8123956314a8@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:39192 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751523AbdF1WHq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 28 Jun 2017 18:07:46 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 2737743311
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jun 2017 00:07:44 +0200 (CEST)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I installed the FreeBSD package i build for v12.1.0 but now my cluster
reports:

  cluster:
    id:     6436b2a5-59a5-11e7-b746-0025903744dc
    health: HEALTH_ERR
            mds rank 0 has failed
            mds cluster is degraded
            all OSDs are running luminous or later but
require_osd_release < luminous

However `ceph osd set` only has:
	require_jewel_osds|require_kraken_osds

So I cannot set something luminous....

Or is this the wrong approach?

--WjW
