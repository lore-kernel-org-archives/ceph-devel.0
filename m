From: Sage Weil <sweil@redhat.com>
Subject: crush luminous endgame
Date: Wed, 3 May 2017 15:09:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705031458310.32730@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbdECPJO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 3 May 2017 11:09:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A5514E4CD
        for <ceph-devel@vger.kernel.org>; Wed,  3 May 2017 15:09:14 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ldachary@redhat.com
Cc: ceph-devel@vger.kernel.org

Hey,

My current thinking is that it would be great to get the following working 
for luminous (roughly in order of priority):

1/ add a mon setting for the oldest client version we want to support.  
this would replace the various mon_allow_* settings that control whenter 
we user primary-affinity, osd upmap, and gate the crush tunables changes 
(i.e. you can't set jewel untables if the oldest compat client is 
firefly).

2/ make sure the above gates the new crush weight sets.

3/ make crushwrapper encode a "legacy" crushmap if (1) we're using weight 
sets, (2) the client is lacking features for the weight set, but (3) the 
weight set has a single position and no id remapping.  Since these maps 
are *only* used by clients (not humans), then i don't think there's any 
need to preserve the original crush weights in a shadow hierarchy; we can 
just swpa them for the real weights and the legacy clients wll behave as 
expected.  a helper can tell us whether this is possible so that we gate 
any commands that inject crush map on the compat option in #1.

4/ I would *love love love* it if we could have a mgr task that optimizes 
the crush weights in a way that Just Works.  If we remove any need for the 
admin to worry about reweighting in luminous I would call it a bit 
usability win.  I think depends on your ongonig investigation in which 
optimization methods work, and then eventually some mgr work so that it is 
done automatically.

I can work on #1; #2 is something we need to sort before luminous releases 
to make sure users to shoot themselves in the foot.  #3 would be awesome 
(it will still allow offline optimization tools and maintain compat with 
clients) and #4 would be the big win IMO.

What do you think?
sage
