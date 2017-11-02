From: xiaoyan li <wisher2003@gmail.com>
Subject: Should set bluestore_shard_finishers as true?
Date: Thu, 2 Nov 2017 16:15:40 +0800
Message-ID: <CAERxPZKzt7MLZOAELmvUPzvNixj8eyqWvZx5re-LBCm=FN76sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:52798 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbdKBIPl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Nov 2017 04:15:41 -0400
Received: by mail-oi0-f48.google.com with SMTP id r128so369058oig.9
        for <ceph-devel@vger.kernel.org>; Thu, 02 Nov 2017 01:15:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage and all,

Currently the option bluestore_shard_finishers is set as false. As a
result there is one finisher to handle bluestore IO completion.

In NVMe scenario, it becomes the bottleneck.
In my cluster with one OSD on NVMe disk,
With finisher number is 1:
  write: IOPS=20.6k, BW=80.5MiB/s (84.4MB/s)(70.8GiB/899908msec)
And when set finisher numbers to 8:
write: IOPS=41.1k, BW=161MiB/s (168MB/s)(141GiB/899916msec)

In scenario with finisher number as 1, it takes long time in finisher queue.
I am wondering whether we can set bluestore_shard_finishers  to true by default?
And by default
m_finisher_num = cct->_conf->osd_op_num_shards_hdd/2 or m_finisher_num
= cct->_conf->osd_op_num_shards_ssd/2

How do you think?

-- 
Best wishes
Lisa
