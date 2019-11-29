From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2] fs: Fix page_mkwrite off-by-one errors
Date: Fri, 29 Nov 2019 17:35:53 +0100 (CET)
Message-ID: <51833696.101442.1575045353332.JavaMail.zimbra@nod.at>
References: <20191129142045.7215-1-agruenba@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191129142045.7215-1-agruenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Darrick <darrick.wong@oracle.com>, torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, tytso <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd <linux-mtd@lists.infradead.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpan>
List-Id: ceph-devel.vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Andreas Gruenbacher" <agruenba@redhat.com>
> An: "Christoph Hellwig" <hch@infradead.org>, "Darrick" <darrick.wong@oracle.com>
> CC: "Andreas Gruenbacher" <agruenba@redhat.com>, "torvalds" <torvalds@linux-foundation.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Jeff Layton" <jlayton@kernel.org>, "Sage Weil"
> <sage@redhat.com>, "Ilya Dryomov" <idryomov@gmail.com>, "tytso" <tytso@mit.edu>, "Andreas Dilger"
> <adilger.kernel@dilger.ca>, "Jaegeuk Kim" <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>, linux-xfs@vger.kernel.org,
> "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "richard" <richard@nod.at>, "Artem Bityutskiy" <dedekind1@gmail.com>,
> "Adrian Hunter" <adrian.hunter@intel.com>, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
> linux-f2fs-devel@lists.sourceforge.net, "linux-mtd" <linux-mtd@lists.infradead.org>, "Chris Mason" <clm@fb.com>, "Josef
> Bacik" <josef@toxicpanda.com>, "David Sterba" <dsterba@suse.com>, "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Gesendet: Freitag, 29. November 2019 15:20:45
> Betreff: [PATCH v2] fs: Fix page_mkwrite off-by-one errors

> The check in block_page_mkwrite meant to determine whether an offset is
> within the inode size is off by one.  This bug has spread to
> iomap_page_mkwrite and to several filesystems (ubifs, ext4, f2fs, ceph).
> To fix that, introduce a new page_mkwrite_check_truncate helper that
> checks for truncate and computes the bytes in the page up to EOF, and
> use that helper in the above mentioned filesystems and in btrfs.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Thank you for fixing UBIFS!

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
