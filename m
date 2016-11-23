From: Sage Weil <sweil@redhat.com>
Subject: ceph.git housecleaning
Date: Wed, 23 Nov 2016 23:32:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611232330290.21102@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933995AbcKWXcf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 23 Nov 2016 18:32:35 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 041D9C04D30A
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2016 23:32:35 +0000 (UTC)
Received: from ovpn-112-42.phx2.redhat.com (ovpn-112-42.phx2.redhat.com [10.3.112.42])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uANNWXi4021197
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2016 18:32:34 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've removed most of the stale branches from ceph.git.  We went from 500+ 
to 100 something.  I'll remove the others shortly once we get ceph-ci.git 
set up, unless there is an open PR against the branch.

All old/current branches are archived in the new ceph-old.git repo at

	https://github.com/ceph/ceph-old

Happy Thanksgiving!
sage
