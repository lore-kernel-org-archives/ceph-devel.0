From: Luis Henriques <lhenriques@suse.com>
Subject: Help understanding xfstest generic/467 failure
Date: Tue, 12 May 2020 16:13:24 +0100
Message-ID: <878shx190r.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgELPN1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 12 May 2020 11:13:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org

Hi Jeff,

I've been looking at xfstest generic/467 failure in cephfs, and I simply
can not decide if it's a genuine bug on ceph kernel code.  Since you've
recently been touching the ceph_unlink code maybe you could help me
understanding what's going on.

generic/467 runs a couple of tests using src/open_by_handle, but the one
failing can be summarized with the following:

- get a handle to /cephfs/myfile using name_to_handle_at(2)
- open(2) file /cephfs/myfile
- unlink(2) /cephfs/myfile
- drop caches
- open_by_handle_at(2) => returns -ESTALE

This test succeeds opening the handle with other (local) filesystems
(maybe I should run it with other networked filesystem such as NFS).

The -ESTALE is easy to trace to __fh_to_dentry, where inode->i_nlink is
checked against 0.  My question is: should we really be testing the
i_nlink here?  We dropped the name, but the file may still be there (as in
this case).

I guess I'm missing something, but hopefully you'll be able to shed some
light on this.  Thanks in advance for any help you may provide!

Cheers,
-- 
Luis
