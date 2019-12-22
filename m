From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v3] fs: Fix page_mkwrite off-by-one errors
Date: Sat, 21 Dec 2019 20:59:56 -0500
Message-ID: <20191222015956.GA63378@mit.edu>
References: <20191218130935.32402-1-agruenba@redhat.com>
 <20191218185216.GA7497@magnolia>
 <CAHc6FU7vuiN4iCB3TthLaow+7c41UUS0MYEeiJ5b1iPStT=+sA@mail.gmail.com>
 <20191218192331.GA7473@magnolia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20191218192331.GA7473@magnolia>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Jan Kara <jack@suse.cz>, Adrian Hunter <adrian.hunter@intel.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Andreas Gruenbacher <agruenba@redhat.com>, Sage Weil <sage@redhat.com>, Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@infradead.org>, Ilya Dryomov <idryomov@gmail.com>, linux-ext4 <linux-ext4@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mtd@lists.infradead.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Dec 18, 2019 at 11:23:31AM -0800, Darrick J. Wong wrote:
> *OH*, because we're stuffing the value in ret2, not ret.  Ok, that makes
> more sense.  Er, I guess I don't mind pushing via iomap tree, but could
> we get some acks from Ted and any of the ceph maintainers?

Acked-by: Theodore Ts'o <tytso@mit.edu>

My only nit is the same one Jan raised, which is should
page_mkwrite_check_truncate() be an inline function?

			      	    - Ted
