From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v4 5/6] Revert "ceph: SetPageError() for writeback pages
 if writepages fails"
Date: Fri, 10 Feb 2017 06:53:42 -0500
Message-ID: <1486727622.4233.8.camel@redhat.com>
References: <20170209144836.12525-1-jlayton@redhat.com>
         <20170209144836.12525-6-jlayton@redhat.com>
         <D37683D2-E73B-486C-BE6B-14DD65172700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:35278 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbdBJLz3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2017 06:55:29 -0500
Received: by mail-qt0-f177.google.com with SMTP id x49so31922238qtc.2
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2017 03:53:44 -0800 (PST)
In-Reply-To: <D37683D2-E73B-486C-BE6B-14DD65172700@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>

On Fri, 2017-02-10 at 19:22 +0800, Yan, Zheng wrote:
> > On 9 Feb 2017, at 22:48, Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > This reverts commit b109eec6f4332bd517e2f41e207037c4b9065094.
> > 
> > If I'm filling up a filesystem with this sort of command:
> > 
> >    $ dd if=/dev/urandom of=/mnt/cephfs/fillfile bs=2M oflag=sync
> > 
> > ...then I'll eventually get back EIO on a write. Further calls
> > will give us ENOSPC.
> > 
> > I'm not sure what prompted this change, but I don't think it's what we
> > want to do. If writepages failed, we will have already set the mapping
> > error appropriately, and that's what gets reported by fsync() or
> > close().
> > 
> > __filemap_fdatawait_range however, does this:
> > 
> > 	wait_on_page_writeback(page);
> > 	if (TestClearPageError(page))
> > 		ret = -EIO;
> > 
> > ...and that -EIO ends up trumping the mapping's error if one exists.
> > 
> > When writepages fails, we only want to set the error in the mapping,
> > and not flag the individual pages.
> 
> I think you are right. Maybe we should also remove the SetPageError in writepage_nounlock
> 

Yeah, good catch. The last patch in this series should probably also
call ceph_set/clear_error_write in that function as well.

> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> > fs/ceph/addr.c | 4 +---
> > 1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 308787eeee2c..040d05c8f4a2 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -668,6 +668,7 @@ static void writepages_finish(struct ceph_osd_request *req)
> > 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
> > 	bool remove_page;
> > 
> > +
> > 	dout("writepages_finish %p rc %d\n", inode, rc);
> > 	if (rc < 0)
> > 		mapping_set_error(mapping, rc);
> > @@ -702,9 +703,6 @@ static void writepages_finish(struct ceph_osd_request *req)
> > 				clear_bdi_congested(&fsc->backing_dev_info,
> > 						    BLK_RW_ASYNC);
> > 
> > -			if (rc < 0)
> > -				SetPageError(page);
> > -
> > 			ceph_put_snap_context(page_snap_context(page));
> > 			page->private = 0;
> > 			ClearPagePrivate(page);
> > -- 
> > 2.9.3
> > 
> 
> 

-- 
Jeff Layton <jlayton@redhat.com>
