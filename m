From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] ceph: Add FScache support
Date: Wed, 03 Jul 2013 00:40:17 +0100
Message-ID: <3869.1372808417@warthog.procyon.org.uk>
References: <CANP1eJH9PU3wX8m9auNjHrRt=rQWKCMmnFjfQ+V4tSG7mBBoEg@mail.gmail.com> <20130629035155.GA7975@gmail.com> <CANP1eJGJ4eAn1BtXSnKLu5egDAtK5DFAX9S1nWtBFnbLKWDtJA@mail.gmail.com> <CANP1eJGouH+_FXEbaRsrqt1QMY5HEPj6bLV2Pw7LhY5v37Hapw@mail.gmail.com> <11954.1372792498@warthog.procyon.org.uk> <CANP1eJGQqiijOVsX+sz1WY6CwViYweh3fo0N0VUznmTGVQCJzQ@mail.gmail.com> <12577.1372793962@warthog.procyon.org.uk> <CANP1eJGqq0ocQQUS5sBsvdT35qADSMoFLC71uprt_qw7=Pphrg@mail.gmail.com> <1074.1372798161@warthog.procyon.org.uk>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24012 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445Ab3GBXk0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Jul 2013 19:40:26 -0400
In-Reply-To: <CANP1eJH9PU3wX8m9auNjHrRt=rQWKCMmnFjfQ+V4tSG7mBBoEg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: dhowells@redhat.com, ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, linux-cachefs@redhat.com


Okay, my analysis of the patch:

Looking at your index structure, ceph has per-fsid indices under the top
"ceph" index and then per-inode indices under those?  Are fsids universally
unique - or just for a given server/cell/whatever?

> +#ifdef CONFIG_CEPH_FSCACHE
> +	if (PageFsCache(page))
> +		ceph_invalidate_fscache_page(inode, page);
> +#endif

The PageFsCache() test here should be folded into the header file.  You
actually have a redundant test:

	+static inline void ceph_invalidate_fscache_page(struct inode *inode,
	+						struct page *page)
	+{
	+	if (ceph_inode(inode)->fscache == NULL)
	+		return;
	+
	+	if (PageFsCache(page))
	+		return __ceph_invalidate_fscache_page(inode, page);
	+}

> +#ifdef CONFIG_CEPH_FSCACHE
> +	/* Can we release the page from the cache? */
> +	if (PageFsCache(page) && ceph_release_fscache_page(page, g) == 0)
> +		return 0;
> +#endif

The PageFsCache() test here is also redundant as fscache_maybe_release_page()
also does it - though I acknowledge it does it after doing the "is this cookie
valid" test.  The reason I put that test first is that if CONFIG_FSCACHE=n
then the "is this cookie valid" test just evaluates immediately to false at
compile time.

> +void ceph_fscache_inode_get_cookie(struct inode *inode);

No such function?

> +static inline void ceph_fsxache_async_uncache_inode(struct inode* inode)

Misspelling?

> +static inline int ceph_readpage_from_fscache(struct inode *inode,
> +					     struct page *page)
> +{
> +	if (ceph_inode(inode)->fscache == NULL)
> +		return -ENOBUFS;
> +
> +	return __ceph_readpage_from_fscache(inode, page);
> +}

Looking at functions like this, if you wrap:

	ceph_inode(inode)->fscache

as, say:

	struct fscache_cookie *ceph_inode_cookie(struct inode *inode)
	{
	#ifdef CONFIG_CEPH_FSCACHE
		return ceph_inode(inode)->fscache;
	#else
		return NULL;
	#endif
	}

then you can get rid of a lot of cpp conditionals and just rely on gcc's
optimiser (see what I did in include/linux/fscache.h).  Note that anything in
fs/ceph/cache.c wouldn't need to use this.

>  static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
> ...
> +#ifdef CONFIG_CEPH_FSCACHE
> +		spin_lock(&ci->i_ceph_lock);
> +		ceph_fscache_register_inode_cookie(fsc, ci);
> +		spin_unlock(&ci->i_ceph_lock);
> +#endif

Ummm...  ceph_fscache_register_inode_cookie() calls fscache_acquire_cookie()
which allocates GFP_KERNEL and grabs fscache_addremove_sem.  You can't wrap
this call in a spinlock.  Do you use lockdep?

David
