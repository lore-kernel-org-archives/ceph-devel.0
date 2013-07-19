From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: optimal values for osd threads
Date: Fri, 19 Jul 2013 15:16:03 +0200
Message-ID: <CAMNMNTzV0+21yn+RjfYRPS3OG9=NoYT8xBPRRBuAY5LXaSTV_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:61622 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760461Ab3GSNQE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jul 2013 09:16:04 -0400
Received: by mail-qa0-f52.google.com with SMTP id hv16so294744qab.18
        for <ceph-devel@vger.kernel.org>; Fri, 19 Jul 2013 06:16:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
My config:
        osd op threads = 8
        osd disk threads = 4
        osd recovery threads = 1
        osd recovery max active = 1
        osd recovery op priority = 10
        osd client op priority = 100
        osd max backfills = 1

I set it to maximize client operation priority and slow backfill
operations ( client first !! :-) )
Once the osd holding the rgw index died, after the restart the cluster
got stuck on "25 active+recovery_wait, 1 active+recovering;"

Please help me choose optimal values for osd recovery threads and
priorty on ceph s3 optimized cluster.

Cluster:
   12 server x 12 osd
   3 mons, 144 osds, 32424 pgs

--
Regards
Dominik
