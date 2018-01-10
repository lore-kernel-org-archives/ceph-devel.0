From: Sage Weil <sweil@redhat.com>
Subject: can we stop packaging sysvinit scripts?
Date: Wed, 10 Jan 2018 14:44:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801101440550.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932218AbeAJOow (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 10 Jan 2018 09:44:52 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

We've had systemd unit files for several releases now and all major 
distros are using systemd by default.  Can we stop packaging the sysvinit 
scripts?

I realize that Debian allows you to switch init systems... do any users 
actually do this?  Is it required that debs include the sysvinit scripts 
or is there some glue that lets packages avoid maintaining sysvinit 
scripts?

I ask because the init scripts are one of the few remainining bits that 
use the ceph-conf utility, which I would like to deprecate (and eventually 
remove).  It parses local config files but we are migrating this to the 
mon.  We could make ceph-conf pull configs from the mon but I would 
like to simplify if possible!

Thanks-
sage

