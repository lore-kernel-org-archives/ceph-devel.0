From: qi Shi <m13913886148@gmail.com>
Subject: Which function is mon ping osd?
Date: Sun, 21 May 2017 22:10:01 +0800
Message-ID: <CAN=xyVX9S2g6RW-PMjhR8Xhch2Kd8UofZRDwHV=yrEbt7EFyFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:34865 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754165AbdEUOKD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 21 May 2017 10:10:03 -0400
Received: by mail-it0-f49.google.com with SMTP id c15so139599685ith.0
        for <ceph-devel@vger.kernel.org>; Sun, 21 May 2017 07:10:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When i read the official documents,I found that mon would ping osds.

The following is a description of the official documentation:
---------------------------------------------------------------------------------------------------------------------

OSD Membership and Status: Ceph OSD Daemons join a cluster and report
on their status. At the lowest level, the Ceph OSD Daemon status is up
or down reflecting whether or not it is running and able to service
Ceph Client requests. If a Ceph OSD Daemon is down and inthe Ceph
Storage Cluster, this status may indicate the failure of the Ceph OSD
Daemon. If a Ceph OSD Daemon is not running (e.g., it crashes), the
Ceph OSD Daemon cannot notify the Ceph Monitor that it is down. The
Ceph Monitor can ping a Ceph OSD Daemon periodically to ensure that it
is running. However, Ceph also empowers Ceph OSD Daemons to determine
if a neighboring OSD is down, to update the cluster map and to report
it to the Ceph monitor(s). This means that Ceph monitors can remain
light weight processes. SeeMonitoring OSDs and Heartbeats for
additional details.
-----------------------------------------------------------------------------------------------------------------------

Who can tell me which file in the source code, and which function,
which function to do mon ping osd?
