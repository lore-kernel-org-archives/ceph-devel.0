From: Sage Weil <sweil@redhat.com>
Subject: bluestore sharded extent map, and design review session
Date: Fri, 2 Sep 2016 16:56:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609021653240.31624@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932495AbcIBQ4I (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Sep 2016 12:56:08 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCB7981225
        for <ceph-devel@vger.kernel.org>; Fri,  2 Sep 2016 16:56:04 +0000 (UTC)
Received: from ovpn-112-75.phx2.redhat.com (ovpn-112-75.phx2.redhat.com [10.3.112.75])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u82Gu26K018959
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Fri, 2 Sep 2016 12:56:04 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

I have the sharded extent code passing all my tests and in a reasonably 
clean state:

	https://github.com/ceph/ceph/pull/10963

Please review!

Also, I think now is a good time to do another video call to walk through 
the current/new design and code.

How about Tuesday Sep 6 at 9am PDT / 12pm EDT?

sage
