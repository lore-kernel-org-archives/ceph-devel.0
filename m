From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH 6/6] osd_client: send watch ping messages
Date: Tue, 16 Jun 2015 10:07:38 -0500
Message-ID: <55803BBA.5080605@redhat.com>
References: <cover.1434124007.git.dfuller@redhat.com> <3d2f491172fd1c2c33c46a4bcf64743af5f45568.1434124007.git.dfuller@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44683 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754651AbbFPPHj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Jun 2015 11:07:39 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 1F9048F26F
	for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 15:07:39 +0000 (UTC)
In-Reply-To: <3d2f491172fd1c2c33c46a4bcf64743af5f45568.1434124007.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>, ceph-devel@vger.kernel.org

On 06/12/2015 10:56 AM, Douglas Fuller wrote:
>  static int ceph_oloc_decode(void **p, void *end,
>  			    struct ceph_object_locator *oloc)
>  {
> @@ -2795,6 +2889,7 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
>  	osdc->num_requests = 0;
>  	INIT_DELAYED_WORK(&osdc->timeout_work, handle_timeout);
>  	INIT_DELAYED_WORK(&osdc->osds_timeout_work, handle_osds_timeout);
> +	INIT_DELAYED_WORK(&osdc->linger_ping_work, handle_linger_ping);
>  	spin_lock_init(&osdc->event_lock);
>  	osdc->event_tree = RB_ROOT;
>  	osdc->event_count = 0;
> @@ -3079,12 +3174,15 @@ static struct ceph_msg *alloc_msg(struct ceph_connection *con,
>  	case CEPH_MSG_OSD_MAP:
>  	case CEPH_MSG_WATCH_NOTIFY:
>  		{
> -			struct ceph_msg *m = ceph_msg_new(type, front, GFP_NOFS, false);
> +			struct ceph_msg *m = ceph_msg_new(type, front,
> +			                                  GFP_NOFS, false);
>  			size_t len = con->in_hdr.data_len;
>  			if (len > 0) {
>  				struct page **pages;
>  				struct ceph_osd_data osd_data;
> -				pages = ceph_alloc_page_vector(calc_pages_for(0, len), GFP_KERNEL);
> +				pages = ceph_alloc_page_vector(
> +				              calc_pages_for(0, len), GFP_NOFS);
> +				WARN_ON(!pages);

Are you wanting this warn to get more info in case someone sends us a
really large buffer?

Handle the null pointer here like is done elsewhere. If you don't you
will get NULL pointer ooppses or other crashes due to there being a non
zero len but null pages pointer.

