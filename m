From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 1/2] cephfs: ignore error from
 invalidate_inode_pages2_range() in direct write.
Date: Wed, 31 Aug 2016 09:47:37 -0400
Message-ID: <1472651257.5795.5.camel@redhat.com>
References: <874m61eje0.fsf@notabene.neil.brown.name>
         <871t15ej9y.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34271 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934789AbcHaNrm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Aug 2016 09:47:42 -0400
Received: by mail-qk0-f171.google.com with SMTP id t7so51499473qkh.1
        for <ceph-devel@vger.kernel.org>; Wed, 31 Aug 2016 06:47:42 -0700 (PDT)
In-Reply-To: <871t15ej9y.fsf@notabene.neil.brown.name>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: NeilBrown <neilb@suse.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 2016-08-31 at 12:58 +1000, NeilBrown wrote:
> This call can fail if there are dirty pages.  The preceding call to
> filemap_write_and_wait_range() will normally remove dirty pages, but
> as inode_lock() is not held over calls to ceph_direct_read_write(), it
> could race with non-direct writes and pages could be dirtied
> immediately after filemap_write_and_wait_range() returns
> 
> If there are dirty pages, they will be removed by the subsequent call
> to truncate_inode_pages_range(), so having them here is not a problem.
> 
> If the 'ret' value is left holding an error, then in the async IO case
> (aio_req is not NULL) the loop that would normally call
> ceph_osdc_start_request() will see the error in 'ret' and abort all
> requests.  This doesn't seem like correct behaviour.
> 
> So clear 'ret' and ignore the error (other than the dout() message).
> 
> > Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  fs/ceph/file.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 0f5375d8e030..1ca6e29edcc9 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -905,8 +905,14 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
> >  		ret = invalidate_inode_pages2_range(inode->i_mapping,
> >  					pos >> PAGE_SHIFT,
> >  					(pos + count) >> PAGE_SHIFT);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> >  			dout("invalidate_inode_pages2_range returned %d\n", ret);
> > +			/*
> > +			 * Error is not fatal as we truncate_inode_pages_range()
> > +			 * below.
> > +			 */
> > +			ret = 0;
> > +		}
>  
> >  		flags = CEPH_OSD_FLAG_ORDERSNAP |
> >  			CEPH_OSD_FLAG_ONDISK |


Good catch. Even better might be to just declare a int ret2 and not
clobber "ret" at all.

Clearly, mixing buffered and direct I/O is gross, but I suppose you
could hit the occasional problem here with a real workload
occasionally.

Should this go to stable? The patch seems safe enough.

Reviewed-by: Jeff Layton <jlayton@redhat.com>
