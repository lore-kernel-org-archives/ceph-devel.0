From: Sage Weil <sweil@redhat.com>
Subject: requiring sortbitwise post-jewel
Date: Thu, 3 Nov 2016 17:30:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611031728580.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759053AbcKCRag (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 3 Nov 2016 13:30:36 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0898C8F225
        for <ceph-devel@vger.kernel.org>; Thu,  3 Nov 2016 17:30:36 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com
Cc: ceph-devel@vger.kernel.org

What do you think about requiring that the sortbitwise OSDMap flag be set 
before ceph-osd will start?  I think this would let us drop all the 
Sortbitwise comparator stuff immediately.  Jewel already issues a health 
warning if all OSDs are jewel and the flag isn't set.  We can make a note 
in the upgrade notes.

?

sage

