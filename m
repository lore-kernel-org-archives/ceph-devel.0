From: Milosz Tanski <milosz@adfin.com>
Subject: Re: ceph: use fscache as a local presisent cache
Date: Thu, 10 Mar 2016 13:53:35 -0500
Message-ID: <CANP1eJGTTXHQZjqzzn345Q4FUsSvurVHb6ejRv_4M4f=vw77NA@mail.gmail.com>
References: <20160309085452.GA4085@mwanda>
	<CAAM7YAnOuxYuxEprfiwy522P2p0N=8DOebuYSo_UJCO+40zgag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33118 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbcCJSxh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2016 13:53:37 -0500
Received: by mail-lb0-f179.google.com with SMTP id k15so126514412lbg.0
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2016 10:53:36 -0800 (PST)
In-Reply-To: <CAAM7YAnOuxYuxEprfiwy522P2p0N=8DOebuYSo_UJCO+40zgag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Mar 9, 2016 at 10:26 PM, Yan, Zheng <ukernel@gmail.com> wrote:
>
> On Wed, Mar 9, 2016 at 4:54 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > [ Hm...  I don't know why this has suddenly started warning now only.
> >   This check doesn't warn if it knows that the NULL check is not
> >   needed so potentially that was what prevented the warning before?
> >   -dan ]
> >
> > Hello Milosz Tanski,
> >
> > This is a semi-automatic email about new static checker warnings.
> >
> > The patch 99ccbd229cf7: "ceph: use fscache as a local presisent
> > cache" from Aug 21, 2013, leads to the following Smatch complaint:
> >
> > fs/ceph/addr.c:183 ceph_releasepage()
> >          error: we previously assumed 'page->mapping' could be null (see line 178)
> >
> > fs/ceph/addr.c
> >    177  {
> >    178          struct inode *inode = page->mapping ? page->mapping->host : NULL;
> >                                       ^^^^^^^^^^^^^
> > Check for NULL.
>
> page->mapping can not be NULL in this case.  I will remove the check


Thanks Yan. And sorry I just noticed the email now.

>
>
>
> Regards
> Yan, Zheng
>
> >
> >    179          dout("%p releasepage %p idx %lu\n", inode, page, page->index);
> >    180          WARN_ON(PageDirty(page));
> >    181
> >    182          /* Can we release the page from the cache? */
> >    183          if (!ceph_release_fscache_page(page, g))
> >                                                ^^^^
> > The patch adds a dereference inside the function call.
> >
> >    184                  return 0;
> >    185
> >
> > regards,
> > dan carpenter
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html




-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
