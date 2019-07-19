From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 0/4] Sleeping functions in invalid context bug fixes
Date: Fri, 19 Jul 2019 11:20:34 -0400
Message-ID: <ab5ccaa05994e2eef05bdb54510e6b017db2d807.camel@kernel.org>
References: <20190719143222.16058-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190719143222.16058-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Fri, 2019-07-19 at 15:32 +0100, Luis Henriques wrote:
> Hi,
> 
> I'm sending three "sleeping function called from invalid context" bug
> fixes that I had on my TODO for a while.  All of them are ceph_buffer_put
> related, and all the fixes follow the same pattern: delay the operation
> until the ci->i_ceph_lock is released.
> 
> The first patch simply allows ceph_buffer_put to receive a NULL buffer so
> that the NULL check doesn't need to be performed in all the other patches.
> IOW, it's not really required, just convenient.
> 
> (Note: maybe these patches should all be tagged for stable.)
> 
> Luis Henriques (4):
>   libceph: allow ceph_buffer_put() to receive a NULL ceph_buffer
>   ceph: fix buffer free while holding i_ceph_lock in __ceph_setxattr()
>   ceph: fix buffer free while holding i_ceph_lock in
>     __ceph_build_xattrs_blob()
>   ceph: fix buffer free while holding i_ceph_lock in fill_inode()
> 
>  fs/ceph/caps.c              |  5 ++++-
>  fs/ceph/inode.c             |  7 ++++---
>  fs/ceph/snap.c              |  4 +++-
>  fs/ceph/super.h             |  2 +-
>  fs/ceph/xattr.c             | 19 ++++++++++++++-----
>  include/linux/ceph/buffer.h |  3 ++-
>  6 files changed, 28 insertions(+), 12 deletions(-)

This all looks good to me. I'll plan to merge these into the testing
branch soon, and tag them for stable.

PS: On a related note (and more of a question for Ilya)...

I'm wondering if we get any benefit from having our own ceph_kvmalloc
routine. Why are we not better off using the stock kvmalloc routine
instead? Forcing a vmalloc just because we've gone above 32k allocation
doesn't seem like the right thing to do.

PPS: I also wonder if we ought to put a might_sleep() in kvfree(). I
think that kfree generally doesn't, and I wonder how many uses of this
end up using kfree until memory ends up fragmented.
-- 
Jeff Layton <jlayton@kernel.org>
