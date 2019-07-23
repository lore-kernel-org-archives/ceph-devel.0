From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 0/4] Sleeping functions in invalid context bug fixes
Date: Tue, 23 Jul 2019 12:02:57 +0200
Message-ID: <CAOi1vP86qVeMV9hJPCP7sHfimMv08j-znSGyhcYdd1TC_Gn19A@mail.gmail.com>
References: <20190719143222.16058-1-lhenriques@suse.com> <ab5ccaa05994e2eef05bdb54510e6b017db2d807.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ab5ccaa05994e2eef05bdb54510e6b017db2d807.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis Henriques <lhenriques@suse.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Jul 19, 2019 at 5:20 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Fri, 2019-07-19 at 15:32 +0100, Luis Henriques wrote:
> > Hi,
> >
> > I'm sending three "sleeping function called from invalid context" bug
> > fixes that I had on my TODO for a while.  All of them are ceph_buffer_put
> > related, and all the fixes follow the same pattern: delay the operation
> > until the ci->i_ceph_lock is released.
> >
> > The first patch simply allows ceph_buffer_put to receive a NULL buffer so
> > that the NULL check doesn't need to be performed in all the other patches.
> > IOW, it's not really required, just convenient.
> >
> > (Note: maybe these patches should all be tagged for stable.)
> >
> > Luis Henriques (4):
> >   libceph: allow ceph_buffer_put() to receive a NULL ceph_buffer
> >   ceph: fix buffer free while holding i_ceph_lock in __ceph_setxattr()
> >   ceph: fix buffer free while holding i_ceph_lock in
> >     __ceph_build_xattrs_blob()
> >   ceph: fix buffer free while holding i_ceph_lock in fill_inode()
> >
> >  fs/ceph/caps.c              |  5 ++++-
> >  fs/ceph/inode.c             |  7 ++++---
> >  fs/ceph/snap.c              |  4 +++-
> >  fs/ceph/super.h             |  2 +-
> >  fs/ceph/xattr.c             | 19 ++++++++++++++-----
> >  include/linux/ceph/buffer.h |  3 ++-
> >  6 files changed, 28 insertions(+), 12 deletions(-)
>
> This all looks good to me. I'll plan to merge these into the testing
> branch soon, and tag them for stable.
>
> PS: On a related note (and more of a question for Ilya)...
>
> I'm wondering if we get any benefit from having our own ceph_kvmalloc
> routine. Why are we not better off using the stock kvmalloc routine
> instead? Forcing a vmalloc just because we've gone above 32k allocation
> doesn't seem like the right thing to do.

I don't remember off the top of my head and can't check right now.
Could be that kvmalloc() didn't exist back then.  I'll add that to my
TODO list.

Thanks,

                Ilya
