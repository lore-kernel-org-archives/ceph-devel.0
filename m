From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [RFC PATCH 2/3] ceph: quotas: support for ceph.quota.max_files
Date: Fri, 08 Sep 2017 09:33:54 +0100
Message-ID: <871snhlhcd.fsf@hermes>
References: <20170906141224.11813-1-lhenriques@suse.com>
        <20170906141224.11813-3-lhenriques@suse.com>
        <B56DB47D-CFD8-49E5-8483-CF591488DD2D@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754657AbdIHId5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 8 Sep 2017 04:33:57 -0400
In-Reply-To: <B56DB47D-CFD8-49E5-8483-CF591488DD2D@redhat.com> (Zheng Yan's
        message of "Thu, 7 Sep 2017 22:22:20 +0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Fajerski <jfajerski@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>, Jeff Layton <jlayton@redhat.com>

"Yan, Zheng" <zyan@redhat.com> writes:

>> On 6 Sep 2017, at 22:12, Luis Henriques <lhenriques@suse.com> wrote:
<snip>
> This bottom-up dentry traversal code worries me. I vaguely remember that bottom-up
> dentry traversal in kernel is discouraged. Then there are multiples clients modifying
> the filesystem at the same time, the rename_lock does not help. That's why user space
> code Client::get_quota_root() checks dentry lease and does lookup parent. I’m not sure
> if we can do the same operations in kernel, because locking is much more complex in
> kernel.

So, you're saying that in addition to using the rename_lock (for local
renames), that loop will also need to do something similar to what's
being done already in function ceph_d_revalidate.  I.e., it needs to
validate the lease (as in function dentry_lease_is_valid) and send a
CEPH_MDS_OP_LOOKUP if a dentry is invalid.  Or am I missing something?

> For the long term, I prefer unifying quota and snapshot implementation. The inode
> trace in MClientReply contains information about which quota realm the inode belongs
> to. So client can find quota information easily. (This requires bigger change for both
> mds and client)

My motivation for trying to bring the kernel client a bit closer to
the fuse client was that there are currently valid use-cases for this
quota implementation, with all its limitations.

Now, I completely agree that ideally the core quota implementation
should be moved to the MDS.  This would simplify the clients side,
and, above all, would remove the limitation of requiring clients
cooperation.

Obviously, I would be more than happy to help on the kernel client
side of this solution.  But I'm afraid that the real hard work would
be on the MDS code, where things such as multi-MDS and dir
fragmentation would make this solution quite complex.

Cheers,
-- 
Luís
