From: Jan Kara <jack@suse.cz>
Subject: [PATCH 0/5] fs: Avoid premature clearing of file capabilities
Date: Thu, 26 May 2016 18:19:55 +0200
Message-ID: <1464279600-13009-1-git-send-email-jack@suse.cz>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, xfs@oss.sgi.com, ceph-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
List-Id: ceph-devel.vger.kernel.org

Hello,

this patch series is my attempt to fix an issue when user can clear capabilites
of arbitrary file he can look up for example by running chown on it (this got
assigned CVE-2015-1350). The problem is that we call security_inode_killpriv()
before checking permissions in inode_change_ok(). This patch set moves
that call into inode_change_ok() after permissions are checked - the only
trouble is that we need to give dentry instead of inode there and that is
not completely trivial in some cases - I'd like to have a review from XFS,
Ceph, and FUSE people to verify I didn't miss anything. Anyway, have a look
how the result looks like...

								Honza
