From: Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH 0/6] net: ceph: messenger: code cleanup
Date: Wed, 27 Jan 2016 02:43:33 +0200
Message-ID: <cover.1453853617.git.ciorneiioana@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33607 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbcAZWnt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 17:43:49 -0500
Received: by mail-wm0-f66.google.com with SMTP id r129so21935wmr.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jan 2016 14:43:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@ieee.org, Ioana Ciornei <ciorneiioana@gmail.com>


This patchset makes some small code cleanup on the messenger code from net/ceph.
Most of the patches are a result of running checkpatch.pl on
net/ceph/messenger.c


Ioana Ciornei (6):
  net: ceph: messenger: remove unnecessary blank spaces
  net: ceph: messenger: fix coding style comparison to NULL
  net: ceph: messenger: add blank line after declarations
  net: ceph: messenger: properly align function parameters
  net: ceph: messenger: change printk to pr_warn
  net: ceph: messenger: add braces to all arms of conditional statement

 net/ceph/messenger.c | 207 ++++++++++++++++++++++++++-------------------------
 1 file changed, 107 insertions(+), 100 deletions(-)

-- 
2.6.4

