From: maxwell miller <gk.maring@gmail.com>
Subject: Questions about Tier evict
Date: Fri, 29 Dec 2017 16:50:12 +0800
Message-ID: <CAOvCcb4YPEx8u4wpuSkzraKKMK4vQf9FmiQCZQioYYgaMRYg2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f172.google.com ([209.85.213.172]:39550 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754932AbdL2IuN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Dec 2017 03:50:13 -0500
Received: by mail-yb0-f172.google.com with SMTP id f201so3784591ybg.6
        for <ceph-devel@vger.kernel.org>; Fri, 29 Dec 2017 00:50:13 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

      After reading Ceph Tier logical,  I wonder what would happen if
flush_mode = FLUSH_MODE_IDLE, evict_mode = EVICT_MODE_SOME and all the
low-temperature objects are dirty?  Would agent do an infinite evict
cycle without evicting anything?

      If so, could we trigger agent_maybe_flush in agent_maybe_evict?

      Thanks for providing the hints.

Hanjie Zhou
