From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] ceph: Add FScache support
Date: Tue, 09 Jul 2013 11:33:44 +0100
Message-ID: <6424.1373366024@warthog.procyon.org.uk>
References: <CANP1eJG1=58P70-j0GH=iS_0a6_0mWDFeg0e4batRN9_caYz_w@mail.gmail.com> <20130629035155.GA7975@gmail.com> <CANP1eJGJ4eAn1BtXSnKLu5egDAtK5DFAX9S1nWtBFnbLKWDtJA@mail.gmail.com> <CANP1eJGouH+_FXEbaRsrqt1QMY5HEPj6bLV2Pw7LhY5v37Hapw@mail.gmail.com> <11954.1372792498@warthog.procyon.org.uk> <CANP1eJGQqiijOVsX+sz1WY6CwViYweh3fo0N0VUznmTGVQCJzQ@mail.gmail.com> <12577.1372793962@warthog.procyon.org.uk> <CANP1eJGqq0ocQQUS5sBsvdT35qADSMoFLC71uprt_qw7=Pphrg@mail.gmail.com> <1074.1372798161@warthog.procyon.org.uk> <CANP1eJH9PU3wX8m9auNjHrRt=rQWKCMmnFjfQ+V4tSG7mBBoEg@mail.gmail.com> <3869.1372808417@warthog.procyon.org.uk> <CANP1eJFQgoLBjZ7-vCTzRb62H2P6hX5ZD8u2XyMQAjwZtFJDJQ@mail.gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60821 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611Ab3GIKdx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Jul 2013 06:33:53 -0400
In-Reply-To: <CANP1eJG1=58P70-j0GH=iS_0a6_0mWDFeg0e4batRN9_caYz_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>, Trond.Myklebust@netapp.com
Cc: dhowells@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, linux-cachefs@redhat.com

Milosz Tanski <milosz@adfin.com> wrote:

> It looks like both the cifs and NFS code do not bother with any
> locking around cifs_fscache_set_inode_cookie. Is there no concern over
> multiple open() calls racing to create the cookie in those
> filesystems?

Yeah...  That's probably wrong.  AFS obviates the need for special locking by
doing it in afs_iget().

Hmmm...  I think I've just spotted what might be the cause of pages getting
marked PG_fscache whilst belonging to the allocator.

	void nfs_fscache_set_inode_cookie(struct inode *inode, struct file *filp)
	{
		if (NFS_FSCACHE(inode)) {
			nfs_fscache_inode_lock(inode);
			if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
				nfs_fscache_disable_inode_cookie(inode);
			else
				nfs_fscache_enable_inode_cookie(inode);
			nfs_fscache_inode_unlock(inode);
		}
	}

can release the cookie whilst reads are in progress on it when an inode being
read suddenly changes to an inode being written.  We need some sort of
synchronisation on that there.

David
