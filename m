From: David Sterba <dsterba@suse.cz>
Subject: Re: kernel BUG at fs/btrfs/inode.c:1163
Date: Wed, 19 Oct 2011 11:49:25 +0200
Message-ID: <20111019094925.GA29468@ds.suse.cz>
References: <4E9DDBB1.2050007@tuxadero.com>
Reply-To: dsterba@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45033 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772Ab1JSJt2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Oct 2011 05:49:28 -0400
Content-Disposition: inline
In-Reply-To: <4E9DDBB1.2050007@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org

On Tue, Oct 18, 2011 at 10:04:01PM +0200, Martin Mailand wrote:
> [28997.273289] ------------[ cut here ]------------
> [28997.282916] kernel BUG at fs/btrfs/inode.c:1163!

1119                 fi = btrfs_item_ptr(leaf, path->slots[0],
1120                                     struct btrfs_file_extent_item);
1121                 extent_type = btrfs_file_extent_type(leaf, fi);
1122
1123                 if (extent_type == BTRFS_FILE_EXTENT_REG ||
1124                     extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
...
1158                 } else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
1159                         extent_end = found_key.offset +
1160                                 btrfs_file_extent_inline_len(leaf, fi);
1161                         extent_end = ALIGN(extent_end, root->sectorsize);
1162                 } else {
1163                         BUG_ON(1);
1164                 }

rc10 kernel sources point to this, can you please verify it in your
sources? if it's really this one, that means that it's an unhandled
extent_type read from the b-tree leaf and could be a corruption. (the
value is directly obtained from file extent type item, line 1121)

It would be interesting what's the value of 'extent_type' at the time of
crash, if it's eg -1 that could point to a real bug, some unhandled
corner case in truncate, for example.

> [28997.507960] Call Trace:
> [28997.507960]  [<ffffffffa00903e0>] ? acls_after_inode_item+0xc0/0xc0 [btrfs]

... a corruption caused by overflow of xattrs/acls into inode item bytes?

As ceph stresses xattrs very well, I wouldn't be surprised by that.


david
