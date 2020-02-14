From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH v4 0/9] ceph: add support for asynchronous directory operations
Date: Fri, 14 Feb 2020 10:10:28 +0800
Message-ID: <CAAM7YAn8MR4tO3Q5dKkYKhz-ubN7+_3Voj4dzXU3dTw=001PkA@mail.gmail.com>
References: <20200212172729.260752-1-jlayton@kernel.org> <CAAM7YAmz9U4TmBMNhFV+4xiDRNM5GVwhe94wZmedwp7g4RgFoQ@mail.gmail.com>
 <079aab73e6d189de419dce98057c687b734134fc.camel@kernel.org>
 <CAAM7YA=h-xR3WDYFkPw27mBiaYtPXRqyftvbg4LT3tzSm14TBw@mail.gmail.com> <cce1f6201480922cfb492b3099562baa2c89ab11.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44614 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgBNCKn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Feb 2020 21:10:43 -0500
Received: by mail-qt1-f193.google.com with SMTP id k7so5975008qth.11
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2020 18:10:41 -0800 (PST)
In-Reply-To: <cce1f6201480922cfb492b3099562baa2c89ab11.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, idridryomov@gmail.com, Sage Weil <sage@redhat.com>, Zheng Yan <zyan@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

On Thu, Feb 13, 2020 at 11:09 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2020-02-13 at 22:43 +0800, Yan, Zheng wrote:
> > On Thu, Feb 13, 2020 at 9:20 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > On Thu, 2020-02-13 at 21:05 +0800, Yan, Zheng wrote:
> > > > On Thu, Feb 13, 2020 at 1:29 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > I've dropped the async unlink patch from testing branch and am
> > > > > resubmitting it here along with the rest of the create patches.
> > > > >
> > > > > Zheng had pointed out that DIR_* caps should be cleared when the session
> > > > > is reconnected. The underlying submission code needed changes to
> > > > > handle that so it needed a bit of rework (along with the create code).
> > > > >
> > > > > Since v3:
> > > > > - rework async request submission to never queue the request when the
> > > > >   session isn't open
> > > > > - clean out DIR_* caps, layouts and delegated inodes when session goes down
> > > > > - better ordering for dependent requests
> > > > > - new mount options (wsync/nowsync) instead of module option
> > > > > - more comprehensive error handling
> > > > >
> > > > > Jeff Layton (9):
> > > > >   ceph: add flag to designate that a request is asynchronous
> > > > >   ceph: perform asynchronous unlink if we have sufficient caps
> > > > >   ceph: make ceph_fill_inode non-static
> > > > >   ceph: make __take_cap_refs non-static
> > > > >   ceph: decode interval_sets for delegated inos
> > > > >   ceph: add infrastructure for waiting for async create to complete
> > > > >   ceph: add new MDS req field to hold delegated inode number
> > > > >   ceph: cache layout in parent dir on first sync create
> > > > >   ceph: attempt to do async create when possible
> > > > >
> > > > >  fs/ceph/caps.c               |  73 +++++++---
> > > > >  fs/ceph/dir.c                | 101 +++++++++++++-
> > > > >  fs/ceph/file.c               | 253 +++++++++++++++++++++++++++++++++--
> > > > >  fs/ceph/inode.c              |  58 ++++----
> > > > >  fs/ceph/mds_client.c         | 156 +++++++++++++++++++--
> > > > >  fs/ceph/mds_client.h         |  17 ++-
> > > > >  fs/ceph/super.c              |  20 +++
> > > > >  fs/ceph/super.h              |  21 ++-
> > > > >  include/linux/ceph/ceph_fs.h |  17 ++-
> > > > >  9 files changed, 637 insertions(+), 79 deletions(-)
> > > > >
> > > >
> > > > Please implement something like
> > > > https://github.com/ceph/ceph/pull/32576/commits/e9aa5ec062fab8324e13020ff2f583537e326a0b.
> > > > MDS may revoke Fx when replaying unsafe/async requests. Make mds not
> > > > do this is quite complex.
> > > >
> > >
> > > I added this in reconnect_caps_cb in the latest set:
> > >
> > >         /* These are lost when the session goes away */
> > >         if (S_ISDIR(inode->i_mode)) {
> > >                 if (cap->issued & CEPH_CAP_DIR_CREATE) {
> > >                         ceph_put_string(rcu_dereference_raw(ci->i_cached_layout.pool_ns));
> > >                         memset(&ci->i_cached_layout, 0, sizeof(ci->i_cached_layout));
> > >                 }
> > >                 cap->issued &= ~(CEPH_CAP_DIR_CREATE|CEPH_CAP_DIR_UNLINK);
> > >         }
> > >
> >
> > It's not enough.  for async create/unlink, we need to call
> >
> > ceph_put_cap_refs(..., CEPH_CAP_FILE_EXCL | CEPH_CAP_DIR_FOO) to release caps
> >
>
> That sounds really wrong.
>
> The call holds references to these caps. We can't just drop them here,
> as we could be racing with reply handling.
>
> What exactly is the problem with waiting until r_callback fires to drop
> the references? We're clearing them out of the "issued" field in the
> cap, so we won't be handing out any new references. The fact that there
> are still outstanding references doesn't seem like it ought to cause any
> problem.
>

see https://github.com/ceph/ceph/pull/32576/commits/e9aa5ec062fab8324e13020ff2f583537e326a0b.

Also need to make r_callback not release cap refs if cap ref is
already release at reconnect.  The problem is that mds may want to
revoke Fx when replaying unsafe/async requests. (same reason that we
can't send getattr to fetch inline data while holding Fr cap)

> --
> Jeff Layton <jlayton@kernel.org>
>
