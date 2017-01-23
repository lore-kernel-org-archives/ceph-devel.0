From: Ming Lin <minggr@gmail.com>
Subject: monitor port closed
Date: Sun, 22 Jan 2017 21:32:26 -0800
Message-ID: <CAF1ivSbn_bzic_JjOEEUKnp936XOy43s2r=0V0ujzVSpv2okBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36673 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAWFc2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 00:32:28 -0500
Received: by mail-io0-f171.google.com with SMTP id j13so102730333iod.3
        for <ceph-devel@vger.kernel.org>; Sun, 22 Jan 2017 21:32:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

[mon]
mon initial members = a

[mon.a]
mon addr = 192.168.0.1:7000

jewel release with 1 monitor and 3 OSDs.

After hours of fio rbd test, the monitor binded port(7000) was closed
for unknown reason.
But monitor is still running,

# pidof ceph-mon
21980

Another strange thing is there are more than 1000 threads for the
ceph-mon process.

# ls /proc/21980/task/ |wc -l
1022

Any possible reason?

Thanks,
Ming
