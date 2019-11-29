From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2] fs: Fix page_mkwrite off-by-one errors
Date: Fri, 29 Nov 2019 17:06:34 +0100
Message-ID: <20191129160634.GM2734@twin.jikos.cz>
References: <20191129142045.7215-1-agruenba@redhat.com>
Reply-To: dsterba@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191129142045.7215-1-agruenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Artem Bityutskiy <dedekind1@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, Chris Mason <clm@fb.com>
List-Id: ceph-devel.vger.kernel.org

On Fri, Nov 29, 2019 at 03:20:45PM +0100, Andreas Gruenbacher wrote:
> The check in block_page_mkwrite meant to determine whether an offset is
> within the inode size is off by one.  This bug has spread to
> iomap_page_mkwrite and to several filesystems (ubifs, ext4, f2fs, ceph).
> To fix that, introduce a new page_mkwrite_check_truncate helper that
> checks for truncate and computes the bytes in the page up to EOF, and
> use that helper in the above mentioned filesystems and in btrfs.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> 
> ---
> 
> This patch has a trivial conflict with commit "iomap: Fix overflow in
> iomap_page_mkwrite" in Darrick's iomap pull request for 5.5:
> 
>   https://lore.kernel.org/lkml/20191125190907.GN6219@magnolia/
> ---
>  fs/btrfs/inode.c        | 15 ++++-----------

For the btrfs part

Acked-by: David Sterba <dsterba@suse.com>

and reviewed that the change is equivalent.
