From: Scott Jing <scott.jing152@gmail.com>
Subject: the question of way to modify bucket metadata
Date: Fri, 16 Dec 2016 22:20:26 +0800
Message-ID: <CANzRsYzgN9p317ge10cDQE+qXqYEyOQ3r7zLYgWYGXgrphM2Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:36390 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757382AbcLPOU2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2016 09:20:28 -0500
Received: by mail-io0-f174.google.com with SMTP id 136so98238903iou.3
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2016 06:20:27 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm Wenjun Jing from China Mobile(suzhou). Recently ceph multisite is
applied to our production onest, short for Object-Orient Storage
System,
which is a object storage production based on ceph. Needless to say,
the feature of active-active is awesome! But there are also some
features
which may not be supported very well and the community is improving
them constantly. So we want to discuss with you to comfirm the roadmap
of them.

This is the fact that if creating bucket on the secondary
zone/zonegroup. The request would send to meta master and the bucket
will be created
on meta master firstly, then it will be created locally.

Some metadata/feature of bucket in the process upper is not synced to
secondary zone or zonegroup. For instance, the bucket acl and bucket
versionning cannot be modified on the slave zone/zonegroup, which has
been fixed in the jewel. Now, we want to ack you to get the
development
direction(way) of the bucket metadata to modify.

The below are some ways which I've thought out currently.

1. All the bucket metadata will be modified in the meta master firstly
and then modify the metadata
locally according to the status retured from meta master. Considering
this way, some metadata (eg. creation time)
may not consistent with the meta master, which doesn't improve user experience.

2. All the bucket metadata will be modified in the meta master firstly
and sync the changed bucket metadata to slave zone or zonegroup.

3. The other alternative way to handle this situation? Could you
discribe to me detailedly?

Once the upper way could be comfirmed Definitely, we can make some
contribution to the community.

Look forward to your kind reply.
Thanks!
