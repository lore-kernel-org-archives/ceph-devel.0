Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1442F7F1F;
	Mon,  3 Aug 2026 02:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785722817; cv=none; b=HhE9QzybldWqJ+JP4R5pFqYOQyE7UVwo90RWXuknAAmAiQAIkuARJiXWllBdFedyeM6g1kwKd+rd2BHSG302OZ6QHc7x8Qltv2G1qzrNBoEkU1MLVwLiATNMHS4a74C/yrAw3PGDX8Jws0SCzWDMrdXxi1M7AtXms/z194RsLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785722817; c=relaxed/simple;
	bh=ux3no57IkA5oZi3iACfcUhJtCL00glkyC6aOm1UdhGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sf0hLnLYbFNdA8Z1/iIoHuAAzxY07CBkFaBIHe0pCBYDerXiM9t3QuZ6fmYweRR30/0b24CbfAdCToYeiJJ6e+M7lI77OmHIddCfbRThCDKlnNJan09wrKtxqeFRSzX1T3HDDaksAqQv6yj8AKYHQfWzKzTAMFS/h6/7BsOskxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vOC3V1kj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vOC3V1kj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vAtto6COYpowGn7w8xEz/ATwLur92gvwTqS/9hGpRTs=; b=vOC3V1kj1md7BOyGrPCz6hcIlv
	ciInho3Qww7CYBFz9ZhzGnt28wUH61GKPzt2YqnvWtLF28Q3VhwAAvwe7SYmKgV6kyuuuTluxeK/v
	xMsiQbQSvDjYtLT6gvSFGNpeXn3Ut62n7C4zKXkTwithA+Y1fLbLJFeSL2rSQ3hih7D07ICb4l29T
	qidI70jz9YMXBdEXpcGTxxq+QKH4Pxw/pAujdhSgPQWeUBLB+BpJ0j1/ANI1PiwjY6zpScj9bH+mb
	5+PCwgcsP5S15rNoeixaXQpq+DR7cyUeg1mFXUqMod8Spu16XjKClg/FoihZGIVOha75UM1hVJHoI
	w65rKB9w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqi4R-00000000G7T-1IcH;
	Mon, 03 Aug 2026 02:06:27 +0000
Date: Mon, 3 Aug 2026 03:06:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] ceph: remove page_snap_context()
Message-ID: <am_3oyOJAoFeBFTC@casper.infradead.org>
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
 <20260802-remove-wait-on-page-writeback-v1-4-6c35d6b3ad36@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-remove-wait-on-page-writeback-v1-4-6c35d6b3ad36@columbia.edu>

On Sun, Aug 02, 2026 at 12:50:05PM -0400, Tal Zussman wrote:
> Convert the final caller in get_writepages_data_length() to use a folio
> and ceph_folio_snap_context(), then remove page_snap_context().
> 
> This drops the last open-coded use of page->private in ceph's writeback
> path.

This one I'm deeply conflicted about.  It's adding an extra call to
compound_head() ... and we're not getting much for it.

I'd feel better about it if it started with::

 static u64 get_writepages_data_length(struct inode *inode,
                                       struct page *page, u64 start)
 {
+	struct folio *folio = page_folio(page);

and then we had a ceph_fscrypt_pagecache_folio() function and
ceph_fscrypt_folio_offset() (we already have a fscrypt_is_bounce_page())

That way we'd have this function entirely converted except for its
argument, and a future patch can do the conversion with little fuss.
And we'd get rid of one of the four remaining calls to
fscrypt_is_bounce_page()

> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/ceph/addr.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index f4aaf9a5f196..702cf5fc1eab 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -29,9 +29,9 @@
>   *
>   * There are a few funny things going on here.
>   *
> - * The page->private field is used to reference a struct
> - * ceph_snap_context for _every_ dirty page.  This indicates which
> - * snapshot the page was logically dirtied in, and thus which snap
> + * The folio->private field is used to reference a struct
> + * ceph_snap_context for _every_ dirty folio.  This indicates which
> + * snapshot the folio was logically dirtied in, and thus which snap
>   * context needs to be associated with the osd write during writeback.
>   *
>   * Similarly, struct ceph_inode_info maintains a set of counters to
> @@ -68,13 +68,6 @@
>  static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned int len,
>  					struct folio **foliop, void **_fsdata);
>  
> -static inline struct ceph_snap_context *page_snap_context(struct page *page)
> -{
> -	if (PagePrivate(page))
> -		return (void *)page->private;
> -	return NULL;
> -}
> -
>  static inline struct ceph_snap_context *ceph_folio_snap_context(struct folio *folio)
>  {
>  	if (folio_test_private(folio))
> @@ -697,7 +690,7 @@ static u64 get_writepages_data_length(struct inode *inode,
>  	u64 end = i_size_read(inode);
>  	u64 ret;
>  
> -	snapc = page_snap_context(ceph_fscrypt_pagecache_page(page));
> +	snapc = ceph_folio_snap_context(page_folio(ceph_fscrypt_pagecache_page(page)));
>  	if (snapc != ci->i_head_snapc) {
>  		bool found = false;
>  		spin_lock(&ci->i_ceph_lock);
> 
> -- 
> 2.39.5
> 
