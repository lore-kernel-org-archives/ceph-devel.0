From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: fix memory leak when reallocating pages array for
 writepages
Date: Mon, 27 Jul 2020 09:18:41 -0400
Message-ID: <ff6497016429a0ba962d97d6997427a5020ac6d4.camel@kernel.org>
References: <20200726122804.16008-1-jlayton@kernel.org>
         <3c8fb2aa-834b-a202-24b4-7eb29cd9b7c3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgG0NSn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:18:43 -0400
In-Reply-To: <3c8fb2aa-834b-a202-24b4-7eb29cd9b7c3@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org

On Mon, 2020-07-27 at 20:16 +0800, Xiubo Li wrote:
> On 2020/7/26 20:28, Jeff Layton wrote:
> > Once we've replaced it, we don't want to keep the old one around
> > anymore.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/ceph/addr.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 01ad09733ac7..01e167efa104 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1212,6 +1212,7 @@ static int ceph_writepages_start(struct address_space *mapping,
> >   			       locked_pages * sizeof(*pages));
> >   			memset(data_pages + i, 0,
> >   			       locked_pages * sizeof(*pages));
> 
> BTW， do we still need to memset() the data_pages ?
> 

Self-NAK on this patch...

Zheng pointed out that this array is actually freed by the request
handler after the submission. This loop is creating a new pages array
for a second request.

As far as whether we need to memset the end of the original array...I
don't think we do. It looks like the pointers at the end of the array
are ignored once you go past the length of the request. That said, it's
fairly cheap to do so, and I'm not inclined to change it, just in case
there is code that does look at those pointers.

> 
> > +			kfree(data_pages);
> >   		} else {
> >   			BUG_ON(num_ops != req->r_num_ops);
> >   			index = pages[i - 1]->index + 1;
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>
