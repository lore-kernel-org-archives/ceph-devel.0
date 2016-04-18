From: Peter Rajnoha <prajnoha@redhat.com>
Subject: 60-ceph-partuuid-workaround.rules
Date: Mon, 18 Apr 2016 12:01:23 +0200
Message-ID: <5714B073.6070809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59228 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbcDRKB0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Apr 2016 06:01:26 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56A674DAF6
	for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 10:01:26 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Loic Dachary <ldachary@redhat.com>, "Alasdair G. Kergon" <agk@redhat.com>, Zdenek Kabelac <zkabelac@redhat.com>

Hi!

I'm resending original mail to this list after initial
discussion with Loic Dachary so others can chime in. Loic
says these rules were there to workaround certain problems
on Centos 6 only and that it can be discarded now.

Please, read original mail below:

===

We've just noticed 60-ceph-partuuid-workaround.rules.

You added a patch some time ago which made these rules
to be applied for DM devices too:


https://github.com/ceph/ceph/commit/42ad86e14e352f2a3a33e774224f1789f268da83

The problem we've spotted and hit recently is that
these rules call blkid which opens all DM devices now
on uevents. However, not all DM devices are suitable
for scanning as they may not be prepared fully yet.
We use various flags in DM (and its subsystems like LVM)
to avoid these scans and for all the rules we don't manage,
there's DM_UDEV_DISABLE_OTHER_RULES_FLAG that needs to
be checked in these "foreign" rules before opening such
DM device (which includes running blkid).

Otherwise, we may end up with errors where some DM subsystem
needs to close the device or do some initialization on this
device before making it public by dropping the
DM_UDEV_DISABLE_OTHER_RULES_FLAG. So we need to make sure
these things are in sync - the scan can't be run on all DM
devices, it's controlled via DM_UDEV_*_FLAG variables.

Now, when it comes to the 60-ceph-partuuid-workaround.rules,
why do we need that at all? I mean, the 60-persistent-storage.rules
do not whitelist DM devices, so these rules are skipped anyway
and it was that way since beginning, I think. Now, I see this
comment in the 60-ceph-partuuid-workaround.rules:

# this is a kludge installed by ceph to fix the /dev/disk/by-partuuid
# symlinks on systems with old udev (< 180).  it's a stripped down
# version of a newer 60-persistent-storage.rules file that hopefully
# captures the same set of conditions for setting up those symlinks.

So I need to get to the bottom of the problem which was
resolved here. Feel free to point me to someone else if you're
not the right person, but I need to understand what's behind
these extra workaround rules so I can help to make it work
correctly with DM devices.

Thanks.

-- 
Peter
