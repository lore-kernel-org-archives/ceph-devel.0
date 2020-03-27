From: Sage Weil <sage@newdream.net>
Subject: Re: v15.2.0 Octopus released
Date: Fri, 27 Mar 2020 14:14:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.21.2003271410190.4773@piezo.novalocal>
References: <878sjqc79i.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:36498 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0OOc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2020 10:14:32 -0400
In-Reply-To: <878sjqc79i.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: ceph-announce@ceph.io, ceph-users@ceph.io, dev@ceph.io, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.io

One word of caution: there is one known upgrade issue if you

 - upgrade from luminous to nautilus, and then
 - run nautilus for a very short period of time (hours), and then
 - upgrade from nautilus to octopus

that prevents OSDs from starting.  We have a fix that will be in 15.2.1, 
but until that is out, I would recommend against the double-upgrade.  If 
you have been running nautilus for a while (days) you should be fine.

sage


https://tracker.ceph.com/issues/44770
