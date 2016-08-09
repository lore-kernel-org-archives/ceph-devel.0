From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/5] xfs: Propagate dentry down to inode_change_ok()
Date: Tue, 9 Aug 2016 01:27:56 -0700
Message-ID: <20160809082756.GA11657@infradead.org>
References: <1470223689-17783-1-git-send-email-jack@suse.cz>
	<1470223689-17783-2-git-send-email-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xfs-bounces@oss.sgi.com>
Content-Disposition: inline
In-Reply-To: <1470223689-17783-2-git-send-email-jack@suse.cz>
List-Unsubscribe: <http://oss.sgi.com/mailman/options/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=unsubscribe>
List-Archive: <http://oss.sgi.com/pipermail/xfs>
List-Post: <mailto:xfs@oss.sgi.com>
List-Help: <mailto:xfs-request@oss.sgi.com?subject=help>
List-Subscribe: <http://oss.sgi.com/mailman/listinfo/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=subscribe>
Errors-To: xfs-bounces@oss.sgi.com
Sender: xfs-bounces@oss.sgi.com
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, xfs@oss.sgi.com, "Yan,
	Zheng" <zyan@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

> +static int
> +xfs_vn_change_ok(
> +	struct dentry	*dentry,
> +	struct iattr	*iattr)

Please don't use the _vn prefix for something that's not an
actual inode operation (and we should do a mess rename to 
_iop one day as well.)

> +int
> +xfs_vn_setattr_nonsize(
> +	struct dentry		*dentry,
> +	struct iattr		*iattr)

Same here.

_______________________________________________
xfs mailing list
xfs@oss.sgi.com
http://oss.sgi.com/mailman/listinfo/xfs
