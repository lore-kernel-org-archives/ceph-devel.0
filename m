From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v4 2/6] libceph: abort already submitted but abortable
 requests when map or pool goes full
Date: Fri, 10 Feb 2017 20:01:34 +0800
Message-ID: <285D1D56-D4CD-4B4F-BF51-F915560F28C2@redhat.com>
References: <20170209144836.12525-1-jlayton@redhat.com>
 <20170209144836.12525-3-jlayton@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbdBJMCS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 10 Feb 2017 07:02:18 -0500
In-Reply-To: <20170209144836.12525-3-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, jspray@redhat.com


> On 9 Feb 2017, at 22:48, Jeff Layton <jlayton@redhat.com> wrote:
> 
> When a Ceph volume hits capacity, a flag is set in the OSD map to
> indicate that, and a new map is sprayed around the cluster. With cephfs
> we want it to shut down any abortable requests that are in progress with
> an -ENOSPC error as they'd just hang otherwise.
> 
> Add a new ceph_osdc_abort_on_full helper function to handle this. It
> will first check whether there is an out-of-space condition in the
> cluster. It will then walk the tree and abort any request that has
> r_abort_on_full set with an ENOSPC error. Call this new function
> directly whenever we get a new OSD map.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
> net/ceph/osd_client.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 42 insertions(+)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index f68bb42da240..cdb0b58c4c99 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1777,6 +1777,47 @@ static void complete_request(struct ceph_osd_request *req, int err)
> 	ceph_osdc_put_request(req);
> }
> 
> +/*
> + * Drop all pending requests that are stalled waiting on a full condition to
> + * clear, and complete them with ENOSPC as the return code.
> + */
> +static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
> +{
> +	struct ceph_osd_request *req;
> +	struct ceph_osd *osd;
> +	struct rb_node *m, *n;
> +	u32 latest_epoch = 0;
> +	bool osdmap_full = ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL);
> +
> +	dout("enter abort_on_full\n");
> +
> +	if (!osdmap_full && !have_pool_full(osdc))
> +		goto out;
> +
> +	for (n = rb_first(&osdc->osds); n; n = rb_next(n)) {
> +		osd = rb_entry(n, struct ceph_osd, o_node);
> +		mutex_lock(&osd->lock);
> +		m = rb_first(&osd->o_requests);
> +		while (m) {
> +			req = rb_entry(m, struct ceph_osd_request, r_node);
> +			m = rb_next(m);
> +

For requests that have already got unsafe reply, we should ignore them or call req->r_unsafe_callback() to clean them up


Regards
Yan, Zheng 
> +			if (req->r_abort_on_full &&
> +			    (osdmap_full || pool_full(osdc, req->r_t.base_oloc.pool))) {
> +				u32 cur_epoch = le32_to_cpu(req->r_replay_version.epoch);
> +
> +				dout("%s: abort tid=%llu flags 0x%x\n", __func__, req->r_tid, req->r_flags);
> +				complete_request(req, -ENOSPC);
> +				if (cur_epoch > latest_epoch)
> +					latest_epoch = cur_epoch;
> +			}
> +		}
> +		mutex_unlock(&osd->lock);
> +	}
> +out:
> +	dout("return abort_on_full latest_epoch=%u\n", latest_epoch);
> +}
> +
> static void cancel_map_check(struct ceph_osd_request *req)
> {
> 	struct ceph_osd_client *osdc = req->r_osdc;
> @@ -3292,6 +3333,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
> 
> 	ceph_monc_got_map(&osdc->client->monc, CEPH_SUB_OSDMAP,
> 			  osdc->osdmap->epoch);
> +	ceph_osdc_abort_on_full(osdc);
> 	up_write(&osdc->lock);
> 	wake_up_all(&osdc->client->auth_wq);
> 	return;
> -- 
> 2.9.3
> 

