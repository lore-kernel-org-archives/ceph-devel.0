From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] ceph: don't set req->r_locked_dir in ceph_d_revalidate
Date: Mon, 05 Dec 2016 06:47:26 -0500
Message-ID: <1480938446.2544.4.camel@redhat.com>
References: <1480697536-10107-1-git-send-email-jlayton@redhat.com>
         <415F6BA5-3FA3-45FD-A709-C438B4EACE3C@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34935 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbcLELra (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2016 06:47:30 -0500
Received: by mail-qt0-f174.google.com with SMTP id c47so310847921qtc.2
        for <ceph-devel@vger.kernel.org>; Mon, 05 Dec 2016 03:47:30 -0800 (PST)
In-Reply-To: <415F6BA5-3FA3-45FD-A709-C438B4EACE3C@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, donatas.abraitis@gmail.com, viro@zeniv.linux.org.uk

On Mon, 2016-12-05 at 10:28 +0800, Yan, Zheng wrote:
> > 
> > On 3 Dec 2016, at 00:52, Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > This function sets req->r_locked_dir which is supposed to indicate to
> > ceph_fill_trace that the parent's i_rwsem is locked for write.
> > Unfortunately, there is no guarantee that the dir will be locked when
> > d_revalidate is called, so we really don't want ceph_fill_trace to do
> > any dcache manipulation from this context. Clear req->r_locked_dir since
> > it's clearly not safe to do that.
> > 
> > What we really want to know with d_revalidate is whether the dentry
> > still points to the same inode. ceph_fill_trace installs a pointer to
> > the inode in req->r_target_inode, so we can just compare that to
> > d_inode(dentry) to see if it's the same one after the lookup.
> > 
> > Also, since we aren't generally interested in the parent here, we can
> > switch to using a GETATTR to hint that to the MDS, which also means that
> > we only need to reserve one cap.
> > 
> > Finally, just remove the d_unhashed check. That's really outside the
> > purview of a filesystem's d_revalidate. If the thing became unhashed
> > while we're checking it, then that's up to the VFS to handle anyway.
> > 
> > Fixes: 200fd27c8fa2 (ceph: use lookup request to revalidate dentry)
> > Reported-by: Donatas Abraitis <donatas.abraitis@gmail.com>
> > Cc: stable@vger.kernel.org # v4.6+
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> > fs/ceph/dir.c | 24 ++++++++++++++----------
> > 1 file changed, 14 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index 78180d151730..a594c7879cc2 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -1261,26 +1261,30 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
> > 			return -ECHILD;
> > 
> > 		op = ceph_snap(dir) == CEPH_SNAPDIR ?
> > -			CEPH_MDS_OP_LOOKUPSNAP : CEPH_MDS_OP_LOOKUP;
> > +			CEPH_MDS_OP_LOOKUPSNAP : CEPH_MDS_OP_GETATTR;
> > 		req = ceph_mdsc_create_request(mdsc, op, USE_ANY_MDS);
> > 		if (!IS_ERR(req)) {
> > 			req->r_dentry = dget(dentry);
> > -			req->r_num_caps = 2;
> > +			req->r_num_caps = op == CEPH_MDS_OP_GETATTR ? 1 : 2;
> > 
> > 			mask = CEPH_STAT_CAP_INODE | CEPH_CAP_AUTH_SHARED;
> > 			if (ceph_security_xattr_wanted(dir))
> > 				mask |= CEPH_CAP_XATTR_SHARED;
> > 			req->r_args.getattr.mask = mask;
> > 
> > -			req->r_locked_dir = dir;
> > 			err = ceph_mdsc_do_request(mdsc, NULL, req);
> > -			if (err == 0 || err == -ENOENT) {
> > -				if (dentry == req->r_dentry) {
> > -					valid = !d_unhashed(dentry);
> > -				} else {
> > -					d_invalidate(req->r_dentry);
> > -					err = -EAGAIN;
> > -				}
> > +			switch (err) {
> > +			case 0:
> > +				if (d_really_is_positive(dentry) &&
> > +				    d_inode(dentry) == req->r_target_inode)
> > +					valid = 1;
> > +				break;
> > +			case -ENOENT:
> > +				if (d_really_is_negative(dentry))
> > +					valid = 1;
> > +				/* Fallthrough */
> > +			default:
> > +				break;
> > 			}
> > 			ceph_mdsc_put_request(req);
> > 			dout("d_revalidate %p lookup result=%d\n”,
> 
> Looks good. As we discussed, please write a patch that guarantees safe access to d_parent when parent is not locked.
> (__choose_mds, build_dentry_path and probably ceph_encode_dentry_release)
> 
> Regards
> Yan, Zheng
> 

Thanks. I'll add your Reviewed-by and merge it into ceph-client.git if
that's ok.

The issue with parent stability while walking back up the tree is a
bigger problem, but is separate from this one. I'm still looking at
that...

-- 
Jeff Layton <jlayton@redhat.com>
