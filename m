From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 0/2] rbd_img_obj_exists_submit() fixes
Date: Thu,  1 Sep 2016 16:59:17 +0200
Message-ID: <1472741959-1786-1-git-send-email-ddiss@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933043AbcIAPAP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Sep 2016 11:00:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@linaro.org

Hi,

This patchset fixes a couple of bugs in the rbd_img_obj_exists_submit()
code-path which appear to have been there since the function was first
added.

Feedback appreciated.

Cheers, David

 drivers/block/rbd.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

