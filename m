From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] fs: Fix page_mkwrite off-by-one errors
Date: Wed, 18 Dec 2019 11:21:44 -0800
Message-ID: <20191218192144.GF32169@bombadil.infradead.org>
References: <20191218130935.32402-1-agruenba@redhat.com>
 <20191218185216.GA7497@magnolia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191218185216.GA7497@magnolia>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Jan Kara <jack@suse.cz>, Adrian Hunter <adrian.hunter@intel.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Andreas Gruenbacher <agruenba@redhat.com>, Sage Weil <sage@redhat.com>, Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@infradead.org>, Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org, Chao Yu <chao@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Artem Bityutskiy <dedekind1@gmail.com>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.or
List-Id: ceph-devel.vger.kernel.org

On Wed, Dec 18, 2019 at 10:52:16AM -0800, Darrick J. Wong wrote:
> > @@ -9016,13 +9016,11 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
> >  	ret = VM_FAULT_NOPAGE; /* make the VM retry the fault */
> >  again:
> >  	lock_page(page);
> > -	size = i_size_read(inode);
> >  
> > -	if ((page->mapping != inode->i_mapping) ||
> > -	    (page_start >= size)) {
> > -		/* page got truncated out from underneath us */
> > +	ret2 = page_mkwrite_check_truncate(page, inode);
> > +	if (ret2 < 0)
> >  		goto out_unlock;
> 
> ...here we try to return -EFAULT as vm_fault_t.  Notice how btrfs returns
> VM_FAULT_* values directly and never calls block_page_mkwrite_return?  I
> know dsterba acked this, but I cannot see how this is correct?

I think you misread it.  'ret2' is never returned; we'll end up returning
VM_FAULT_NOPAGE here.  Arguably it should be SIGBUS or something, but
I think retrying the fault will also end up giving a SIGBUS.

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
