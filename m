From: Sage Weil <sweil@redhat.com>
Subject: Mimic planning: Wed
Date: Mon, 28 Aug 2017 16:02:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708281556180.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751346AbdH1QC5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 28 Aug 2017 12:02:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC8D47E425
        for <ceph-devel@vger.kernel.org>; Mon, 28 Aug 2017 16:02:57 +0000 (UTC)
Received: from ovpn-112-5.rdu2.redhat.com (ovpn-112-5.rdu2.redhat.com [10.10.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 623C87F495
        for <ceph-devel@vger.kernel.org>; Mon, 28 Aug 2017 16:02:57 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'd like to have an ad hoc call on Wednesday 8/30 at 9am PT/12p ET/1600 
UTC to go over the plans and priorities for the next major release, mimic.

	https://bluejeans.com/5192676054/

On the Ceph Backlog trello I've started marking items for Mimic with the 
pink labels.  Please add/adjust as appropriate.  (Purple == luminous or 
will-be-backported-to-luminous.)

	https://trello.com/b/ugTc2QFH/ceph-backlog

FWIW, a few of the items that came on the advisory board call last week 
included

	rbd client side caching (both read-only and writeback)
	pg autoscaling
	dashboard
	rados qos
	cephfs snapshots
	ceph-fuse with kubernetes (in order to avoid lack of kclient quota)
	ongoing bluestore/rocksdb performance optimization

If this time presents a major conflict for you please let me know sooner 
rather than later so we can reschedule (but I'm hoping I've managed to 
avoid the major conflicts for the key people).

Thanks!
sage
