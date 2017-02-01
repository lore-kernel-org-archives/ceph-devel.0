From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v2 01/13] ceph: add new r_req_flags field to
 ceph_mds_request
Date: Wed, 01 Feb 2017 12:47:10 -0500
Message-ID: <1485971230.20965.1.camel@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
         <20170201114914.20808-1-jlayton@redhat.com>
         <20170201114914.20808-2-jlayton@redhat.com>
         <CAOi1vP9hGnsqVMnZV7RO7f4AQUEFsnD0VeuAcumTOcQu2sZ8+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33533 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753103AbdBARrU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2017 12:47:20 -0500
Received: by mail-qt0-f180.google.com with SMTP id v23so275982434qtb.0
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2017 09:47:14 -0800 (PST)
In-Reply-To: <CAOi1vP9hGnsqVMnZV7RO7f4AQUEFsnD0VeuAcumTOcQu2sZ8+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>

On Wed, 2017-02-01 at 15:08 +0100, Ilya Dryomov wrote:
> On Wed, Feb 1, 2017 at 12:49 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > ...and start moving bool flags into it.
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> >  fs/ceph/dir.c        | 2 +-
> >  fs/ceph/mds_client.c | 2 +-
> >  fs/ceph/mds_client.h | 4 +++-
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index d4385563b70a..04fa4ae3deca 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -371,7 +371,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
> >                 /* hints to request -> mds selection code */
> >                 req->r_direct_mode = USE_AUTH_MDS;
> >                 req->r_direct_hash = ceph_frag_value(frag);
> > -               req->r_direct_is_hash = true;
> > +               set_bit(CEPH_MDS_R_DIRECT_IS_HASH, &req->r_req_flags);
> 
> Hi Jeff,
> 
> Just a couple of nits:
> 
> These are atomic -- should probably mention in the commit message why
> is atomicity needed.
> 

It's not strictly needed for most of this stuff. DIRECT_IS_HASH in
particular could just use __set_bit.

The rest of the flags, I think are already protected from concurrent
writes by mutexes in the code. What I'm not sure of is whether they are
protected by the _same_ lock. That's a requirement if we mix all of the
flags together into the same word and don't want to use the atomic
*_bit macros.

I can look and see if that's possible. Even if it's not though, using
the atomic *_bit macros is generally not that expensive (particularly
in a situation where we're already using sleeping locks anyway).

> >                 if (fi->last_name) {
> >                         req->r_path2 = kstrdup(fi->last_name, GFP_KERNEL);
> >                         if (!req->r_path2) {
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 176512960b14..1f2ef02832d9 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -705,7 +705,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
> >         int mode = req->r_direct_mode;
> >         int mds = -1;
> >         u32 hash = req->r_direct_hash;
> > -       bool is_hash = req->r_direct_is_hash;
> > +       bool is_hash = test_bit(CEPH_MDS_R_DIRECT_IS_HASH, &req->r_req_flags);
> > 
> >         /*
> >          * is there a specific mds we should try?  ignore hint if we have
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index 3c6f77b7bb02..a58cacccc986 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -205,6 +205,9 @@ struct ceph_mds_request {
> >         struct inode *r_locked_dir; /* dir (if any) i_mutex locked by vfs */
> >         struct inode *r_target_inode;       /* resulting inode */
> > 
> > +#define CEPH_MDS_R_DIRECT_IS_HASH      (1) /* r_direct_hash is valid */
> 
> Why parens?
> 

Habit. I think we can safely remove them here.

> > +       unsigned long   r_req_flags;
> > +
> >         struct mutex r_fill_mutex;
> > 
> >         union ceph_mds_request_args r_args;
> > @@ -216,7 +219,6 @@ struct ceph_mds_request {
> >         /* for choosing which mds to send this request to */
> >         int r_direct_mode;
> >         u32 r_direct_hash;      /* choose dir frag based on this dentry hash */
> > -       bool r_direct_is_hash;  /* true if r_direct_hash is valid */
> > 
> >         /* data payload is used for xattr ops */
> >         struct ceph_pagelist *r_pagelist;
> 
> 3, 4, 5 and 6 can be merged into this patch, IMO.  They are trivial and
> some change the same if statement over and over again.
> 

Sure. I did it this way as that's how I put it together, but they can
definitely be squashed together. I'll plan to do that before the next
posting or before merging into testing branch.

-- 
Jeff Layton <jlayton@redhat.com>
