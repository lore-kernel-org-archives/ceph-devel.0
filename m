From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/12] fs: export inode_to_bdi and use it in favor of
	mapping->backing_dev_info
Date: Mon, 12 Jan 2015 13:36:06 +0100
Message-ID: <20150112123606.GB29325@lst.de>
References: <1420739133-27514-1-git-send-email-hch@lst.de> <1420739133-27514-8-git-send-email-hch@lst.de> <20150111181651.GN25319@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20150111181651.GN25319@htj.dyndns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Sun, Jan 11, 2015 at 01:16:51PM -0500, Tejun Heo wrote:
> > +struct backing_dev_info *inode_to_bdi(struct inode *inode)
> >  {
> >  	struct super_block *sb = inode->i_sb;
> >  #ifdef CONFIG_BLOCK
> > @@ -75,6 +75,7 @@ static inline struct backing_dev_info *inode_to_bdi(struct inode *inode)
> >  #endif
> >  	return sb->s_bdi;
> >  }
> > +EXPORT_SYMBOL_GPL(inode_to_bdi);
> 
> This is rather trivial.  Maybe we wanna make this an inline function?

Without splitting backing-dev.h this leads recursive includes.  With
the split of that file in your series we could make it inline again.

Another thing I've through of would be to always dynamically allocate
bdis instead of embedding them.  This would stop the need to have
backing-dev.h included in blkdev.h and would greatly simply the filesystems
that allocated bdis on their own.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
