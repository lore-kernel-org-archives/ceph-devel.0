From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/6] rbd: old patches from Josh
Date: Thu, 19 Jul 2012 07:30:34 -0500
Message-ID: <5007FDEA.9010605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60240 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab2GSMag (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 08:30:36 -0400
Received: by yhmm54 with SMTP id m54so2668348yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 05:30:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Late last year Josh Durgin had put together a series of
fixes for rbd that never got committed.  I told him I
would get them in, and this series represents the last
six that remain.

Here's a summary:
[PATCH 1/6] rbd: return errors for mapped but deleted snapshot
    This adds code to distinguish the result of attempting
    to read data from a deleted snapshot from the the result
    of reading a hole in a snapshot.  The former now produces
    ENXIO.
[PATCH 2/6] rbd: only reset capacity when pointing to head
    When an rbd header is refreshed, its capacity is set in
    case it has been changed.  This should not happen for
    mapped snapshots.
[PATCH 3/6] rbd: expose the correct size of the device in sysfs
    An rbd_dev--even one mapping a snashot--holds the size of
    it's base image in its header's image_size field.  The sysfs
    entry for the snapshot size was showing the wrong value.
[PATCH 4/6] rbd: set image size when header is updated
    The rbd image size was not getting updated when a header
    was refrehsed.
[PATCH 5/6] rbd: use reference counting for the snap context
    This makes sure the rbd code takes a reference to its
    snapshot context while a request related to that context
    is underway.
[PATCH 6/6] rbd: send header version when notifying
    This ensures the version that gets sent back on a watch
    notify acknowledgement is the one that got read as
    a result of refreshing the header.

I've reviewed them all, but am posting them for a chance for
others to comment before I commit them.

					-Alex
