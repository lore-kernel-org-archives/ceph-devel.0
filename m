From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/5] fs: Give dentry to inode_change_ok() instead of inode
Date: Tue, 9 Aug 2016 01:28:28 -0700
Message-ID: <20160809082828.GB11657@infradead.org>
References: <1470223689-17783-1-git-send-email-jack@suse.cz>
 <1470223689-17783-5-git-send-email-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48316 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbcHII2c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2016 04:28:32 -0400
Content-Disposition: inline
In-Reply-To: <1470223689-17783-5-git-send-email-jack@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, xfs@oss.sgi.com, "Yan, Zheng" <zyan@redhat.com>, linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On Wed, Aug 03, 2016 at 01:28:08PM +0200, Jan Kara wrote:
> inode_change_ok() will be resposible for clearing capabilities and IMA
> extended attributes and as such will need dentry. Give it as an argument
> to inode_change_ok() instead of an inode. Also rename inode_change_ok()
> to setattr_prepare() to better relect that it does also some
> modifications in addition to checks.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
