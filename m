From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 2/2] cephfs: remove warning when ceph_releasepage() is
 called on dirty page.
Date: Wed, 31 Aug 2016 09:48:22 -0400
Message-ID: <1472651302.5795.6.camel@redhat.com>
References: <874m61eje0.fsf@notabene.neil.brown.name>
         <87y43dd4oe.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35648 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933390AbcHaNsZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Aug 2016 09:48:25 -0400
Received: by mail-qk0-f182.google.com with SMTP id v123so51347538qkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 31 Aug 2016 06:48:24 -0700 (PDT)
In-Reply-To: <87y43dd4oe.fsf@notabene.neil.brown.name>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: NeilBrown <neilb@suse.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 2016-08-31 at 12:59 +1000, NeilBrown wrote:
> If O_DIRECT writes are racing with buffered writes, then
> the call to invalidate_inode_pages2_range() can call ceph_releasepage()
> on dirty pages.
> 
> Most filesystems hold inode_lock() across O_DIRECT writes so they do not
> suffer this race, but cephfs deliberately drops the lock, and opens a window
> for the race.
> 
> This race can be triggered with the generic/036 test from the xfstests
> test suite.  It doesn't happen every time, but it does happen often.
> 
> As the possibilty is expected, remove the warning, and instead include
> the PageDirty() status in the debug message.
> 
> > Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  fs/ceph/addr.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index d5b6f959a3c3..f657da7d12ff 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -175,9 +175,8 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
>  
>  static int ceph_releasepage(struct page *page, gfp_t g)
>  {
> > -	dout("%p releasepage %p idx %lu\n", page->mapping->host,
> > -	     page, page->index);
> > -	WARN_ON(PageDirty(page));
> > +	dout("%p releasepage %p idx %lu (%sdirty)\n", page->mapping->host,
> > +	     page, page->index, PageDirty(page) ? "" : "not ");
>  
> >  	/* Can we release the page from the cache? */
> >  	if (!ceph_release_fscache_page(page, g))


Reviewed-by: Jeff Layton <jlayton@redhat.com>
