From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/6] ceph: simple cleanups (mostly rbd)
Date: Thu, 26 Jul 2012 13:40:51 -0500
Message-ID: <50118F33.7080502@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47721 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab2GZSkx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:40:53 -0400
Received: by yhmm54 with SMTP id m54so2318362yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:40:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series includes a set of fairly minor code cleanups in rbd.
I won't bother summarizing them here.  They are all simple nad
their descriptions ought to be sufficient.

					-Alex

[PATCH 1/6] rbd: drop extra header_rwsem init
[PATCH 2/6] rbd: simplify __rbd_remove_all_snaps()
[PATCH 3/6] rbd: clean up a few dout() calls
[PATCH 4/6] ceph: define snap counts as u32 everywhere
[PATCH 5/6] rbd: encapsulate header validity test
[PATCH 6/6] rbd: rename rbd_device->id
