From: qi Shi <m13913886148@gmail.com>
Subject: Which pg need to be moved?
Date: Wed, 5 Jul 2017 18:17:40 +0800
Message-ID: <CAN=xyVU9QotprYzdY02qa-_OdjKo_bfu6f7Dj4PkmxugryXVsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:34270 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdGEKRm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jul 2017 06:17:42 -0400
Received: by mail-io0-f170.google.com with SMTP id r36so83225642ioi.1
        for <ceph-devel@vger.kernel.org>; Wed, 05 Jul 2017 03:17:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

For example: ceph cluster has 10 osd, now add a osd

the problem is as follows:

               1, when add a osd, osdmap, crushmap changes, Break the
original all pg on osd positioning. Cause all pgs to migrate between
11 osd?
               2,If a new OSD is added, a small amount of PG is
migrated. In the first 10 osd, how does ceph determine which pg needs
to split?
               3,when osdmap changes, Is ceph most pg having to look
for positions again?  How do you ensure that a small number of pg find
locations?
