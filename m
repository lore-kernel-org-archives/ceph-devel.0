From: Sage Weil <sweil@redhat.com>
Subject: btime and change_attr features in kclient
Date: Mon, 24 Oct 2016 16:16:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610241613520.14316@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753513AbcJXQQF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 24 Oct 2016 12:16:05 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 847ED8124D
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2016 16:16:04 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com, jlayton@redhat.com, ceph-devel@vger.kernel.org

Hi,

This PR that changes the entity_addr encoding is finally ready to merge

	https://github.com/ceph/ceph/pull/9825

but it defines an MSG_ADDR2 feature bit indicating whether we support the 
new addr encoding.  Right now it's defined with the same value as the 
FS_CHANGE_ATTR and FS_BTIME feature bit.  Are those upstream yet?  If not, 
we should get the addr2 support in at the same time so that we can 
conserve a feature bit.  If not, we'll have to consume another bit.  :(

sage

