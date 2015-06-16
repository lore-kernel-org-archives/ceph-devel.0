From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH 5/6] osd_client: add support for notify payloads via notify
 event
Date: Tue, 16 Jun 2015 10:26:43 -0500
Message-ID: <55804033.2000600@redhat.com>
References: <cover.1434124007.git.dfuller@redhat.com> <0010a14dcbe868312b9be6c7add8ec9d43fc0a28.1434124007.git.dfuller@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60782 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754905AbbFPP0o (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Jun 2015 11:26:44 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 71AC4C99D3
	for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 15:26:44 +0000 (UTC)
In-Reply-To: <0010a14dcbe868312b9be6c7add8ec9d43fc0a28.1434124007.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>, ceph-devel@vger.kernel.org

On 06/12/2015 10:56 AM, Douglas Fuller wrote:
> @@ -2533,8 +2548,10 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
>  	if (msg->hdr.version >= 2)
>  		ceph_decode_32_safe(&p, end, return_code, bad);
>  
> -	if (msg->hdr.version >= 3)
> +	if (msg->hdr.version >= 3) {
>  		ceph_decode_32_safe(&p, end, notifier_gid, bad);
> +		data = list_first_entry(&msg->data, struct ceph_msg_data, links);

It's not completely clear how/who can use this data. Would rbd be
calling ceph_osdc_create_notify_event/ceph_osdc_create_notify_event, or
is some libceph code (net/ceph)?

If it's rbd, is it supposed to be digging into ceph_msg_data structs?
Did we want to pass it a pagelist or CEPH_OSD_DATA_TYPE_PAGES type of
pages array?



> +	}
>  
>  	__do_event(osdc, opcode, cookie, notify_id, payload_len, payload,
>  		return_code, notifier_gid, data);
> @@ -3061,7 +3078,23 @@ static struct ceph_msg *alloc_msg(struct ceph_connection *con,
>  	switch (type) {
>  	case CEPH_MSG_OSD_MAP:
>  	case CEPH_MSG_WATCH_NOTIFY:
> -		return ceph_msg_new(type, front, GFP_NOFS, false);
> +		{
> +			struct ceph_msg *m = ceph_msg_new(type, front, GFP_NOFS, false);
> +			size_t len = con->in_hdr.data_len;
> +			if (len > 0) {
> +				struct page **pages;
> +				struct ceph_osd_data osd_data;
> +				pages = ceph_alloc_page_vector(calc_pages_for(0, len), GFP_KERNEL);


You should use GFP_NOIO, or at least GFP_NOFS like above. Anything but
GFP_KERNEL.

Also handle the allocation failure like is done in other places.


> +				osd_data.type = CEPH_OSD_DATA_TYPE_PAGES;
> +				osd_data.pages = pages;
> +				osd_data.length = len;
> +				osd_data.alignment = 0;
> +				osd_data.pages_from_pool = false;
> +				osd_data.own_pages = false;
> +				ceph_osdc_msg_data_add(m, &osd_data);
> +			}
> +			return m;
> +		}
>  	case CEPH_MSG_OSD_OPREPLY:
>  		return get_reply(con, hdr, skip);
>  	default:
> 

