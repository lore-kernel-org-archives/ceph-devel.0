From: Dzianis Huznou <dzianis_huznou@epam.com>
Subject: Re: [PATCH 1/2] No MDS mount error fix
Date: Mon, 9 Dec 2013 15:02:29 +0300
Message-ID: <1386590549.2091.1.camel@epbyminw3646.minsk.epam.com>
References: <1b8c4b9c49deb956e9d065b0677bfeaf17c968d2.1386442053.git.plageat90@gmail.com>
	 <CAAM7YAnZUWmRdB8+SV11688M+vR-oWxW5xYCUg1Cg1DmELZmqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from owamsq.epam.com ([217.21.63.37]:34550 "EHLO
	EVBYMINSA0102.epam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932532Ab3LIMSv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Dec 2013 07:18:51 -0500
In-Reply-To: <CAAM7YAnZUWmRdB8+SV11688M+vR-oWxW5xYCUg1Cg1DmELZmqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Mikhail Campos Guadamuz <plageat90@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 2013-12-07 at 21:59 +0800, Yan, Zheng wrote:
> On Sun, Dec 8, 2013 at 2:59 AM, Mikhail Campos Guadamuz
> <plageat90@gmail.com> wrote:
> > For http://tracker.ceph.com/issues/4386
> >
> > It determines situation, when a user is trying to mount CephFS
> > with no MDS present. Return ECOMM from
> > open_root_dentry which can be analyzed then by ceph.mount
> >
> > Signed-off-by: Mikhail Campos Guadamuz <plageat90@gmail.com>
> > ---
> >  fs/ceph/mdsmap.c            | 19 ++++++++++++++++---
> >  fs/ceph/super.c             | 10 +++++++++-
> >  include/linux/ceph/mdsmap.h |  1 +
> >  3 files changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> > index 132b64e..3a6ba8a 100644
> > --- a/fs/ceph/mdsmap.c
> > +++ b/fs/ceph/mdsmap.c
> > @@ -12,6 +12,20 @@
> >
> >  #include "super.h"
> >
> > +/*
> > + * count active mds's
> > + */
> > +int ceph_mdsmap_active_mds_count(struct ceph_mdsmap *m)
> > +{
> > +    int n = 0;
> > +    int i;
> > +
> > +    for(i = 0; i < m->m_max_mds; ++i)
> > +       if(m->m_info[i].state > 0)
> > +           ++n;
> > +
> > +    return  n;
> > +}
> >
> >  /*
> >   * choose a random mds that is "up" (i.e. has a state > 0), or -1.
> > @@ -26,9 +40,8 @@ int ceph_mdsmap_get_random_mds(struct ceph_mdsmap *m)
> >                 return 0;
> >
> >         /* count */
> > -       for (i = 0; i < m->m_max_mds; i++)
> > -               if (m->m_info[i].state > 0)
> > -                       n++;
> > +       n = ceph_mdsmap_active_mds_count(m);
> > +
> >         if (n == 0)
> >                 return -1;
> >
> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > index 6627b26..4d33d68 100644
> > --- a/fs/ceph/super.c
> > +++ b/fs/ceph/super.c
> > @@ -674,7 +674,15 @@ static struct dentry *open_root_dentry(struct ceph_fs_client *fsc,
> >         struct ceph_mds_request *req = NULL;
> >         int err;
> >         struct dentry *root;
> > -
> > +
> > +       /* check for mds*/
> > +       if( 0 == ceph_mdsmap_active_mds_count(mdsc->mdsmap) )
> > +       {
> > +           pr_info("active mds not found, possible not exist\n");
> > +           root = ERR_PTR( -ECOMM );
> > +           return root;
> > +       }
> 
> I think we should return error immediately only if there is no mds
> (mdsmap->m_max_mds == 0).  If there is inactive mds, we should stick
> to current behavior (wait until timeout). Furthermore please don't use
> uncommon error code ECOMM, use common error code such as EINVAL.
> 
> Regards
> Yan, Zheng
> 
> 
> > +
> >         /* open dir */
> >         dout("open_root_inode opening '%s'\n", path);
> >         req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR, USE_ANY_MDS);
> > diff --git a/include/linux/ceph/mdsmap.h b/include/linux/ceph/mdsmap.h
> > index 87ed09f..4d7d502 100644
> > --- a/include/linux/ceph/mdsmap.h
> > +++ b/include/linux/ceph/mdsmap.h
> > @@ -56,6 +56,7 @@ static inline bool ceph_mdsmap_is_laggy(struct ceph_mdsmap *m, int w)
> >         return false;
> >  }
> >
> > +extern int ceph_mdsmap_active_mds_count(struct ceph_mdsmap *m);
> >  extern int ceph_mdsmap_get_random_mds(struct ceph_mdsmap *m);
> >  extern struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end);
> >  extern void ceph_mdsmap_destroy(struct ceph_mdsmap *m);
> > --
> > 1.8.3.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I think we can't check mds presence by (mdsmap->m_max_mds == 0)
statement, because max_mds value does not strictly represent the number
of mds. For example, we have max_mds = 1 (by default) no matter have we
one mds or haven't. Is this a expected behavior?


