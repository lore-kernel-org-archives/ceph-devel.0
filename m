From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: [PATCH] ceph: fix memory leak in async readpages
Date: Mon, 24 Oct 2011 16:28:08 +0800
Message-ID: <1319444888.4473.9.camel@cephclient0>
References: <20110928181954.GA18512@rd.bbc.co.uk>
	 <Pine.LNX.4.64.1109281133330.13650@cobra.newdream.net>
	 <Pine.LNX.4.64.1109281215280.13650@cobra.newdream.net>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:26659 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753477Ab1JXIdg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2011 04:33:36 -0400
In-Reply-To: <Pine.LNX.4.64.1109281215280.13650@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: David Flynn <davidf@rd.bbc.co.uk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi ,

start_read() do twice "kfree(pages)",

................
 out_pages:
        ceph_release_page_vector(pages, nr_pages);
        kfree(pages);


ceph_release_page_vector had kfree pages, continue to do kfree(pages),
sometimes ,async read ,printk "BUG kmalloc-16: Object already
free" ,then OOPS.

Jeff Wu

----------------------------------------------------------------------
void ceph_release_page_vector(struct page **pages, int num_pages)
{
	int i;

	for (i = 0; i < num_pages; i++)
		__free_pages(pages[i], 0);
	kfree(pages);
}


$ git diff
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 5ffee90..4144caf 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -345,7 +345,6 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 
 out_pages:
        ceph_release_page_vector(pages, nr_pages);
-       kfree(pages);
 out:
        ceph_osdc_put_request(req);
        return ret;


On Thu, 2011-09-29 at 03:16 +0800, Sage Weil wrote:
> On Wed, 28 Sep 2011, Sage Weil wrote:
> > I'll send this upstream with the other patches so it'll hopefully make 
> > 3.1...
> 
> Er, not really.. this'll go upstream during the next merge window, along 
> with the readahead code.  :)
> 
> sage
> 
> 
> > 
> > Thanks!
> > sage
> > 
> > 
> > On Wed, 28 Sep 2011, David Flynn wrote:
> > 
> > > The finish_read callback introduced in 63c90314546c1cec1f220f6ab24ea
> > > fails to release the page list allocated in start_read.
> > > ---
> > >  fs/ceph/addr.c |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > > index e06a322..4144caf 100644
> > > --- a/fs/ceph/addr.c
> > > +++ b/fs/ceph/addr.c
> > > @@ -261,6 +261,7 @@ static void finish_read(struct ceph_osd_request *req, struct ceph_msg *msg)
> > >  		unlock_page(page);
> > >  		page_cache_release(page);
> > >  	}
> > > +	kfree(req->r_pages);
> > >  }
> > >  
> > >  /*
> > > -- 
> > > 1.7.4.1
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

