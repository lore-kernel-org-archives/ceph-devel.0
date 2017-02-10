From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v4 1/6] libceph: allow requests to return immediately on
 full conditions if caller wishes
Date: Fri, 10 Feb 2017 06:52:29 -0500
Message-ID: <1486727549.4233.7.camel@redhat.com>
References: <20170209144836.12525-1-jlayton@redhat.com>
         <20170209144836.12525-2-jlayton@redhat.com>
         <D09ADECB-B744-4456-B174-2DFDA16D0A0E@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33563 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbdBJMCS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2017 07:02:18 -0500
Received: by mail-qt0-f182.google.com with SMTP id v23so32218718qtb.0
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2017 04:01:54 -0800 (PST)
In-Reply-To: <D09ADECB-B744-4456-B174-2DFDA16D0A0E@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, jspray@redhat.com

On Fri, 2017-02-10 at 19:41 +0800, Yan, Zheng wrote:
> > On 9 Feb 2017, at 22:48, Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > Usually, when the osd map is flagged as full or the pool is at quota,
> > write requests just hang. This is not what we want for cephfs, where
> > it would be better to simply report -ENOSPC back to userland instead
> > of stalling.
> > 
> > If the caller knows that it will want an immediate error return instead
> > of blocking on a full or at-quota error condition then allow it to set a
> > flag to request that behavior. Cephfs write requests will always set
> > that flag.
> > 
> > A later patch will deal with requests that were submitted before the new
> > map showing the full condition came in.
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> > fs/ceph/addr.c                  | 4 ++++
> > fs/ceph/file.c                  | 4 ++++
> > include/linux/ceph/osd_client.h | 1 +
> > net/ceph/osd_client.c           | 6 ++++++
> > 4 files changed, 15 insertions(+)
> > 
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 4547bbf80e4f..308787eeee2c 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1040,6 +1040,7 @@ static int ceph_writepages_start(struct address_space *mapping,
> > 
> > 		req->r_callback = writepages_finish;
> > 		req->r_inode = inode;
> > +		req->r_abort_on_full = true;
> > 
> > 		/* Format the osd request message and submit the write */
> > 		len = 0;
> > @@ -1689,6 +1690,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
> > 	}
> > 
> > 	req->r_mtime = inode->i_mtime;
> > +	req->r_abort_on_full = true;
> > 	err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> > 	if (!err)
> > 		err = ceph_osdc_wait_request(&fsc->client->osdc, req);
> > @@ -1732,6 +1734,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
> > 	}
> > 
> > 	req->r_mtime = inode->i_mtime;
> > +	req->r_abort_on_full = true;
> > 	err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> > 	if (!err)
> > 		err = ceph_osdc_wait_request(&fsc->client->osdc, req);
> > @@ -1893,6 +1896,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
> > 	err = ceph_osdc_start_request(&fsc->client->osdc, rd_req, false);
> > 
> > 	wr_req->r_mtime = ci->vfs_inode.i_mtime;
> > +	wr_req->r_abort_on_full = true;
> > 	err2 = ceph_osdc_start_request(&fsc->client->osdc, wr_req, false);
> > 
> > 	if (!err)
> 
> do you ignore writepage_nounlock() case intentionally?
> 
> 
> 
No. Hmmm...writepage_nounlock calls ceph_osdc_writepages, and it's the
only caller so I guess we'll need to set this there. Maybe we should
just lift ceph_osdc_writepages into ceph.ko since there are no callers
in libceph?

> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index a91a4f1fc837..987dcb9b566f 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -714,6 +714,7 @@ static void ceph_aio_retry_work(struct work_struct *work)
> > 	req->r_callback = ceph_aio_complete_req;
> > 	req->r_inode = inode;
> > 	req->r_priv = aio_req;
> > +	req->r_abort_on_full = true;
> > 
> > 	ret = ceph_osdc_start_request(req->r_osdc, req, false);
> > out:
> > @@ -912,6 +913,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
> > 
> > 			osd_req_op_init(req, 1, CEPH_OSD_OP_STARTSYNC, 0);
> > 			req->r_mtime = mtime;
> > +			req->r_abort_on_full = true;
> > 		}
> > 
> > 		osd_req_op_extent_osd_data_pages(req, 0, pages, len, start,
> > @@ -1105,6 +1107,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
> > 						false, true);
> > 
> > 		req->r_mtime = mtime;
> > +		req->r_abort_on_full = true;
> > 		ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> > 		if (!ret)
> > 			ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
> > @@ -1557,6 +1560,7 @@ static int ceph_zero_partial_object(struct inode *inode,
> > 	}
> > 
> > 	req->r_mtime = inode->i_mtime;
> > +	req->r_abort_on_full = true;
> > 	ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> > 	if (!ret) {
> > 		ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
> > diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> > index 03a6653d329a..5da666cc5891 100644
> > --- a/include/linux/ceph/osd_client.h
> > +++ b/include/linux/ceph/osd_client.h
> > @@ -171,6 +171,7 @@ struct ceph_osd_request {
> > 
> > 	int               r_result;
> > 	bool              r_got_reply;
> > +	bool		  r_abort_on_full; /* return ENOSPC when full */
> > 
> > 	struct ceph_osd_client *r_osdc;
> > 	struct kref       r_kref;
> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > index 3a2417bb6ff0..f68bb42da240 100644
> > --- a/net/ceph/osd_client.c
> > +++ b/net/ceph/osd_client.c
> > @@ -49,6 +49,7 @@ static void link_linger(struct ceph_osd *osd,
> > 			struct ceph_osd_linger_request *lreq);
> > static void unlink_linger(struct ceph_osd *osd,
> > 			  struct ceph_osd_linger_request *lreq);
> > +static void complete_request(struct ceph_osd_request *req, int err);
> > 
> > #if 1
> > static inline bool rwsem_is_wrlocked(struct rw_semaphore *sem)
> > @@ -1636,6 +1637,7 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
> > 	enum calc_target_result ct_res;
> > 	bool need_send = false;
> > 	bool promoted = false;
> > +	int ret = 0;
> > 
> > 	WARN_ON(req->r_tid || req->r_got_reply);
> > 	dout("%s req %p wrlocked %d\n", __func__, req, wrlocked);
> > @@ -1670,6 +1672,8 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
> > 		pr_warn_ratelimited("FULL or reached pool quota\n");
> > 		req->r_t.paused = true;
> > 		maybe_request_map(osdc);
> > +		if (req->r_abort_on_full)
> > +			ret = -ENOSPC;
> > 	} else if (!osd_homeless(osd)) {
> > 		need_send = true;
> > 	} else {
> > @@ -1686,6 +1690,8 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
> > 	link_request(osd, req);
> > 	if (need_send)
> > 		send_request(req);
> > +	else if (ret)
> > +		complete_request(req, ret);
> > 	mutex_unlock(&osd->lock);
> > 
> > 	if (ct_res == CALC_TARGET_POOL_DNE)
> > -- 
> > 2.9.3
> > 
> 
> 

-- 
Jeff Layton <jlayton@redhat.com>
