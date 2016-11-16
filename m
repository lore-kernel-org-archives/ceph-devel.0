From: David Disseldorp <ddiss@suse.de>
Subject: udev remove events to mark OSD down/out on disk-pull
Date: Wed, 16 Nov 2016 03:30:42 +0100
Message-ID: <20161116033042.68eee001@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45597 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753186AbcKPCap (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 15 Nov 2016 21:30:45 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7D356ABF9
        for <ceph-devel@vger.kernel.org>; Wed, 16 Nov 2016 02:30:44 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm currently looking at ways to speed up OSD down/out notifications
for disk-pull events, and was investigating using udev remove events
for this.

IIUC, the outage currently propagates through to the mons via OSD device
I/O error -> filestore I/O error ->  ceph-osd ceph_abort() -> heartbeat
failure.

For the disk-pull case, this should be relatively easy to speed up
by handling the remove event in 95-ceph-osd.rules with an appropriate
osd down/out PDU. The problem then becomes maintaining consistent
information in the udev database (all stashed via IMPORT{program}):
- cluster / OSD ids
- appropriate cephx creds

Before I hack something up for this, I'm interested in what others
think, and whether anyone has already gone down this path. I seem to
recall someone attempting to change the ceph-osd behaviour on I/O
error at some stage.

Cheers, David
