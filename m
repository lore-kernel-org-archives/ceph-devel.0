From: Sage Weil <sweil@redhat.com>
Subject: bluestore prefer wal size
Date: Wed, 1 Feb 2017 15:34:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702011533340.3660@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751671AbdBAPeW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Feb 2017 10:34:22 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: nick@fisk.me.uk
Cc: ceph-devel@vger.kernel.org

Hey Nick,

I've updated/improved the prefer wal size PR (that sends small writes 
through the wal).  See

	https://github.com/ceph/ceph/pull/13217

if you want to try it out.

Thanks!
sage


