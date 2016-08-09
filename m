From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/5] fs: Avoid premature clearing of capabilities
Date: Tue, 9 Aug 2016 01:29:12 -0700
Message-ID: <20160809082912.GC11657@infradead.org>
References: <1470223689-17783-1-git-send-email-jack@suse.cz>
	<1470223689-17783-6-git-send-email-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xfs-bounces@oss.sgi.com>
Content-Disposition: inline
In-Reply-To: <1470223689-17783-6-git-send-email-jack@suse.cz>
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

On Wed, Aug 03, 2016 at 01:28:09PM +0200, Jan Kara wrote:
> Currently, notify_change() clears capabilities or IMA attributes by
> calling security_inode_killpriv() before calling into ->setattr. Thus it
> happens before any other permission checks in inode_change_ok() and user
> is thus allowed to trigger clearing of capabilities or IMA attributes
> for any file he can look up e.g. by calling chown for that file. This is
> unexpected and can lead to user DoSing a system.
> 
> Fix the problem by calling security_inode_killpriv() at the end of
> inode_change_ok() instead of from notify_change(). At that moment we are
> sure user has permissions to do the requested change.

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
xfs mailing list
xfs@oss.sgi.com
http://oss.sgi.com/mailman/listinfo/xfs
