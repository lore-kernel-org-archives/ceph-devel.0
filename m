From: Vincent Godin <vince.mlist@gmail.com>
Subject: OSD recovery priority ?
Date: Wed, 24 Jan 2018 10:54:15 +0100
Message-ID: <CAL2-6bLEx-C3H_7x+JGpJUzP=BTcL5TELi4RjVaf+q7FPms+uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:37797 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932799AbeAXJyQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jan 2018 04:54:16 -0500
Received: by mail-qt0-f172.google.com with SMTP id d54so8805446qtd.4
        for <ceph-devel@vger.kernel.org>; Wed, 24 Jan 2018 01:54:16 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I have a cluster in recovery state and i notice that few pgs are only
hold bye one OSD and a lot hold by two OSDs (pool configured with size
=3 & min=1). After few days, i'm surprised to see that the few pgs
hold only by one OSD are still there. It seems there is no high
priority for pg in critical state (1 on 3) compare to those in warn
state (2 on 3). Am i wrong or could it be a near feature ?
My Cluster is in Jewel 10.2.6
