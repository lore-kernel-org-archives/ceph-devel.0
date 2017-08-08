From: Sage Weil <sweil@redhat.com>
Subject: final luminous blockers
Date: Tue, 8 Aug 2017 15:58:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708081556210.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752441AbdHHP6d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 8 Aug 2017 11:58:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B10C7EA83
        for <ceph-devel@vger.kernel.org>; Tue,  8 Aug 2017 15:58:33 +0000 (UTC)
Received: from ovpn-112-5.rdu2.redhat.com (ovpn-112-5.rdu2.redhat.com [10.10.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12AB470958
        for <ceph-devel@vger.kernel.org>; Tue,  8 Aug 2017 15:58:32 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm hoping we get get 12.2.0 out the door tomorrow.  On the rados side, 
there is just one blocker:

	http://tracker.ceph.com/issues/20925

which I'm testing a fix for now.  There is also the rocskdb build issue 
that makes things break for folks with really old CPUs, but I don't think 
it needs to block the initial release.

I'm waiting for the latest round of upgrade tests to run as well but I 
think everything is resolved there.

Jason, Matt, Patrick: how are rbd, rgw, and cephfs looking?

Everyone else: any other blockers?

Thanks!
sage

