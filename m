From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCHv2 5/6] osd_client: add support for notify payloads via
 notify event
Date: Wed, 17 Jun 2015 11:11:37 -0500
Message-ID: <55819C39.4010002@redhat.com>
References: <cover.1434550968.git.dfuller@redhat.com> <c486ba353fea150db8bc78b9ad03f07f03882b46.1434550968.git.dfuller@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36936 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbbFQQLi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Jun 2015 12:11:38 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 9E3F12CAF07
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 16:11:38 +0000 (UTC)
In-Reply-To: <c486ba353fea150db8bc78b9ad03f07f03882b46.1434550968.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>, ceph-devel@vger.kernel.org

On 06/17/2015 09:25 AM, Douglas Fuller wrote:
> @@ -2486,6 +2579,7 @@ static void __do_event(struct ceph_osd_client *osdc, u8 opcode,
>  		case CEPH_WATCH_EVENT_NOTIFY_COMPLETE:
>  			if (event) {
>  				event->notify.notify_data = data;
> +				event->notify.notify_data_len = data_len;
>  				if (event->osd_req) {
>  					ceph_osdc_cancel_request(event->osd_req);
>  					event->osd_req = NULL;
> @@ -2532,11 +2626,13 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
>  	if (msg->hdr.version >= 2)
>  		ceph_decode_32_safe(&p, end, return_code, bad);
>  
> -	if (msg->hdr.version >= 3)
> +	if (msg->hdr.version >= 3) {
>  		ceph_decode_64_safe(&p, end, notifier_gid, bad);
> +		data = list_first_entry(&msg->data, struct ceph_msg_data, links);
> +	}
>  
>  	__do_event(osdc, opcode, cookie, notify_id, payload_len, payload,
> -		return_code, notifier_gid, data);
> +		return_code, notifier_gid, data->pages, data->length);
>  
>  	return;
>  
> @@ -3055,12 +3151,33 @@ static struct ceph_msg *alloc_msg(struct ceph_connection *con,
>  	struct ceph_osd *osd = con->private;
>  	int type = le16_to_cpu(hdr->type);
>  	int front = le32_to_cpu(hdr->front_len);
> +	struct ceph_msg *m;
> +	size_t len = con->in_hdr.data_len;
>  
>  	*skip = 0;
>  	switch (type) {
>  	case CEPH_MSG_OSD_MAP:
>  	case CEPH_MSG_WATCH_NOTIFY:
> -		return ceph_msg_new(type, front, GFP_NOFS, false);
> +		m = ceph_msg_new(type, front, GFP_NOFS, false);
> +		if (!m)
> +			goto out;
> +
> +		if (len > 0) {
> +			struct page **pages;
> +			struct ceph_osd_data osd_data;
> +			pages = ceph_alloc_page_vector(
> +				      calc_pages_for(0, len), GFP_NOFS);
> +			if (!pages)
> +				goto out2;
> +			osd_data.type = CEPH_OSD_DATA_TYPE_PAGES;
> +			osd_data.pages = pages;
> +			osd_data.length = len;
> +			osd_data.alignment = 0;
> +			osd_data.pages_from_pool = false;
> +			osd_data.own_pages = false;
> +			ceph_osdc_msg_data_add(m, &osd_data);
> +		}
> +		return m;
>  	case CEPH_MSG_OSD_OPREPLY:
>  		return get_reply(con, hdr, skip);
>  	default:
> @@ -3069,6 +3186,12 @@ static struct ceph_msg *alloc_msg(struct ceph_connection *con,
>  		*skip = 1;
>  		return NULL;
>  	}
> +out2:
> +	ceph_msg_put(m);
> +out:
> +	pr_err("couldn't allocate reply, will skip\n");
> +	*skip = 1;
> +	return NULL;
>  }
>  
>  /*
> 

When is the data freed?

Does it get freed when we do dispatch->ceph_msg_put [is this the last
put so we do] -> ceph_msg_release?

If so, then I think when __do_event() does complete_all() the thread
that did the ceph_osdc_wait_event could end up accessing freed memory.

