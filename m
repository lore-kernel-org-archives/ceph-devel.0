From: Sage Weil <sweil@redhat.com>
Subject: service map
Date: Thu, 22 Jun 2017 02:29:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706220227280.32269@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751154AbdFVC3d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Jun 2017 22:29:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D88541A23
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jun 2017 02:29:32 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Jason Dillaman <dillaman@redhat.com>, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 21 Jun 2017, Sage Weil wrote:
> I've updated the pad at
> 
> 	http://pad.ceph.com/p/service-map
> 
> - commands mediated by mgr
> - (some) state persisted in config-key
> - a few use-cases outline explicitly

Updated again to include the optoin of piggybacking daemon metadata and 
status in the MMgrReprot messagse already sent from MgrClient -> ceph-mgr 
(with metrics etc).  This has the nice property of keeping it all together 
with perfcounter metrics, which eventually we'll want to allow these 
services to add to as well.

sage

