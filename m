From: Sage Weil <sweil@redhat.com>
Subject: osd pg logs
Date: Fri, 25 Aug 2017 17:47:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708251746150.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756443AbdHYRr5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 25 Aug 2017 13:47:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CBF361497
        for <ceph-devel@vger.kernel.org>; Fri, 25 Aug 2017 17:47:57 +0000 (UTC)
Received: from ovpn-112-13.rdu2.redhat.com (ovpn-112-13.rdu2.redhat.com [10.10.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 130766E520
        for <ceph-devel@vger.kernel.org>; Fri, 25 Aug 2017 17:47:56 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On the perf call yesterday we talked a bit about managing and optimizing 
for pg log storage.  I wrote down some notes on the current ideas I'm 
aware of and put them in a pad:

	http://pad.ceph.com/p/osd-pg-log-management

sage
