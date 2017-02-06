From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v2 6/6] libceph: allow requests to return immediately on
 full conditions if caller wishes
Date: Mon, 06 Feb 2017 10:28:34 -0500
Message-ID: <1486394914.2712.2.camel@redhat.com>
References: <20170206132927.9219-1-jlayton@redhat.com>
         <20170206132927.9219-7-jlayton@redhat.com>
         <CAOi1vP_k0q0ff-BjTWYk8faJvRs4TNFgJO+XeovebvAM9Wtxfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36089 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753817AbdBFP2i (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2017 10:28:38 -0500
Received: by mail-qk0-f178.google.com with SMTP id 11so58210103qkl.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2017 07:28:37 -0800 (PST)
In-Reply-To: <CAOi1vP_k0q0ff-BjTWYk8faJvRs4TNFgJO+XeovebvAM9Wtxfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>

On Mon, 2017-02-06 at 15:09 +0100, Ilya Dryomov wrote:
> On Mon, Feb 6, 2017 at 2:29 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > Right now, cephfs will cancel any in-flight OSD write operations when a
> > new map comes in that shows the OSD or pool as full, but nothing
> > prevents new requests from stalling out after that point.
> > 
> > If the caller knows that it will want an immediate error return instead
> > of blocking on a full or at-quota error condition then allow it to set a
> > flag to request that behavior. Cephfs write requests will always set
> > that flag.
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> >  fs/ceph/addr.c             | 14 +++++++++-----
> >  fs/ceph/file.c             |  8 +++++---
> >  include/linux/ceph/rados.h |  1 +
> >  net/ceph/osd_client.c      |  6 ++++++
> >  4 files changed, 21 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 4547bbf80e4f..577fe6351de1 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1019,7 +1019,8 @@ static int ceph_writepages_start(struct address_space *mapping,
> >                                         offset, &len, 0, num_ops,
> >                                         CEPH_OSD_OP_WRITE,
> >                                         CEPH_OSD_FLAG_WRITE |
> > -                                       CEPH_OSD_FLAG_ONDISK,
> > +                                       CEPH_OSD_FLAG_ONDISK |
> > +                                       CEPH_OSD_FLAG_FULL_CANCEL,
> >                                         snapc, truncate_seq,
> >                                         truncate_size, false);
> >                 if (IS_ERR(req)) {
> > @@ -1030,7 +1031,8 @@ static int ceph_writepages_start(struct address_space *mapping,
> >                                                     CEPH_OSD_SLAB_OPS),
> >                                                 CEPH_OSD_OP_WRITE,
> >                                                 CEPH_OSD_FLAG_WRITE |
> > -                                               CEPH_OSD_FLAG_ONDISK,
> > +                                               CEPH_OSD_FLAG_ONDISK |
> > +                                               CEPH_OSD_FLAG_FULL_CANCEL,
> >                                                 snapc, truncate_seq,
> >                                                 truncate_size, true);
> >                         BUG_ON(IS_ERR(req));
> > @@ -1681,7 +1683,9 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
> >         req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
> >                                     ceph_vino(inode), 0, &len, 0, 1,
> >                                     CEPH_OSD_OP_CREATE,
> > -                                   CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
> > +                                   CEPH_OSD_FLAG_ONDISK |
> > +                                   CEPH_OSD_FLAG_WRITE |
> > +                                   CEPH_OSD_FLAG_FULL_CANCEL,
> >                                     NULL, 0, 0, false);
> >         if (IS_ERR(req)) {
> >                 err = PTR_ERR(req);
> > @@ -1699,7 +1703,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
> >         req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
> >                                     ceph_vino(inode), 0, &len, 1, 3,
> >                                     CEPH_OSD_OP_WRITE,
> > -                                   CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
> > +                                   CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_FULL_CANCEL,
> >                                     NULL, ci->i_truncate_seq,
> >                                     ci->i_truncate_size, false);
> >         if (IS_ERR(req)) {
> > @@ -1872,7 +1876,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
> >                 goto out_unlock;
> >         }
> > 
> > -       wr_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ACK;
> > +       wr_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_FULL_CANCEL;
> >         osd_req_op_init(wr_req, 0, CEPH_OSD_OP_CREATE, CEPH_OSD_OP_FLAG_EXCL);
> >         ceph_oloc_copy(&wr_req->r_base_oloc, &rd_req->r_base_oloc);
> >         ceph_oid_copy(&wr_req->r_base_oid, &rd_req->r_base_oid);
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index a91a4f1fc837..938dca02db7a 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -692,7 +692,7 @@ static void ceph_aio_retry_work(struct work_struct *work)
> > 
> >         req->r_flags =  CEPH_OSD_FLAG_ORDERSNAP |
> >                         CEPH_OSD_FLAG_ONDISK |
> > -                       CEPH_OSD_FLAG_WRITE;
> > +                       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_FULL_CANCEL;
> >         ceph_oloc_copy(&req->r_base_oloc, &orig_req->r_base_oloc);
> >         ceph_oid_copy(&req->r_base_oid, &orig_req->r_base_oid);
> > 
> > @@ -849,7 +849,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
> > 
> >                 flags = CEPH_OSD_FLAG_ORDERSNAP |
> >                         CEPH_OSD_FLAG_ONDISK |
> > -                       CEPH_OSD_FLAG_WRITE;
> > +                       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_FULL_CANCEL;
> >         } else {
> >                 flags = CEPH_OSD_FLAG_READ;
> >         }
> > @@ -1051,6 +1051,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
> >         flags = CEPH_OSD_FLAG_ORDERSNAP |
> >                 CEPH_OSD_FLAG_ONDISK |
> >                 CEPH_OSD_FLAG_WRITE |
> > +               CEPH_OSD_FLAG_FULL_CANCEL |
> >                 CEPH_OSD_FLAG_ACK;
> > 
> >         while ((len = iov_iter_count(from)) > 0) {
> > @@ -1549,7 +1550,8 @@ static int ceph_zero_partial_object(struct inode *inode,
> >                                         offset, length,
> >                                         0, 1, op,
> >                                         CEPH_OSD_FLAG_WRITE |
> > -                                       CEPH_OSD_FLAG_ONDISK,
> > +                                       CEPH_OSD_FLAG_ONDISK |
> > +                                       CEPH_OSD_FLAG_FULL_CANCEL,
> >                                         NULL, 0, 0, false);
> >         if (IS_ERR(req)) {
> >                 ret = PTR_ERR(req);
> > diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
> > index 5c0da61cb763..def43570a85a 100644
> > --- a/include/linux/ceph/rados.h
> > +++ b/include/linux/ceph/rados.h
> > @@ -401,6 +401,7 @@ enum {
> >         CEPH_OSD_FLAG_KNOWN_REDIR = 0x400000,  /* redirect bit is authoritative */
> >         CEPH_OSD_FLAG_FULL_TRY =    0x800000,  /* try op despite full flag */
> >         CEPH_OSD_FLAG_FULL_FORCE = 0x1000000,  /* force op despite full flag */
> > +       CEPH_OSD_FLAG_FULL_CANCEL = 0x2000000, /* cancel operation on full flag */
> 
> Is this a new flag?  This is the wire protocol and I don't see it in
> ceph.git.
> 
> I'll look at epoch_barrier and callback stuff later.
> 
> Thanks,
> 

Oof, ok. I thought those were kernel-internal flags. I missed that they
get encoded onto the wire.

Yeah, this is probably the wrong place to pass that flag in then. What
we really want is to pass this along to the request submission code, but
there is no need to pass this to the server.

I'll look at the code to see if there's a more suitable place for this
flag. Worst case, I'll just add a new bool to ceph_osd_request for this.

Thanks,
-- 
Jeff Layton <jlayton@redhat.com>
