From: Sage Weil <sweil@redhat.com>
Subject: luminous branch is now forked
Date: Mon, 7 Aug 2017 16:01:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708071600050.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26005 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751794AbdHGQBx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 7 Aug 2017 12:01:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4848315565
        for <ceph-devel@vger.kernel.org>; Mon,  7 Aug 2017 16:01:53 +0000 (UTC)
Received: from ovpn-112-5.rdu2.redhat.com (ovpn-112-5.rdu2.redhat.com [10.10.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F256A5D969
        for <ceph-devel@vger.kernel.org>; Mon,  7 Aug 2017 16:01:52 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The luminous branch is now fully forked from master.  Any fixes merged to 
master need to be cherry-pick -x'd to luminous.

There are only 6 open prs with the luminous tag.  I'm going to clear the 
milestone for these shortly so that the luminous milestone can be used for 
luminous backport PRs.

Thanks!
sage

