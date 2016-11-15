From: Sage Weil <sweil@redhat.com>
Subject: stalls caused by scrub on jewel
Date: Tue, 15 Nov 2016 22:35:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611152232260.2650@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933752AbcKOWgB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 15 Nov 2016 17:36:01 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

Hi everyone,

There was a regression in jewel that can trigger long OSD stalls during 
scrub.  How long the stalls are depends on how many objects are in your 
PGs, how fast your storage device is, and what is cached, but in at least 
one case they were long enough that the OSD internal heartbeat check 
failed and it committed suicide (120 seconds).

The workaround for now is to simply 

 ceph osd set noscrub

as the bug is only triggered by scrub.  A fix is being tested and will be 
available shortly.

If you've seen any kind of weird latencies or slow requests on jewel, I 
suggest setting noscrub and seeing if they go away!

The tracker bug is

 http://tracker.ceph.com/issues/17859

Big thanks to Yoann Moulin for helping track this down!

sage
