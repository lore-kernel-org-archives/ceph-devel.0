From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 0/1] ceph/osd_client: GETXATTR support
Date: Fri,  9 Oct 2015 16:43:08 +0200
Message-ID: <1444401789-17396-1-git-send-email-ddiss@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53055 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756686AbbJIOnQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Oct 2015 10:43:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: mchristi@redhat.com, idryomov@gmail.com

The following patch adds support for xattr retrieval via
CEPH_OSD_OP_GETXATTR. This allows for future RBD Persistent Reservation
support to implemented with state retained in an xattr on the RBD
header object.

RBD get/set/cmpset xattr functionality can be tested using the debug
DEVICE_ATTR patches found at:
https://git.samba.org/?p=ddiss/linux.git;a=shortlog;h=refs/heads/rbd_xattrs

E.g.
dracut:/# echo "key" > /sys/devices/rbd/0/getxattr
sh: echo: write error: No data available
dracut:/# echo "key val1" > /sys/devices/rbd/0/setxattr
dracut:/# echo "key" > /sys/devices/rbd/0/getxattr
[   95.842774] rbd: rbd0: key: val1
dracut:/# echo "key val1 val2" > /sys/devices/rbd/0/cmpsetxattr
dracut:/# echo "key" > /sys/devices/rbd/0/getxattr
[  129.868432] rbd: rbd0: key: val2
dracut:/# echo "key val1 val2" > /sys/devices/rbd/0/cmpsetxattr
sh: echo: write error: Operation canceled
dracut:/# echo "key val2 val3" > /sys/devices/rbd/0/cmpsetxattr
dracut:/# echo "key" > /sys/devices/rbd/0/getxattr
[  152.532082] rbd: rbd0: key: val3

Cheers, David
