From: maxwell miller <gk.maring@gmail.com>
Subject: Questions about Tier evict
Date: Fri, 29 Dec 2017 16:46:35 +0800
Message-ID: <CAOvCcb5mr6+R8qKOcCjvk3CaM5_XUvXseDY+9ds8=AoQn+YHHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:37905 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755063AbdL2Iqg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Dec 2017 03:46:36 -0500
Received: by mail-yw0-f174.google.com with SMTP id x199so9246735ywg.5
        for <ceph-devel@vger.kernel.org>; Fri, 29 Dec 2017 00:46:36 -0800 (PST)
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
