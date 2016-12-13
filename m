From: Sage Weil <sweil@redhat.com>
Subject: kraken rc is out, and kraken is branched!
Date: Tue, 13 Dec 2016 23:51:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612132349030.343@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751621AbcLMXvP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Dec 2016 18:51:15 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACA6C3B3E7
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2016 23:51:09 +0000 (UTC)
Received: from ovpn-200-86.brq.redhat.com (ovpn-200-86.brq.redhat.com [10.40.200.86])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBDNp46p018604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2016 18:51:08 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Please continue to target PRs at master; we will cherry-pick -x them to 
kraken.  This isn't quite what we usually do (if there is a "usually" 
here), but for RBD we are reverting some half-completed features and we 
don't want those to get merged back into master.

Thanks!
sage

