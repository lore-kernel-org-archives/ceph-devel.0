From: qi Shi <m13913886148@gmail.com>
Subject: Why not to change primary read to random read in any replication
Date: Thu, 25 May 2017 17:58:50 +0800
Message-ID: <CAN=xyVV+9aWt=g4SS3MMbPQU4RHTDUfBMTetez5-3DLq7e-c2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:32778 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032114AbdEYJ6w (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 May 2017 05:58:52 -0400
Received: by mail-it0-f43.google.com with SMTP id w68so14672587itc.0
        for <ceph-devel@vger.kernel.org>; Thu, 25 May 2017 02:58:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

When the ceph client reads a very hot little file (less than 4M). The
application scenario is live video. A single disk may have a
bottleneck. The ceph client only reads the primary pg of osd. But this
is the implementation of the serial. My suggestion is to change the
primary read to random read three replication, or change to read 3
replications at the same time, so to improve the reading efficiency.
