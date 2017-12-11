From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] ceph: don't set st_dev to 0 for stat(2)
Date: Mon, 11 Dec 2017 07:42:04 -0500
Message-ID: <1512996124.3326.11.camel@redhat.com>
References: <20171211084758.3225-1-zyan@redhat.com>
         <1512993587.3326.5.camel@redhat.com>
         <09AD4813-3F08-4438-A55A-BDC0885C9646@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38583 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdLKMmH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Dec 2017 07:42:07 -0500
Received: by mail-qt0-f195.google.com with SMTP id d4so37983951qtj.5
        for <ceph-devel@vger.kernel.org>; Mon, 11 Dec 2017 04:42:06 -0800 (PST)
In-Reply-To: <09AD4813-3F08-4438-A55A-BDC0885C9646@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 2017-12-11 at 20:19 +0800, Yan, Zheng wrote:
> > On 11 Dec 2017, at 19:59, Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > On Mon, 2017-12-11 at 16:47 +0800, Yan, Zheng wrote:
> > > Zero st_dev confuses ls(1) code. it make 'ls -l' not print '+' sign
> > > for file/directory with ACL.
> > > 
> > > Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> > > ---
> > > fs/ceph/inode.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > > index c6ec5aa46100..b5529b0b77a6 100644
> > > --- a/fs/ceph/inode.c
> > > +++ b/fs/ceph/inode.c
> > > @@ -2244,7 +2244,7 @@ int ceph_getattr(const struct path *path, struct kstat *stat,
> > > 		if (ceph_snap(inode) != CEPH_NOSNAP)
> > > 			stat->dev = ceph_snap(inode);
> > > 		else
> > > -			stat->dev = 0;
> > > +			stat->dev = 1; /* the smallest snapid is 2 */
> > > 		if (S_ISDIR(inode->i_mode)) {
> > > 			if (ceph_test_mount_opt(ceph_sb_to_client(inode->i_sb),
> > > 						RBYTES))
> > 
> > This looks wrong to me.
> > 
> > This should be getting filled out with the value of the sb->s_dev field
> > in generic_fillattr. The right fix would be to ensure that that field
> > ends up with something valid in it, and that should be happening when we
> > call set_anon_super.
> > 
> > I think we need to understand why that isn't happening here.
> 
> I think the reason we set st_dev to snapid is to distinguish head inode from snapped inode. It avoids user programs (eg backup program) from recognizing snapped inode as the same as head inode. (We probably can allocate an anon super for each snapid we encountered)
> 

Yes, that would make more sense.

I'm not sure you need a separate sb for each one (though it would make a
lot of sense to do what NFS does here and create a shrinkable mount when
the fsid changes).

It may be sufficient to just call get_anon_bdev / free_anon_bdev to get
a unique device number, and then track them somehow.

-- 
Jeff Layton <jlayton@redhat.com>
