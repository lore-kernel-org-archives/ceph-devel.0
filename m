From: Mark Nelson <mnelson@redhat.com>
Subject: Effect of 11014 on wip-denc bitmap allocator locking overhead
Date: Wed, 14 Sep 2016 15:55:17 -0500
Message-ID: <b54f84b5-abe6-f259-74be-08d59efbfebb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753970AbcINUzU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Sep 2016 16:55:20 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01ADDC04D2AF
        for <ceph-devel@vger.kernel.org>; Wed, 14 Sep 2016 20:55:20 +0000 (UTC)
Received: from [10.3.112.17] (ovpn-112-17.phx2.redhat.com [10.3.112.17])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8EKtIRV031469
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Wed, 14 Sep 2016 16:55:19 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Today at the bluestore standup and perf meeting there was some 
discussion regarding time spent in bitmap allocator locking and the 
effect of 11014 on it.  I ran a 4K random write test today with wip-denc 
+ 11059 + 11014 and took a perf callgraph during 4K random writes.

As expected we are still picking up some buffer::list::append time in 
encode_some even after the wip-denc changes:

-    5.45%     2.10%  tp_osd_tp        ceph-osd                     [.] 
BlueStore::ExtentMap::encode_some
    - 3.35% BlueStore::ExtentMap::encode_some
       - 2.51% ceph::buffer::list::append
            2.31% ceph::buffer::ptr::ptr
    + 1.24% __clone

But we also still see a fair amount of time spent in 
BitMapAreaLeaf::child_check_n_lock:

-    5.26%     0.88%  tp_osd_tp        ceph-osd                     [.] 
BitMapAreaLeaf::child_check_n_lock
    - 4.39% BitMapAreaLeaf::child_check_n_lock
       - 1.78% BitMapZone::lock_excl_try
            1.49% pthread_mutex_trylock
       - 1.59% BitMapZone::is_exhausted
          + 1.23% BitMapZone::check_locked
         0.89% pthread_mutex_unlock

This is pretty comparable to what I was seeing prior to 11014, so it 
doesn't appear to be having much effect on this specific issue.

Mark

