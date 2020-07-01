From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/4] libceph: refactor osdc request initialization
Date: Wed, 01 Jul 2020 14:24:31 -0400
Message-ID: <4b7f50556f879d8aa724fc6dc96edad577c00d85.camel@kernel.org>
References: <20200701155446.41141-1-jlayton@kernel.org>
         <20200701155446.41141-3-jlayton@kernel.org>
         <CAOi1vP-o16swX+oHd0Xj30jdTqYUUrm5Fk4O7rA2LwNBKne5QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgGASYd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:24:33 -0400
In-Reply-To: <CAOi1vP-o16swX+oHd0Xj30jdTqYUUrm5Fk4O7rA2LwNBKne5QQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 2020-07-01 at 20:08 +0200, Ilya Dryomov wrote:
> On Wed, Jul 1, 2020 at 5:54 PM Jeff Layton <jlayton@kernel.org> wrote:
> > Turn the request_init helper into a more full-featured initialization
> > routine that we can use to initialize an already-allocated request.
> > Make it a public and exported function so we can use it from ceph.ko.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  include/linux/ceph/osd_client.h |  4 ++++
> >  net/ceph/osd_client.c           | 28 +++++++++++++++-------------
> >  2 files changed, 19 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> > index 8d63dc22cb36..40a08c4e5d8d 100644
> > --- a/include/linux/ceph/osd_client.h
> > +++ b/include/linux/ceph/osd_client.h
> > @@ -495,6 +495,10 @@ extern struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *,
> > 
> >  extern void ceph_osdc_get_request(struct ceph_osd_request *req);
> >  extern void ceph_osdc_put_request(struct ceph_osd_request *req);
> > +void ceph_osdc_init_request(struct ceph_osd_request *req,
> > +                           struct ceph_osd_client *osdc,
> > +                           struct ceph_snap_context *snapc,
> > +                           unsigned int num_ops);
> > 
> >  extern int ceph_osdc_start_request(struct ceph_osd_client *osdc,
> >                                    struct ceph_osd_request *req,
> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > index 3cff29d38b9f..4ddf23120b1a 100644
> > --- a/net/ceph/osd_client.c
> > +++ b/net/ceph/osd_client.c
> > @@ -523,7 +523,10 @@ void ceph_osdc_put_request(struct ceph_osd_request *req)
> >  }
> >  EXPORT_SYMBOL(ceph_osdc_put_request);
> > 
> > -static void request_init(struct ceph_osd_request *req)
> > +void ceph_osdc_init_request(struct ceph_osd_request *req,
> > +                           struct ceph_osd_client *osdc,
> > +                           struct ceph_snap_context *snapc,
> > +                           unsigned int num_ops)
> >  {
> >         /* req only, each op is zeroed in osd_req_op_init() */
> >         memset(req, 0, sizeof(*req));
> > @@ -535,7 +538,13 @@ static void request_init(struct ceph_osd_request *req)
> >         INIT_LIST_HEAD(&req->r_private_item);
> > 
> >         target_init(&req->r_t);
> > +
> > +       req->r_osdc = osdc;
> > +       req->r_num_ops = num_ops;
> > +       req->r_snapid = CEPH_NOSNAP;
> > +       req->r_snapc = ceph_get_snap_context(snapc);
> >  }
> > +EXPORT_SYMBOL(ceph_osdc_init_request);
> > 
> >  /*
> >   * This is ugly, but it allows us to reuse linger registration and ping
> > @@ -563,12 +572,9 @@ static void request_reinit(struct ceph_osd_request *req)
> >         WARN_ON(kref_read(&reply_msg->kref) != 1);
> >         target_destroy(&req->r_t);
> > 
> > -       request_init(req);
> > -       req->r_osdc = osdc;
> > +       ceph_osdc_init_request(req, osdc, snapc, num_ops);
> >         req->r_mempool = mempool;
> > -       req->r_num_ops = num_ops;
> >         req->r_snapid = snapid;
> > -       req->r_snapc = snapc;
> >         req->r_linger = linger;
> >         req->r_request = request_msg;
> >         req->r_reply = reply_msg;
> > @@ -591,15 +597,11 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
> >                 BUG_ON(num_ops > CEPH_OSD_MAX_OPS);
> >                 req = kmalloc(struct_size(req, r_ops, num_ops), gfp_flags);
> >         }
> > -       if (unlikely(!req))
> > -               return NULL;
> > 
> > -       request_init(req);
> > -       req->r_osdc = osdc;
> > -       req->r_mempool = use_mempool;
> > -       req->r_num_ops = num_ops;
> > -       req->r_snapid = CEPH_NOSNAP;
> > -       req->r_snapc = ceph_get_snap_context(snapc);
> > +       if (likely(req)) {
> > +               req->r_mempool = use_mempool;
> > +               ceph_osdc_init_request(req, osdc, snapc, num_ops);
> > +       }
> > 
> >         dout("%s req %p\n", __func__, req);
> >         return req;
> 
> What is going to use ceph_osdc_init_request()?
> 
> Given that OSD request allocation is non-trivial, exporting a
> routine for initializing already allocated requests doesn't seem
> like a good idea.  How do you ensure that the OSD request to be
> initialized has enough room for passed num_ops?  What about calling
> this routine on a request that has already been initialized?
> None of these issues exist today...
> 

Oops, I put this one in the pile by mistake. We don't need this,
currently. I'll drop this patch from the series.

I've been working with dhowells' fscache rework and the exported helper
would be needed in the patches I have to wire that up to cephfs.
Basically we'll need to allocate a structure that contains both a
fscache request and an OSD request. If those come to fruition, then
we'll need something like this (and an updated way to handle freeing
those objects).

-- 
Jeff Layton <jlayton@kernel.org>
