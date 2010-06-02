From: Paul <paul_chiang@tcloudcomputing.com>
Subject: Correct proceedure for removing ceph nodes
Date: Wed, 2 Jun 2010 15:31:43 +0800
Message-ID: <AANLkTimW7oNdbDnTTyPzlOlD8fr0Bw5rRybuTiHNQTmV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:33496 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab0FBHbs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jun 2010 03:31:48 -0400
Received: by wwb28 with SMTP id 28so2648674wwb.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jun 2010 00:31:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

We're having trouble figuring out what the correct proceedure for
(permanently) removing nodes from a ceph cluster is.
1. Mon:
    I see that the MonMap class has a remove operation, but is not
exposed through the MonmapMonitor. Any reason why not?
2. MDS:
    I guess we just kill the daemon and let the recovery mechanism do
its job. We notcied however, that decreasing the active mds count
using set max mds doesn't seem to have any effect: i.e. no MDSes are
moved back to standby.
3. OSD:
   Again, I suppose we could just kill the daemon, but that'd leave
holes in the data placement which doesn't seem to be very elegant.
Setting the device weight to 0 in the crushmap works, but trying to
remove a device entriely produces strange results. Could you shed some
light on this?

Thanks in advance,
Paul C
