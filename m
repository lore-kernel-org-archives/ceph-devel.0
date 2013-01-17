From: Dan Mick <dan.mick@inktank.com>
Subject: tgt backend driver for Ceph block devices (rbd)
Date: Wed, 16 Jan 2013 18:47:14 -0800
Message-ID: <50F76632.4040404@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:40394 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218Ab3AQCrR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 21:47:17 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so1099607pbb.15
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 18:47:16 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: stgt@vger.kernel.org
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all.  I recently hacked at bs_rdwr and made it work as a 
proof-of-concept driver allowing tgt to be backed by the Ceph[1] storage 
cluster's RADOS block device (rbd)[2].  I thought I'd share the results 
of my investigations, as it's useful even in its current form:

http://github.com/dmick/tgt, forked from http://github.com/fujita/tgt
branch bs_rbd (https://github.com/dmick/tgt/tree/bs_rbd)

This is a simple transliteration of bs_rdwr to use librbd/librados
calls instead of normal file I/O calls (so might be instructive to diff 
bs_rbd.c against bs_rdwr.c to see what was involved).  It currently uses 
only the synchronous librbd interfaces, so each tgtd worker thread will 
block for completion of each request.  See the commit comment
for usage advice.

For those with less exposure to Ceph:

Ceph is a distributed storage system, and rbd provides a block-device 
abstraction to that storage that can be used directly from the kernel or 
from a userland library and things built on it.  That is:

1) you can create rbd images in the cluster, and then expose them as
kernel block devices to machines that talk to the cluster

2) You can create rbd images in the cluster, and then expose them to 
qemu-kvm virtual machines without kernel support (by using 
librbd/librados to access the cluster).

bs_rbd adds another access path: exposing rbd images as iSCSI targets
with strictly-userland code.

I was quite impressed at how easy this was, and how well-organized the 
stgt source is.  Kudos to the developers and maintainers!

--

[1] http://ceph.com, http://ceph.com/docs
[2] http://ceph.com/ceph-storage/block-storage/
