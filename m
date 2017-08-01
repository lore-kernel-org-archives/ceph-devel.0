From: Sage Weil <sweil@redhat.com>
Subject: ceph nagios plugins
Date: Tue, 1 Aug 2017 14:30:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708011414210.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751768AbdHAOaW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 1 Aug 2017 10:30:22 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: valery.tschopp@switch.ch
Cc: ceph-devel@vger.kernel.org

Hi Valery,

We're thinking about bringing the nagios plugins into the ceph tree to 
make them easier to find for users (e.g., making ceph-nagios-plugins 
available in the upstream ceph.com repos).  It looks like these are the 
most complete (and most commonly used) plugins out there.

Would you object to pulling 

	https://github.com/valerytschopp/ceph-nagios-plugins

into ceph.git (into, say, contrib/nagios)?

Thanks!
sage
