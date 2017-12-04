From: Sage Weil <sweil@redhat.com>
Subject: mimic-dev1 branch for 13.0.1
Date: Mon, 4 Dec 2017 17:57:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712041459580.22619@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751246AbdLDR56 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Dec 2017 12:57:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 866A37F3F4
        for <ceph-devel@vger.kernel.org>; Mon,  4 Dec 2017 17:57:58 +0000 (UTC)
Received: from ovpn-112-42.rdu2.redhat.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31F5A781F2
        for <ceph-devel@vger.kernel.org>; Mon,  4 Dec 2017 17:57:58 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I've pushed a mimic-dev1 branch and am kicking off a bunch of qa runs for 
the 13.0.1 dev checkpoint release.  The goal here is to make sure these QA 
runs are clean so that we don't have weeks and weeks of cleaning up our 
testing debt at the end of the mimic cycle.  Yuri is on PTO right now so 
it'll be up to the leads to drive these tests for now.

Overall for the rados suite I think we are in reasonably good shape, 
but there are definitely some failures that we should clean up before 
moving on.

Please try to merge fixes directly into the mimic-dev1 branch (instead of 
cherry-picking the fixes).  We will periodically merge mimic-dev1 back 
into master, and also merge the eventual 13.0.1 release tag into master as 
well.

Thanks!
sage

