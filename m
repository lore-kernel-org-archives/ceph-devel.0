From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 0/2] clean up read only mode
Date: Mon, 30 Sep 2013 22:15:57 -0700
Message-ID: <1380604559-5331-1-git-send-email-josh.durgin@inktank.com>
References: <1379993136-29246-1-git-send-email-guangliang@unitedstack.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55867 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab3JAF7p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Oct 2013 01:59:45 -0400
In-Reply-To: <1379993136-29246-1-git-send-email-guangliang@unitedstack.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@inktank.com>

Running with lockdep showed that there were problems holding
rbd_dev->lock while doing in the BLKROSET ioctl patch. Fix this, and
clean up the initial read-only setting to occur during device
initialization instead of every time the device is opened.

These are also available in the wip-rbd-ro branch of ceph-client.git.

Josh Durgin (2):
  rbd: move calls that may sleep out of spin lock range
  rbd: only set disk to read-only once

 drivers/block/rbd.c |   38 ++++++++++++++++++++++++--------------
 1 files changed, 24 insertions(+), 14 deletions(-)

-- 
1.7.2.5

