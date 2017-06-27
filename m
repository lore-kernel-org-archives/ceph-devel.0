From: Timofey Titovets <nefelim4ag@gmail.com>
Subject: Bluestore: compession heuristic
Date: Wed, 28 Jun 2017 01:47:26 +0300
Message-ID: <CAGqmi77-KqhcTKxa=jnxZ2NUzVL-MT=ktRwoUYy9Zg6-C9n9dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:35923 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbdF0WsI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jun 2017 18:48:08 -0400
Received: by mail-qt0-f177.google.com with SMTP id i2so36849233qta.3
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 15:48:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi, i've write some heuristic code for btrfs compression subsystem,
userspace option are simple and fast enough (~4GiB/s on my notebook).

Heuristic can detect good/bad compressible data, to decrease cpu load
and avoid compressing bad compressible data.

https://github.com/Nefelim4ag/Entropy_Calculation

So, if that looks interesting, please let me know,
Thanks.
-- 
Have a nice day,
Timofey.
