From: Milosz Tanski <milosz@adfin.com>
Subject: fscache support
Date: Fri, 17 May 2013 14:17:04 -0400
Message-ID: <CANP1eJEKUErEYiNaPd=bsHF4Mz5hvyhFTDUkOhWbypDFmrnGPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:62405 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab3EQSRF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 May 2013 14:17:05 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so9962410iec.22
        for <ceph-devel@vger.kernel.org>; Fri, 17 May 2013 11:17:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello there,

I'm working on netfs-fscache support to the kernel ceph filesystem
client. The other filesystems in the kernel that have implemented it
are NFS and AFS.

In the cache of a inode, how do I tell that's I'm the only person that
has this file open. So I can tell that I can safely cache the file.
After reading the code I imagine it has something to do with the
CEPH_CAP_FILE_SHARED, CEPH_CAP_FILE_EXCL and CEPH_CAP_FILE_CACHE. But
I wasn't able to find enough info to know that I've implemented my
cache invalidation correctly.

To give you a little background. I'm doing this work because I think
it has great potential for our workload. We're using cephfs as a
backing store for our distributed  database. Our frontend nodes (the
ones that perform the querying) contain decent size SSD drives. With
our primarily read workload and having a high rate of cachability for
file pages that contain indexes, data extents, ISAM trees. It would be
nice performance improvement.

Thanks,
- Milosz
