From: Alfredo Deza <adeza@redhat.com>
Subject: slowness in builds this week
Date: Thu, 25 May 2017 18:15:56 -0400
Message-ID: <CAC-Np1x_oa2r4d9KOztcWYnSG8LyN8NPN=9hqyd=8SqhjyQRjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38633 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762847AbdEYWQD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 May 2017 18:16:03 -0400
Received: by mail-wm0-f49.google.com with SMTP id e127so124080302wmg.1
        for <ceph-devel@vger.kernel.org>; Thu, 25 May 2017 15:15:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sepia@lists.ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

If you have experienced slow builds this week it was because we caused
a misconfiguration to get Ubuntu 14.04 nodes provisioned to build when
we really need 16.04.

The disparity was caused because the system that provisions was edited
by hand when we had the Jenkins issue after an upgrade a few weeks
ago. Ubuntu 14.04 cannot join Jenkins because they have a dated Java
version that is no longer supported.

By deploying from version control (as we try to do always) we
overwrote the manual fix.

This has now been fixed in source control and the queue is looking
good. The system is elastic when coping with load, so this issue
quickly improved once we re-deployed.

tl;dr: we overwrote some configuration which made nodes unable to join
jenkins to do builds, hence, slower build times

Sorry for all/any troubles, this was hard to catch.


-Alfredo
