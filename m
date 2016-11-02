From: Sage Weil <sweil@redhat.com>
Subject: install task and ceph-mgr
Date: Wed, 2 Nov 2016 17:56:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611021754240.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756394AbcKBR4k (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 2 Nov 2016 13:56:40 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD2B861B8E
        for <ceph-devel@vger.kernel.org>; Wed,  2 Nov 2016 17:56:39 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kchai@redhat.com, zcerza@redhat.com
Cc: ceph-devel@vger.kernel.org

The recent ceph-qa-suite change to install ceph-mgr breaks the upgrade 
tests because ceph-mgr doesn't exist in jewel and earlier.  How should we 
fix that?

- add exclude packages option to install.py, and update all the install 
tests?

- make install.py try to sort out on its own if the version is pre-kraken 
and exclude it itself?

http://pulpito.ceph.com/sage-2016-11-02_13:49:58-rados-wip-sage-testing---basic-smithi/

sage


