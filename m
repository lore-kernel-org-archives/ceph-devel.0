From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/8] wip-overlap
Date: Thu, 24 Jul 2014 12:42:41 +0400
Message-ID: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:44553 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934229AbaGXImy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 04:42:54 -0400
Received: by mail-lb0-f169.google.com with SMTP id s7so2031147lbd.0
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 01:42:52 -0700 (PDT)
Received: from localhost ([109.110.66.237])
        by mx.google.com with ESMTPSA id c9sm3875664laa.32.2014.07.24.01.42.51
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 01:42:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

This series fixes a bug reported by Sandisk in the "Read from clones"
thread about a week ago.  The description along with a simplified
reproducer are in 7/8 and 8/8.  1/8 touches on our sysfs interface.
The rest are cleanups.

Thanks,

                Ilya


Ilya Dryomov (8):
  rbd: show the entire chain of parent images
  rbd: introduce rbd_dev_header_info()
  rbd: remove unnecessary asserts in rbd_dev_image_probe()
  rbd: split rbd_dev_spec_update() into two functions
  rbd: harden rbd_dev_refresh() caller
  rbd: update mapping size only on refresh
  rbd: do not read in parent info before snap context
  rbd: take snap_id into account when reading in parent info

 Documentation/ABI/testing/sysfs-bus-rbd |    4 +-
 drivers/block/rbd.c                     |  261 ++++++++++++++++---------------
 2 files changed, 137 insertions(+), 128 deletions(-)

-- 
1.7.10.4

