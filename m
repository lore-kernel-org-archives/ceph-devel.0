From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH V2] fs:ceph: Remove unused variables in
 ceph_mdsmap_decode()
Date: Wed, 22 Jul 2020 11:59:12 -0400
Message-ID: <a2264c76c59e6bcb39acc7704fb169856d28f7b4.camel@kernel.org>
References: <20200722134604.3026-1-jiayang5@huawei.com>
         <CAOi1vP9kMKVTr4K0WzEpr1cjvguuH-gOy8vnOrMm3ELdiBfk_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgGVP7O (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:59:14 -0400
In-Reply-To: <CAOi1vP9kMKVTr4K0WzEpr1cjvguuH-gOy8vnOrMm3ELdiBfk_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Jia Yang <jiayang5@huawei.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 2020-07-22 at 15:53 +0200, Ilya Dryomov wrote:
> On Wed, Jul 22, 2020 at 3:39 PM Jia Yang <jiayang5@huawei.com> wrote:
> > Fix build warnings:
> > 
> > fs/ceph/mdsmap.c: In function ‘ceph_mdsmap_decode’:
> > fs/ceph/mdsmap.c:192:7: warning:
> > variable ‘info_cv’ set but not used [-Wunused-but-set-variable]
> > fs/ceph/mdsmap.c:177:7: warning:
> > variable ‘state_seq’ set but not used [-Wunused-but-set-variable]
> > fs/ceph/mdsmap.c:123:15: warning:
> > variable ‘mdsmap_cv’ set but not used [-Wunused-but-set-variable]
> > 
> > Use ceph_decode_skip_* instead of ceph_decode_*, because p is
> > increased in ceph_decode_*.
> > 
> > Signed-off-by: Jia Yang <jiayang5@huawei.com>
> > ---
> >  fs/ceph/mdsmap.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> > index 889627817e52..7455ba83822a 100644
> > --- a/fs/ceph/mdsmap.c
> > +++ b/fs/ceph/mdsmap.c
> > @@ -120,7 +120,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
> >         const void *start = *p;
> >         int i, j, n;
> >         int err;
> > -       u8 mdsmap_v, mdsmap_cv;
> > +       u8 mdsmap_v;
> >         u16 mdsmap_ev;
> > 
> >         m = kzalloc(sizeof(*m), GFP_NOFS);
> > @@ -129,7 +129,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
> > 
> >         ceph_decode_need(p, end, 1 + 1, bad);
> >         mdsmap_v = ceph_decode_8(p);
> > -       mdsmap_cv = ceph_decode_8(p);
> > +       ceph_decode_skip_8(p, end, bad);
> 
> Hi Jia,
> 
> The bounds are already checked in ceph_decode_need(), so using
> ceph_decode_skip_*() is unnecessary.  Just increment the position
> with *p += 1, staying consistent with ceph_decode_8(), which does
> not bounds check.
> 

I suggested using ceph_decode_skip_*, mostly just because it's more
self-documenting and I didn't think it that significant an overhead.
Just incrementing the pointer will also work too, of course.

While you're doing that though, please also make note of what would have
been decoded there too. So in this case, something like this is what I'd
suggest:

	*p += 1;	/* mdsmap_cv */

These sorts of comments are helpful later, esp. with a protocol like
ceph that continually has fields being deprecated.

> >         if (mdsmap_v >= 4) {
> >                u32 mdsmap_len;
> >                ceph_decode_32_safe(p, end, mdsmap_len, bad);
> > @@ -174,7 +174,6 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
> >                 u64 global_id;
> >                 u32 namelen;
> >                 s32 mds, inc, state;
> > -               u64 state_seq;
> >                 u8 info_v;
> >                 void *info_end = NULL;
> >                 struct ceph_entity_addr addr;
> > @@ -189,9 +188,8 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
> >                 info_v= ceph_decode_8(p);
> >                 if (info_v >= 4) {
> >                         u32 info_len;
> > -                       u8 info_cv;
> >                         ceph_decode_need(p, end, 1 + sizeof(u32), bad);
> > -                       info_cv = ceph_decode_8(p);
> > +                       ceph_decode_skip_8(p, end, bad);
> 
> Ditto.
> 
> >                         info_len = ceph_decode_32(p);
> >                         info_end = *p + info_len;
> >                         if (info_end > end)
> > @@ -210,7 +208,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
> >                 mds = ceph_decode_32(p);
> >                 inc = ceph_decode_32(p);
> >                 state = ceph_decode_32(p);
> > -               state_seq = ceph_decode_64(p);
> > +               ceph_decode_skip_64(p, end, bad);
> 
> Ditto.
> 
> Thanks,
> 
>                 Ilya

-- 
Jeff Layton <jlayton@kernel.org>
