From: Jan Kara <jack@suse.cz>
Subject: [PATCH 0/5 v2 RESEND] fs: Avoid premature clearing of file capabilities
Date: Mon, 19 Sep 2016 17:30:54 +0200
Message-ID: <1474299059-14806-1-git-send-email-jack@suse.cz>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, xfs@oss.sgi.org, Dave Chinner <david@fromorbit.com>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
List-Id: ceph-devel.vger.kernel.org

Hello,

I'm resending the patches since Al did not respond to the series yet (I've
previously posted it in [1] on Aug 3. Al? If Al does not respond, can you
Andrew please feed to patches to Linus? Thanks.

This patch series is my attempt to fix an issue when user can clear capabilites
of arbitrary file he can look up for example by running chown on it (this got
assigned CVE-2015-1350). The problem is that we call security_inode_killpriv()
before checking permissions in inode_change_ok(). This patch set moves that
call into inode_change_ok() after permissions are checked - the only trouble is
that we need to give dentry instead of inode there and that is not completely
trivial in some cases - I'm still missing a review from Ceph people to verify I
didn't miss anything.

Anyway, I guess the changes are fine for merging. Al, you please merge the
patches? Thanks!

Changes since v1:
* Added acks for XFS and FUSE patches

								Honza

[1] https://www.spinics.net/lists/ceph-devel/msg31650.html
