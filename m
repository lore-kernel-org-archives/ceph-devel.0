From: Ugis <ugis22@gmail.com>
Subject: ocfs2 for OSDs?
Date: Wed, 11 Sep 2013 16:58:51 +0300
Message-ID: <CAE63xUNKj7JnU_Kypnh39j4z6qVPh2ZLCdiEvfis3_9fDBZ2FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46405 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab3IKN6w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Sep 2013 09:58:52 -0400
Received: by mail-ie0-f177.google.com with SMTP id qd12so8829957ieb.8
        for <ceph-devel@vger.kernel.org>; Wed, 11 Sep 2013 06:58:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi,

I wonder is ocfs2 suitable for hosting OSD data?
In ceph documentation only XFS, ext4 and btrfs are discussed, but
looking at ocfs2 feature list it theoretically also could host OSDs:

Some of the notable features of the file system are:
Optimized Allocations (extents, reservations, sparse, unwritten
extents, punch holes)
REFLINKs (inode-based writeable snapshots)
Indexed Directories
Metadata Checksums
Extended Attributes (unlimited number of attributes per inode)
Advanced Security (POSIX ACLs and SELinux)
User and Group Quotas
Variable Block and Cluster sizes
Journaling (Ordered and Writeback data journaling modes)
Endian and Architecture Neutral (x86, x86_64, ia64 and ppc64)
Buffered, Direct, Asynchronous, Splice and Memory Mapped I/Os
In-built Clusterstack with a Distributed Lock Manager
Cluster-aware Tools (mkfs, fsck, tunefs, etc.)

ocfs2 can work in cluster mode but it can also work for single node.

Just wondering would OSD work on ocfs2 and what would performance
characteristics be.
Any thoughts/experience?

BR,
Ugis Racko
